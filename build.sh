#!/bin/sh

bundle exec jekyll build
bundle exec jekyll serve --host $(ip addr show docker0 2>/dev/null | awk '/inet / {print $2}' | cut -d/ -f1 || echo '127.0.0.1') --port 44000 --incremental --watch --drafts --trace --config _config.yml,_local_config.yml
