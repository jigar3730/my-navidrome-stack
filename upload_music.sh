#!/bin/bash
# Updated to permanent paths
INBOUND_DIR="/opt/stacks/navidrome/inbound"
MUSIC_DIR="/opt/stacks/navidrome/music"

if [ "$(ls -A "$INBOUND_DIR" 2>/dev/null)" ]; then
   echo "🎵 New music detected in permanent inbound! Moving to library..."
   sudo mv "$INBOUND_DIR"/* "$MUSIC_DIR"/
fi

echo "🏷️ Starting Beets Auto-Tagger..."
docker exec -it beets beet import -sI /music

echo "🔄 Refreshing Navidrome Library..."
docker exec -it my-navidrome-stack-navidrome-1 /app/navidrome scan

echo "✅ Done!"
