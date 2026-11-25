# Networking and Cloud QA Report

## Test 1: Baseline Performance
Result: Passed
300 requests completed with zero failures.
P95 latency was 24.93 ms.

## Test 2: Autoscaling
Send at least 15 requests per second and verify
that web scales automatically to at least two pods.
Status: Pending

## Test 3: Application Availability
Run k6 for at least three minutes while deleting
one web pod and rolling out a new image through
the deployment pipeline.
Expected failure rate: Below 1%.
Status: Pending

## Test 4: NetworkPolicy
Test allowed and denied connections before and
after modifying a NetworkPolicy.
Status: Pending

## Test 5: Memory Budget
Verify that additional memory limits remain
within 768Mi.
Status: Pending

## Test 6: PodDisruptionBudget
Verify the web PDB at the starting and scaled
replica counts.
Status: Pending
