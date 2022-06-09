# Updating ODK

A new version of the Ontology Development Kit (ODK) is out? This is what you should be doing:

1) Install the latest version of ODK by pulling the ODK docker images. In your terminal, run:

```
docker pull obolibrary/odkfull
```

2) To update your repository, go to your `src/ontology` directory.

```
cd myrepo/src/ontology
```

3) Create a new git branch in your usual way (optional)

Now run the update command TWICE (the first time it may fail, as the update command needs to update itself).

```
sh run.sh make update_repo
sh run.sh make update_repo
```

4) Edit the following file: `.github/workflows/qc.yml` (from the top level of your repository) and make sure that it is using the latest version of the ODK.

For example, `container: obolibrary/odkfull:v1.3.0`, if `v1.3.0`. Is the latest version. If you are unsure what the latest version is, you can find that information here: https://hub.docker.com/r/obolibrary/odkfull/tags

5) OPTIONAL: if you have any other GitHub actions you would like to update to the latest ODK, now is the time! All of your GitHub actions can be found in the `.github/workflows/` directory from the top level of your repo.

6) Review all the changes and commit them, and make a PR the usual way. 100% wait for the PR to pass QC - ODK updates can be significant!

7) Send a reminder to all other ontology developers of your repo and tell them to install the latest version of ODK (step 1 only).
