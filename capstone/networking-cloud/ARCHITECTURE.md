# Week 11 Architecture Plan

## Initial Request Path

k6 on Ubuntu VM
  |
  v
Web Service (10.43.130.29:8080)
  |
  v
Web Pod
  |
  v
DB Service (10.43.181.227:5432)
  |
  v
Database Pod

The cluster currently has one web replica and one
database replica. The db-clients NetworkPolicy
protects the database.

## Planned Improvements

I plan to add horizontal pod autoscaling so the
application can handle increased traffic. I will
also add a PodDisruptionBudget and test whether
the application continues working when a web pod
is deleted or a new image is deployed.

The database will not be scaled. The maximum
number of web replicas will be four, subject to
the 768Mi additional memory budget.

This is an initial architecture sketch. The full
network path and policy behavior will be verified
during later testing.
