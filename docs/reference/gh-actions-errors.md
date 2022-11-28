# Common Errors in GitHub actions

## `Killed`: Running out of memory

Running the same workflow several times simultaneously (e.g. if two PRs are submitted in a short time, and the second PR triggers the CI workflow while the CI workflow triggered by the first PR is still running) could lead to lack-of-memory situations because all concurrent workflows have to share a single memory limit.

(Note: it isn't really clear with documentation of GitHub Actions on whether concurrent workflow runs share a single memory limit.)

What could possibly be done is to forbid a given workflow from ever running as long as there is already a run of the same workflow ongoing, [using the concurrency property](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#concurrency).
