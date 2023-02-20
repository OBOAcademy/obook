# 5 step installation guide for Protégé
1. [Click here to find latest release of Protégé.](https://github.com/protegeproject/protege-distribution/releases)
Choose and download the appropriate files for your operating system (Linux, macOS, Windows, platform independent).
2. Use the [PGP signature](https://www.wikihow.com/Verify-a-PGP-Signature) contained in the appropriate file with an `.asc` extension [to verify the integrity of the downloaded Protégé version.](https://www.apache.org/info/verification.html)
3. Decompress the downloaded `.zip` or `.tar.gz` file with tools appropriate for your operating system.
4. Follow the steps as needed by your operating system to install the Protégé application.
For example, on macOS: drag and drop `Protégé.app` to the `Applications` folder and replace any older versions of the software.
You may need to [right click `Protégé.app` and then choose `Open` from the menu to authorise the programme to run on your machine.](https://wiki.geneontology.org/Protege5_6_setup_for_GO_Eds#Download_and_install_Protege)
Alternatively, go to `Preferences -> Security -> General`.
You need to open the little lock, then click `Mac stopped an application from Running (Protégé)` -> `Open anyways`.

5. Adjust memory settings if necessary.
Memory settings can now be adjusted in a *jvm.conf* configuration file that can be located either in the .protege/conf directory under your home directory, or in the conf directory within the application bundle itself.
For example, to set the maximum amount of memory available for Protégé to, say, 12GB, put the following in the jvm.conf file:
```
max_heap_size=12G
```
* On macOS, you can find the file is here:

```
/Applications/Protégé.app/Contents/conf/jvm.conf
```

Edit this part:

```
# Uncomment the line below to set the maximal heap size to 8G
#max_heap_size=8G
```
