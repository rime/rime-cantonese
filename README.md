# essay-cantonese

## Expected behaviour

- `gamx` → the first candidate should be 噉
- 而家 > 宜家

## Build Essay

Input:

- `essay.txt`
- `cifu-freq.txt`

Run:

`cd essay`

`python build.py`

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
