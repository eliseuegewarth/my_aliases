#!/bin/bash
od="$PWD"
REPO_PATH="$(dirname "$0")"
if [[ -z "$(echo $REPO_PATH | grep -v '.')" ]]; then
	REPO_PATH=$PWD
else
	cd ${REPO_PATH}
fi
# Install Package Control for Sublime Text 3
SUBLIME_CONFIG_PATH="${HOME}/.config/sublime-text-3"
rm -rf ${SUBLIME_CONFIG_PATH}/Installed\ Packages/;
mkdir -p ${SUBLIME_CONFIG_PATH}/Installed\ Packages/ && \
cd ${SUBLIME_CONFIG_PATH}/Installed\ Packages/ && \
wget https://packagecontrol.io/Package%20Control.sublime-package && \
rm -rf ${SUBLIME_CONFIG_PATH}/Packages;
mkdir -p ${SUBLIME_CONFIG_PATH}/Packages && \
cd ${SUBLIME_CONFIG_PATH}/Packages && \
git clone https://bitbucket.org/hmml/jsonlint.git --single-branch --branch master && \
git clone https://github.com/djjcast/mirodark-st2 --single-branch --branch master && \
git clone --single-branch --branch master https://github.com/eliseuegewarth/material-theme.git Material\ Theme && \
git clone --single-branch --branch master https://github.com/eliseuegewarth/material-theme-appbar.git Material\ Theme\ -\ Appbar && \
rm -rf ${SUBLIME_CONFIG_PATH}/Packages/User;
mkdir -p ${SUBLIME_CONFIG_PATH}/Packages/User && \
cd ${SUBLIME_CONFIG_PATH}/Packages && \
cp ${REPO_PATH}/Preferences.sublime-settings Preferences.sublime-settings
cd "${od}"
