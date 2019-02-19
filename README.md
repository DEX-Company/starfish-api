# starfish-api
DEX Starfish API Documentation

You need to install `graphviz`

To re-build the documentation

1. Install PlantUML

On Linux systems
```bash
sudo apt-get-install plantuml
```

On Mac
```bash
brew install plantuml
```

Or by hand
```bash
mkdir -p $HOME/bin
export PATH=$HOME/bin:$PATH
cat <<EOF > $HOME/bin/plantuml
#!/bin/sh
# plantuml

dir="$(dirname $0)"
jar="$dir/plantuml.jar"

if [ ! -e "$jar" ]; then
    echo "cannot find PlantUML jar: $jar"
    exit 1
fi

java -jar "$jar" $@

EOF
chmod +x $HOME/bin/plantuml
curl -L http://sourceforge.net/projects/plantuml/files/plantuml.jar/download -o $HOME/bin/plantuml.jar
```
2. Install Graphviz

http://graphviz.org/download/

3. Make the docs
```bash
virtualvenv venv
# or for a specific version of python
# virtualvenv -p /usr/bin/python3.6 venv
source venv/bin/activate
pip install -r requirements_dev.txt
make docs
deactivate
open docs/build/html/index.html
```
