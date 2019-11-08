FROM ubuntu:latest

RUN apt-get update \
 && apt-get install -y \
    clang-6.0 \
    curl \
    cython \
    git \
    golang-1.10-go \
    libz-dev \
    libbz2-dev \
    liblzma-dev \
    python-numpy \
    python-pip

RUN pip install python-config docopts

ENV PATH="/usr/lib/go-1.10/bin:$PATH"

RUN curl https://sh.rustup.rs -sSf \
    | sh -s -- -y --profile minimal \
    --default-toolchain nightly
    
ENV PATH="/root/.cargo/bin:$PATH"

RUN rustup install 1.28.0 && rustup default 1.28.0

RUN git clone https://github.com/10XGenomics/cellranger 

RUN cd cellranger && make 

ENV PATH /cellranger/bin/:/cellranger/lib/bin:/cellranger/tenkit/bin/:/cellranger/tenkit/lib/bin:/martian/bin/:$PATH

ENV PYTHONPATH /cellranger/lib/python:/cellranger/tenkit/lib/python:/martian/adapters/python:$PYTHONPATH

ENV MROPATH /cellranger/mro/:/cellranger/tenkit/mro/
