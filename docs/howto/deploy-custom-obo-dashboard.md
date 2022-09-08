# How to deploy a custom OBO dashboard

Contributed by @XinsongDu, edited by @matentzn

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
