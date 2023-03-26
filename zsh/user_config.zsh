# Install
#
# 1. oh-my-zsh
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#
# 2. antibody
# curl -sfL git.io/antibody | sh -s - -b /usr/local/bin
# or
# yay -S antibody
# or brew install antibody
#
# 3. fzf
# git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
# ~/.fzf/install
#
# 4. bat
# cargo install bat
# 

# User configuration

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    command-not-found
    extract
    autojump
    colored-man-pages
    safe-paste # 复制脚本后不会立即运行
    autopep8
    python
    rust
    pip
    tmux
    fzf
    ripgrep
    sudo
    virtualenv
)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source $ZSH/oh-my-zsh.sh
source <(antibody init)

antibody bundle romkatv/powerlevel10k
antibody bundle zsh-users/zsh-syntax-highlighting
antibody bundle Aloxaf/fzf-tab

# https://github.com/sharkdp/vivid
# cargo install vivid
if [[ -x "$(command -v vivid)" ]]; then
    export LS_COLORS="$(vivid generate molokai)"
fi

export LANG=en_US.UTF-8

# alias
alias vim='nvim'
alias rvim='/usr/bin/vim'
alias bcmake='cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1'
alias bmake='bear -- make'
alias bgcc='bear -- gcc'
alias bg++='bear -- g++'
alias bclang='bear -- clang'
alias bclang++='bear -- clang++'
alias open='open_command'

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#9ed072,bold'
if [[ $TMUX != "" ]] then
    export TERM="tmux-256color"
else
    export TERM="xterm-256color"
fi

export PATH=$HOME/.local/bin/:$PATH

case "$OSTYPE" in
    darwin*)
        # unalias ls
        # alias ls='LSCOLORS=gxfxcxdxbxexexabagacad /bin/ls -bHGLOPW'

        # for mac
        export PATH=/usr/local/opt/llvm/bin:$PATH
        export PATH=/usr/local/opt/gcc/bin:$PATH
        alias awk=gawk
        alias ls="gls --color"
        alias ubuntu='multipass shell'
        ;;
    linux*)
        if [[ "$(uname -r)" == *icrosoft* ]];
        then
            # 配置win32yank.exe
            # curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
            # unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
            # chmod +x /tmp/win32yank.exe
            # sudo mv /tmp/win32yank.exe /usr/local/bin/
            alias pbcopy='win32yank.exe -i --crlf'
            alias pbpaste='win32yank.exe -o --lf'

            # X11 configure
            # https://stackoverflow.com/questions/61110603/how-to-set-up-working-x11-forwarding-on-wsl2
            # export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
            # wslg
            export DISPLAY=:0
            # export LIBGL_ALWAYS_INDIRECT=1
        else
            alias pbcopy='xsel --clipboard --input'
            alias pbpaste='xsel --clipboard --output'
        fi
        ;;
esac

fzf-man-widget() {
  batman="man {1} | col -bx | bat --language=man --plain --color always --theme=\"Monokai Extended\""
   man -k . | sort \
   | awk -v cyan=$(tput setaf 6) -v blue=$(tput setaf 4) -v res=$(tput sgr0) -v bld=$(tput bold) '{ $1=cyan bld $1; $2=res blue;} 1' \
   | fzf  \
      -q "$1" \
      --ansi \
      --tiebreak=begin \
      --prompt=' Man > '  \
      --preview-window '50%,rounded,<50(up,85%,border-bottom)' \
      --preview "${batman}" \
      --bind "enter:execute(man {1})" \
      --bind "alt-c:+change-preview(cht.sh {1})+change-prompt(ﯽ Cheat > )" \
      --bind "alt-m:+change-preview(${batman})+change-prompt( Man > )" \
      --bind "alt-t:+change-preview(tldr --color=always {1})+change-prompt(ﳁ TLDR > )"
  zle reset-prompt
}
# `Ctrl-H` keybinding to launch the widget (this widget works only on zsh, don't know how to do it on bash and fish (additionaly pressing`ctrl-backspace` will trigger the widget to be executed too because both share the same keycode)
bindkey '^h' fzf-man-widget
zle -N fzf-man-widget
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# core dump location
# ulimit -c unlimited
# Arch:
# echo '/tmp/core_%e_%p' | sudo tee /proc/sys/kernel/core_pattern
# Ubuntu:
# sudo sysctl -w kernel.core_pattern=/tmp/core_%e_%p
