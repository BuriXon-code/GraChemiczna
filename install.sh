#!/bin/bash

PWD=$(mktemp)
TEMP=$(mktemp)

GREEN="\033[38;2;0;255;0m"
RED="\033[38;2;255;0;0m"
YELLOW="\e[38;2;255;255;0m"
RESET="\033[0m"
CHECKMARK="${GREEN}✓${RESET}"
CROSS="${RED}×${RESET}"
QUOTE="${YELLOW}?${RESET}"
TASK="${YELLOW}>${RESET}"
OK="${GREEN}OK${RESET}"
BLAD="${RED}BŁĄD${RESET}"

pwd > $PWD
clear
echo -e "\n\e[?25l"
echo -e "\e[1;3m${GREEN}Instalator gry '${YELLOW}GraChemiczna${GREEN}'"
echo -e "${GREEN}  Made by ${YELLOW}BuriXon${GREEN}"

# Funkcja animująca proces
show_progress() {
	local step="$1"
	local line_num="$2"
	local pid="$3"
	echo -ne "\033[$line_num;0H [ ] $step"
	local i=0
	while kill -0 "$pid" 2>/dev/null; do
		i=$(( (i+1) % 4 ))
		case $i in
			0) echo -ne "\r [|] $step.  " ;;
			1) echo -ne "\r [/] $step.. " ;;
			2) echo -ne "\r [—] $step..." ;;
			3) echo -ne "\r [\] $step.. " ;;
		esac
		sleep 0.075
	done
}

LINE_NUM=7

export_() {

echo "" >> "$( cat $TEMP | tail -n1 )"
echo "#ŚCIEZKA DO LIST PIERWIASTKÓW" >> "$( cat $TEMP | tail -n1 )"
echo "export PIERWIASTKI=\""$( cat $TEMP | head -n1 )/.pierwiastki\""" >> "$( cat $TEMP | tail -n1 )"

}

main_installer() {

# kopiowanie pliku .tar.xz
	sleep 0.5
	mkdir "$( cat $TEMP | head -n1 )/.pierwiastki" &>/dev/null
	mv "$(pwd)/pierwiastki.tar.xz" "$( cat $TEMP | head -n1 )/.pierwiastki/pierwiastki.tar.xz" &>/dev/null && {
		echo -e "\r   [$TASK] Listy przeniesione.\e[K"
		sleep 0.5
	} || {
		echo -en "\r [$CROSS] Nie mozna przeniesc list.\e[K\n"
		echo -e "\r   [${QUOTE}] Sprobuj ${YELLOW}recznej instalacji${RESET}.\e[K"
		sleep 0.5
		return 1
	}

# rozpakowywanie pliku .tar.xz
	cd "$( cat $TEMP | head -n1 )/.pierwiastki/" &&
	tar xvf "$( cat $TEMP | head -n1 )/.pierwiastki/pierwiastki.tar.xz" &>/dev/null && {
		echo -e "\r   [$TASK] Lista rozpakowana.\e[K"
		rm "$( cat $TEMP | head -n1 )/.pierwiastki/pierwiastki.tar.xz"
		sleep 0.5
	} || {
		echo -en "\r [$CROSS] Nie mozna rozpakowac list.\e[K\n"
		echo -e "\r   [${QUOTE}] Sprobuj ${YELLOW}recznej instalacji${RESET}.\e[K"
		sleep 0.5
		return 1
	}

# wpisywanie srodowiskowej do pliku rc shell'a

	export_ && {
		echo -e "\r   [$TASK] Lokalizacja listy eksportowana.\e[K"
		sleep 0.5
	} || {
		echo -en "\r [$CROSS] Nie mozna eksportowac zmiennej lokalizacji listy.\e[K\n"
		echo -e "\r   [${QUOTE}] Sprobuj ${YELLOW}recznej instalacji${RESET}.\e[K"
		sleep 0.5
		return 1
	}

}

check_packages() {
	{
		REQUIRED_PKG=("wget" "tar")
		for PKG in "${REQUIRED_PKG[@]}"; do
			if ! command -v "$PKG" &> /dev/null; then
				sleep 1
				echo -e "\r [$CROSS] Pakiet $PKG nie jest skonfigurowany!\e[K"
				sleep 0.5
				echo -e "\r   [${QUOTE}] Uzyj komendy '${YELLOW}apt install $PKG${RESET}', aby zainstalowac pakiet.\e[K"
				return 1
			fi
		done
		sleep 1
		return 0
	} &
    
	show_progress "Sprawdzanie niezbednych narzedzi" $LINE_NUM $!
	wait $!
	if [ $? -eq 0 ]; then
		echo -e "\r [${CHECKMARK}] Sprawdzanie narzedzi - $OK\e[K"
	else
		echo -e "\r [${CROSS}] Sprawdzanie narzedzi - $BLAD\e[K"
		return 1
	fi
	LINE_NUM=$((LINE_NUM + 1))
}

check_directories() {
	{
		DIRECTORIES=("/data/data/com.termux/home" "/data/data/com.termux/home/.wisielec" "/data/data/com.termux/files/usr/dict" "$HOME" "$HOME/.wisielec" "/usr/dict" "/usr/local/dict" "/home/$USER" "$USER")
		sleep 1	
		for DIR in "${DIRECTORIES[@]}"; do
		if [ -d "$DIR" ] && [ -w "$DIR" ]; then
			TARGET_DIR="$DIR"
			echo $TARGET_DIR > $TEMP
			return 0
		fi
		done
		return 1
	} &

	show_progress "Sprawdzanie katalogow docelowych" $LINE_NUM $!
	wait $!
	if [ $? -eq 0 ]; then
		echo -e "\r [${CHECKMARK}] Sprawdzanie katalogow - $OK\e[K"
		sleep 0.1
		echo -e "\r   [${TASK}] Wybrany katalog: ${YELLOW}$( cat $TEMP | head -n1 )${RESET}\e[K"
	else
		echo -e "\r [${CROSS}] Nie mozna utowrzyc katalogu dla listy!\e[K"
		sleep 0.1
		echo -e "\r   [${QUOTE}] Konieczna bedzie ${YELLOW}reczna instalacja${RESET} pakietu...\e[K"
		sleep 0.5
		echo -e "\r [${CROSS}] Sprawdzanie katalogów - $BLAD\e[K"
		return 1
	fi
	LINE_NUM=$((LINE_NUM + 2))
}

check_shell() {
	{
		CURRENT_SHELL=$(basename "$SHELL")
		sleep 2
		case "$CURRENT_SHELL" in
			"bash")
				SHELL_RC="$HOME/.bashrc"
			;;
			"zsh")
				SHELL_RC="$HOME/.zshrc"
			;;
			"fish")
				SHELL_RC="$HOME/.config/fish/config.fish"
			;;
			*)
				return 1
			;;
		esac

		if [ -w "$SHELL_RC" ]; then
		echo "$SHELL_RC" >> $TEMP
			return 0
		else
			return 1
		fi
	} &
    
	show_progress "Sprawdzanie srodowiska" $LINE_NUM $!
	wait $!
	if [ $? -eq 0 ]; then
		echo -e "\r [${CHECKMARK}] Sprawdzanie srodowiska - $OK\e[K"
		sleep 0.1
		echo -e "\r   [${TASK}] Aktualny shell: ${YELLOW}$(basename "$SHELL")${RESET}\e[K"
		sleep 0.1
		echo -e "\r   [${TASK}] Plik konfiguracyjny: ${YELLOW}$( cat $TEMP | tail -n1 )${RESET}\e[K"
		sleep 0.2
	else
		echo -e "\r [${CROSS}] Nieznany shell: ${YELLOW}$(basename "$SHELL")${RESET}\e[K"
		echo -e "\r   [${QUOTE}] Instalator działa jedynie w srodowiskach\e[K"
		echo -e "\r       shell: ${YELLOW}bash${RESET}, ${YELLOW}zsh${RESET} oraz ${YELLOW}fish${RESET}.\e[K"
		echo -e "\r [${CROSS}] Sprawdzanie srodowiska - $BLAD\e[K"
		return 1
	fi
	LINE_NUM=$((LINE_NUM + 3))
}

download_file() {
	{
		FILE_URL="https://burixon.com.pl/github/GraChemiczna/pierwiastki.tar.xz"
		TARGET_FILE="pierwiastki.tar.xz"
		sleep 0.5
		wget -q "$FILE_URL" -O "$TARGET_FILE" && return 0 || return 1
		sleep 0.5
	} &
    
	show_progress "Pobieranie slowników" $LINE_NUM $!
	wait $!
	if [ $? -eq 0 ]; then
		echo -e "\r [${CHECKMARK}] Pobieranie slowników - $OK\e[K"
		sleep 0.1
		echo -e "\r   [${TASK}] MD5 pliku ze slowami: ${YELLOW}$( md5sum pierwiastki.tar.xz | cut -d " " -f 1 )${RESET}\e[K"
		sleep 0.1
		echo -e "\r   [${QUOTE}] Jezeli suma kontrolna pliku nie zgadza sie\e[K"
		sleep 0.1
		echo -e "\r       z suma podana na Github, ${RED}nie uruchamiaj gry${RESET}!\e[K"
		sleep 0.2
		echo -e "\r [${CHECKMARK}] Obliczanie MD5 - $OK\e[K"
	else
		echo -e "\r [${CROSS}] Pobieranie slownika nie powiodlo się!\e[K"
		sleep 0.1
		echo -e "\r   [${QUOTE}] Sprawdz swoje polaczenie internetowe.\e[K"
		sleep 0.1
		echo -e "\r   [${QUOTE}] Jesli problem bedzie się powtarzac,\e[K"
		sleep 0.1
		echo -e "\r       skontaktuj sie ze mna: ${YELLOW}admin@burixon.com.pl${RESET}.\e[K"
		sleep 0.1
		echo -e "\r [${CROSS}] Pobieranie slownikow - $BLAD\e[K"
		return 1
	fi
	LINE_NUM=$((LINE_NUM + 5))
}

install_script() {
	{
		sleep 3
		main_installer && return 0 || return 1
	} &
    
	show_progress "Instalowanie" $LINE_NUM $!
	wait $!
	if [ $? -eq 0 ]; then
		echo -e "\r [${CHECKMARK}] Instalowanie - $OK\e[K"
	else
		echo -e "\r [${CROSS}] Instalowanie - $BLAD\e[K"
		return 1
	fi
	LINE_NUM=$((LINE_NUM + 1))
}

{
	check_packages && check_directories && check_shell && download_file && install_script
} || {
	echo -e "\n${RED}Blad${RESET}: Instalacja nie powiodla sie podczas jednego z etapow."
	echo -e "Sprobuj rozwiazac problem i uruchomic ponownie."
	echo -e "W razie dalszych problemow sprobuj ${YELLOW}recznej instalacji${RESET}."
	rm $TEMP
	rm $PWD
	echo -en "\e[?25h"
	exit 1
}

#echo -e " - Katalog docelowy: $( cat $TEMP | head -n1 )"
#echo -e " - Plik konfiguracyjny shella: $( cat $TEMP | tail -n1 )"
echo -e "\n${GREEN}Instalacja zakonczona pomyslnie!\n${RESET}Aby uruchomić gre, wpisz ${GREEN}\"bash wisielec\"${RESET} lub ${GREEN}\"./wisielec\"${RESET}."
echo -e "\n\e[1;6;31mPrzed uruchomieniem gry sprawdz sumy kontrolne!${RESET}"
echo -e "${YELLOW}Przed pierwszym uruchomieniem zrestartuj shell.${RESET}"
sleep 3
echo -e "\e[2A\r\e[1;31mPrzed uruchomieniem gry sprawdz sumy kontrolne!\n\n"
rm $TEMP
rm $PWD
echo -en "\e[?25h"
