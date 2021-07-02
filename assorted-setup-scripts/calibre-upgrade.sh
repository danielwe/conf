#!/bin/bash

# Install/upgrade calibre
LOCAL="${HOME}/local"
wget -nv -O- https://download.calibre-ebook.com/linux-installer.py | \
python -c "import sys; main=lambda x,y:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main('${LOCAL}', True)"
