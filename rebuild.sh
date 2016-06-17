# Pre-requisites: pip install mkdocs
# Yes, this needs to be turned into a step in the TerriaJS build process, preferably not using Python.

source ../env/bin/activate

TERRIADIR=../terriajs
WORKDIR=../work
rm -rf $WORKDIR
rm -rf ../site
mkdir $WORKDIR
cp -pr ${TERRIADIR}/Documentation/* $WORKDIR
cp ${TERRIADIR}/CONTRIBUTING.md ${WORKDIR}/Contributors/
# @Overview.md is a crappy name for each index page, but at least it sorts first.


find ${WORKDIR}/* -type d -exec mv '{}/README.md' '{}/@Overview.md' \;
find ${WORKDIR} -type f -exec perl -i -pe 's/\/CONTRIBUTING.md/\/Contributors\/CONTRIBUTING/g' '{}' \;
find ${WORKDIR}/* -type f -exec perl -i -pe 's/\/Documentation//g' '{}' \;
find ${WORKDIR} -type f -exec perl -i -pe 's/\/README.md/\/\@Overview.md/g' '{}' \;

cp ${TERRIADIR}/Documentation/README.md Documentation/ # Undo the rules above
HOMEPAGE=Documentation/index.md
mv Documentation/README.md "$HOMEPAGE"
perl -i -pe 's/\(Deployment\)/(Deployment\/\@Overview)/g' "$HOMEPAGE"
perl -i -pe 's/\(Customizing\)/(Customizing\/\@Overview)/g' "$HOMEPAGE"
perl -i -pe 's/\(CatalogManagement\)/(CatalogManagement\/\@Overview)/g' "$HOMEPAGE"
perl -i -pe 's/\(Contributors\)/(Contributors\/\@Overview)/g' "$HOMEPAGE"

perl -i -pe 's/LICENSE.md/https:\/\/github.com\/TerriaJS\/terriajs\/blob\/master\/LICENSE.md/g' "Documentation/CONTRIBUTING.md"

#cat <<EOF >>Documentation/index.md
#
#This site is built from the [TerriaJS Github repository](https://github.com/TerriaJS/TerriaJS/tree/master/Documentation).
#EOF

cat <<EOF >../mkdocs.yml
site_name: Terria
#cosmo|cyborg|readthedocs|yeti|journal|bootstrap|readable|united|simplex|flatly|spacelab|amelia|cerulean|slate|mkdocs
theme: flatly
docs_dir: work ## Should keep in sync with WORKDIR
EOF

cd ..
mkdocs build --clean
cd site
git init
git checkout -b gh-pages
git add .
git commit -m 'Generate documentation' --author 'Terria Bot <TerriaBot@users.noreply.github.com>' 

cd ../Documentation
#mkdocs serve

# 'site' directory gets pushed to the gh-pages branch
