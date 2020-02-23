ARG pandoc_version

FROM pandoc/latex:${pandoc_version}

ARG pandoc_version_under
ARG crossref_release

# get crossref
RUN wget -O- "https://github.com/lierdakil/pandoc-crossref/releases/download/"${crossref_release}"/linux-pandoc_"${pandoc_version_under}".tar.gz" | tar zx -C/usr/bin/ ./pandoc-crossref && \
    # install python
    apk add make \
        python3 \
        py3-psutil \
    && python3 -m pip install --upgrade pip \
    # install pandoc-*nos filters
    && pip3 install \
        pandoc-eqnos \
        pandoc-fignos \
        pandoc-secnos \
        pandoc-tablenos \
    # required tex packages
    && `which tlmgr` update --self \
    && `which tlmgr` install cleveref footnotebackref mdframed zref needspace sourcecodepro titling sourcesanspro

LABEL maintainer='Jaromir Radek <jradek@yandex.com>'
LABEL org.pandoc.maintainer='Albert Krewinkel <albert+pandoc@zeitkraut.de>'
LABEL org.pandoc.author "John MacFarlane"
LABEL org.pandoc.version "${pandoc_version}"

WORKDIR /data
