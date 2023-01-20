# Getting set up with Docker and the Ontology Development Kit

## Installation

### For Windows

- Follow the instructions [here](https://hub.docker.com/editions/community/docker-ce-desktop-windows). Note that you should have Windows 10 Professional installed for this to work. We are not sure Docker Desktop works at all with Windows 10 Home, but we have not tried in a while. If you know what you are doing, you could try to configure Docker toolbox, but we have had many issues with it, and do not recommend it unless absolutely necessary.
    - If you are unable to install Docker Desktop on your Windows PC (e.g. no admin rights or pohibited by the IT department of your institution) but you have the ability to use the Windows [Hyper-V-Manager](https://adamtheautomator.com/hyper-v-windows-10/) (possible [w/o admin rights](https://www.ibm.com/docs/en/capm?topic=cmhvm-adding-non-administrator-user-in-hyper-v-administrator-users-group)) or another virtualization tool, such as [VirtualBox](https://www.virtualbox.org/), you could set up a Linux virtual machine (VM) to use ODK. We recommend using [Lubuntu](https://lubuntu.me/), as it won't need much computing resources. Although you cannot install Docker Desktop in such a VM, you can [install the Docker Engine](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository), which suffices to proceed with the next step.
- Once installed, you should be able to open your command line and download the ODK.
  - Click on your Windows symbol (usually in bottom left corner of screen), type "cmd" and you should be able to see and open the Command Line tool.
  - in the command line type, type `docker pull obolibrary/odkfull`. This will download the ODK (will take a few minutes, depending on you internet connection).
- Executing something in a Docker container can be "wordy", because the docker container requires quite a few parameters to be run. To make this easier, we prepared a wrapper script [here](../resources/odk.bat). You can download this file by clicking on `Raw`, and then, when the file is open in your browser, CTRL+S to save it. Ideally, you save this file in your project directory, the directory you will be using for your exercises, as it will only allow you to edit files in that very same directory (or one of its sub-directories).
- Setting the memory:
  Typical issues (WSL 1 vs 2)

### For Mac/Linux

- [Install docker](https://www.docker.com/get-docker): Install Docker following the official instructions.
- Make sure its running properly, for example by typing `docker ps` in your terminal or command line (CMD). If all is ok, you should be seeing something like:

```
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

- Run `docker pull obolibrary/odkfull` on your command line to install the ODK. This will take while.
- Download an [ODK wrapper script](../resources/odk.sh). The odk.sh has further instruction on how to best use it.
- Now you are ready to go to a directory containing the odk.sh wrapper script and running `sh odk.sh robot --version` to see whether it works.
- The ODK wrapper script is generally useful to have: you can for example enter a ODK container, similar to a virtual machine,
  by simply running `sh odk.sh bash` (to leave the ODK container again, simply run `exit` from within the container). On Windows, use `run.bat bash` instead.
  However, for many of the ontologies we develop, we already ship an ODK wrapper script in the ontology repo, so we dont need the odk.sh or odk.bat file.
  That file is usually called `run.sh` or `run.bat` and can be found in your ontology repo in the `src/ontology` directory
  and can be used in the exact same way.

<a id="memory"></a>

## Problems with memory (important)

One of the most frequent problems with running the ODK for the first time is failure because of lack of memory.
There are two potential causes for out-of-memory errors:

1. The application (for example, the ODK release run) needs more memory than assigned to `JAVA` _inside the ODK docker container_. This memory is set as part of the ODK wrapper files, i.e. `src/ontology/run.bat` or `src/ontology/run.sh`, usually with `ODK_JAVA_OPTS`.
2. The application needs more memory than is assigned to your docker installation. On most systems (apart from a handful fo Windows ones based on WSL), you have to set docker memory in the docker preferences. That happens here is that the Java memory above may be set to something like 10GB, while the maximum docker memory is set to 8GB. If the application needs, say, 9GB to run, you have assigned enough Java memory, but docker does not permit more than 8 to be used.

Out-of-memory errors can take many forms, like a Java OutOfMemory exception,
but more often than not it will appear as something like an `Error 137`.

### Solving memory issues

#### Setting memory limits:

There are two places you need to consider to set your memory:

1. Your ODK wrapper script (see above), i.e. odk.bat, odk.sh or src/ontology/run.sh (or run.bat) file. You can set the memory in there by adding
   `robot_java_args: '-Xmx8G'` to your src/ontology/cl-odk.yaml file, see for example [here](https://github.com/INCATools/ontology-development-kit/blob/0e0aef2b26b8db05f5e78b7c38f807d04312d06a/configs/uberon-odk.yaml#L36).
2. Set your docker memory. By default, it should be about 10-20% more than your `robot_java_args` variable. You can manage your memory settings
   by right-clicking on the docker whale in your system bar-->Preferences-->Resources-->Advanced, see picture below.

![dockermemory](../images/docker_memory.png)

#### More intelligent pipeline design

If your problem is that you do not have enough memory on your machine, the only solution is to try to engineer the pipelines a bit more intelligently, but even that has limits: large ontologies require a lot of memory to process when using ROBOT. For example, handling ncbitaxon as an import in any meaningful way easily consumes up to 12GB alone. Here are some tricks you may want to contemplate to reduce memory:

- `robot query` uses an entirely different framework for representing the ontology, which means that whenever you use ROBOT query, for at least a short moment, you will have the entire ontology in memory _twice_. Sometimes you can optimse memory by seperating `query` and other `robot` commands into seperate commands (i.e. not chained in the same `robot` command).
- The `robot reason` command consumes _a lot_ of memory. `reduce` and `materialise` potentially even more. Use these only ever in the last possible moment in a pipeline.

- `
