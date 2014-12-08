# Makefile for clearwater-seagull-cdf package

# This should come first so make does the right thing by default
all: deb

DEB_COMPONENT := clearwater-seagull-cdf-acr-aca
DEB_MAJOR_VERSION := 1${DEB_VERSION_QUALIFIER}
DEB_NAMES := clearwater-seagull-cdf-acr-aca
DEB_ARCH := all

include build-infra/cw-deb.mk

deb: deb-only

.PHONY: all deb
