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

Card content is trimmed to 180 characters.
Cards with `done: true` show strikethrough.
Cards with `archive: true` are hidden and counted in the tab title as `(<n>)`.
Within each tab, cards are sorted by ascending `due`; cards without `due` are placed after dated cards and ordered by filename.
When `due` is set, it is shown beside the title as `Title • Due in <n>d|<n>h|<n>m`.
Past due dates are shown using the original frontmatter value as `Title • Due <due>`.
Running `kanban` with no arguments shows two tabs, `Overdue` and `Next 7 days`, built from every board under `KANBAN_HOME`. In that agenda view, cards render as `board • title • due`.

## Usage

Run directly:

```sh
kanban
kanban -l
kanban -b my-board
kanban -b meca
```

## Configuration

Board home directory resolution order:

1. `$KANBAN_HOME`
2. `$HOME/Documents/boards`

Useful flags:

- `-b/--board <name>`: board directory to render; accepts partial, case-insensitive, accent-insensitive matches and prefers the closest match
- `-l`: list boards under home directory
- `-n`: disable ANSI styling
