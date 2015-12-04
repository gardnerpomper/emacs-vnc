FROM gardnerpomper/minimal-xfce-xvnc-xrdp
MAINTAINER Gardner Pomper "gardner@networknow.org"
#
# ----- install git, firefox, emacs, docker and dependencies
#
RUN yum install -y	\
        docker firefox git make emacs cvs hg automake texlive python-pip texinfo bzr &&\
        yum clean all
RUN pip install pyflakes pep8
#
# ----- override the default .Xclients to start emacs on boot
#
COPY .Xclients /dhome/me/.Xclients
#
# ----- add the modified copy of github.com/jhamrick/emacs-master
#
USER me
WORKDIR /tmp
ADD emacs-master /tmp/emacs-master
RUN cd /tmp/emacs-master	&&\
    ./bootstrap.sh --force
#
# ----- switch back to root, because this will run the
# ----- ENTRYPOINT and CMD from the base image (minimal-xfce-xvnc-xrdp)
# ----- which will change the UID/GID of the "me" user, so
# ----- DO NOT put in a new ENTRYPOINT or CMD unless you check
# ----- what the existing ones are doing
#
USER root
