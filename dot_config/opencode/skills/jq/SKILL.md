---
name: jq
description: Extract a known field from a JSON file by running jq instead of reading the whole file.
---

# jq

When you need a specific field from a JSON file, reach for `jq` rather than
reading the whole file.

```
jq -r '.field' file.json
```

Three details easy to forget:

- `-r` -- raw string output (no surrounding quotes)
- `// "default"` -- fallback when a field is missing or null
- `keys[]` -- list an object's property names

For anything beyond this, `man jq`.
