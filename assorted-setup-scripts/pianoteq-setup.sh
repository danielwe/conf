#!/bin/bash

# Link Pianoteq plugins to the right directories

PIANOTEQ_VERSION="Pianoteq 6 STAGE"
PIANOTEQ_ROOT="$HOME/local/$PIANOTEQ_VERSION"
LV2_PATH="$HOME/.lv2"
LXVST_PATH="$HOME/.vst"

mkdir -p "$LV2_PATH"
mkdir -p "$LXVST_PATH"

ln -s "$PIANOTEQ_ROOT/amd64/$PIANOTEQ_VERSION.lv2" "$LV2_PATH"
ln -s "$PIANOTEQ_ROOT/amd64/$PIANOTEQ_VERSION.so" "$LXVST_PATH"
