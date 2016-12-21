## Documentation for TerriaJS

This repository contains tools for building a documentation site from TerriaJS. The resulting Github Pages site is uploaded to `TerriaJS/Documentation`.  This is run as a cronjob on the nationalmap research server.

### Installation

```
git clone https://github.com/TerriaJS/MakeDocs
git clone https://github.com/TerriaJS/terriajs # Or preferably use a symlink
cd MakeDocs

# Install mkdocs. Preferably you'd do this with a virtualenv.
pip install mkdocs 
```

### Updating

```
./rebuild.sh # This generates a ../work and a ../site directory.
./publish.sh # Publishes the ../site directory to Github.
```
