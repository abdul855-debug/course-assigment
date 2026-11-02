# Week 8: Security Hardening and Shifting Left

## What I Did

This week, I improved the security of my Kubernetes application and deployment process.

I made the web container run as a non-root user and disabled privilege escalation. I also added CPU and memory limits to the web and database containers.

I added a NetworkPolicy so only web pods can connect to the database.

I updated the GitHub Actions workflow to run security checks on pull requests.

I also updated the deployment script to check for destructive changes before applying them.

## Attack 1: Insecure Pull Request

I changed the web container configuration to allow privilege escalation.

The security scan failed and detected the insecure setting.

However, GitHub allowed the pull request to merge because branch protection was not enforced.

I reverted the insecure change afterward.

## Attack 2: Database Volume Replacement

I changed the database volume name from db-data to db-data-v2.

OpenTofu detected that the volume would need to be replaced.

The plan showed:
1 to add, 1 to change, 1 to destroy.

I tested the destructive-change detection logic locally without applying the plan.

I restored the original configuration and confirmed the database volume remained Bound.

## Limitations

My repository did not have an active GitHub ruleset because GitHub restricted this feature on my private repository.

The security scan detected Attack 1, but it did not prevent the merge.

For Attack 2, I tested the blocking logic locally rather than running the complete automated deployment.

The database was not deleted.

## Conclusion

This assignment showed me why security checks are important before merging and deploying changes.

Security scanning helps identify insecure configurations, while deployment checks can prevent dangerous changes from reaching the cluster.
