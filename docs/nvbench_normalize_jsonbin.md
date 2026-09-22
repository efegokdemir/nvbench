# `nvbench-normalize-jsonbin`

`nvbench-normalize-jsonbin` repairs legacy NVBench JSON results whose jsonbin
sidecar filenames were recorded relative to the launch directory instead of
the JSON file directory.

Preview changes without modifying the result:

```bash
nvbench-normalize-jsonbin --dry-run result.json
```

Write a normalized copy, or update the result in place with a backup:

```bash
nvbench-normalize-jsonbin --output normalized.json result.json
nvbench-normalize-jsonbin --in-place result.json
```

The tool resolves sample-time and sample-frequency sidecars relative to the
JSON file, the launch directory, or an explicitly supplied `--sidecar-root`.
If a sidecar is missing or more than one candidate exists, it exits with an
error instead of silently choosing a path.
