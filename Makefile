# Makefile - Build script for pollex runtime partition
#
#    Copyright (c) 2019 - Open Source Competencer Center ICMC-USP
#
#    This file is part of Pollex.
#
#    Pollex is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    Pollex is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

# QUICK START
# 
# Pollex is meant to run within a Runtime Parition System (RPS).
# Currently, the project uses Docker as the RPS.
# Available build targets:
#
#   all:	builds RP image (Docker image)
#   start:	bring up RP instance (Docker container)
#   stop:	gring down RP instance
#   login:      login into a running RP instance
#   clean:	remove temporary files
#   cleanup:    cleans and remove RP image

# User configs (defaults)

PORT=8080
FLASK_NAME=pollex
VERSION=dev

# Project configs

FLASK_IMAGE = $(FLASK_NAME)\:$(VERSION)
FLASK_CONTAINER = $(FLASK_NAME)-$(VERSION)
FLASK_DOCKERFILE = Dockerfile-flask
DOCKER = docker
MAKE = make

# Sources

sources-flask = run.py app/* config/* instance/config.py

# Do it all

all : $(FLASK_IMAGE)

instance/config.py:
	$(MAKE) -C polex-flask

# Build RP image

$(FLASK_IMAGE) : $(FLASK_DOCKERFILE) $(sources-flask:%=pollex-flask/%)
	$(DOCKER) build -f $(FLASK_DOCKERFILE) -t $(FLASK_IMAGE) .
	@echo "Removing dangling previous version image"
	@$(DOCKER) image prune -f --filter "label=status=current"	

# Start and stop RP instance

start: $(FLASK_IMAGE)
	$(MAKE) stop
	$(DOCKER) run -itd -p 8080:5000 --name $(FLASK_CONTAINER) $(FLASK_IMAGE)

stop:
	if ! $(DOCKER) stop -t 0 $(FLASK_CONTAINER)  ; then exit 0; fi 
	if ! $(DOCKER) rm $(FLASK_CONTAINER) ; then exit 0; fi
	@echo "Container stopped and removed"

.PHONY: test

# Clean temporary files

clean:
	rm -f *~

# Clean temporary files and erase image

cleanup:
	$(MAKE) stop
	$(DOCKER) rmi $(FLASK_IMAGE)
	$(MAKE) clean

# List items

list :
	@$(DOCKER) images | grep $(FLASK_NAME) ; exit 0
	@$(DOCKER) ps --all | grep $(FLASK_CONTAINER) ; exit 0

list-image :
	@$(DOCKER) images | grep $(FLASK_NAME) ; exit 0

list-instance :
	@$(DOCKER) ps --all | grep $(FLASK_CONTAINER) ; exit 0

# Log in (leave with 'exit' at bash prompt)

login:
	$(DOCKER) exec -it $(FLASK_CONTAINER) /bin/bash

