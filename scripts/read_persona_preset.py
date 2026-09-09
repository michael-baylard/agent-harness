"""Emit persona preset JSON for install.ps1. Usage: python read_persona_preset.py <id> [harness_root]"""
from __future__ import annotations

import json
import sys
from pathlib import Path

try:
    import yaml
except ImportError:
    yaml = None  # type: ignore


def main() -> None:
    if len(sys.argv) < 2:
        raise SystemExit("usage: read_persona_preset.py <persona-id> [harness_root]")
    persona_id = sys.argv[1]
    root = Path(sys.argv[2]) if len(sys.argv) > 2 else Path(__file__).resolve().parents[1]
    path = root / "config" / "persona-presets" / f"{persona_id}.yaml"
    if not path.exists():
        raise SystemExit(f"missing preset: {path}")
    text = path.read_text(encoding="utf-8")
    if yaml is None:
        raise SystemExit("PyYAML required in shared dev-env venv")
    data = yaml.safe_load(text)
    print(json.dumps(data, default=str))


if __name__ == "__main__":
    main()
