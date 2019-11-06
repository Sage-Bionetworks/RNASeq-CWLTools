FROM ubuntu:latest

COPY cellranger-3.1.0.tar.gz /usr/local/bin

RUN tar -xf /usr/local/bin/cellranger-3.1.0.tar.gz && rm /usr/local/bin/cellranger-3.1.0.tar.gz

ENV PATH="/cellranger-3.1.0:${PATH}"

CMD ["/bin/bash"]
