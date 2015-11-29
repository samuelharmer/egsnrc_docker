# egsnrc_docker
Docker Image for EGSnrc

### Manual build
```
$ docker build -t "egsnrc_image"
```

### Run from manual build
```
$ docker run -it egsnrc_image
```

### Run from Dockerhub
```
$ docker run -it nicornk/egsnrc_docker
$ # to test egsnrc, runs this after container start: 
$ tutor7pp -i test1 -p /root/EGSnrc/HEN_HOUSE/pegs4/data/tutor_data.pegs4dat 
```

### Run with support for X11 on OS X
To enable X11 support for this docker image on OS X, follow these steps (homebrew required, adapted from [this link](https://github.com/docker/docker/issues/8710)). 

```
$ brew install socat
$ brew cask install xquartz
$ open -a XQuartz
```
In the Quartz shell execute `echo $DISPLAY`. Copy the output. Open a new shell and run the following commands:

```
$ DISPLAY=<#VALUE_FROM_above e.g. /private/tmp/.../$ org.macosforge.xquartz:0>
$ export DISPLAY
$ socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"  
```

Keep this shell open. Open a new shell window and run `ifconfig`, copy the ip address of `vboxnet0` (e.g. 192.168.99.1).
Now you can start the container, replace placeholder with ip address.

```
$ docker run -it -e DISPLAY=<IP_ADDRESS>:0 nicornk/egsnrc_docker
$ # start egs_gui in container:
$ $HEN_HOUSE/bin/egs_gui
$ # start egs_inprz
$ $HEN_HOUSE/bin/egs_inprz
```