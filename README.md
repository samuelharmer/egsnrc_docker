# egsnrc_docker

A Docker image for running [EGSnrc][1] simulations.

On its own the image is not much use as no user codes have been compiled. Instead it is intended to be used as a base for images containing compiled user codes for specific uses. It is assumed these simulations will be running headlessly (i.e. without a GUI).

## Using the image

We can pull the latest image from [Docker Hub][2] and start a new container based on it in a single step.
```
$ docker run -it samuelharmer/egsnrc
root@ec13bbaf593e:~# exit
```

Or we can use a specific version of EGSnrc.
```
$ docker run -it samuelharmer/egsnrc:v2018
root@dc8189614e92:~# 
```

From within a container we can now test it by making the *tutor7pp* user code, and running it.
```
root@4ec00661c701:~# make -C $EGS_HOME/tutor7pp
root@4ec00661c701:~# tutor7pp -i test1 -p $HEN_HOUSE/pegs4/data/tutor_data.pegs4dat
```


## Building the image

We can build this image ourselves locally.
```
$ docker build -t egsnrc
```

Assuming the build succeeded, we now want to tag this ready for pushing to [Docker Hub][2].
```
$ docker tag egsnrc samuelharmer/egsnrc
$ docker tag egsnrc samuelharmer/egsnrc:v2018
```

Now we can login to [Docker Hub][2], and upload the new image.
```
$ docker login -u samuelharmer
$ docker push samuelharmer/egsnrc
```

[1]: https://github.com/nrc-cnrc/EGSnrc
[2]: https://hub.docker.com/r/samuelharmer/egsnrc

