# Setup Protege 5.6.2

(This was adopted from the [Gene Ontology editors guide](http://wiki.geneontology.org/index.php/Protege5_5_setup_for_GO_Eds) and [Mondo documentation](https://mondo.readthedocs.io/en/latest/editors-guide/a-protege-setup/)). _Updated 2023-08-16 by Nicole Vasilevsky_

## Mac Instructions

These instructions are for Mac OS

### Protege version

As of February 2023, OBO ontology editors are using [Protege version 5.6.2](https://github.com/protegeproject/protege-distribution/releases).

### Download and install Protege

- Get Protege from [protege.stanford.edu](https://protege.stanford.edu/)
- Unzip and move the Protege app to your Applications folder.
- See [Install_Protege5_Mac](https://protegewiki.stanford.edu/wiki/Install_Protege5_Mac) for more instructions and troubleshooting common problems.

### Increase memory in Protege 5.6.2
Protege needs at least 4G of RAM to cope with large ontologie like Mondo, ideally use 12G or 16G if your machine can handle it. Edits to the Protege configuration files will not take effect until Protege is restarted.

1. If running from Protege.app on a Mac, open the /Applications/Protege-5.6.2/Protégé.app/Contents/conf/jvm.conf file
1. set the heap size to 12G: max_heap_size=12G

### Increase memory in Protege 5.5.0

1. If running from Protege.app on a Mac, open the /Applications/Protege-5.5.0/Protégé.app/Contents/info.plist file
1. Below the line: `<string>-Xss16M</string>`
1. Insert another line: `<string>-Xmx12G</string>`

Some Mac users might find that the edits need to be applied to `/Applications/Protégé.app/Contents/Info.plist`.

## PC Instructions

_Taken in part from [Memory Management with Protégé](https://www.michaeldebellis.com/post/memory-management-with-prot%C3%A9g%C3%A9) by Michael DeBellis. Updated by Nicole Vasilevsky._

_The following instructions will probably not work if Protégé was installed from the **platform independent version**, which does not include the Java Runtime Environment or a Windows .exe launcher._

- Visit https://protege.stanford.edu/
- Click orange **DOWNLOAD NOW** button
- Click gray **Download for Windows** button on subsequent page
- Register if desired, or skip registration 
- Find `Protege-<version>-win.zip`
  - most likely in your Downloads directory (or in This PC directory)
  - current version is Protege-5.5.0-win.zip
- Unzip the downloaded file with your favorite file compression utility
- You should see the Protege application and a file called 'run'
- To open Protege, double-click the 'run' file. This will open cmd.exe and it will take a bit to open the file.
- The fonts used by Protégé may be very small, especially on some high resolution monitors. To increase the font size, go to  File -> Preferences -> Renderer -> Font size.
- Exit Protégé after confirming that it can be launched.
- There should be a `Protege.l4j.ini` in the same directory as `Protege.exe`. Opening large ontologies like MONDO will require an increase to Protege's default maximum Java heap size, which is symbolized as `-Xmx<size>`. 4GB is usually adequate for opening MONDO, as long as 4GB of free memory is really available on your system before you launch Protégé! Allocating even more memory will improve some tasks, like reasoning. You can check your available memory by launching the Windows Task Manager, clicking on the **More details** button on the bottom of the window and then checking the Performance tab at the top of the window.
  - It's recommended to make a backup of `Protege.l4j.ini` before editing

Open `Protege.l4j.ini` with a lightweight text editor like Atom or Sublime. Using notepad.exe instead might work, but may change character encodings or the character(s) used to represent End of Line.  

After increasing the memory available to Protégé, `Protege.l4j.ini` might look like this. 

```
-Xms200M
-Xmx4G
-Xss16M
```

Note that there is no whitespace between `-Xmx`, the numerical amount of memory, and the Megabytes/Gigabytes suffix. Don't forget to save. 

Taking advantage of the memory increase requires that Protégé is shut down and relaunched, if applicable. The methods discussed here may not apply if Protégé  is launched through any method other than double clicking `Protege.exe` from the folder where the edited `Protege.l4j.ini` resides.

### Note on increasing memory

If you have issues opening Protege, then reduce the memory, try 10G (or lower) instead.

## Add ELK reasoner

See [instructions here](https://oboacademy.github.io/obook/howto/installing-elk-in-protege/). Note: Protege 5.6.1 has the ELK reasoner installed.

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
3. `Creator property` Add http://purl.org/dc/terms/contributor
4. `Creator value` Select Use ORCID
5. `Date property` Add http://purl.org/dc/terms/date
6. `Date value format` Select ISO-8601

## Install Protege OBO plugin

This plugin enables some extra functionality, such as the option to obsolete entities from the menu. To install it:

1. Go to `File > Check for plugins...`.
2. Click on `OBO Annotations Editor` and click on `Install`.
3. Restart Protege for the plugin to be active.
4. You should now have the option to obsolete entities in `Edit > Make entity obsolete`.
5. You can see a list of all installed plugins in `Preferences > Plugins`.
