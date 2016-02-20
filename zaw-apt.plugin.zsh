function zaw-src-apt-cache () {
    local buf
    buf="($(apt-cache search .))"
    : ${(A)candidates::=${(f)buf}}
    : ${(A)cand_descriptions::=${(f)buf}}

    actions=(zaw-src-apt-get-install zaw-src-apt-cache-show zaw-src-apt-insert)
    act_descriptions=("install package" "show package info" "append to edit buffer")
    options+=(-m)
}

function _zaw-src-apt-cache-strip () {
local parts
parts=(${=1})
echo $parts[1]
}

function zaw-src-apt-insert () {
    local package
    package=$(_zaw-src-apt-cache-strip $1)
    zaw-callback-append-buffer $package
}

function zaw-src-apt-get-install () {
    BUFFER="sudo apt-get install $(_zaw-src-apt-cache-strip $1)"
    zle accept-line
}

function zaw-src-apt-cache-show () {
    BUFFER="apt-cache show $(_zaw-src-apt-cache-strip $1)"
    zle accept-line
}


zaw-register-src -n apt zaw-src-apt-cache
