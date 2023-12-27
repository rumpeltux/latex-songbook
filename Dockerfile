FROM ubuntu:jammy
MAINTAINER Hagen Fritsch <rumpeltux-songbookdocker@irgendwo.org>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q && \
    apt-get install -qy texlive-full wget make && \
    apt-get remove -qy texlive*doc

# Install more packages that are needed now that the songbook evolved.
RUN apt-get update -q && apt-get install -qy --no-install-recommends \
    git python3-pyparsing lilypond

# leadsheets bugfix (https://github.com/cgnieder/leadsheets/pull/18)
RUN sed -i 's/prop_gput:cnn/prop_gput:cnV/' /usr/share/texlive/texmf-dist/tex/latex/leadsheets/leadsheets.library.properties.code.tex

# Install pdfsizeopt
RUN mkdir -p /usr/local/pdfsizeopt; \
    cd /usr/local/pdfsizeopt; \
    wget -q -O - https://github.com/pts/pdfsizeopt/releases/download/2023-04-18/pdfsizeopt_libexec_linux-v9.tar.gz | tar xzo; \
    wget -q -O pdfsizeopt https://raw.githubusercontent.com/pts/pdfsizeopt/master/pdfsizeopt.single; \
    chmod -R 755 .

WORKDIR /data
VOLUME ["/data"]
