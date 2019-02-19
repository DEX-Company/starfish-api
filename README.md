# starfish-api
DEX Starfish API Documentation

You need to install `graphviz`

To re-build the documentation

```
# download plantuml .jar file
wget http://sourceforge.net/projects/plantuml/files/plantuml.1.2019.1.jar/download -O docs/plantuml.jar
virtualvenv venv
# or for a specific version of python
# virtualvenv -p /usr/bin/python3.6 venv
source venv/bin/activate
pip install -r requirements_dev.txt
make docs
deactivate
open docs/build/html/index.html
```
