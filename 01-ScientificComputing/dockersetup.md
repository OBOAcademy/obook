# Getting set up with Docker and the Ontology Development Kit

## Installation

### For Windows

- Follow the instructions [here](https://hub.docker.com/editions/community/docker-ce-desktop-windows). Note that you should have Windows 10 Professional installed for this to work. We are not sure Docker Desktop works at all with Windows 10 Home, but we have not tried in a while. If you know what you are doing, you could try to configure Docker toolbox, but we have had many issues with it, and do not recommend it unless absolutely necessary.
- Once installed, you should be able to open your command line and download the ODK.
  - Click on your Windows symbol (usually in bottom left corner of screen), type "cmd" and you should be able to see and open the Command Line tool.
  - in the command line type, type `docker pull obolibrary/odkfull`. This will download the ODK (will take a few minutes, depending on you internet connection).
- Executing something in a Docker container can be "wordy", because the docker container requires quite a few parameters to be run. To make this easier, we prepared a wrapper script [here](https://github.com/jamesaoverton/obook/blob/master/resources/odk.bat). You can download this file by clicking on `Raw`, and then, when the file is open in your browser, CTRL+S to save it. Ideally, you save this file in your project directory, the directory you will be using for your exercises, as it will only allow you to edit files in that very same directory (or one of its sub-directories).
- Setting the memory: 
Typical issues (WSL 1 vs 2)
4. 