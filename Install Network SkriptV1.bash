# Farben definieren
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
RESET='\033[0m'

# Funktion: Menü anzeigen
function zeige_menü() {
    echo -e "${CYAN}============================"
    echo -e "        ${GREEN}Hauptmenü${CYAN}"
    echo -e "============================${RESET}"
	echo -e "${BLUE}1)${RESET} Stoppe die Cloud"
	echo -e "${BLUE}2)${RESET} Starte die Cloud"
	echo -e "${BLUE}3)${RESET} Installiere PHP"
	echo -e "${BLUE}4)${RESET} Installiere Java"
	echo -e "${BLUE}5)${RESET} Installiere MySQL"
	echo -e "${BLUE}6)${RESET} Installiere Nginx"
	echo -e "${BLUE}7)${RESET} Installiere MongoDB"
    echo -e "${BLUE}8)${RESET} Network.sh Skript Beenden"
    echo -e "${CYAN}============================${RESET}"
}

# Hauptschleife
while true; do
    zeige_menü
    read -p "Wähle eine Option [1-8]: " auswahl

    case $auswahl in
        1)
            echo -e "${GREEN}Stoppe die Cloud...${RESET}"
            sudo screen -X -S Cloud kill
            ;;
        2)
            echo -e "${GREEN}Starte die Cloud...${RESET}"
            cd /home/minecraft
			sudo screen -S Cloud java -jar Cloud.jar nogui
            ;;
		3)
            echo -e "${GREEN}Installiere PHP...${RESET}"
            sudo apt update && sudo apt full-upgrade -y 
			sudo apt install php8.2 php8.2-cli php8.2-common php8.2-curl php8.2-gd php8.2-intl php8.2-mbstring php8.2-mysql php8.2-opcache php8.2-readline php8.2-xml php8.2-xsl php8.2-zip php8.2-bz2 php8.2-fpm -y
			echo -e "${GREEN}PHP8.2 wurde erfolgreich installiert${RESET}"
            ;;
        4)
            echo -e "${GREEN}Installiere Java...${RESET}"
            sudo apt update
            sudo apt install gnupg ca-certificates curl -y
			curl -s https://repos.azul.com/azul-repo.key | sudo gpg --dearmor -o /usr/share/keyrings/azul.gpg
			echo "deb [signed-by=/usr/share/keyrings/azul.gpg] https://repos.azul.com/zulu/deb stable main" | sudo tee /etc/apt/sources.list.d/zulu.list
			sudo apt update
			sudo apt install zulu21-jdk -y
			echo -e "${GREEN}Java ZUlu 21 wurde erfolgreich installiert${RESET}"
            ;;
		5)
            echo -e "${GREEN}Installiere MySQL...${RESET}"
            sudo apt update && sudo apt full-upgrade -y 
            sudo apt install ca-certificates apt-transport-https lsb-release gnupg curl nano unzip -y
			curl -fsSL https://packages.sury.org/php/apt.gpg -o /usr/share/keyrings/php-archive-keyring.gpg
			echo "deb [signed-by=/usr/share/keyrings/php-archive-keyring.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list
			sudo apt update
			sudo apt install php8.2 php8.2-cli php8.2-common php8.2-curl php8.2-gd php8.2-intl php8.2-mbstring php8.2-mysql php8.2-opcache php8.2-readline php8.2-xml php8.2-xsl php8.2-zip php8.2-bz2 php8.2-fpm -y
			sudo apt install mariadb-server mariadb-client -y
			sudo mysql_secure_installation
			cd /usr/share
			wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip -O phpmyadmin.zip
			unzip phpmyadmin.zip
			rm phpmyadmin.zip
			mv phpMyAdmin-*-all-languages phpmyadmin
			chmod -R 0755 phpmyadmin
			mkdir /usr/share/phpmyadmin/tmp/
			chown -R www-data:www-data /usr/share/phpmyadmin/
			echo -e "${GREEN}MySQL wurde erfolgreich installiert${RESET}"
			;;
        6)
            echo -e "${GREEN}Installiere Nginx...${RESET}"
            sudo apt update && sudo apt full-upgrade -y && sudo apt install nginx -y
            echo -e "${GREEN}Nginx wurde erfolgreich installiert${RESET}"
			;;
        
        7)
            echo -e "${GREEN}Installiere MongoDB...${RESET}"
            sudo apt update && sudo apt full-upgrade -y 
			sudo apt-get install gnupg curl -y
			curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
			sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
			--dearmor			sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \ --dearmor
			echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] http://repo.mongodb.org/apt/debian bookworm/mongodb-org/8.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
			sudo apt-get update
			sudo apt-get install -y mongodb-org
			echo -e "${GREEN}MongoDB wurde erfolgreich installiert${RESET}"
            ;;
		
        8)
            echo -e "${CYAN}Skript wird beendet. Auf Wiedersehen!${RESET}"
            break
            ;;
        *)
            echo -e "${RED}Ungültige Eingabe! Bitte wählen Sie eine Zahl zwischen 1 und 8.${RESET}"
            ;;
    esac
done
