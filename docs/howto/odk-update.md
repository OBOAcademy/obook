# Updating ODK

A new version of the Ontology Development Kit (ODK) is out? This is what you
should be doing:

1. Install the latest version of ODK by pulling the ODK docker images. In your
   terminal, run:

```
docker pull obolibrary/odkfull
```

2. To update your repository, go to your `src/ontology` directory.

```
cd myrepo/src/ontology
```

3. Create a new git branch in your usual way, then run the update command.

```
odkrun update_repo
```

Note, for older ODK versions the command was `sh run.sh make update_repo`, and
it had to be run TWICE (the first time it could fail, as the update command
needed to update itself).

5. Check that all your GitHub workflows (in `.github/workflows/*.yml`) are
   using the latest version of the ODK. For the workflows that are maintained
   by the ODK itself (such as `.github/workflows/qc.yml`), this should have
   been done automatically by the `update_repo` command above, but if you have
   any custom workflow, you will have them to update them yourself.

6. Review all the changes and commit them, and make a PR the usual way. 100%
   wait for the PR to pass QC - ODK updates can be significant!

7. Send a reminder to all other ontology developers of your repo and tell them
   to install the latest version of ODK (step 1 only).
