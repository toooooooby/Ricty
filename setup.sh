#!/bin/bash
set -ex   # stop on error("-e") , and debug("-x")

#OPTIONS='-a'
OPTIONS=$RICTY_OPTIONS

MIGU1M='http://sourceforge.jp/frs/redir.php?m=iij&f=%2Fmix-mplus-ipa%2F56156%2Fmigu-1m-20120411-2.zip'

DIR=$(pwd)
DISTRO="$(lsb_release --id --short)"  # => "Ubuntu"
DISTRO_VERSION="$(lsb_release --release --short)" # => "11.10" or "12.04"

# **"How to use" is from `ricty_generator.sh`**
# > How to use:
# > 1. Install FontForge
# > 2. Get Inconsolata.otf
# fill the requirements for build
if [[ "$DISTRO" == 'Ubuntu' && "$DISTRO_VERSION" == '12.04' ]] ; then
    sudo apt-get install -y fontforge ttf-inconsolata
fi

pushd $(mktemp -d)
    # > 3. Get migu-1m-regular/bold.ttf
    # >                   Get from http://mix-mplus-ipa.sourceforge.jp/
    # download and unzip requirements 
    wget "$MIGU1M"
    unzip $(basename $MIGU1M)

    ls 

    # > 4. Run this script
    # >    % sh ricty_generator.sh auto
    # >    or
    # >    % sh ricty_generator.sh Inconsolata.otf migu-1m-regular.ttf migu-1m-bold.ttf
    # build ricty
    sh $DIR/ricty_generator.sh $OPTIONS auto

    # > 5. Install Ricty
    # >    % cp -f Ricty*.ttf ~/.fonts/
    # >    % fc-cache -vf
    # install to local
    mkdir -p ~/.fonts/
    cp -f Ricty*.ttf ~/.fonts/
    fc-cache -vf

    ls -laFh ~/.fonts/Ricty*.ttf
popd

