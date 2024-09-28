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
> [!WARNING]
> - Instalator gry potrzebuje skonfigurowanego pakietu 'wget' oraz 'tar'! 

## Instalacja i uruchomienie ...

Posiadać zainstalowany bash, coreutils, tar, wget.

### Instalator

Dla ułatwienia instalacji napisałem skrypt instalatora wraz z instrukcjami po instalacji i w przypadku niepowodzenia.

### Pobieranie i instalacja :

```
git clone https://github.com/BuriXon-code/GraChemiczna
cd GraMatematyczna
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
./gra2 -p
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

