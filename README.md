# My Navidrome Stack 🎵

A portable, Docker-based music streaming and automated tagging stack. This project uses **Navidrome** for streaming and **Beets** (linked to the MusicBrainz database) to fix missing metadata like "Unknown Album" tags.

## 🚀 Features
- **Navidrome**: Personal self-hosted music streamer (AirSonic compatible).
- **Beets Sidecar**: Automated CLI music tagger to ensure clean metadata.
- **GitHub Sync**: Configuration is stored in the repo for instant deployment on any Ubuntu box or GitHub Codespaces.

## 📂 Project Structure
- `docker-compose.yml`: Defines the Navidrome and Beets services.
- `beets/config.yaml`: Rules for the Beets auto-tagger (plugins, matching logic).
- `.env`: Local environment variables (PUID, PGID, Paths).
- `setup.sh`: Automated directory creation for Ubuntu.

## 🛠️ Quick Start

### 1. Clone and Setup
```bash
git clone https://github.com/jigar3730/my-navidrome-stack
cd my-navidrome-stack
cp .env.example .env
# Edit .env with your specific paths and PUID/PGID
./setup.sh
```

### 2. Launch the Stack
```bash
docker compose up -d
```

### 3. Fix "Unknown Album" Tags
To scan your music folder and fix missing metadata using the MusicBrainz database:
```bash
# Standard Import (Album mode)
docker exec -it beets beet import /music

# Singleton Import (For individual tracks/MediaHuman downloads)
docker exec -it beets beet import -s /music
```

### 4. Refresh Navidrome UI
Force an immediate scan after tagging:
```bash
docker exec -it my-navidrome-stack-navidrome-1 /app/navidrome scan
```

## ⚙️ Configuration Notes
- **Beets Logic**: The `config.yaml` is mounted as Read-Only from the repo to ensure consistency.
- **Persistence**: All data is stored in `${STACK_DIR}` to survive container restarts.
