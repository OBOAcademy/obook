# Using the ODK Toolbox

This tutorial will show you how to use the tools that are made available by
the ODK Docker images, independently of an ODK-generated repository and of
ODK-managed workflows.

## Prerequisites

You have:

- Docker installed and running on your machine.

You know:

- how to use a command line interface (e.g., run commands and navigate through
  a filesystem from a terminal prompt).


## Managing Docker images

Let’s check which Docker images, if any, are available in your Docker
installation:

```sh
$ docker images
REPOSITORY            TAG       IMAGE ID       CREATED        SIZE
```

Here, the listing comes up empty, meaning there are no images at all. This is
what you would expect if you have just installed Docker and have yet to do
anything with it.

Let’s download the main ODK image:

```sh
$ docker pull obolibrary/odkfull
Using default tag: latest
latest: Pulling from obolibrary/odkfull
[… Output truncated for brevity …]
Digest: sha256:272d3f788c18bc98647627f9e6ac7311ade22f35f0d4cd48280587c15843beee
Status: Downloaded newer image for obolibrary/odkfull:latest
docker.io/obolibrary/odkfull:latest
```

Let’s see the images list again:

```sh
$ docker images
REPOSITORY           TAG       IMAGE ID       CREATED        SIZE
obolibrary/odkfull   latest    0947360954dc   6 months ago   2.81GB
```

Docker images can exist in several versions, which are called _tags_ in Docker
parlance. In our `pull` command, since we have not specified any tag, Docker
had automatically defaulted to the `latest` tag, which by convention is the
latest ODK release.

To download a specific version, append the tag after the image name (you can
check which tags are available [on
DockerHub](https://hub.docker.com/r/obolibrary/odkfull/tags)). For example,
let’s download the 1.3.1 release from June 2022:

```sh
$ docker pull obolibrary/odkfull:v1.3.1
v1.3.1: Pulling from obolibrary/odkfull
Digest: sha256:272d3f788c18bc98647627f9e6ac7311ade22f35f0d4cd48280587c15843beee
Status: Downloaded newer image for obolibrary/odkfull:v1.3.1
docker.io/obolibrary/odkfull:v1.3.1
```

Again, let’s see the output of `docker images`:

```sh
$ docker images
REPOSITORY           TAG       IMAGE ID       CREATED        SIZE
obolibrary/odkfull   latest    0947360954dc   6 months ago   2.81GB
obolibrary/odkfull   v1.3.1    0947360954dc   6 months ago   2.81GB
```

Note how both the `latest` and the `v1.3.1` images have the same ID. This is
because, at the time of this writing, the 1.3.1 release _is_ the latest ODK
release, so the `latest` tag actually points to the same image as the `v1.3.1`
tag. This will change when the ODK v1.3.2 is released: then, using `latest`
(explicitly or by not specifying any tag at all) will point to the new
release, while `v1.3.1` will forever continue to point to the June 2022
release.

In the rest of this tutorial, we will always use the `latest` image, and so we
will dispense with the explicit tag. But remember that anywhere you see
`obolibrary/odkfull` in one of the commands below, you can always use
`obolibrary/odkfull:TAG` to force Docker to use a specific ODK version.


## Starting a container

Now that we have the ODK image available, let’s try to start it. The command
for that is `docker run`, which has the following syntax:

```
docker run [OPTIONS] <IMAGE> [COMMAND [ARGUMENTS...]]
```

where `IMAGE` is the name of the image to use (in our case, always
`obolibrary/odkfull`).

With the ODK, you will always need the `--rm` option. It instructs the Docker
engine to automatically remove the container it creates to run a command, once
that command terminates. (Not using the `--rm` option would lead to those
“spent” containers to accumulate on your system, ultimately forcing you to
manually remove them with the `docker container rm` command.)

If we don’t specify an explicit command, the simplest command line we can have
is thus:

```sh
$ docker run --rm obolibrary/odkfull
Usage: odk.py [OPTIONS] COMMAND [ARGS]...

Options:
  --help  Show this message and exit.

Commands:
  create-dynfile   For testing purposes
  create-makefile  For testing purposes
  dump-schema      Dumps the python schema as json schema.
  export-project   For testing purposes
  seed             Seeds an ontology project
$
```

In the absence of an explicit command, the default command `odk.py` is
automatically invoked by Docker. Since it has been invoked without any
argument, `odk.py` does nothing but printing its “usage” message before
terminating. When it terminates, the Docker container terminates as well, and
we are back at the terminal prompt.

To invoke one of the tools available in the toolbox (we’ll see what those
tools are later in this document), just complete the command line as needed.
For example, to test that ROBOT is there (and to see which version we have):

```sh
$ docker run --rm obolibrary/odkfull robot --version
ROBOT version 1.9.0
```


## Accessing your files from within the container

Since we have ROBOT, let’s use it. Move to a directory containing some
ontology files (here, I’ll use a file from the _Drosophila Anatomy Ontology_,
because if you have to pick an ontology, why not picking an ontology that
describes the One True Model Organism?).

```sh
$ ls
fbbt.obo
```

We want to convert that OBO file to a file in, say, the OWL Functional Syntax.
So we call ROBOT with the appropriate command and options:

```sh
$ docker run ---rm obolibrary/odkfull robot convert -i fbbt.obo -f ofn -o fbbt.ofn
org.semanticweb.owlapi.io.OWLOntologyInputSourceException: java.io.FileNotFoundException: fbbt.obo (No such file or directory)
Use the -vvv option to show the stack trace.
Use the --help option to see usage information.
```

Huh? Why the “No such file or directory” error? We just checked that
`fbbt.obo` is present in the current directory, why can’t ROBOT find it?

Because Docker containers run _isolated from the rest of the system_ – that’s
kind of the entire point of such containers in general! From within a
container, programs can, _by default_, only access files from the image from
which the container has been started.

For the ODK Toolbox to be at all useful, we need to explicitly allow the
container to access some parts of our machine. This is done with the `-v`
option, as in the following example:

```sh
$ docker run --rm -v /home/alice/fbbt:/work […rest of the command omitted for now…]
```

This `-v /home/alice/fbbt:/work` has the effect of _binding_ the directory
`/home/alice/fbbt` from our machine to the directory `/work` inside the
container. This means that if a program that runs within the container tries
to have a look at the `/work` directory, what this program will actually see
is the contents of the `/home/alice/fbbt` directory. Figuratively, the `-v`
option opens a window in the container’s wall, allowing to see parts of what’s
outside from within the container.

With that window, and assuming our `fbbt.obo` file is within the
`/home/alice/fbbt` directory, we can try again invoking the conversion
command:

```sh
$ docker run --rm -v /home/alice/fbbt:/work obolibrary/odkfull robot convert -i /work/fbbt.obo -f ofn -o /work/fbbt.ofn
$ ls
fbbt.obo
fbbt.ofn
```

This time, ROBOT was able to find out `fbbt.obo` file, and to convert it as we
asked.

We can slightly simplify the last command line in two ways.

First, instead of explicitly specifying the full pathname to the current
directory (`/home/alice/fbbt`), we can use the shell variable `$PWD`, which is
automatically expanded to that pathname: `-v $PWD:/work`.

Second, to avoid having to explicitly refer to the `/work` directory in the
command, we can ask the Docker engine to run our command as if the current
directory, within the container, was already `/work`. This is done with the
`-w /work` option.

The command above now becomes:

```sh
$ docker run --rm -v $PWD:/work -w /work obolibrary/odkfull robot convert -i fbbt.obo -f ofn -o fbbt.ofn
```

This is the typical method of invoking a tool from the ODK Toolbox to work on
files from the current directory.

In fact, this is exactly how the `src/ontology/run.sh` wrapper script, that is
automatically created in an ODK-generated repository, works. If you work with
an ODK-managed ontology, you can invoke an arbitrary ODK tool by using the
`run.sh` instead of calling `docker run` yourself. Assuming for example that
you already are in the `src/ontology` directory of an ODK-managed ontology,
you could use:

```sh
./run.sh robot convert -i fbbt.obo -f ofn -o fbbt.ofn
```

If you want to use the ODK toolbox with ontologies that are _not_ managed by
the ODK (so, where a `run.sh` script is not readily available), you can set up
an independent wrapper script, as explained in the [Setting up the
ODK](../howto/odk-setup.md#for-maclinux) tutorial.


## Running a shell session within the container

If you have several commands to invoke in a row involving files from the same
directory, you do not have to repeatedly invoke `docker run` once for each
command. Instead, you can invoke a shell, from which you will be able to run
successively as many commands as you need:

```sh
$ docker run --rm -ti -v $PWD:/work -w /work obolibrary/odkfull bash
root@c1c2c80c491b:/work# 
```

The `-ti` options allow to use your current terminal to control the shell that
is started within the container. This is confirmed by the modified prompt that
you can see above, which indicates that you are now “in” the container. You
can now directly use all the tools that you need:

```sh
root@c1c2c80c491b:/work# robot convert -i fbbt.obo -f owx -o fbbt.owl
root@c1c2c80c491b:/work# Konclude consistency -i fbbt.owl
{info} 18:21:14.543 >> Starting Konclude …
[…]
{info} 18:21:16.949 >> Ontology ‘out.owl’ is consistent.
root@c1c2c80c491b:/work#
```

When you are done, exit the shell by hitting `Ctrl-D` or with the `exit`
command. The shell will terminate, and with it, the container will terminate
as well, sending you back to your original terminal.


## What’s in the toolbox, actually?

Now that you know how to invoke any tool from the ODK Toolbox, here’s a quick
overview of which tools are available.

For a definitive list, the authoritative source is the [ODK
repository](https://github.com/INCATools/ontology-development-kit), especially
the `Dockerfile` and `requirements.txt.full` files. And if you miss a tool
that you think should be present in the toolbox, don’t hesitate to [open a
ticket](https://github.com/INCATools/ontology-development-kit/issues) to
suggest that the tool be added in a future ODK release!

### Programming language and associated tools
- Java Development Kit, Maven
- Ammonite (Scala scripting engine)
- Python3
- NodeJS

### Ontology manipulation tools
- [ROBOT](https://github.com/ontodev/robot)
- [OWLTools](https://github.com/owlcollab/owltools)
- [Ontology Access Kit](https://github.com/INCATools/ontology-access-kit)
- [Fastobo](https://github.com/fastobo/fastobo)
- [DOSDPTools](https://github.com/INCATools/dosdp-tools)

### Other semantic tools
- [Apache Jena](https://github.com/apache/jena)
- [Soufflé](https://github.com/souffle-lang/souffle)
- [Konclude](https://github.com/konclude/Konclude)
- [SSSOM-py](https://github.com/mapping-commons/sssom)
- [SPARQLProg](https://github.com/cmungall/sparqlprog)
- [curies](https://github.com/cthoyt/curies)
- [Bioregistry](https://github.com/biopragmatics/bioregistry)
