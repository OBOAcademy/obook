# How to Migrate an Existing Ontology Repository to the Ontology Development Kit

These are instructions on how to migrate an existing ontology repository hosted on GitHub
or GitLab to an ODK based workflow. They are heavily based on (and are often identical to) the
instructions provided in [Creating a new Repository with the Ontology Development Kit](odk-create-repo.md).
You may need assistance from someone with basic unix knowledge in following the instructions here.

## 1. Install requirements

* [Getting set up with Docker and the Ontology Development Kit](odk-setup.md).
* [Install Protégé](set-up-protege.md)
* OPTIONAL (Beta Testing): Install the [ODK runner](https://github.com/gouttegd/odkrunner) for
  better user experience. In the Linux shell you can do this with:
    * ```mkdir ~/tools``` (to create a _~/tools_ directory)
    * ```wget https://github.com/gouttegd/odkrunner/releases/download/odkrunner-0.3.1/odkrun-linux -O ~/tools/odk```
      (to download and save the ODK runner binary file into the _~/tools_ directory. CHECK IF A NEWER VERSION
      IS ALREADY AVAILABLE FIRST)
    * ```chmod +x ~/tools/odk``` (to make the binary file executable)
    * ```export PATH=$PATH:~/tools``` (to add the _~/tools_ folder to your path for the current
      session)
        * To add the _~/tools_ folder permanently to your path, you can add it to your Bash config
          file with:
          ```
          echo "
          # Adding ODK runner script living in ~/tools to PATH
          export PATH=\"\$PATH:~/tools\"" >> ~/.bashrc
          ```

## 2. Get the ontology you want to migrate into the right format

CONTEXT: In the ODK, the ontology files being released to the public are not edited
manually. Instead, there exists an "editor file" of your ontology, which, as the name
suggests, is the one you edit in Protégé, your text editor or via ROBOT templates, the
one where you import external ontologies or separate ontology modules via import
statements. From this editor file, the public release files will be created
automatically by ODK.

Now, your current ontology file will most likely be serialized in RDF/XML (.owl) or
Turtle (.ttl), but the editor file in ODK is serialized in functional syntax (.ofn).
For migrating to ODK, it thus is best to convert your current ontology file to functional
syntax as well. There are two benefits for doing this. For one, it will allow you to
just copy and paste the content of your current ontology file to the editor file that will
be created by ODK in one of the next steps. Second, the compact declaration section in the
beginning of the OFN serialization allows you to quickly see external terms (those that
have been reused from other ontologies), which will help you to build your import modules.

The conversion to OFN can best be done with ROBOT, which is provided in ODK. If you
installed the ODK runner previously, you can simply run the following command (replace
[PATH TO YOUR “OLD” ONTOLOGY FILE] with the actual path to your “old” ontology file):

      ```
      odk robot convert \
      --input [PATH TO YOUR “OLD” ONTOLOGY FILE] \
      --format ofn --output [PATH TO YOUR “OLD” ONTOLOGY FILE].ofn
      ```
* If you didn't install the ODK runner, you need to download the ODK wrapper script into your
  working directory with
* `wget https://oboacademy.github.io/obook/resources/odk.sh`. Then check that it works by
  running `sh odk.sh robot --version`, which should return the version of ROBOT (e.g.: `ROBOT 
version 1.9.6`). Now, you can convert your current ontology file with:
    ```
    sh odk.sh robot convert \
    --input [PATH TO YOUR “OLD” ONTOLOGY FILE] \
    --format ofn --output [PATH TO YOUR “OLD” ONTOLOGY FILE].ofn
    ```
In the below example of the Chemical Methods Ontology (CHMO), you can see that it
declares terms from the following namespaces:
* classes from BFO,FIX, CHEBI, IAO, MS, OBSC, OBI and REX
* object properties from BFO, IAO, OBI, and RO
* and annotation properties from various other ontologies.
  ```
  Declaration(Class(obo:BFO_0000140)
  Declaration(Class(obo:CHEBI_50803))
  Declaration(Class(obo:CHMO_0010020))
  Declaration(Class(obo:FIX_0001068))
  Declaration(Class(obo:IAO_0000140))
  Declaration(Class(obo:MS_1000073))
  Declaration(Class(obo:OBCS_0000058))
  Declaration(Class(obo:OBI_0600014))
  Declaration(Class(obo:REX_0000188))
  Declaration(ObjectProperty(obo:BFO_0000052))
  Declaration(ObjectProperty(obo:CHMO_0002922))
  Declaration(ObjectProperty(obo:IAO_0000136))
  Declaration(ObjectProperty(obo:OBI_0000293))
  Declaration(ObjectProperty(obo:OBI_0000299))
  Declaration(ObjectProperty(obo:OBI_0000312))
  Declaration(ObjectProperty(obo:OBI_0000417))
  Declaration(ObjectProperty(obo:RO_0002411))
  Declaration(ObjectProperty(obo:RO_0002418))
  Declaration(AnnotationProperty(obo:BFO_0000179))
  Declaration(AnnotationProperty(obo:BFO_0000180))
  Declaration(AnnotationProperty(obo:IAO_0000115))
  Declaration(AnnotationProperty(chmo:isDefinedBy))
  Declaration(AnnotationProperty(chmo:non-mining_synonym))
  Declaration(AnnotationProperty(dc:title))
  Declaration(AnnotationProperty(terms:license))
  Declaration(AnnotationProperty(oboInOwl:SynonymTypeProperty))
  Declaration(AnnotationProperty(rdfs:label))
  Declaration(AnnotationProperty(owl:deprecated))
  ```
Based on this and assuming that all native terms within CHMO use the CHMO namespace
(obo:CHMO_), we can derive that CHMO needs to have import modules for BFO, RO, CHEBI,
IAO, OBI, MS, OBSC, REX and FIX to properly import the terms from these ontologies. To
reuse the standard OBO annotation properties, like IAO:0000115 or
oboInOwl:SynonymTypeProperty, you should import the complete
[OBO Metadata Ontology](http://purl.obolibrary.org/obo/omo.owl) instead of re-declaring
them in your editor file.

## 3. Create your ODK config file
Create a _config file_ (aka _project.yaml_) in your working directory, according to
[this schema](http://incatools.github.io/ontology-development-kit/project-schema/),
which is usually named _yourOntologyID-odk.yaml_.

For example, if we want to migrate CHMO we would create a file called _chmo-odk.yaml_
with this content to start out with:

    ```
    ## ontology metadata ##
    id: chmo
    title: Chemical Methods Ontology
    description: "CHMO, the chemical methods ontology, describes methods used to collect data in chemical experiments, such as mass spectrometry and electron microscopy prepare and separate material for further analysis, such as sample ionisation, chromatography, and electrophoresis synthesise materials, such as epitaxy and continuous vapour deposition It also describes the instruments used in these experiments, such as mass spectrometers and chromatography columns. It is intended to be complementary to the Ontology for Biomedical Investigations (OBI)."
    contact:  batchelorc [at] rsc [.] org
    creators:
    - Royal Society of Chemistry
      license: https://creativecommons.org/licenses/by/4.0/
    
    
    ## general ODK Settings ##
    repo: rsc-cmo
    git_main_branch: master
    github_org: rsc-ontologies
    ci:
    - github_actions
      documentation:
      documentation_system: mkdocs
      export_formats:
      - owl
      - obo
        reasoner: ELK
        release_artefacts:
      - full
      - base
        robot_java_args: '-Xmx8G'  # max RAM to be used by Robot in ODK
    
    
    ## CHMO specific Settings ##
    import_group:
    products:
    - id: bfo
      module_type: mirror
      - id: ro
        use_base: true
        slme_individuals: exclude
      - id: omo
        module_type: mirror
      - id: iao
        make_base: true
      - id: obi
      - id: ms
      - id: fix
      - id: rex
      - id: obsc
      - id: chebi
        is_large: true
        use_gzipped: true
        make_base: true
    ```
## 4. Seeding your ODK Repository Locally
To create a new ODK repository within your working directory based on the project YAML
file you just created, you just have to call the following commands (replacing [PATH TO
YOUR PROJECT YAML FILE] with the actual path to your project YAML file).

* Using the seed-via-docker wrapper script (which is downloaded in this call, and thus
  needs internet connection):
    ```
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/INCATools/ontology-development-kit/master/seed-via-docker.sh)" --clean -C [PATH TO YOUR PROJECT YAML]
    ```
* Using ODK runner:
    ```
    odk seed --clean -C [PATH TO YOUR PROJECT YAML]
    ```
This will create a folder called _target_ in which you will find your new ODK repository
structure with all the necessary files and folders as well as some first GIT commits already
made. For more details, see also
[this OBOOK section](odk-create-repo.md#3-run-the-wrapper-script).

NOTE: This step may take a while and might seem to you that it stalled, because there is
no output on the console when the script downloads the ontologies you specified in your
_import_group_ in the background. So, if you need to import many and/or large ontologies,
as is the case in our example with ChEBI, be patient and wait until the script is done.
Also, the _target_ folder is not owned by the Linux user who called this command but by
the root user. You thus might get a rights permission error, when you try to rerun the
script in case something went wrong and would have to delete the target folder before a
rerun with root permission.

## 5. Push your ODK Repository to GitHub / GitLab
If you want to create a brand-new repository on GitHub / GitLab, you can
just follow the steps explained [here](odk-create-repo.md#4-push-to-git-hosting-website).

## 6. Make a new Branch to Work in
If you want to keep your existing GitHub / GitLab repository, used your local clone as working directory for
the above steps and have not done the following already, then you should now:
* [Make a new branch](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-and-deleting-branches-within-your-repository#creating-a-branch) and check it out.
* Think about how to integrate existing files and folders of your current repository into the
  new ODK repo structure. (E.g. you might want to archive previous release files in a
  dedicated folder or might want to integrate documentation related files into the `docs` folder
  created by ODK to automatically build a GitHub pages documentation.)
* Copy all but the .git folder from the directory created by the seeding step (e.g.
  `target/chmo/`) into the top level of your new branch.

Even if you created a completely new repository, you should now do the next steps in a new branch.

## 6. Migrating the Content into the Editor File

* Open the editor file (.e.g. `target/chmo/src/ontology/chmo-edit.owl`) in your text editor and Protégé.
* From your previously created “old” OFN ontology file, copy all declared terms (classes, object, data &
  annotation properties and individuals) that use the namespace of your ontology into the editor file.
    * Start by copying the term declarations, then the classes, and so on.
    * Check that you make no mistakes these copying steps. Whenever you save your text editor, Protégé will
      ask you to reload the editor file. Click yes, and if this causes an error, you did something wrong.

## 7. Building your Import Modules
In the term declaration section of your “”old” OFN ontology there should now only be those terms left,
that are external and which need to be imported via import modules. To build the latter, you first need
to provide these terms in the empty text files that were created by ODK in the seeding step in the
`src/ontology/imports` folder (e.g. _iao_terms.txt_). Each term that should be imported must be listed in its
respective text file as a new row via its term IRI. Optionally, for better human-readbility, you can provide a
label after the term IRI via a comment. E.g. if you want to import the IAO object property “is about” you need
to have this row in your _iao_terms.txt_:
  ```
  http://purl.obolibrary.org/obo/IAO_0000136 # is about
  ```
Assuming you have specified all terms you want to import in their respective import text file, you can build
an import module from it in two ways, as described
[in this section of the OBOOK](https://oboacademy.github.io/obook/howto/update-import/).
* You can either call the ODK command with which all import modules are build/updated at once using:
  ```
  ../src/ontology/$ sh run.sh make refresh-imports
  ```
* or you can only update a specific import module by calling:
  ```
  ../src/ontology/$ sh run.sh make refresh-%
  ```
  where the “%” is the placeholder for the id of the ontology from which you import. E.g. to build/update your
  IAO module, you’d have to call:
  ```
  ../src/ontology/$ sh run.sh make refresh-iao
  ```
* With the above commands ODK will first download the whole ontology from which ODK will build your
  import module. If you ran this command previously just recently, and thus already have the most current mirror
  of that ontology within your mirror folder (`scr/ontology/mirror`), you can skip this download/mirror step by
  instead calling:
  ```
  ../src/ontology/$ sh run.sh make no-mirror-refresh-imports
  ```
  for building all import modules at once, or:
  ```
  ../src/ontology/$ sh run.sh make no-mirror-refresh-%
  ```
  for building only a specific one.

In most cases the default way of building import modules in ODK via the extraction method called SLME-BOT will
be the best option. In some cases this default can be too “noisy” by also importing terms you don’t need/want.
With the `module_type` & `module_type_slme` parameters in your project.yaml you can tweak the default import
module build behavior of ODK, which relies on knowing what ROBOT can do, see also:
* http://robot.obolibrary.org/extract
* http://robot.obolibrary.org/filter
* http://robot.obolibrary.org/remove

The easiest ways would be to try `TOP` or `STAR` instead of the default `BOT` as value for the
`module_type_slme` parameter and then refresh your imports to see if you still got all the terms you
wanted, including their axioms and not any terms that are unrelated.

You also have the option to use `module_type: custom` and define your own ROBOT code for building an
import module within your custom makefile (e.g. [like this](https://github.com/NFDI4Chem/VibrationalSpectroscopyOntology/blob/main/src/ontology/vibso.Makefile#L46-L56)).
* However, this can be quite challenging to get right, as you’d probably not want to accidentally miss
  any asserted axioms.

Check if everything worked as expected by reloading the editor file in Protégé when you refreshed an
import module.

NOTE: If you need to add a new import dependency to your _project.yaml_ (e.g. you added another
ontology dependency to the `import_group` section), you need to run:
   ```
   ../src/ontology/$ sh run.sh make update_repo
   ```
**AND** you need to add this newly added ontology dependency also to the import declaration sections of your
`catalog-v001.xml` and your editor file.

## 8. Merge your Branch
Once you got your import modules (dependencies) right, you can merge the branch.

## 9. Make a Release
Make a release and update the metadata needed for your purl system to resolve (e.g. OBO PURL system can also
resolve to your import modules) see also: http://pato-ontology.github.io/pato/odk-workflows/ReleaseWorkflow/

## 10. Join the ODK Slack Channel
Come to the [#ontology-development-kit](https://obo-communitygroup.slack.com/archives/C01BKKED8R2) Slack
channel to get help (best to have an open repo so others have something to look at for helping to fix problems

## 11. Updating your ODK Environment
To update your ODK environment follow [this HowTo](odk-update.md)).

## Good to Know
Your cheat sheet for the [Frequently Used ODK Commands](http://incatools.github.io/ontology-development-kit/FrequentlyUsedODKCommands/).

## Contributors

- [Philip Strömert](https://orcid.org/0000-0002-1595-3213)
- [Nicolas Matentzoglu](https://orcid.org/0000-0002-7356-1779)