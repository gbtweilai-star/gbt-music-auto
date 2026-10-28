#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_music_auto info
PYTHONPATH=src python -m gbt_music_auto check --payload '{}'
PYTHONPATH=src python -m gbt_music_auto run   --payload '{}'
