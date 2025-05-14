# Installation Guide

This document provides instructions for setting up and running this Jekyll-based blog.

## Method 1: Traditional Ruby Installation

### Prerequisites

- Linux/Unix-based system (Ubuntu/Debian recommended)
- Git

### Installation Steps

1. Install Ruby and Ruby development packages:

```bash
sudo apt install ruby ruby-dev
```

2. Install Bundler gem:

```bash
sudo gem install bundler
```

3. Clone the repository (if you haven't already):

```bash
git clone <repository-url>
cd blog
```

4. Install dependencies using Bundler:

```bash
bundle
```

5. Run the Jekyll server:

```bash
bundle exec jekyll serve
```

The blog will be available at http://localhost:4000

## Method 2: Docker Installation

### Prerequisites

- Docker
- Docker Compose

### Installation Steps

1. Clone the repository (if you haven't already):

```bash
git clone <repository-url>
cd blog
```

2. Build and run using Docker Compose:

```bash
docker compose up
```

The blog will be available at http://localhost:4000

### Additional Docker Commands

- Build the site without serving:

```bash
docker compose run jekyll-build
```

- Run in detached mode:

```bash
docker compose up -d
```

- Stop the containers:

```bash
docker compose down
```

## Troubleshooting

If you encounter any issues with port 4000 being unavailable, you may need to:

1. Check if another process is using port 4000:
   ```bash
   sudo lsof -i :4000
   ```

2. If using Docker, ensure the port mapping is correct in the docker-compose.yml file.

3. For Docker installations, you may need to enable access to port 4000:
   ```bash
   sudo iptables -I INPUT -p tcp --dport 4000 -j ACCEPT
   ```
