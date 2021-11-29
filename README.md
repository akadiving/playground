### **Requirements:** 🔌
  - Docker
  - Docker-compose

### **Steps:**
  - Edit the `.env` file if necessary
  - Run the project installer: `make install`

### **Commands:** 📄
  - `make up` - Builds the containers
  - `make start`- Starts all on.ge containers
  - `make stop`- Stops all on.ge containers
  - `make shell <SERVICE NAME>`- Opens a shell console of a service (example: make shell on.website)
  - `make logs`- Open log for on.ge containers
  - `make kill`- Destroy on.ge containers
  - `make prune` - Stop and destroy all on.ge containers

### **URL:** 🗺️
  - `api.sweeft.localhost` - Main site
  - `monitor.sweeft.localhost` - Traefik web-UI
  - `docs.sweeft.localhost` - Documentations
