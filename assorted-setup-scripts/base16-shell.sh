#!/bin/bash

# Install base16 themes for terminal
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

BASHRC="${HOME}/.bashrc"
echo >> ${BASHRC}
echo "# enable base16 shell themes" >> ${BASHRC}
echo 'BASE16_SHELL="$HOME/.config/base16-shell/"' >> ${BASHRC}
echo '[ -n "$PS1" ] && \' >> ${BASHRC}
echo '    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \' >> ${BASHRC}
echo '        eval "$("$BASE16_SHELL/profile_helper.sh")"' >> ${BASHRC}

echo "To activate a base16 theme, start a new shell and execute the command"
echo "'base16-default-dark' or similar. Tab completion is available."
