#!/bin/bash

# package docs and deploy

DOC_PATH='./docs/build/html'
# FIXME get version from npm
VERSION="0.0.1"
# FIXME get project name from npm
PROJECT_NAME="starfish-api"
PACKAGE_NAME="docs_${PROJECT_NAME}_${VERSION}"
DEPLOY_FILENAME="./${PACKAGE_NAME}.tar.gz"

DEPLOY_USER=docs_deploy

if [ ! -z "$1" ]; then
    DEPLOY_SERVER="$1"
fi

if [ ! -z "$2" ]; then
    DEPLOY_USER="$2"
fi

if [ "$3" = "dev" ]; then
    # create safe branch name
    DEV_BRANCH=$(echo $TRAVIS_BRANCH | sed -e 's^/^%^g' -e 's/[()<>&*!]/_/g' -e 's/\s/_/g')
else
    DEV_BRANCH=""
fi

echo "building docs package $PACKAGE_NAME"

# ensure we are in the venv
if [ ! -d venv ]; then
    echo "creating the virtualenv"
    python3.7 -m venv venv
fi
source venv/bin/activate
pip install -r requirements_dev.txt

# ensure we have PlantUML
plantuml_path="$(which plantuml)"
if [ -z "$plantuml_path" ]; then
    echo "plantuml not found"
    exit 1
fi

# ensure we have graphviz
dot_path="$(which dot)"
if [ -z "$dot_path" ]; then
    echo "graphviz not found"
    exit 1
fi

# make the docs from source
make docs

# package into a tar.gz file for deployment
(cd "$DOC_PATH"; tar -czf "../../../$DEPLOY_FILENAME" ./)

if [ ! -z "$DEPLOY_SERVER" ]; then
    DEPLOY_BUILD_URL="http://${DEPLOY_SERVER}/docs_build"

    echo "Deploying doc file to $DEPLOY_SERVER"
    openssl aes-256-cbc -K $encrypted_4f2a9a4bc576_key -iv $encrypted_4f2a9a4bc576_iv \
    -in scripts/keys/dex-docs-deploy.enc \
    -out /tmp/dex-docs-deploy -d

    chmod 0600 /tmp/dex-docs-deploy

    if [ -z "$DEV_BRANCH" ]; then
        scp -i /tmp/dex-docs-deploy "$DEPLOY_FILENAME" ${DEPLOY_USER}@${DEPLOY_SERVER}:
    else
        # for debugging send the environment from travis
        mkdir -p "target/$PROJECT_NAME/branches/$DEV_BRANCH"
        mv "$DEPLOY_FILENAME" "target/$PROJECT_NAME/branches/$DEV_BRANCH/"
        env > "target/$PROJECT_NAME/branches/$DEV_BRANCH/env.txt"
        rsync -auvW --rsh 'ssh -i /tmp/dex-docs-deploy' target/$PROJECT_NAME/ ${DEPLOY_USER}@${DEPLOY_SERVER}:$PROJECT_NAME/
    fi

    rm /tmp/dex-docs-deploy

    # echo "requesting docs rebuild at $DEPLOY_BUILD_URL"
    # curl -H "Content-Type: application/json" -X POST -d '{"file":"$DEPLOY_FILENAME"}' "$DEPLOY_BUILD_URL"
fi
