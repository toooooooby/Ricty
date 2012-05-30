#!/bin/bash
set -ex   # stop on error("-e") , and debug("-x")

#OPTIONS='-a'
OPTIONS=$RICTY_OPTIONS

MIGU1M='http://sourceforge.jp/frs/redir.php?m=iij&f=%2Fmix-mplus-ipa%2F55556%2Fmigu-1m-20120411.zip'

DIR=$(pwd)
DISTRO="$(lsb_release --id --short)"  # => "Ubuntu"
DISTRO_VERSION="$(lsb_release --release --short)" # => "11.10" or "12.04"

# fill the requirements for build
if [[ "$DISTRO" == 'Ubuntu' && "$DISTRO_VERSION" == '12.04' ]] ; then
    sudo apt-get install -y fontforge ttf-inconsolata
fi

pushd $(mktemp -d)
    # download and unzip requirements 
    wget "$MIGU1M"
    unzip $(basename $MIGU1M)

    ls 

    # build ricty
    sh $DIR/ricty_generator.sh $OPTIONS auto

    # install to local
    mkdir -p ~/.fonts/
    cp -f Ricty*.ttf ~/.fonts/
    fc-cache -vf
popd

