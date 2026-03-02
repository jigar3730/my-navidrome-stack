#!/bin/bash

# 1. Define where the music is coming from and going to
# These paths match what we set up in your .env file
INBOUND_DIR="./workdir/inbound"
MUSIC_DIR="./workdir/music"

# 2. Make sure the 'inbound' folder exists so the script doesn't crash
mkdir -p "$INBOUND_DIR"

# 3. Check if you actually put any music in the inbound folder
if [ -z "$(ls -A $INBOUND_DIR)" ]; then
   echo "❌ No new music found in $INBOUND_DIR. Drop files there first!"
   exit 1
fi

echo "🎵 New music detected! Moving to library..."
# This moves everything from 'inbound' to the main 'music' folder
mv "$INBOUND_DIR"/* "$MUSIC_DIR"/

echo "🏷️ Starting Beets Auto-Tagger..."
# This tells the 'beets' container to fix the tags of the new files
docker exec -it beets beet import -s /music

echo "🔄 Refreshing Navidrome Library..."
# This tells Navidrome to scan for the changes immediately
docker exec -it my-navidrome-stack-navidrome-1 /app/navidrome scan

echo "✅ Done! Your music is now tagged and ready in Navidrome."