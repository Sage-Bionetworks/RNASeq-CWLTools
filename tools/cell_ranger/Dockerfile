# Base Image
FROM ubuntu:bionic

# Metadata
LABEL base_image="ubuntu:bionic"
LABEL software="Cell Ranger"
LABEL software.version="3.0.2"
LABEL about.documentation="https://github.com/10XGenomics/cellranger"
LABEL about.summary="Docker image for the CellRanger software.  This image is not provided\
    or supported by 10X Genomics, and uses the unsupported source code on github"
LABEL about.license="SPDX:MIT"
LABEL about.tags="scRNA"

# install dependencies
RUN apt-get update \
 && apt-get install -y \
    binutils \
    build-essential \
    clang-6.0 \
    curl \
    git \
    golang-1.9 \
    libatlas-base-dev \
    libz-dev \
    libbz2-dev \
    liblzma-dev \
    liblz4-tool \
    libopenblas-dev \
    python-numpy \
    python-pip \
    samtools \
    wget

# install python dependencies with pip
RUN pip install \
    cffi==1.13.2 \
    Cython==0.28.5 \
    docopts==0.6.1 \
    h5py==2.10.0 \
    Jinja2==2.10.3 \
    lz4==2.2.1 \
    pandas==0.24.2 \
    pyfasta==0.5.2 \
    pysam==0.15.3 \
    python-config==0.1.2 \
    pyvcf==0.6.8 \
    scipy==1.2.2 \
    sklearn==0.0 \
    tables==3.5.2

# export path to golang
ENV PATH="/usr/lib/go-1.9/bin:$PATH"

# download and install rustup
RUN curl https://sh.rustup.rs -sSf \
    | sh -s -- -y --profile minimal \
    --default-toolchain nightly

# export cargo path    
ENV PATH="/root/.cargo/bin:$PATH"

# install correct version of rustup
RUN rustup install 1.28.0 && rustup default 1.28.0

# Download precompiled martian and unpack
RUN wget https://github.com/martian-lang/martian/releases/download/v3.2.0/martian-v3.2.0-linux-x86_64.tar.gz \
  && tar -xf martian-v3.2.0-linux-x86_64.tar.gz && rm martian-v3.2.0-linux-x86_64.tar.gz

# Install STAR aligner
RUN wget https://github.com/alexdobin/STAR/archive/2.5.1b.tar.gz \
 && tar -xf 2.5.1b.tar.gz \
 && rm 2.5.1b.tar.gz \
 && cd STAR-2.5.1b \
 && make \
 && cp bin/Linux_x86_64/STAR /usr/bin \
 && cd .. \
 && rm -rf STAR-2.5.1b

# Install tsne
RUN git clone https://github.com/wpoehlm/tsne.git \
 && cd tsne \
 && make install \
 && cd .. \
 && rm -rf tsne

# clone cellranger sourcecode repo, cd into this dir, and install cellranger
RUN git clone https://github.com/wpoehlm/cellranger.git \
  && cd cellranger && make 

# setup environment to run cellranger
ENV PATH /cellranger/bin/:/cellranger/lib/bin:/cellranger/tenkit/bin/:/cellranger/tenkit/lib/bin:/martian-v3.2.0-linux-x86_64/bin:$PATH

ENV PYTHONPATH /cellranger/lib/python:/cellranger/tenkit/lib/python:$PYTHONPATH

ENV MROPATH /cellranger/mro:$MROPATH
