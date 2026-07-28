# Mimi V2

Mimi V2 extends the original pet with the Codex V2 look-direction contract.

- Atlas: `pet/spritesheet.webp`
- Size: 1536×2288 (8 columns × 11 rows)
- Cell size: 192×208
- Manifest: `pet/pet.json`
- Contract: `spriteVersionNumber: 2`
- Standard animation rows: 0–8
- Look direction rows: 9–10

The 16 look cells progress clockwise in 22.5-degree steps:

```text
row 9:  000, 022.5, 045, 067.5, 090, 112.5, 135, 157.5
row 10: 180, 202.5, 225, 247.5, 270, 292.5, 315, 337.5
```

`000` means looking up. The V2 atlas also contains the dedicated neutral look frame used by the renderer.

Install V2 from the repository root:

```bash
./install.sh
```

Package-level verification evidence and its scope are recorded in `qa/package-checks.json`.
