# User configuration

# plugins=(
#     git
#     command-not-found
#     extract
#     autojump
#     cp
#     colored-man-pages
#     safe-paste # 复制脚本后不会立即运行
#     autopep8
#     python
#     rust
#     rustup
#     cargo
#     pip
#     tmux
# )

# curl -sfL git.io/antibody | sh -s - -b /usr/local/bin
# or
# yay -S antibody
# or brew install antibody
source <(antibody init)

antibody bundle zsh-users/zsh-syntax-highlighting
antibody bundle zsh-users/zsh-history-substring-search
antibody bundle zsh-users/zsh-completions

for file (
    # racket completion
    /usr/share/racket/pkgs/shell-completion/racket-completion.zsh
    $HOME/.cargo/env
); do
  if [[ -r "$file" ]]; then
    source "$file"
  fi
done
unset file

export LANG=en_US.UTF-8

# alias
alias vim='nvim'
alias rvim='/usr/bin/vim'
alias cmake='cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1'
alias make='bear -- make'

# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=blue'
if [[ $TMUX != "" ]] then
    export TERM="tmux-256color"
else
    export TERM="xterm-256color"
fi

# https://gist.github.com/ntamvl/6597b6e28a50a592519a1e2c89fa4386
case "$OSTYPE" in
    darwin*)
        unalias ls
        alias ls='LSCOLORS=gxfxcxdxbxexexabagacad /bin/ls -bHGLOPW'
        
        # for mac 
        export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
        export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH
        export PATH=/usr/local/opt/llvm/bin:$PATH
        alias awk=gawk
        ;;
    linux*)
        # export PATH=$HOME/.gem/ruby/2.7.0/bin/:$PATH
        export PATH=$HOME/.local/bin/:$PATH
        alias open=xdg-open
        alias pbcopy='xsel --clipboard --input'
        alias pbpaste='xsel --clipboard --output'
        ;;
esac

# in WSL
ISWSL=`uname -r | grep microsoft`
if [ -n "$ISWSL" ]; then
    # 配置win32yank.exe
    # curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
    # unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
    # chmod +x /tmp/win32yank.exe
    # sudo mv /tmp/win32yank.exe /usr/local/bin/
    alias pbcopy='win32yank.exe -i --crlf'
    alias pbpaste='win32yank.exe -o --lf'

    # use files.exe or explorer.exe to open the specific path
    function open_wsl() {
        if [[ `which files.exe &>/dev/null && echo $?` == "0" ]]; then
            files.exe `wslpath -w "$1"` &
        else
            explorer.exe `wslpath -w "$1"` 
        fi
    }
    alias open='open_wsl'
    # X11 configure
    # https://stackoverflow.com/questions/61110603/how-to-set-up-working-x11-forwarding-on-wsl2
    export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
    export LIBGL_ALWAYS_INDIRECT=1
fi

# core dump location
# ulimit -c unlimited
# echo '/tmp/core_%e.%p' | sudo tee /proc/sys/kernel/core_pattern

