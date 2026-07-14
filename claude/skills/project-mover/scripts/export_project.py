#!/usr/bin/env python3
"""Export a Claude Code project's state to a portable archive.

Collects the project's session transcripts, persistent memory, and its
per-project entry in .claude.json into a tar.gz, together with a manifest
and a copy of import_project.py so the target machine does not need this
skill installed.

Reads only; never modifies any Claude Code state.
"""
import argparse
import json
import os
import re
import socket
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
    """Claude Code names the per-project state dir by replacing every
    non-alphanumeric character of the absolute path with '-'."""
    return re.sub(r"[^A-Za-z0-9]", "-", path)


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Export a Claude Code project's state to a portable archive."
    )
    parser.add_argument(
        "project_path",
        nargs="?",
        default=".",
        help="Project directory (default: current directory)",
    )
    parser.add_argument(
        "-o",
        "--output",
        help="Output archive path (default: ./claude-project-<name>.tar.gz)",
    )
    args = parser.parse_args()

    project = Path(args.project_path).expanduser().resolve()
    encoded = encode_path(str(project))
    state_dir = config_dir() / "projects" / encoded

    cj_path = claude_json_path()
    entry = None
    if cj_path.exists():
        try:
            entry = json.loads(cj_path.read_text()).get("projects", {}).get(str(project))
        except (json.JSONDecodeError, OSError) as exc:
            print(f"warning: could not read {cj_path} ({exc}); skipping config entry", file=sys.stderr)

    if not state_dir.exists() and entry is None:
        print(f"error: no Claude Code state found for {project}", file=sys.stderr)
        print(f"  looked for directory: {state_dir}", file=sys.stderr)
        print(f"  and a 'projects' entry in: {cj_path}", file=sys.stderr)
        projects_root = config_dir() / "projects"
        if projects_root.is_dir():
            print("  projects with state on this machine:", file=sys.stderr)
            for d in sorted(projects_root.iterdir()):
                print(f"    {d.name}", file=sys.stderr)
        sys.exit(1)

    sessions = sorted(state_dir.glob("*.jsonl")) if state_dir.exists() else []
    memory_dir = state_dir / "memory"
    has_memory = memory_dir.is_dir() and any(memory_dir.iterdir())

    manifest = {
        "format_version": 1,
        "project_path": str(project),
        "encoded_name": encoded,
        "exported_at": time.strftime("%Y-%m-%dT%H:%M:%S%z"),
        "hostname": socket.gethostname(),
        "session_count": len(sessions),
        "has_memory": has_memory,
        "has_config_entry": entry is not None,
    }

    out = Path(args.output).expanduser() if args.output else Path(f"claude-project-{project.name}.tar.gz")
    if out.parent != Path("."):
        out.parent.mkdir(parents=True, exist_ok=True)

    def add_json(tar: tarfile.TarFile, arcname: str, obj: object) -> None:
        with tempfile.NamedTemporaryFile("w", suffix=".json", delete=False) as tf:
            json.dump(obj, tf, indent=2)
            tmp_name = tf.name
        tar.add(tmp_name, arcname=arcname)
        os.unlink(tmp_name)

    with tarfile.open(out, "w:gz") as tar:
        add_json(tar, "manifest.json", manifest)
        if entry is not None:
            add_json(tar, "claude_json_entry.json", entry)
        if state_dir.exists():
            tar.add(state_dir, arcname="project_state")
        importer = Path(__file__).resolve().with_name("import_project.py")
        if importer.exists():
            tar.add(importer, arcname="import_project.py")

    print(f"Exported Claude Code state for {project}")
    print(f"  sessions:     {len(sessions)}")
    print(f"  memory:       {'yes' if has_memory else 'no'}")
    print(f"  config entry: {'yes' if entry is not None else 'no'}")
    print(f"  archive:      {out}")
    print()
    print("On the target machine:")
    print(f"  1. copy {out.name} over (scp, USB, cloud drive)")
    print(f"  2. tar -xzf {out.name} import_project.py")
    print(f"  3. python3 import_project.py {out.name} /path/to/project/there")


if __name__ == "__main__":
    main()
