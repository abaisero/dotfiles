---
name: project-mover
description: Migrate a Claude Code project's state from one machine to another. Moves the project's session history (past conversations), persistent memory, and per-project configuration (MCP servers, allowed tools, trust settings) — not the project's source code. Use this whenever the user wants to move, copy, transfer, back up, restore, or sync their Claude Code sessions, history, memory, or project settings across machines — e.g. setting up a new laptop, switching dev machines, moving to a server, or recovering from an old disk — even if they don't say "migrate". Phrases like "keep my Claude history", "move my conversations", "same Claude setup on my other machine", "export my sessions" all apply.
---

# Claude Project Mover

Claude Code stores a project's state outside the project directory, keyed by the project's **absolute path**:

- `~/.claude/projects/<encoded-path>/` — session transcripts (`*.jsonl`) and the persistent `memory/` directory. The encoded name is the absolute path with every non-alphanumeric character replaced by `-`.
- `~/.claude.json` — an entry under the `projects` key, keyed by the literal absolute path. Holds MCP servers, allowed tools, and trust state.
- If `CLAUDE_CONFIG_DIR` is set, both live under it instead: `$CLAUDE_CONFIG_DIR/projects/` and `$CLAUDE_CONFIG_DIR/.claude.json`.

The absolute path also appears **inside** the transcripts (the `cwd` field on most lines, plus paths in recorded commands). So if the project lives at a different path on the new machine, a correct migration rewrites those references — a plain file copy leaves the state orphaned under the old path. The bundled scripts handle all of this; use them rather than copying files by hand.

## Workflow

A migration is two halves with a manual file transfer in between. You can only run the half that belongs to the machine you're on — tell the user how to do the other half (the archive carries the import script, so the target machine doesn't need this skill).

### 1. Export (source machine)

```bash
python3 scripts/export_project.py /path/to/project -o /tmp/project-export.tar.gz
```

- The project path defaults to the current directory.
- Collects the transcripts, memory, and the `.claude.json` entry into one archive, plus a `manifest.json` and a copy of `import_project.py`.
- Respects `CLAUDE_CONFIG_DIR`. Exporting doesn't modify anything.

### 2. Transfer

The user copies the archive however they like — scp, USB drive, cloud storage. Suggest a concrete command, e.g. `scp /tmp/project-export.tar.gz user@newmachine:`.

### 3. Import (target machine)

```bash
python3 scripts/import_project.py project-export.tar.gz /path/to/project/here
```

Or, on a machine without this skill, extract the bundled importer first:

```bash
tar -xzf project-export.tar.gz import_project.py
python3 import_project.py project-export.tar.gz /path/to/project/here
```

- The project path on this machine is a required argument — there is no implicit default. If it differs from the path on the source machine, the script rewrites the encoded directory name, the `.claude.json` key, every path reference inside the transcripts, and path mentions in memory files.
- `.claude.json` is backed up before being touched, and only the one project entry is added — nothing else in the file is modified. An existing entry for the same project is kept, not overwritten.
- If state already exists for the project, the script aborts; rerun with `--merge` to add only non-conflicting files.

## After importing

Verify for the user:

1. `$CONFIG/projects/<new-encoded-name>/` exists and contains the expected `*.jsonl` sessions and `memory/`.
2. If the path changed: `grep` confirms the old path no longer appears in the transcripts.
3. The `projects` entry exists in `.claude.json` under the new path.

Then tell the user: `cd` into the project and run `claude`; past sessions are available via `/resume`, and memory carries over automatically.

## Scope notes

- This migrates Claude Code state only, not the project's source code. If the user also needs the code moved, handle that separately (usually `git clone` on the target).
- Machine-wide state (global `~/.claude/CLAUDE.md`, installed skills/plugins, credentials) is out of scope; mention it if the user seems to expect a full environment clone.
