# Ce script est codé en dure, mais servira de canevas au développement d'un outil CLI

# ce script doit être lancé à la racine d'un projet...
build_root=pwd

# ... et repose sur les composantes suivantes:
#   - frontEndLab  (éventuellement, pourrait être compatible avec d'autres outils front-end ou UI/UX)
#   - stack (éventuellement, d'autres outils de gestion des évènements)
#   - repertoire des éléments graphiques  (par défaut: design)
# tout ceci devra être mis dans un fichier de configuration 

# pour l'instant, la commande build-site est destructrice pour le répartoire public
# la commande update-site devra être développé éventuellement...
rm -rf public
mkdir public
cd public
mkdir css js

# Download stack et frontEndLab si pas présent
# sinon, mettre à jour
cd
