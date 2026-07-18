# CLAUDE.md

## Overview

Personal website / blog published via GitHub Pages at the `andrius.github.io`
repo (custom domain in `CNAME`). Built on the Pixyll Jekyll theme (originally
by John Otander), customized by Andrius Kairiukstis. Own project.

## Tech stack

- Jekyll (static site generator), Ruby + Bundler (`Gemfile`).
- Liquid templates in `_layouts/`, `_includes/`; content in `_posts/`, `_drafts/`.
- Styles under `_sass/` and `css/` (Sass).
- Static output builds to `_site/` (generated, not edited by hand).

## Structure

- `_config.yml` (if present) holds site settings.
- `_posts/` - published posts (dated `YYYY-MM-DD-title.md`).
- `Rakefile` - helper tasks, e.g. `rake post['Title']` scaffolds a new post.
- Year folders (`2013/`, `2014/`, ...) and `cv/`, `contact/` are content pages.

## Commands

- `bundle install` - install gems.
- `bundle exec jekyll serve` - local preview with live reload.
- `bundle exec jekyll build` - build into `_site/`.
- `rake post['My Title']` - create a new post stub.

## Notes

- Last commit 2020; effectively an archived personal site.
- Theme heritage is upstream Pixyll; site-specific content and config are Andrius's.
