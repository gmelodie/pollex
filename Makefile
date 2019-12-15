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
#   all:		build the docker images
#
#   image_flask: 	builds flask image
#   image_angular:	builds angular image
#   images:		built both images
#
#   start_flask:	starts flask container
#   start_angular:	starts angular_container
#   start:	        starts both containers
#
#   stop_flask:		stop flask container
#   stop angular:       stop angular_container
#   stop:		stop both containers
#
#   list:		lists application's containers and images
#
#   login_flask:	log into a running flask container (bash prompt)
#   login_angular:	log into a running angular container (bash prompt)
#
#                           call 'exit' from the prompt to log out.
#
#   clean:		remove temporary files from work directory (as usual)
#   cleanup:    	remove both flask's and angular's containers and images

# User configs (defaults)

FLASK_PORT=8081
FLASK_NAME=pollex-flask
ANGULAR_PORT=8080
ANGULAR_NAME=pollex-angular
VERSION=dev

# Project configs

FLASK_IMAGE = $(FLASK_NAME)\:$(VERSION)
FLASK_CONTAINER = $(FLASK_NAME)-$(VERSION)
FLASK_DOCKERFILE = Dockerfile-flask

ANGULAR_IMAGE = $(ANGULAR_NAME)\:$(VERSION)
ANGULAR_CONTAINER = $(ANGULAR_NAME)-$(VERSION)
ANGULAR_DOCKERFILE = Dockerfile-angular

DOCKER = docker
MAKE = make

# Sources (TODO: enumerate sources explicitly rather than just loading up everything)

sources-flask = run.py app/* config/* instance/config.py
sources-angular = *

# Do it all

all : images 

instance/config.py:
	$(MAKE) -C polex-flask

# Build RP image

image_flask : $(FLASK_IMAGE)

image_angular: $(ANGULAR_IMAGE)

images : $(FLASK_IMAGE) $(ANGULAR_IMAGE)
	@$(DOCKER) image prune -f --filter "label=status=current"	

$(FLASK_IMAGE) : clean_dangling $(FLASK_DOCKERFILE) $(sources-flask:%=pollex-flask/%)
	$(DOCKER) build -f $(FLASK_DOCKERFILE) -t $(FLASK_IMAGE) .


$(ANGULAR_IMAGE) : clean_dangling $(ANGULAR_DOCKERFILE) $(sources-angular:%=pollex-angular/%)
	$(DOCKER) build -f $(ANGULAR_DOCKERFILE) -t $(ANGULAR_IMAGE) .
	@echo "Removing dangling previous version image"

# Start and stop containers

start: start_flask start_angular

stop: stop_flask stop_angular

start_flask: $(FLASK_IMAGE)
	$(MAKE) stop_flask
	$(DOCKER) run -itd -p $(FLASK_PORT):5000 --name $(FLASK_CONTAINER) $(FLASK_IMAGE)

stop_flask:
	if ! $(DOCKER) stop -t 0 $(FLASK_CONTAINER)  ; then exit 0; fi 
	if ! $(DOCKER) rm $(FLASK_CONTAINER) ; then exit 0; fi
	@echo "Container stopped and removed"

start_angular: $(ANGULAR_IMAGE)
	$(MAKE) stop_angular
	$(DOCKER) run -itd -p $(ANGULAR_PORT):4200 --name $(ANGULAR_CONTAINER) $(ANGULAR_IMAGE)

stop_angular:
	if ! $(DOCKER) stop -t 0 $(ANGULAR_CONTAINER)  ; then exit 0; fi 
	if ! $(DOCKER) rm $(ANGULAR_CONTAINER) ; then exit 0; fi
	@echo "Container stopped and removed"


.PHONY: start stop start_flask stop_flask start_angular stop_angular clean cleanup image_flask image_angular images clean_dangling

# Clean temporary files

clean:
	rm -f *~

# Clean temporary files and erase image

cleanup:
	$(MAKE) stop
	$(DOCKER) rmi -f $(FLASK_IMAGE) $(ANGULAR_IMAGE)
	$(MAKE) clean

clean_dangling:
	@echo "Removing dangling previous version image"
	@$(DOCKER) image prune -f --filter "label=status=current"	


# List items

list :
	@$(DOCKER) images | grep $(FLASK_NAME) ; exit 0
	@$(DOCKER) ps --all | grep $(FLASK_CONTAINER) ; exit 0
	@$(DOCKER) images | grep $(ANGULAR_NAME) ; exit 0
	@$(DOCKER) ps --all | grep $(ANGULAR_CONTAINER) ; exit 0

list-image :
	@$(DOCKER) images | grep $(FLASK_NAME) ; exit 0
	@$(DOCKER) images | grep $(ANGULAR_NAME) ; exit 0

list-instance :
	@$(DOCKER) ps --all | grep $(FLASK_CONTAINER) ; exit 0
	@$(DOCKER) ps --all | grep $(ANGULAR_CONTAINER) ; exit 0

# Log in (leave with 'exit' at bash prompt)

login_flask:
	$(DOCKER) exec -it $(FLASK_CONTAINER) /bin/bash

login_angular:
	$(DOCKER) exec -it $(ANGULAR_CONTAINER) /bin/bash

