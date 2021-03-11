#!/bin/bash

echo "--------------------------------------------"

# ----- Variables ----- #

personal_username="BugmanPy"
personal_email="thejus10011@gmail.com"
personal_pass="714cdd971c7f66ea8e3d26560c5fec0358dc23af"

prof_username="Thejus5"
prof_email="thejus@qburst.com"
prof_pass="thejusqburst@github0"

star_username="sabir"
star_email="sabir@qburst.com"
star_pass="qburst@123"

mad_username="mad-meenu"
mad_email="meenus@yeswearemad.com"
mad_pass="yeswearemad@123"

# ----- Functions ----- #

configureGit() {
	clearConfigs

	echo ">>> setting global username for $1"
	git config --global user.name "$1"
	git config --global user.email "$2"

	echo ">>> All done."
}

clearConfigs() {
	dropcachedCredentials
	git config --global --unset-all user.name
	git config --global --unset-all user.email
	echo ">>> Deleted global git configs"
}

createCustomConfig() {
	read -p ">>> Github username: " custom_username
	read -p ">>> Github email: " custom_email
	echo " "

	configureGit "$custom_username" "$custom_email"
}

getCurrendConfigs() {
	current_configs=$(git config --list)

	if test -z "$current_configs"; then
		echo ">>> No configs are active in global"
	else
		echo "$current_configs"
	fi
}

pushWithCred() {
	if test -z "$1"; then
		echo "please enter a brach to push."
		echo "use -h or --help to see usage"
	elif [ $1 != "save" ]; then
		if test -z "$2"; then
			git push origin "$1"
		elif [ $2 == "save" ]; then
			echo "Credentials will be catched for 24 hrs."
			git config credential.helper 'cache --timeout=86400'
			git push origin "$1"
		else
			echo "incorrect argument."
			echo "use -h or --help to see usage"
		fi
	else
		echo "save cannot be a branch name. Sorry"
	fi
	# git push origin "$1"
}

dropcachedCredentials (){
	git credential-cache exit
	echo ">>> Cleared cached credentials"
}

help() {
	echo "COMMANDS HELP"
	echo " "
	echo "options:"
	echo " -h, --help                Show brief help"
	echo " -per                      Set personal profile as git config in global (BugmanPy)"
	echo " -prof                     Set work profile as git config in global (Thejus5)"
	echo " -mad                      Set mad project profile as git config in global (mad-meenu)"
	echo " -star                     Set Starsona project profile as git config in global (sabir)"
	echo " -cl, --clear              Clear the global config and remove cached credentials"
	echo " -c, --custom              Create custom global config"
	echo " push <branch> save        Push to <branch> in origin by caching login credentials for 24 hours. Just have to do this once"
	echo " push <branch>             Push to <branch> in origin without credential caching. You have to enter username and password each time you push"
	echo " dropcache                 Clear all saved credentials from cache"
	echo " -l, --list                Show current global configs"
}

# ----- Actions ----- #

if [ $# -gt 0 ]; then
	case "$1" in
	-h | --help)
		help
		shift
		;;
	-per)
		configureGit "$personal_username" "$personal_email"
		shift
		;;
	-prof)
		configureGit "$prof_username" "$prof_email"
		shift
		;;
	-mad)
		configureGit "$mad_username" "$mad_email"
		shift
		;;
	-star)
		configureGit "$star_username" "$star_email"
		shift
		;;
	-c | --custom)
		createCustomConfig
		shift
		;;
	-cl | --clear)
		clearConfigs
		shift
		;;
	-l | --list)
		getCurrendConfigs
		shift
		;;
	push)
		pushWithCred "$2" "$3"
		shift
		;;
	dropcache)
		dropcachedCredentials
		shift
		;;
	*)
		echo "Unknown argument."
		echo "Use -h or --help to see list of commands."
		;;
	esac
else
	echo "Unknown argument."
	echo "Use -h or --help to see list of commands."

fi

echo "--------------------------------------------"
