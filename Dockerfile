FROM ubuntu
MAINTAINER "Adib Afandi bin Abdullah <fendy90.oscura@gmail.com>"

ENV AMBERHOME=/opt/amber18
ENV AMBER_PREFIX=/opt/amber18
ENV PATH="${AMBER_PREFIX}/bin:${PATH}"
ENV PYTHONPATH="${AMBER_PREFIX}/lib/python3.6/site-packages"
ENV LD_LIBRARY_PATH="${AMBER_PREFIX}/lib"
ENV PATH="/opt/PnetCDF/bin:$PATH"
RUN apt-get update && \

# AmberTools 18
    apt-get -y install curl unzip wget && \
    apt-get -y install csh flex patch gfortran g++ make xorg-dev libbz2-dev zlib1g-dev \
                    libboost-dev libboost-thread-dev libboost-system-dev libboost-all-dev \
                    mpich libmpich-dev ssh && \
    wget http://cucis.ece.northwestern.edu/projects/PnetCDF/Release/parallel-netcdf-1.10.0.tar.gz && \
    tar -xzvf parallel-netcdf-1.10.0.tar.gz && cd parallel-netcdf-1.10.0 && \
    ./configure --prefix=/opt/PnetCDF && make && make install && \

    wget https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_linux_amd64.zip && \
    unzip pup_v0.4.0_linux_amd64.zip && chmod +x pup && \
    filename=AmberTools18.tar.bz2 && \
    fileid=1HBURnAo7G6_LqnY_OQba597xSBjt9OHe && \
    query=`curl -c ./cookie.txt -s -L "https://drive.google.com/uc?export=download&id=${fileid}" | ./pup 'a#uc-download-link attr{href}' | sed -e 's/amp;//g'` && \
    curl -s -b ./cookie.txt -L -o ${filename} "https://drive.google.com${query}" && \

    tar -xf AmberTools18.tar.bz2 -C /opt/ && \
    cd /opt/amber18 && echo -e 'y\ny' | ./configure gnu && make install && \
    ./configure -mpi --with-pnetcdf /opt/PnetCDF gnu && make install && \

    chmod -R 777 /opt && \
# cleanup
    rm /pup_v0.4.0_linux_amd64.zip /pup /AmberTools18.tar.bz2 && \
    apt-get -y purge curl unzip wget && \
    apt-get -y autoremove && apt-get -y clean && rm -rf /var/lib/apt/lists/*
