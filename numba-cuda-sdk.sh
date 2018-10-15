#!/bin/sh

# Make the numba installed in the current conda env to pick up the system-wide CUDA SDK
# rather than a conda-installed cudatoolkit. The paths are correct as of CUDA 10.0 on
# Ubuntu.
ACTIVATE_D="$CONDA_PREFIX/etc/conda/activate.d"
DEACTIVATE_D="$CONDA_PREFIX/etc/conda/deactivate.d"
ACTIVATE_F="$ACTIVATE_D/env_vars.sh"
DEACTIVATE_F="$DEACTIVATE_D/env_vars.sh"

mkdir -p "$ACTIVATE_D"
echo "#!/bin/sh" > "$ACTIVATE_F"
echo "" >> "$ACTIVATE_F"
echo 'export NUMBAPRO_CUDALIB="/usr/local/cuda/lib64"' >> "$ACTIVATE_F"
echo 'export NUMBAPRO_NVVM="/usr/local/cuda/nvvm/lib64/libnvvm.so"' >> "$ACTIVATE_F"
echo 'export NUMBAPRO_LIBDEVICE="/usr/local/cuda/nvvm/libdevice"' >> "$ACTIVATE_F"

mkdir -p "$DEACTIVATE_D"
echo "#!/bin/sh" > "$DEACTIVATE_F"
echo "" >> "$DEACTIVATE_F"
echo 'unset NUMBAPRO_LIBDEVICE' >> "$DEACTIVATE_F"
echo 'unset NUMBAPRO_NVVM' >> "$DEACTIVATE_F"
echo 'unset NUMBAPRO_CUDALIB' >> "$DEACTIVATE_F"

ENV_NAME="$CONDA_DEFAULT_ENV"
conda deactivate
conda activate "$ENV_NAME"
