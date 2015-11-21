# Emacs in a docker container
Gardner Pomper
gardner@networknow.org

** Tested on versions
* docker 1.9
* docker-machine

## Description

Configuring emacs is a skill beyond the capability of many of its
fans. I am a prime example, although I greatly appreciate what emacs
can do for me, getting all the packages working together is an arduous
task that I always give up on before I get it right. Stumbling on the
configuration made available by Jessica Hamrick
(jhamrick@berkeley.edu) was a delight, but not something I looked
forward to for each machine I might want to configure.

For this reason, and others, I wanted to get a docker container that
would let me run emacs on any machine, without requiring an X-windows
client. I build a
[xfce based desktop container](https://hub.docker.com/r/gardnerpomper/minimal-xfce-xvnc-xrdp/)
with VNC connectivity that could be used for this type of project and
set out to build an emacs container on top of it. This is the result.

## Running the image

Running this container starts an xfce desktop based on CentOS 7 with
only firefox and emacs installed. The image will create a user ("me")
with the specified UID and GID, to make it easier to mount a host volume
for editing without issues with file permissions. A typical run script is shown:

```
#!/bin/bash
#
# ----- run the xvnc container, with a user "me" whose UID and GID are
# ----- changed to match the current user. Override the default geometry
# ----- of the container to start it at 1024x768
# ----- open ports for VNC connections
#
docker run -it --rm -e NEWUID=$(id -u) -e NEWGID=$(id -g)	\
       -e GEOMETRY=1024x768	\
       -v $HOME:/host		\
       -p 5901:5901		\
       gardnerpomper/emacs-vnc $*
```

When the container starts up, it will prompt for the password which should
be used by the VNC client to make the connection.

Once connected to the desktop in the VNC client, you can start up
emacs from the "Application Menu". The first time emacs loads, it will
configure itself using the excellent emacs configuration provided by
jhamrick. This may take some signficant time (about 2 minutes on my Macbook Pro).

## Issues

I had to make a few modifications to the emacs project provided by
jhamrick. They are listed here, to make it easier to show that they
are minor. Each change is marked with my initials (gcp) and date.

| File | reason |
| ---- | ------ |
| .emacs | removed magit (requires later version of emacs) |
| | removed mumamo (could not get it to install) |
| .emacs.d/el-get-settings.el | removed magit (as above) |
| | nxhtml (required by mumamo; install failed) |
| .emacs.d/general-settings.el | enabled menubar and toolbar |
| | changed default window size |
| bootstrap.sh | removed prompts and reliance on git |

