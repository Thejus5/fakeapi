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

pushWithCred (){
	git push origin "$1"
}

help() {
	echo "COMMANDS HELP"
	echo " "
	echo "options:"
	echo " -h, --help                show brief help"
	echo " -per                      set personal profile as git config in global (BugmanPy)"
	echo " -prof                     set work profile as git config in global (Thejus5)"
	echo " -mad                      set mad project profile as git config in global (mad-meenu)"
	echo " -star                     set Starsona project profile as git config in global (sabir)"
	echo " -cl, --clear              clear the global config"
	echo " -c, --custom              create custom global config"
	echo " -l, --list                show current global configs"
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
		pushWithCred "$2"
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
