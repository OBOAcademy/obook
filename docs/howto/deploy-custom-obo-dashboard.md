# How to deploy a custom OBO dashboard

## Updated 2022 Workflow

We developed a completely automated variant of the Custom OBO Dashboard Workflow, which does not require any local installation.

<img width="1125" alt="image" src="https://user-images.githubusercontent.com/7070631/192291201-ab2ea488-ec15-4894-ae6b-85655a9e3e75.png">

1. Create a repository using the [Dashboard template repository](https://github.com/OBOFoundry/dashboard-template). ([How to create a repository from a template](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template))
1. Modify the `dashboard-config.yml` file, in particular the `ontologies` section:
    1. Important: Add your ontology ID to the ID 'id' field
    2. Add the path to your ontology to the `mirror_from` field.
1. Optional: use the `profile` section to overwrite the custom robot report profile and add custom checks!

   ```yaml
   profile:
     baseprofile: "https://raw.githubusercontent.com/ontodev/robot/master/robot-core/src/main/resources/report_profile.txt"
     custom:
       - "WARN\tfile:./sparql/missing_xrefs.sparql"
    ```

 1. Click on "Settings" > "Pages" to configure the `GitHub pages`. Set the `Source` to deploy from branch, and `Branch` to build from `main` (or `master` if you are still using the old default) and `/(root)` as directory. Hit `Save`.

     <img width="322" alt="image" src="https://user-images.githubusercontent.com/7070631/192293973-891b400d-c9f1-46d8-aff1-4bc3e6083c43.png">
     
 1. Click on the `Actions` tab in your repo. On the left, select the `Run dashboard` workflow and click on the `Run workflow` button. This action will rebuild the dashboard and make a pull request with the changes.
 1. Review and merge the pull request. Once it is merged, GitHub will automatically rebuild your dashboard website.
 1. After 5 minutes, click on "Settings" > "Pages" again. You should now a new section with information where your site is deployed: 
     <img width="840" alt="image" src="https://user-images.githubusercontent.com/7070631/192295512-4ebf505c-c6e1-4448-9b22-735df8317eef.png">
 1. Click on `Visit site` and you should find your new shiny dashboard page!

 
## 2021 Edition

Contributed by `@XinsongDu`, edited by `@matentzn`

1. Clone https://github.com/OBOFoundry/obo-nor.github.io and copy all its contents to a new GitHub repo under your account. Ensure that the `.gitignore` from the `obo-nor.github.io` repo is also copied to your new repo (it is frequently skipped or hidden from the user in `Finder` or when using the `cp` command) and push to everything to GitHub.
2. Pull the Ontology Development Kit from Docker Hub (can take a while):

```
docker pull obolibrary/odkfull
```

4. Modify the `dashboard-config.yml` file, in particular the `ontologies` section:
   1. Important: Add your ontology ID to the ID 'id' field
   2. Add the path to your ontology to the `mirror_from` field.
5. Get the "base uri namespace" of the ontology using the following steps:
   a. Open the ontology in Protégé
   b. Select a class and press "command + u" (MacOS), the stem of the path would be the base URI namespace (e.g., in EDAM ontology, the base uri namespace is http://edamontology.org/, for Uberon it would be http://purl.obolibrary.org/obo/UBERON_)
6. Add the base uri namespace to 'base_ns' field of your ontology in the dashboard-config.yml
7. (As of October 2021 make sure there are multiple ontologies in the dashboard-config.yml, otherwise errors would be reported while running the code. There are currently some bugs in the dashboard code that require at least 2 or 3 ontologies in the list).
8. In the Makefile uncomment the `#` before `pip install networkx==2.6.2` to ensure the correct network x version is installed.
9. Run `sh run-dash.sh` (make sure dashboard folder is empty before running, e.g. `rm -rf dashboard/*`).
10. When run successfully, push all changes to GitHub.
11. Go to GitHub repo you just created, and go to Settings, then Pages, and select your main/master branch as "source", and your root directory. You will see a website URL highlighted in green, where your OBO dashboard is deployed.



