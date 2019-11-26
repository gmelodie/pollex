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
NAME=pollex
VERSION=dev

# Project configs

RP_IMAGE = $(NAME)\:$(VERSION)
RP_INSTANCE = $(NAME)-$(VERSION)
RP_SOURCE = Dockerfile
RPS = docker
MAKE = make

# Sources

sources = run.py app/* config/* instance/*

# Do it all

all : $(RP_IMAGE)

# Build RP image

$(RP_IMAGE) : $(RP_SOURCE) $(sources)
	$(RPS) build -t $(RP_IMAGE) .

# Start and stop RP instance

start: $(RP_IMAGE)
	$(MAKE) stop
	$(RPS) run -itd -p 8080:5000 --name $(RP_INSTANCE) $(RP_IMAGE)

stop:
	if ! $(RPS) stop -t 0 $(RP_INSTANCE)  ; then exit 0; fi 
	if ! $(RPS) rm $(RP_INSTANCE) ; then exit 0; fi
	@echo "Container stopped and removed"

.PHONY: test

# Clean temporary files

clean:
	rm -f *~

# Clean temporary files and erase image

cleanup:
	$(MAKE) stop
	$(RPS) rmi $(RP_IMAGE)
	$(MAKE) clean

# List items

list :
	@$(RPS) images | grep $(NAME) ; exit 0
	@$(RPS) ps --all | grep $(RP_INSTANCE) ; exit 0

list-image :
	@$(RPS) images | grep $(NAME) ; exit 0

list-instance :
	@$(RPS) ps --all | grep $(RP_INSTANCE) ; exit 0

# Log in (leave with 'exit' at bash prompt)

login:
	$(RPS) exec -it $(RP_INSTANCE) /bin/bash

