#!/bin/bash

# In 18.04 all bets are off.

# BASHRC="${HOME}/.bashrc"
# Prepare any nvidia driver for use with a cuda installed from e.g. anaconda:

# add nvidia driver to linker path if not the selected graphics card
# echo >> ${BASHRC}
# echo '# Add nvidia binaries and libraries to path if offline, for CUDA' >> ${BASHRC}
# echo 'if [ "'"$( prime-select query )"'" == "'"intel"'" ]' >> ${BASHRC}
# echo 'then' >> ${BASHRC}
# echo '    nvdir=( /usr/lib/nvidia-??? )' >> ${BASHRC}
# echo '    if [ ${#nvdir[@]} -ge 0 ]' >> ${BASHRC}
# echo '    then' >> ${BASHRC}
# echo '        export PATH="${nvdir[-1]}/bin${PATH:+:${PATH}}"' >> ${BASHRC}
# echo '        export LD_LIBRARY_PATH="${nvdir[-1]}${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"' >> ${BASHRC}
# echo '    fi' >> ${BASHRC}
# echo '    unset nvdir' >> ${BASHRC}
# echo 'fi 2>/dev/null' >> ${BASHRC}


# Manual CUDA install: lots of hoops to jump through, but in the end you want
# to add something like this to .bashrc:

# add cuda binaries to path
#if [ -d "/usr/local/cuda" ] ; then
#    PATH="/usr/local/cuda/bin:$PATH"

    # manually add cuda libraries to linker path
    #export CUDA_HOME="/usr/local/cuda"
    #export LD_LIBRARY_PATH="$CUDA_HOME/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"
    #export LD_LIBRARY_PATH="$CUDA_HOME/nvvm/lib64:${LD_LIBRARY_PATH}"
    #export LD_LIBRARY_PATH="$CUDA_HOME/extras/CUPTI/lib64:${LD_LIBRARY_PATH}"
    #export LD_LIBRARY_PATH="$CUDA_HOME/extras/Debugger/lib64:${LD_LIBRARY_PATH}"
#fi
