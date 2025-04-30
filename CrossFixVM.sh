RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
RESET='\033[0m'

header() {
  clear
  printf "${BLUE}"
  printf " _________                            ___________.__        \n"
  printf " \_   ___ \_______  ____  ______ _____\_   _____/|__|__  ___\n"
  printf " /    \  \/\_  __ \/  _ \/  ___//  ___/|    __)  |  \  \/  /\n"
  printf " \     \____|  | \(  <_> )___ \ \___ \ |     \   |  |>    < \n" 
  printf "  \______  /|__|   \____/____  >____  >\___  /   |__/__/\_ \\n"
  printf "         \/                  \/     \/     \/             \/ \n"
  printf "${RESET}"
  printf "${CYAN}  CrossFix Version Minimal${RESET}\n"
  printf "${YELLOW}  GitHub.com/Fusneuille/CrossFixVM${RESET}\n\n" 
}

secu() {
    if [[ $EUID -eq 0 ]]; then
        printf "${RED}[✗] ERREUR: Ne pas exécuter en root!${RESET}\n"
        exit 1
    fi
    
    if [[ "$(uname)" != "Darwin" ]]; then
        printf "${RED}[✗] ERREUR: Ce script est uniquement pour macOS!${RESET}\n"
        exit 1
    fi
}

time_trial() {
  PLIST="$HOME/Library/Preferences/com.codeweavers.CrossOver.plist"
  
  if [ -f "$PLIST" ]; then
    FIRST_RUN_DATE=$(plutil -extract FirstRunDate raw "$PLIST" 2>/dev/null)
    
    if [ -n "$FIRST_RUN_DATE" ]; then
      FIRST_RUN_TIMESTAMP=$(date -j -f "%Y-%m-%dT%TZ" "$FIRST_RUN_DATE" "+%s" 2>/dev/null)
      CURRENT_TIMESTAMP=$(date "+%s")
      DAYS_PASSED=$(( (CURRENT_TIMESTAMP - FIRST_RUN_TIMESTAMP) / 86400 ))
      DAYS_LEFT=$(( 14 - DAYS_PASSED ))
      
      if [ "$DAYS_LEFT" -gt 0 ]; then
        printf "${GREEN}${DAYS_LEFT} jour(s) restant(s)${RESET}"
      else
        printf "${RED}Expiré depuis $(( -1 * DAYS_LEFT )) jour(s)${RESET}"
      fi
    else
      printf "${YELLOW}Non détecté${RESET}"
    fi
  else
    printf "${RED}Fichier introuvable${RESET}"
  fi
}

reset_trial() {
  printf "${BLUE}[*] Réinitialisation de la période d'essai...${RESET}\n"
  DATETIME=$(date -u -v -3H '+%Y-%m-%dT%TZ')
  PLIST="$HOME/Library/Preferences/com.codeweavers.CrossOver.plist"
  
  if plutil -replace FirstRunDate -date "${DATETIME}" "$PLIST" && \
     plutil -replace SULastCheckTime -date "${DATETIME}" "$PLIST"; then
    printf "${GREEN}[✓] Période d'essai réinitialisée avec succès!${RESET}\n"
  else
    printf "${RED}[✗] Erreur lors de la réinitialisation${RESET}\n"
  fi
  
  printf "\n${YELLOW}Appuyez sur Entrée pour continuer...${RESET}"
  read -r
}

reset_bottle() {
  printf "\n${BLUE}[*] Liste des bouteilles disponibles:${RESET}\n"
  ls "$HOME/Library/Application Support/CrossOver/Bottles" | while read -r bottle; do
    printf "${CYAN}    - $bottle${RESET}\n"
  done
  
  printf "\n"
  read -p "$(printf "${BLUE}[?] Entrez le nom de la bouteille: ${RESET}")" BOTTLE_NAME
  
  FILE="$HOME/Library/Application Support/CrossOver/Bottles/$BOTTLE_NAME/system.reg"
  
  if [ ! -f "$FILE" ]; then
    printf "${RED}[✗] Bouteille '$BOTTLE_NAME' introuvable${RESET}\n"
    printf "\n${YELLOW}Appuyez sur Entrée pour continuer...${RESET}"
    read -r
    return 1
  fi

  printf "${BLUE}[*] Traitement de la bouteille '$BOTTLE_NAME'...${RESET}\n"
  BACKUP="$FILE.bak"
  PATTERN="[Software\\\\CodeWeavers\\\\CrossOver\\\\cxoffice]"
  
  if cp -f "$FILE" "$BACKUP" 2>/dev/null; then
    printf "${GREEN}[✓] Sauvegarde créée: system.reg.bak${RESET}\n"
  else
    printf "${YELLOW}[!] Impossible de créer la sauvegarde${RESET}\n"
  fi
  
  if sed -i.bak "/$PATTERN/,+4 d" "$FILE" 2>/dev/null; then
    printf "${GREEN}[✓] Bouteille '$BOTTLE_NAME' réinitialisée avec succès!${RESET}\n"
  else
    printf "${RED}[✗] Erreur lors de la modification${RESET}\n"
  fi
  
  printf "\n${YELLOW}Appuyez sur Entrée pour continuer...${RESET}"
  read -r
}

uninstall_crossover() {
    printf "${RED}[!] ATTENTION: Ceci supprimera TOUS les fichiers CrossOver!${RESET}\n"
    read -p "$(printf "${YELLOW}[?] Voulez-vous vraiment continuer? (o/n): ${RESET}")" CONFIRM
    
    if [[ "$CONFIRM" == "o" || "$CONFIRM" == "O" ]]; then
        printf "${BLUE}[*] Suppression des fichiers...${RESET}\n"
        
        PATHS=(
            "$HOME/Library/Application Support/CrossOver"
            "$HOME/Library/Preferences/com.codeweavers.CrossOver.plist"
            "$HOME/Library/Caches/com.codeweavers.CrossOver"
        )
        
        for path in "${PATHS[@]}"; do
            if [ -e "$path" ]; then
                if rm -rf "$path"; then
                    printf "${GREEN}[✓] Supprimé: $path${RESET}\n"
                else
                    printf "${RED}[✗] Échec de suppression: $path${RESET}\n"
                fi
            fi
        done
        
        printf "${GREEN}[✓] Nettoyage complet effectué!${RESET}\n"
    else
        printf "${BLUE}[*] Nettoyage annulé${RESET}\n"
    fi
    
    printf "\n${YELLOW}Appuyez sur Entrée pour continuer...${RESET}"
    read -r
}

menu() {
  while true; do
    header
    printf "${PURPLE}  Période d'essai CrossOver: $(time_trial)${RESET}\n\n"
    
    printf "${BLUE}  Menu Principal:${RESET}\n"
    printf "  ${GREEN}1${RESET}. Réinitialiser la période d'essai\n"
    printf "  ${GREEN}2${RESET}. Réinitialiser une bouteille\n"
    printf "  ${RED}3${RESET}. Désinstaller complètement CrossOver\n"
    printf "  ${YELLOW}4${RESET}. Quitter\n"
    printf "\n"
    read -p "$(printf "${BLUE}[?] Votre choix (1-4): ${RESET}")" CHOICE

    case "$CHOICE" in
      1) 
        reset_trial
        ;;
      2) 
        reset_bottle
        ;;
      3) 
        uninstall_crossover
        ;;
      4)
        clear
        printf "${GREEN}Merci d'avoir utilisé CrossFix!${RESET}\n"
        exit 0
        ;;
      *)
        printf "${RED}Choix invalide${RESET}\n"
        sleep 1
        ;;
    esac
  done
}

secu
menu
