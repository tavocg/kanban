# kanban

A minimal terminal kanban board renderer backed by directories and Markdown files.

## Layout

```text
$KANBAN_HOME/
  <board>/
    <tab>/
      <card>.md
```

- `<board>`: board name used by `kanban -b <board>`
- `<tab>`: each subdirectory is rendered as a board column
- `<card>.md`: a card file

Card frontmatter supports:

- `title`
- `tags`

Example card:

```md
---
title: Fix login flow
tags: [backend, urgent]
---
Investigate token refresh behavior and update retry logic.
```

The card body is printed as-is (plain text wrapping only).
Long content is trimmed using `--max-content`.

## Usage

Run directly:

```sh
kanban -b my-board
```

## Configuration

Board home directory resolution order:

1. `$KANBAN_HOME`
2. `$HOME/Documents/boards`

Useful flags:

- `-b/--board <name>`: board directory to render
- `--list-boards`: list boards under home directory
- `--max-content <n>`: max card body characters (default: `180`)
- `--no-color`: disable ANSI styling
