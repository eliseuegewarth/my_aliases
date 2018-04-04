#!/bin/bash
if [ -z "${CONFIGURADO}" ]; then
	echo "Iniciando configurações...";
	REPO_PATH=$(git rev-parse --show-toplevel);
	cd ~/Downloads/;

	# install nodejs 8, sublime text 3
	echo "apt install apt-transport-https curl ..." && \
	sudo apt-get -qq  -y install apt-transport-https curl && \
	echo "Adicionando chave pública sublime-text ..." && \
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - && \
	echo "Adicionando sublime-text em sources.list ..." && \
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list && \
	echo "Adicionando chave pública google-chrome-stable ..." && \
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && \
	echo "Adicionando google-chrome-stable em sources.list ..." && \
	echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list && \
	echo "Baixando script nodejs 8.x ..." && \
	curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && \
	echo "Adicionando chave pública Atom ..." && \
	curl -L https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add - && \
	echo "Adicionando Atom em sources.list ..." && \
	sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list' && \
	echo "Adicionando chave pública Docker CE ..." && \
	sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
	echo "Adicionando repositório Docker CE ..." && \
	sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main' && \
	echo "apt update ..." && \
	sudo apt-get -qq update && \
	echo "Checando repositório Docker CE ..." && \
	sudo apt-cache policy docker-engine && \
	echo "apt install ..." && \
	sudo apt-get -qq -y install nodejs build-essential google-chrome-stable sublime-text atom terminator docker-engine htop > /dev/null;
	echo "Baixando docker-compose ..." && \
	sudo curl -L https://github.com/docker/compose/releases/download/1.20.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && \
	echo "Adicionando permissões para docker-compose ..." && \
	sudo chmod +x /usr/local/bin/docker-compose && \
	echo "npm install react-native-cli ..." && \
	sudo npm install -g react-native-cli;



	echo "gsettings clock-show-date true ..." && \
	# General interface settings
	gsettings set org.gnome.desktop.interface clock-show-date "true";

	echo "gsettings image background ..." && \
	# image background
	sudo cp REPO_PATH/img/background.jpg /usr/share/backgrounds/background.jpg;
	sudo cp REPO_PATH/img/background.jpg /usr/share/backgrounds/ubuntu-gnome/background.jpg;
	gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/background.jpg';

	echo "gsettings icon-theme Shadow ..." && \
	# Icon theme
	sudo cd /usr/share/icons/ && git clone https://github.com/rudrab/Shadow.git --branch master --single-branch;
	gsettings set org.gnome.desktop.interface icon-theme "Shadow";

	echo "gsettings shell theme Flat-Remix-dark ..." && \
	# Shell Theme
	cd /tmp && rm -rf flat-remix-gnome-theme && \
	git clone https://github.com/daniruiz/flat-remix-gnome.git --branch master --single-branch && \
	mkdir -p ~/.themes && cp -r /tmp/flat-remix-gnome/Flat-Remix* ~/.themes && \
	gsettings set org.gnome.shell.extensions.user-theme name "Flat-Remix-dark";

	echo "Adicionando bash_env em bashrc ..." && \
	# General bash setup
	echo $'\nif [ -f ~/.bash_env ]; then\n    . ~/.bash_env\nfi' >> ~/.bashrc;

	echo "Criando links simbolicos bash_aliases e bash_env ..." && \
	ln -sf REPO_PATH/.bash_aliases ~/.bash_aliases;
	ln -sf REPO_PATH/.bash_env ~/.bash_env;

	echo "source bashrc ..." && \
	. ~/.bashrc;


	echo "Criando ~/workspace se não existir ..." && \
	# creating workspace
	if [ ! -d $WORKSPACE ]; then
	    echo "Configurando WORKSPACE para $WORKSPACE";
		sudo mkdir $WORKSPACE;
		sudo chown -R $USER:$USER $WORKSPACE;
	fi

	echo "Clonando repositórios ..." && \
	source REPO_PATH/git_start.sh

	echo "Finalizando configurações ..." && \
	export CONFIGURADO=true;
	echo 'export CONFIGURADO=true;'  >> ~/.bash_env;
	reload;
else
	echo "Tudo configurado!";
fi
