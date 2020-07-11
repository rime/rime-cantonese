# essay-cantonese

## Expected behaviour

- `gamx` → the first candidate should be 噉
- 而家 > 宜家

## Build

Input:

- `essay.txt`
- `cifu-freq.txt`

Run:

`make zhwiki.dict.yaml`

Result:

`essay-cantonese.txt`

## Usage

Go to `jyut6ping3.yaml`:

```diff
-use_preset_vocabulary: true
+vocabulary: essay-cantonese
```

Delete `1000.0`
