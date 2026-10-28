# music_auto

**One capability bit from GBT V8, packaged standalone.** No. 46 of 341,
`creation` domain (Creation).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> **音乐自动化**（主人令 2026-10-16：把 Folia 蒸馏到音乐自动化里）：蒸自 **chthollyphile/folia-major**（AGPL-3.0，**只蒸思想不搬代码**）。核心不是做播放器，是**四条时间轴对齐**：歌词 · 音频 · 主题（配色）· 动画；六步流水线：选源→匹词→定题→出片→分发→验收。op=plan/sources/lyrics/theme/export/route/check（**全只读·零作用域·不出网**）；边界四条：AGPL 不搬代码 · 音频歌词不外发 · 凭据不入仓 · 不编时间轴。

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-music-auto.git
cd gbt-music-auto
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_music_auto info                  # capability card
python -m gbt_music_auto spec --json           # machine-readable contract
python -m gbt_music_auto check --payload '{}'
python -m gbt_music_auto run   --payload '{}'
```

Real `info` output from this machine:

```text
music_auto  (creation)  v1.0.0
----------------------------------------
**音乐自动化**（主人令 2026-10-16：把 Folia 蒸馏到音乐自动化里）：蒸自 **chthollyphile/folia-major**（AGPL-3.0，**只蒸思想不搬代码**）。核心不是做播放器，是**四条时间轴对齐**：歌词 · 音频 · 主题（配色）· 动画；六步流水线：选源→匹词→定题→出片→分发→验收。op=plan/sources/lyrics/theme/export/route/check（**全只读·零作用域·不出网**）；边界四条：AGPL 不搬代码 · 音频歌词不外发 · 凭据不入仓 · 不编时间轴。

gated      : True   <- needs explicit consent
external   : False
multi-op   : True
params     : (none)
values     : plan, sources, lyrics, theme, export, route, check
```

Wire a real implementation:

```python
from gbt_music_auto import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| — | no | the registry declares no required parameters |

Registry hint (`params_hint`): (empty)

**注册表登记的取值 / 子动作（7 个）**：`plan`、`sources`、`lyrics`、`theme`、`export`、`route`、`check`

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Gated: this bit is marked `safe: false` in the registry — it can change state that no inverse action restores.
- No external service dependency declared.
- Multi-op (`multi_op: true`): several sub-actions share one name — read `op` before calling.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
20 passed, 3 skipped in 0.10s
```

## Provenance

| field | value |
|---|---|
| capability | `music_auto` |
| domain | `creation` |
| handler | `music_auto` |
| safe | `False` (gated = `True`) |
| external | `False` |
| atlas page | [creation/music_auto](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/creation/music_auto.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.
