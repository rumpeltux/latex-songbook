FROM ubuntu:jammy
MAINTAINER Hagen Fritsch <rumpeltux-songbookdocker@irgendwo.org>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q && \
    apt-get install --no-install-recommends -qy \
        fonts-freefont-otf \
	latexmk \
	lilypond \
	python3-pyparsing \
        texlive-base \
	texlive-fonts-recommended \
        texlive-music \
        texlive-xetex \
        wget make && \
    apt-get remove -qy texlive*doc

# Install pdfsizeopt
RUN mkdir -p /usr/local/pdfsizeopt; \
    cd /usr/local/pdfsizeopt; \
    wget -q -O - https://github.com/pts/pdfsizeopt/releases/download/2023-04-18/pdfsizeopt_libexec_linux-v9.tar.gz | tar xzo; \
    wget -q -O pdfsizeopt https://raw.githubusercontent.com/pts/pdfsizeopt/master/pdfsizeopt.single; \
    chmod -R 755 .

WORKDIR /data
VOLUME ["/data"]
