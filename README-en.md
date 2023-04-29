[粵語](README.md) | [官話](README-cmn.md)

<h1 align="center">Rime Cantonese Input</h1>

<p align="center">
<a href="https://github.com/rime/rime-cantonese/issues"><img src="https://img.shields.io/badge/Contributions-Welcomed-1dd3b0?style=for-the-badge&logo=github"/></a>
<a href="https://github.com/rime/rime-cantonese/releases"><img src="https://img.shields.io/github/v/release/rime/rime-cantonese?color=38618c&style=for-the-badge"/></a>
<img alt="GitHub Workflow Status" src="https://img.shields.io/github/actions/workflow/status/rime/rime-cantonese/package.yml?label=Deploy&logo=github&style=for-the-badge">

This work is developed and maintained by the Cantonese Computational Linguistics Infrastructure Development Workgroup ([@CanCLID](https://github.com/CanCLID)). The main part of this work is released under a [Creative Commons Attribution 4.0 International License](http://creativecommons.org/licenses/by/4.0/). `jyut6ping3.maps` is released under a [Open Data Commons Open Database v1.0 License](https://opendatacommons.org/licenses/odbl/).

<p align="center"><a href="https://github.com/rime/rime-cantonese/releases"><img src="https://raw.githubusercontent.com/rime/rime-cantonese/build/button How to install.svg"/></a></p>

Feel free to ask for help in the [Telegram group](https://t.me/rime_cantonese) if you encounter any problem.

---

Schema name: ℞ `cantonese`

`jyut6ping3` is the Jyutping input method schema, while `jyut6ping3_ipa` is the IPA typesetting version.

**Feedback Form for Data Issues**：[![Google Form](https://img.shields.io/badge/Google_Form-white?style=flat-square&logo=google)](https://forms.gle/83cVEAiahr9wjyyq6) [![騰訊問卷](https://img.shields.io/badge/%E9%A8%B0%E8%A8%8A%E5%95%8F%E5%8D%B7-brightgreen?style=flat-square)](https://wj.qq.com/s2/7613837/0794)

**Telegram User Chat Room**: [![t.me/rime_cantonese](https://img.shields.io/badge/rime_cantonese-blue?style=flat-square&logo=telegram)](https://t.me/rime_cantonese)

**Romanization Scheme**

- This schema **only** supports the _LSHK Jyutping Romanization Scheme_ (**粵拼** in Chinese):
  - [Jyutping 粵拼 | LSHK](https://www.lshk.org/jyutping)
  - [Jyutping: The Linguistics Society of Hong Kong Cantonese Romanization Scheme](https://www.jyutping.org/en/jyutping/)
  - [Jyutping](https://en.wikipedia.org/wiki/Jyutping)
- For users of other romanization schemes (e.g. Yale, EduHK), please download the corresponding patch file [here](https://github.com/CanCLID/rime-cantonese-schemes).

**Demo**

| Jyutping                   | Jyutping (IPA version)    |
| -------------------------- | ------------------------- |
| ![示例 1](./demo/tone.gif) | ![示例 2](./demo/ipa.gif) |

- Please find the typesetting tools for other romanization schemes here: [`CanCLID/rime-cantonese-schemes-editor`](https://github.com/CanCLID/rime-cantonese-schemes-editor)

## Instructions

### Tonal markers

While tone markers are not obligatory for typing characters, you may use the following keystrokes to specify the tone to disambiguate:

1. v: High level, e.g. `siv` → 詩; High level checked, e.g. `sikv` → 色
2. x: Medium rising, e.g. `six` → 史
3. q: Medium level, e.g. `siq`→ 試; Medium level checked, e.g. `sekq` → 錫
4. vv: Low falling, e.g. `sivv` → 時
5. xx: Low rising, e.g. `sixx` → 市
6. qq: Low level, e.g. `siqq`→ 事; Low level checked, e.g. `sikqq` → 食

### Fuzzy input

This schema **does not support by default** any fuzzy or 'lazy' pronunciations, i.e. pairs like **n-/l-** and **&empty;-/ng-** are contrastive. If you want the schema to accommodate for fuzzy pronunciations, uncomment the relevant lines under the `speller/algebra:` section in the schema file. e.g. If you want the input method to support the **n-/l-** → **l-** merger, use:

```yaml
# 取消下行註釋, 支援 n- 併入 l- , 如「你」讀若「理」
- derive/^n(?!g)/l/
```

and redeploy. Then voila, `lei hou` will now be recognized internally as 'nei hou'.

### Regional Character Variations

This schema uses the OpenCC standard character set by default--coded as「傳統漢字」in the file. If you want to switch over to the Hong Kong, Taiwanese or Mainland Chinese standard, click <kbd>Ctrl</kbd> + <kbd>`</kbd> and choose the relevant standard from the options list.

### Emoji input

Click <kbd>Ctrl</kbd> + <kbd>`</kbd> and then <kbd>2</kbd> to access the settings menu. Then, from the menu, choose 「有 Emoji」 to enable emoji input - doing so will allow the system to recognize and convert certain Chinese words into their corresponding emoji icons.

The full list of emoji icons can be found [here](https://github.com/rime/rime-emoji/tree/master/opencc).

Please use the following snippet under `switches` in `jyut6ping3.schema.yaml` to permanently enable emoji input.

```yaml
- name: emoji_suggestion
  # 取消下行註釋，預設啓動 emoji (i.e. uncomment the next line to permanently enable emoji input)
  reset: 1
  states: [冇 Emoji, 有 Emoji]
```

### Reverse lookup

This schema also allows the user to lookup Cantonese words with Putonghua Pinyin, [Loengfan](https://github.com/CanCLID/rime-loengfan), stroke order and Cangjie code. Click the following button in edit mode to enable the respective reverse lookup option:

- Putonghua: <kbd>`</kbd>
- Loengfan: <kbd>r</kbd>
- Stroke order: <kbd>x</kbd>
- Cangjie (5th gen): <kbd>v</kbd>

### Special symbols

You can also insert special symbols by <kbd>/</kbd> + `symbol code`.

The complete list of symbols (and their codes) can be found in the two files below:

- [`symbols.yaml`](https://github.com/rime/rime-prelude/blob/master/symbols.yaml)
- [`symbols_cantonese.yaml`](symbols_cantonese.yaml)

## Dictionary Data Source

Please find the detailed description in the [Wiki](https://github.com/rime/rime-cantonese/wiki).

## Contribution

We welcome all forms of contributions. Feel free to leave us a [GitHub issue (or pull request)](https://github.com/rime/rime-cantonese/issues), or a message in our [Telegram group](https://t.me/rime_cantonese) if you find any bug or have any suggestion in general.
