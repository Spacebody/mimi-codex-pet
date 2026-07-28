# Mimi Codex Pet

Mimi is a silver tabby American Shorthair companion for Codex. This repository keeps the original V1 pet and the extended V2 pet in separate, self-contained version directories.

<img src="versions/v1/source/references/canonical-base.png" alt="Mimi preview" width="256">

## Install

Install the current version (V2):

```bash
./install.sh
```

Choose a version explicitly:

```bash
./install.sh --version v2
./install.sh --version v1
```

You can also use the short positional form:

```bash
./install.sh v1
```

Restart Codex after installing, then choose `Mimi` from custom pets.

Both packages use the pet ID `mimi`, so only one version is active at a time. Running the installer again switches the active installation without changing either version stored in this repository.

If `CODEX_HOME` is set, the installer writes to `$CODEX_HOME/pets/mimi`. Otherwise it writes to `~/.codex/pets/mimi`.

## Versions

| Version | Atlas | Manifest contract | Content |
| --- | --- | --- | --- |
| V2 (default) | 1536×2288, 8×11 | `spriteVersionNumber: 2` | Nine standard animation rows plus 16 clockwise look directions |
| V1 (legacy) | 1536×1872, 8×9 | No `spriteVersionNumber` | Nine standard animation rows |

The repository layout is deliberately version-isolated:

```text
versions/
  v1/
    pet/
    qa/
    source/
  v2/
    pet/
    qa/
```

See [V1 details](versions/v1/README.md) and [V2 details](versions/v2/README.md).

## Animation States

Both versions include:

- `idle`
- `running-right`
- `running-left`
- `waving`
- `jumping`
- `failed`
- `waiting`
- `running`
- `review`

V2 adds 16 look directions in 22.5-degree steps across atlas rows 9 and 10. `000` means looking up, followed clockwise through `337.5`.

## Manual Install

Replace `<version>` with `v1` or `v2`:

```bash
mkdir -p ~/.codex/pets/mimi
cp versions/<version>/pet/pet.json \
  versions/<version>/pet/spritesheet.webp \
  ~/.codex/pets/mimi/
```

## License

MIT. See [LICENSE](LICENSE).
