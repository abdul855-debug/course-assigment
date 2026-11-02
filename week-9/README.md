# Week 9, Data Observability and Backup

## What this does
- `week-5/exporter.tf` runs a Postgres exporter so Prometheus can report whether the database is up, how big it is, and how many rows each table has. `week-5/network.tf` lets only the web pods and exporter connect to the database.
- `week-9/backup.sh` backs up the database to `~/backups` every five minutes, checks each backup, and keeps the newest 12. It avoids replacing good backups with an empty database backup.
- `week-9/restore.sh` restores a backup. `week-9/sql.sh` runs SQL, and `week-9/check.sh` checks the setup.

## What lives where
| Where | What | Survives deleting the VM? |
| --- | --- | --- |
| Repository | Scripts, OpenTofu files, README | Yes |
| My Mac | A manually copied backup | Yes |
| Ubuntu VM | Backups, cron jobs, database volume | No |
| Prometheus | Database metrics | No, history is lost when its pod restarts |

## Runbook: restore the database
- **Incident:** Database tables are deleted.
- **Symptom:** The app has missing tickets, `sql.sh` shows `(no tables)`, and Prometheus stops showing table row counts while `pg_up` remains 1.
- **Fix:**
  1. Run `ls -1t ~/backups` and choose a backup from before the data was lost.
  2. Run `./week-9/restore.sh ~/backups/<file>`.
  3. Run `./week-9/sql.sh` to verify the restored rows.

## Recovery measurements
- Rows before: tickets: 3
- Rows after: tickets: 3
- Backup age: 0 seconds (target: 300 seconds)
- Recovery time: 226 seconds (target: 600 seconds)

## Rebuild on a fresh VM
1. Rebuild the Week 7 and Week 8 infrastructure and deployment.
2. Create a private backup folder with `mkdir -m 700 ~/backups`.
3. Copy a backup from the Mac using `scp -P 2222 <file> <username>@127.0.0.1:backups/`.
4. Restore it using `./week-9/restore.sh ~/backups/<file>`.
5. Reinstall the backup cron job:
   `( crontab -l 2>/dev/null; echo "*/5 * * * * $PWD/week-9/backup.sh >> $HOME/backup.log 2>&1" ) | crontab -`

## Known limitations
Backups are not encrypted, and copying them off the VM is manual. The exporter uses the database superuser. There are no automatic alerts for failed backups or database outages. Restoring onto a completely new VM has not been tested, and the Postgres image uses a floating tag.
