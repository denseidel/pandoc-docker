PANDOC_VERSION ?= 2.9.1.1
CROSSREF_RELEASE="v0.3.6.1b"

# substitute dots '.' in version with underscores '_'
PANDOC_VERSION_UNDER = $(subst .,_,${PANDOC_VERSION})

# Used to specify the build context path for Docker.  Note that we are
# specifying the repository root so that we can
#
#     COPY latex-common/texlive.profile /root
#
# for example.  If writing a COPY statement in *ANY* Dockerfile, just know that
# it is from the repository root.
makefile_dir := $(dir $(realpath Makefile))

# Keep this target first so that `make` with no arguments will print this rather
# than potentially engaging in expensive builds.
.PHONY: show-args
show-args:
	@printf "PANDOC_VERSION (i.e. image version tag): %s\n" $(PANDOC_VERSION)
	@printf "CROSSREF_RELEASE: %s\n" $(CROSSREF_RELEASE)

################################################################################
# images and tests                                                             #
################################################################################

.PHONY: latex-with-filters all

latex-with-filters:
	docker build \
	    --tag jradek/pandoc-latex-with-filters:$(PANDOC_VERSION) \
	    --build-arg pandoc_version=$(PANDOC_VERSION) \
	    --build-arg pandoc_version_under=$(PANDOC_VERSION_UNDER) \
	    --build-arg crossref_release=$(CROSSREF_RELEASE) \
	    -f $(makefile_dir)/latex_with_filters/Dockerfile $(makefile_dir)

all: latex-with-filters

################################################################################
# Developer targets                                                            #
################################################################################

# .PHONY: clean
# clean:
# 	IMAGE=none make -C test clean
