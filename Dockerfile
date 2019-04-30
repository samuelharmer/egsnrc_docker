FROM ubuntu:18.04
MAINTAINER Samuel Harmer, <me@samuelharmer.com>

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

# The base 18.04 should be relatively up-to-date, so is this necessary?
RUN apt-get -y update

# Install Git to fetch EGSnrc, and expect to install it
RUN apt-get -y install git expect

# Install EGSnrc requirements
RUN apt-get -y install gfortran g++ make

# What are we cleaning up here?
RUN apt-get -y autoremove

WORKDIR $HOME

# install egsnrc
RUN git clone --depth 1 https://github.com/nrc-cnrc/EGSnrc.git --branch v2018
COPY script.exp .
RUN chmod +x script.exp

#RUN export HEN_HOUSE= EGS_HOME= EGS_CONFIG=
RUN ./script.exp

# Only bother with bash as the default shell for root
ENV EGS_HOME   $HOME/EGSnrc/egs_home/
ENV EGS_CONFIG $HOME/EGSnrc/HEN_HOUSE/specs/linux.conf
RUN echo "source $HOME/EGSnrc/HEN_HOUSE/scripts/egsnrc_bashrc_additions" >> /etc/bash.bashrc


# Check we can build a module
# RUN cd $EGS_HOME/tutor7pp && make

# Check we can run the module in a container
# tutor7pp -i test1 -p $HOME/EGSnrc/HEN_HOUSE/pegs4/data/tutor_data.pegs4dat 

