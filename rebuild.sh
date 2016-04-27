# Pre-requisites: pip install mkdocs
# Yes, this needs to be turned into a step in the TerriaJS build process, preferably not using Python.

rm -rf Documentation
cp -pr ../../terriajs/Documentation .
cp ../../terriajs/CONTRIBUTING.md Documentation/Contributors/
# @Overview.md is a crappy name for each index page, but at least it sorts first.


find Documentation/* -type d -exec mv '{}/README.md' '{}/@Overview.md' \;
find Documentation -type f -exec perl -i -pe 's/\/CONTRIBUTING.md/\/Contributors\/CONTRIBUTING/g' '{}' \;
find Documentation/* -type f -exec perl -i -pe 's/\/Documentation//g' '{}' \;
find Documentation -type f -exec perl -i -pe 's/\/README.md/\/\@Overview.md/g' '{}' \;

cp ../../terriajs/Documentation/README.md Documentation/ # Undo the rules above
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


mkdocs build --clean
mkdocs serve

# 'site' directory gets pushed to the gh-pages branch
