# essay-cantonese

## `essay-cantonese.txt`

### Expected behaviour

- `gamx` → 噉 ✅️
- 而家 > 宜家 ✅️
- 留低 > 婁底 ✅️
- `zo` → 咗 ✅️
- 嗰個 > 哥哥 ❌

### Build

Prepare `cifu-freq.txt`:

Run:

```sh
cd essay
wget https://github.com/rime/rime-essay/raw/master/essay.txt
python build.py
opencc -c ./hk2t.json -i essay-cantonese.txt -o essay-cantonese.txt
python merge_freq.py
```

Result: `essay-cantonese.txt`.

### Usage

Modify `jyut6ping3.dict.yaml`:

```diff
-use_preset_vocabulary: true
+vocabulary: essay-cantonese
```

```
sed -i "s/\t1000.+$//g" jyut6ping3.dict.yaml
```
