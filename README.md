# Gra chemiczna! 🇵🇱
![Gra](/gra2.png)

## O grze...

### Gra polega na dopasowywaniu pierwiastka do ilości protonów i odwrotnie.
![Gra](/gra1.png)

Do wyboru jest kilka "poziomów", lub raczej kategorii/grup pierwiastków.

Gra może dotyczyć pojedynczo wybranych grup (np metali, aktynowców) lub wszystkich pierwiastków!

### Gra jest w 100% skryptem shell'owym.

Gra nie zawiera żadnych poleceń poza funkcjami bash oraz wbudowanymi komendami coreutils.

> [!WARNING]
> - Gra nie będzie działała prawidłowo na systemach z busybox (wymagane coreutils)!
> - Instalator gry potrzebuje skonfigurowanego pakietu 'wget' oraz 'tar'! 

## Instalacja i uruchomienie ...

Posiadać zainstalowany bash, coreutils, tar, wget.

### Instalator

Dla ułatwienia instalacji napisałem skrypt instalatora wraz z instrukcjami po instalacji i w przypadku niepowodzenia.

### Pobieranie i instalacja :

```
git clone https://github.com/BuriXon-code/GraChemiczna
cd GraChemiczna
chmod +x *
./install.sh
```
### Uruchamianie :
```
./gra
```

### Przed pierwszym uruchomieniem :
![Gra](/gra3.png)

Przed pierwszym uruchomieniem zalecane jest użycie flagi -h lub --help, aby zapoznać się z instrukcją dotyczącą gry.
```
./gra --help
```
lub 
```
./gra -h
```
oraz 
```
./gra --pomoc
```
lub 
```
./gra -p
```

> [!WARNING]
> - Przed pierwszym uruchomieniem porównaj sumy MD5 instalowanego pliku i MD5 z pliku w repozytoium!

### Instalacja ręczna

Aby zainstalować grę ręcznie w przypadku niepowodzenia instalacji automatycznej, należy wykonać następujące kroki:

```
# Pobieranie plików z github
git clone https://github.com/BuriXon-code/GraChemiczna
cd GraChemiczna
chmod +x gra*
```
```
# Tworzenie katalogu dla plików z pierwiastkami:
# W miejcu '/path/to/directory/' należy wpisać wybraną przez siebie ścieżkę, w której znajdą się pliki z listami pierwiastków
mkdir /path/to/directory/ && cd /path/to/directory/
```
```
# Pobieranie plików z listami pierwiastków:
wget https://burixon.com.pl/pliki/pierwiastki.tar.xz
```
```
# Rozpakowywanie pierwiastków:
tar xvf pierwiastki.tar.xz
```
```
# Eksportowanie wybranej ścieżki
# W miejcu '/path/to/.shellrc' należy wpisać ścieżkę do pliku konfiguracyjnego shella
echo "export PIERWIASTKI=\"/path/to/directory/\"" >> /path/to/.shellrc
```
```
# Stosowanie zmian w pliku konfiguracyjnym:
source /path/to/.shellrc
```

Gotowe :) Gra została zainstalowana. Teraz można ją uruchomić:

```
./gra
```

## Możliwość zatrzymania skryptu - hasło administratora (rodzica) :
### Gra została zabezpieczona przed próbą zatrzymania sygnałem SIGINT (CTRL+C). Aby jednak ją zatrzymać, należy posiadać hasło administratora.
### Hasło :
![Hasło administratorskie](/captcha.png)

## Uwagi!
### Przytrzymanie CTRL+C :
Przytrzymanie przycisków CTRL+C może wpłynąć źle na działanie skryptu i zatrzymać go przed ukończeniem gry.

### Kompatybilność :
Skrypt kompatybilny jest z wszystkimi systemami Linux oraz Termux.

Co jednak ważne - przez wzgląd na użycie kolorów RGB (ANSI escape \e[38;2...) gra nie będzie dopasowywać się do schematów kolorów używanego emulatora terminala.

Zalecane uruchamianie w terminalu z ciemnym motywem.

![Gra](/gra4.png)

