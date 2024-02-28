# Running ODK with Podman

Some employers, in particular outside academia, may discourage the use of Docker via Docker Desktop for licensing reasons. [Podman](https://podman.io/) is an open source container, pod, and container image management engine. While there are some fundamental differences between Podman and Docker, a basic user can treat them as largely equivalent, for example by creating an alias from Podman's native `podman` command to Docker's `docker`.

Aliases work well for running `docker` commands directly but it create some issues around automatic processes in ODK since a locally set alias is not visible from ODK's `run.sh` script. As a result, a command like

```
sh run.sh make prepare_release -B
```

may give you the error message

```
./run.sh: line 68: docker: command not found

Please remember to update your ODK image from time to time: https://oboacademy.github.io/obook/howto/odk-update/.
```

To fix this, instead create a symlink between `docker` and the Podman executable. To do this, run

```
which podman
```

to find where podman is installed, then navigate to the Podman executable

```
cd /path/to/podman/bin
```

Now create the symlink using (requires admin privileges)

```
sudo ln -s podman docker
```

After this, running `ls -la` in the same directory should include a line like

```
docker -> podman
```


and `which docker` should return
```
/path/to/podman/bin/docker
```

Finally, ensure that the symlink is somewhere on your path (if it isn't already!) by running

```
export PATH=$PATH:/path/to/podman/bin
```

Restart your shell and you should find that your ODK `run.sh` script works again as expected.

## Warning!

The commands above were tested in `zsh` shell on a Mac. They should also work in an `bash` shell, on Mac or Linux. They may not work on Windows.

You could also edit the ODK `run.sh` script to use `podman` instead of `docker`, which would work with the previously mentioned `alias` solution but this is **NOT ADVISABLE** as the change would be overwritten every time the repo is updated. Plus, if your `run.sh` is committed into your Git repo, the change would affect all your fellow ontology editors.

