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
- `done` (`true`/`false`)
- `archive` (`true`/`false`)
- `due` (ISO datetime or date, for example `2026-03-22T15:30` or `2026-03-22`)

Example card:

```md
---
title: Fix login flow
tags: [backend, urgent]
done: false
archive: false
due: 2026-03-22T15:30
---
Investigate token refresh behavior and update retry logic.
```

Long content is trimmed using `--max-content`.
Cards with `done: true` show strikethrough.
Cards with `archive: true` are hidden and counted in the tab title as `(<n>)`.
When `due` is set, it is shown beside the title as `Title • Due in <n>d|<n>h|<n>m`.

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
