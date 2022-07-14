# Install Elk 0.5 in Protege

- Click here to get the latest [Protege Plugin latest build](https://oss.sonatype.org/service/local/artifact/maven/content?r=snapshots&g=org.semanticweb.elk&a=elk-distribution-protege&e=zip&v=LATEST) (this is available on the bottom of [ELK pages](https://github.com/liveontologies/elk-reasoner/wiki/GettingElk). This will download a zipped file.)

- When downloaded, unzip and copy puli and elk jars (two .jar files) in the unpacked directory.
-  Paste these files in your Protege plugin directory.
-  Remove old org.semanticweb.elk.jar

- **Install ELK plugin on Mac:**

This can be done via one of two ways:

**Approach 1**

1. Paste these files in your Protege plugin directory. This is in one of two locations:
    - ~/.Protege/plugins (note this is usually hidden from finder, but you can see it in the terminal) or
    - Go to Protege in Applications (Finder), right click, 'Show package contents' -> Java -> plugins
2. If a directory called `plugins` does not exist in this folder, create it.
3. Copy and paste the two files into the plugins directory
4. Remove old elk.jar (Ex. org.semanticweb.elk.jar)
5. Restart Protege. You should see ELK 0.5 installed in your Reasoner menu. 

For a video showing how to install Elk on a Mac, click [here](https://www.dropbox.com/s/n3td2n48xmwd3mj/Install_ELK_0.5.mov?dl=0)   

**Approach 2**

1. In Terminal:
    `open ~/.Protege, then click on plugins`
2. Click on plugins
3. Copy and paste the two files into the plugins directory
4. Remove old elk.jar (Ex. org.semanticweb.elk.jar)
5. Restart Protege. You should see ELK 0.5 installed in your Reasoner menu. 
    
Important: it seems Elk 0.5. Does not work with all versions of Protege, in particular, 5.2 and below. These instructions were only tested with Protege 5.5.
