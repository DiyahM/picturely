#!/bin/sh

# Calls annotate binary provided by the annotate gem to add schema
# comments to model files.

annotate --position before --show-migration --show-indexes --exclude tests --exclude fixtures $*
