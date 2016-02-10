FROM ubuntu:trusty
MAINTAINER Scalatekids <scalatekids@gmail.com>

RUN ["apt-get", "update"]
RUN [ "apt-get", "install", "-qy", "--force-yes", \
	  "texlive", \
	  "texlive-latex-extra", \
	  "texlive-fonts-extra", \
	  "poppler-utils", \
      "ruby" ]

RUN [ "apt-get", "clean" ]

COPY lib/lib.sh /usr/bin/lib.sh

RUN mkdir /root/input
COPY mispelled.txt /root/input/mispelled.txt

COPY build /usr/bin/build
RUN chmod +x /usr/bin/build

COPY gulpease /usr/bin/gulpease
RUN chmod +x /usr/bin/gulpease

COPY replacegloss /usr/bin/replacegloss
RUN chmod +x /usr/bin/replacegloss

COPY findgloss /usr/bin/findgloss
RUN chmod +x /usr/bin/findgloss

COPY verify /usr/bin/verify
RUN chmod +x /usr/bin/verify

COPY verifygloss /usr/bin/verifygloss
RUN chmod +x /usr/bin/verifygloss

ADD readability /usr/bin/readability
RUN chmod +x /usr/bin/readability

ADD readaruby /usr/bin/readaruby
RUN chmod +x /usr/bin/readaruby

ENV TEXMFHOME /root/texmf
ADD local /root/texmf/tex/latex

RUN texhash
RUN mktexlsr /root/texmf

#VOLUME /latex
VOLUME /root/actorbase
WORKDIR /root/actorbase
