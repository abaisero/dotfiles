#!/usr/bin/env python3
"""Import a Claude Code project archive created by export_project.py.

Restores session transcripts, persistent memory, and the per-project
.claude.json entry. The project's path on this machine is a required
argument; if it differs from the path on the source machine, every path
reference is rewritten: the encoded state-directory name, the
.claude.json key, the cwd fields and path mentions inside transcripts,
and path mentions in memory files.

Safety: .claude.json is backed up before being modified, and only the one
project entry is added — an existing entry for the same project is kept.
If state already exists for the project, the import aborts unless --merge
is given, in which case only non-conflicting files are added.
"""
import argparse
import json
import os
import re
import shutil
import sys
import tarfile
import tempfile
import time
from pathlib import Path


def config_dir() -> Path:
    env = os.environ.get("CLAUDE_CONFIG_DIR")
    return Path(env).expanduser() if env else Path.home() / ".claude"


def claude_json_path() -> Path:
    env = os.environ.get("CLAUDE_CONFIG_DIR")
    if env:
        return Path(env).expanduser() / ".claude.json"
    return Path.home() / ".claude.json"


def encode_path(path: str) -> str:
    return re.sub(r"[^A-Za-z0-9]", "-", path)


def rewrite_obj(obj: object, old: str, new: str) -> object:
    """Replace old->new in every string of a JSON-like structure."""
    if isinstance(obj, str):
        return obj.replace(old, new)
    if isinstance(obj, list):
        return [rewrite_obj(v, old, new) for v in obj]
    if isinstance(obj, dict):
        return {k: rewrite_obj(v, old, new) for k, v in obj.items()}
    return obj


def rewrite_jsonl_file(path: Path, old: str, new: str) -> None:
    lines = []
    with path.open() as fh:
        for line in fh:
            line = line.strip()
            if not line:
                continue
            obj = rewrite_obj(json.loads(line), old, new)
            lines.append(json.dumps(obj, ensure_ascii=False, separators=(",", ":")))
    path.write_text("\n".join(lines) + "\n")


def rewrite_text_file(path: Path, old: str, new: str) -> None:
    try:
        text = path.read_text()
    except (UnicodeDecodeError, OSError):
        return  # binary or unreadable; leave as is
    if old in text:
        path.write_text(text.replace(old, new))


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Import a Claude Code project archive created by export_project.py."
    )
    parser.add_argument("archive", help="The .tar.gz archive to import")
    parser.add_argument(
        "project_path",
        help="Absolute path of the project on this machine",
    )
    parser.add_argument(
        "--merge",
        action="store_true",
        help="If state already exists for this project, add non-conflicting "
        "files instead of aborting",
    )
    args = parser.parse_args()

    with tempfile.TemporaryDirectory() as tmp_str:
        tmp = Path(tmp_str)
        with tarfile.open(args.archive) as tar:
            try:
                tar.extractall(tmp, filter="data")
            except TypeError:  # Python < 3.12 has no extract filters
                tar.extractall(tmp)

        manifest_file = tmp / "manifest.json"
        if not manifest_file.exists():
            print(f"error: {args.archive} has no manifest.json; "
                  "not an archive made by export_project.py", file=sys.stderr)
            sys.exit(1)
        manifest = json.loads(manifest_file.read_text())
        old_path = manifest["project_path"]

        new_path = str(Path(args.project_path).expanduser().resolve())
        encoded = encode_path(new_path)
        state_src = tmp / "project_state"
        state_dst = config_dir() / "projects" / encoded

        # Rewrite path references in the extracted copy before installing.
        if new_path != old_path and state_src.is_dir():
            for f in state_src.rglob("*"):
                if not f.is_file():
                    continue
                if f.suffix == ".jsonl":
                    rewrite_jsonl_file(f, old_path, new_path)
                else:
                    rewrite_text_file(f, old_path, new_path)

        # Install the state directory.
        copied, skipped = 0, 0
        if state_src.is_dir():
            if state_dst.exists() and not args.merge:
                print(f"error: {state_dst} already exists.", file=sys.stderr)
                print("  Rerun with --merge to add non-conflicting files, or move "
                      "the existing directory away first.", file=sys.stderr)
                sys.exit(1)
            for f in state_src.rglob("*"):
                if not f.is_file():
                    continue
                rel = f.relative_to(state_src)
                dst = state_dst / rel
                if dst.exists():
                    skipped += 1
                    continue
                dst.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(f, dst)
                copied += 1

        # Install the .claude.json entry.
        entry_file = tmp / "claude_json_entry.json"
        entry_status = "none in archive"
        backup = None
        if entry_file.exists():
            entry = rewrite_obj(json.loads(entry_file.read_text()), old_path, new_path)
            cj_path = claude_json_path()
            if cj_path.exists():
                backup = cj_path.with_name(
                    cj_path.name + ".backup-" + time.strftime("%Y%m%d-%H%M%S")
                )
                shutil.copy2(cj_path, backup)
                data = json.loads(cj_path.read_text())
            else:
                cj_path.parent.mkdir(parents=True, exist_ok=True)
                data = {}
            projects = data.setdefault("projects", {})
            if new_path in projects:
                entry_status = "kept existing entry (not overwritten)"
            else:
                projects[new_path] = entry
                cj_path.write_text(json.dumps(data, indent=2) + "\n")
                entry_status = f"added to {cj_path}"

    print(f"Imported Claude Code state for {new_path}")
    if new_path != old_path:
        print(f"  rewrote path references: {old_path} -> {new_path}")
    print(f"  state directory: {state_dst}")
    print(f"  files copied:    {copied}" + (f" ({skipped} already existed, skipped)" if skipped else ""))
    print(f"  config entry:    {entry_status}")
    if backup:
        print(f"  config backup:   {backup}")
    print()
    print(f"Done. cd {new_path} and run claude; past sessions are under /resume.")


if __name__ == "__main__":
    main()
