###Generating OBO Semantic Engineer course content and deploying website
#
# These are standard options to make Make sane:
# <http://clarkgrubb.com/makefile-style-guide#toc2>

MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:
.SECONDARY:


.PHONY: deploy_site
deploy_site:
	mkdocs gh-deploy --config-file mkdocs.yml
