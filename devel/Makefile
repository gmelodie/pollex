
all: start

devel : Dockerfile
	docker build -t devel:latest .

.PHONY: test clean

start: devel 
	make stop
	docker run -it --name devel --mount type=bind,source=`pwd`/../src,target=/home/devel/proj devel

stop:
	@if ! docker stop -t 0 devel  ; then exit 0; fi 
	@if ! docker rm devel ; then exit 0; fi
	@echo "Container stopped and removed"

clean:
	rm -f *~ \#*
