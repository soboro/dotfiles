export CLICOLOR=1
export LSCOLORS=dxfxcxdxbxegedabagacad

export PATH="/usr/local/bin:$PATH"
#MacVim
export PATH=/Applications/MacVim.app/Contents/MacOS:$PATH
# PHP5
export PATH=/usr/local/php5/bin:$PATH
# rbenv
PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

