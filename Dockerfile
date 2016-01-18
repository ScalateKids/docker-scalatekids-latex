FROM ubuntu:trusty
MAINTAINER Scalatekids <scalatekids@gmail.com>

RUN ["apt-get", "update"]
RUN [ "apt-get", "install", "-qy", "--force-yes", \
	  "texlive", \
	  "texlive-latex-extra", \
	  "texlive-fonts-extra", \
	  "poppler-utils" ]
RUN [ "apt-get", "clean" ]

COPY lib/lib.sh /usr/bin/lib.sh

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

ENV TEXMFHOME /root/texmf
ADD local /root/texmf/tex/latex

RUN texhash
RUN mktexlsr /root/texmf

#VOLUME /latex
VOLUME /root/actorbase
WORKDIR /root/actorbase
