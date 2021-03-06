download_vendors=false

# Ce script est codé en dure, mais servira de canevas au développement d'un outil CLI

# ce script doit être lancé à la racine d'un projet...
build_root=$(pwd)
#echo $build_root


# ... et repose sur les composantes suivantes:
#   - frontEndLab  (éventuellement, pourrait être compatible avec d'autres outils front-end ou UI/UX)
#   - stack (éventuellement, d'autres outils de gestion des évènements)
#   - repertoire des éléments graphiques  (par défaut: design)
# C'est informations devront être mis dans un fichier de configuration

# pour l'instant, la commande build-site est destructive pour le répertoire public
# la commande update-site devra être développé éventuellement...
rm -rf public
mkdir public
cd public
mkdir css js fonts svg
# Destructif pour l'instant, devra se diriger vers:
#   - Download stack et frontEndLab si pas présent
#   - sinon, mettre à jour au besoin
if $download_vendors
  then
  echo "in"
  echo $download_vendors
  cd $build_root
  rm -rf vendors/*
  touch vendors/.gitkeep
  cd vendors
  ../scripts/fetch-vendors.sh
fi


# Déploiement de stack
cd $build_root
./scripts/install-stack.sh

# Construction du site (éventuellement) avec felab
tmp='.tmp_sass'
rm -rf $tmp
mkdir $tmp
pages=('index')
css=('style')

#      sass -> css
cp -rf design/felab/* $tmp
cp -rf design/sass/* $tmp

for i in ${css[@]}; do
  echo $tmp/$i.sass
  sass $tmp/$i.sass public/css/$i.css
done


#        mustache+yml -> html
#for i in ${pages[@]}; do
  cat templates/header.mustache > temp.mustache
  cat templates/pagetitre.mustache >> temp.mustache  
  cat templates/index.mustache >> temp.mustache
  cat templates/footer.mustache >> temp.mustache
  mustache content/index.yml temp.mustache > public/index.html
  rm  -rf temp.mustache
#done

#      transfert des fonts

cp design/fonts/*  public/fonts/.

#      transfert svg
svg=("Logo_Convergence_Accueil" "Logo_ExportechQc_Accueil")
for i in ${svg[@]}; do
   cp design/svg/$i.svg  public/svg/.
done
