#!/bin/bash

# Define the standard path
STACK_PATH="/opt/stacks/navidrome"

echo "Creating directory structure at $STACK_PATH..."
sudo mkdir -p "$STACK_PATH/data" "$STACK_PATH/music" "$STACK_PATH/beets"

echo "Setting permissions..."
sudo chown -R $(id -u):$(id -g) "$STACK_PATH"

# Create a local .env if it doesn't exist
if [ ! -f .env ]; then
    echo "Creating .env template..."
    cat <<EOT > .env
PUID=$(id -u)
PGID=$(id -g)
STACK_DIR=$STACK_PATH
MUSIC_FOLDER=$STACK_PATH/music
NAVIDROME_BASE_URL=http://$(hostname -I | awk '{print $1}'):4533
EOT
    echo ".env created! Please check it before running docker compose."
fi

echo "Setup complete. You can now run: docker compose up -d"
