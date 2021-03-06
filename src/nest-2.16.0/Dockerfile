FROM volr/docker-nest-master:latest

MAINTAINER "Steffen Graber" <s.graber@fz-juelich.de>

ARG WITH_MPI=1
ARG WITH_GSL=1
ARG WITH_MUSIC=1
ARG WITH_LIBNEUROSIM=1

# add user 'nest'
RUN adduser --disabled-login --gecos 'NEST' --home /home/nest nest && \
    adduser nest sudo && \
    mkdir data && \
    chown nest:nest /home/nest

USER nest

RUN wget https://github.com/nest/nest-simulator/archive/v2.16.0.tar.gz && \
    tar -xvzf v2.16.0.tar.gz && \
    mkdir /home/nest/nest-build && \
    mkdir /home/nest/nest-install && \
    cd  /home/nest/nest-build && \
    cmake -DCMAKE_INSTALL_PREFIX:PATH=/home/nest/nest-install \
        -Dwith-python=3 \
        -Dwith-mpi:BOOL=$WITH_MPI \
        -Dwith-gsl:BOOL=$WITH_GSL /usr/local/lib \
        -Dwith-libneurosim:BOOL=$WITH_LIBNEUROSIM /usr/local/lib \
        -Dwith-music=$WITH_MUSIC /usr/lib \
        /home/nest/nest-simulator-2.16.0 && \
     make -j 8 && make install

# RUN su nest -c 'make installcheck'

USER root

COPY ./entrypoint.sh /home/nest/
RUN chown nest:nest /home/nest/entrypoint.sh && \
    chmod +x /home/nest/entrypoint.sh && \
    echo '. /home/nest/nest-install/bin/nest_vars.sh' >> /home/nest/.bashrc
EXPOSE 8080
WORKDIR /home/nest/data
ENTRYPOINT ["/home/nest/entrypoint.sh"]
