FROM ubuntu:jammy
MAINTAINER Hagen Fritsch <rumpeltux-songbookdocker@irgendwo.org>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q && \
    apt-get install --no-install-recommends -qy \
        ca-certificates \
        curl \
        fonts-freefont-otf \
        git \
        latexmk \
        lilypond \
        make \
        python3-pyparsing \
        texlive-base \
        texlive-fonts-recommended \
        texlive-music \
        texlive-xetex

# Install pdfsizeopt
RUN mkdir -p /usr/local/pdfsizeopt; \
    cd /usr/local/pdfsizeopt; \
    curl -L https://github.com/pts/pdfsizeopt/releases/download/2023-04-18/pdfsizeopt_libexec_linux-v9.tar.gz | tar xzo; \
    curl -L https://raw.githubusercontent.com/pts/pdfsizeopt/master/pdfsizeopt.single > pdfsizeopt; \
    chmod -R 755 .

# Install MuseJazz font
RUN curl -L https://github.com/musescore/MuseScore/raw/master/fonts/musejazz/MuseJazzText.otf \
        > /usr/share/fonts/opentype/MuseJazzText.otf && \
    fc-cache -f -v

WORKDIR /data
VOLUME ["/data"]
