# essay-cantonese

## Expected behaviour

- [x] `gamx` → 噉
- [x] 而家 > 宜家
- [x] 留低 > 婁底
- [x] `zo` → 咗
- [ ] 嗰個 > 哥哥

## Build

Prepare `cifu-freq.txt`.

Run:

```sh
cd essay
wget https://github.com/rime/rime-essay/raw/master/essay.txt
python build.py
opencc -c ./hk2t.json -i essay-cantonese.txt -o essay-cantonese.txt
python merge_freq.py
wget https://github.com/rime/rime-cantonese/raw/master/jyut6ping3.dict.yaml
perl -pi -e "s/use_preset_vocabulary: true/vocabulary: essay-cantonese/g" jyut6ping3.dict.yaml
perl -pi -e "s/\t1000.+$//g" jyut6ping3.dict.yaml
```

## Usage

Copy `jyut6ping3.dict.yaml` and `essay-cantonese.txt` to the rime user directory.
