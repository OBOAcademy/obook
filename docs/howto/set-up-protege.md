# Setup Protege 5.5

(This was adopted from the [Gene Ontology editors guide](http://wiki.geneontology.org/index.php/Protege5_5_setup_for_GO_Eds) and [Mondo documentation](https://mondo.readthedocs.io/en/latest/editors-guide/a-protege-setup/))

## Operating System
These instructions are for Mac OS

## Protege version
As of July 2022, OBO ontology editors are using `Protege version 5.5.0`

## Download and install Protege
- Get Protege from [protege.stanford.edu](https://protege.stanford.edu/)
- Unzip and move the Protege app to your Applications folder.
- See [Install_Protege5_Mac](https://protegewiki.stanford.edu/wiki/Install_Protege5_Mac) for more instructions and troubleshooting common problems.

## Increase memory in Protege

1. Protege needs at least 4G of RAM to cope with Mondo, ideally use 12G or 16G if your machine can handle it.
1. If running from Protege.app on a mac, open the /Applications/Protege-5.5.0/Protégé.app/Contents/info.plist file
1. Below the line: <string>-Xss16M</string>
1. Insert another line: <string>-Xmx12G</string>
1. Note - if you have issues opening Protege, then reduce the memory, try 10G (or lower) instead.

## Add ELK reasoner
See [instructions here](https://oboacademy.github.io/obook/howto/installing-elk-in-protege/). 

## Fix memory settings
- Protege needs at least 4G of RAM to cope with Mondo, ideally use 12G or 16G if your machine can handle it.
- If running from Protege.app on a mac, open the /Applications/Protege-5.5.0/Protégé.app/Contents/info.plist file
  - Below the line: `<string>-Xss16M</string>`
  - Insert another line: `<string>-Xmx12G</string>`

_Note - if you have issues opening Protege, then reduce the memory, try 10G (or lower) instead._

## Instructions for new Protege users

### Setting your ID range
See [instructions here](https://oboacademy.github.io/obook/howto/idrange/).

## User details

1. `User name` Click `Use supplied user name:` add your name (ie nicolevasilevsky)
2. Check `Use Git user name when available`
3. Add `ORCID`. Add the ID number only, do not include https://, ie 0000-0001-5208-3432

## Setting username and auto-adding creation date

1. In the Protege menu, go to `Preferences` > `New Entities Metadata` tab
2. Check `Annotate new entities with creator (user)` box
3. `Creator property` Add http://www.geneontology.org/formats/oboInOwl#created_by
3. `Creator value` Select Use ORCID
4. `Date property` http://purl.org/dc/elements/1.1/date
5. `Date value format` Select ISO-8601

## Install Protege OBO plugin

This plugin enables some extra functionality, such as the option to obsolete entities from the menu. To install it:
1. Go to `File > Check for plugins...`.
2. Click on `OBO Annotations Editor` and click on `Install`.
3. Restart Protege for the plugin to be active.
4. You should now have the option to obsolete entities in `Edit > Make entity obsolete`.
5. You can see a list of all installed plugins in `Preferences > Plugins`.
