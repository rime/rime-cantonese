<h1 align="center">Rime Cantonese Input</h1>

<p align="center">
<a href="https://github.com/rime/rime-cantonese/issues"><img src="https://img.shields.io/badge/Contributions-Welcomed-1dd3b0?style=for-the-badge&logo=github"/></a>
<a href="https://github.com/rime/rime-cantonese/releases"><img src="https://img.shields.io/github/v/release/rime/rime-cantonese?color=38618c&style=for-the-badge"/></a>
<a href="https://travis-ci.com/github/rime/rime-cantonese"><img src="https://img.shields.io/travis/com/rime/rime-cantonese?label=Deploy&logo=travis-ci&logoColor=white&style=for-the-badge"/></a>
<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://img.shields.io/github/license/rime/rime-cantonese?color=blue&label=License&logo=creative-commons&logoColor=white&style=for-the-badge"/></a>
<br/>
This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
</p>

Schema name: ℞ `cantonese`

`jyut6ping3` is the Jyutping input method schema, while `jyut6ping3_ipa` is the IPA typesetting version.

**Telegram User Chat Room**: [![t.me/rime_cantonese](https://img.shields.io/badge/rime_cantonese-blue?style=flat-square&logo=telegram)](https://t.me/rime_cantonese)

**Gitter Community**: [![Gitter](https://img.shields.io/badge/rime_cantonese-blueviolet?style=flat-square&logo=gitter)](https://gitter.im/rime-cantonese/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

**Romanization Scheme**

- This schema **only** supports the *LSHK Jyutping Romanization Scheme* (**粵拼** in Chinese):
    - [Jyutping 粵拼 | LSHK](https://www.lshk.org/jyutping)
    - [Jyutping: The Linguistics Society of Hong Kong Cantonese Romanization Scheme](https://www.jyutping.org/en/jyutping/)
    - [Jyutping](https://en.wikipedia.org/wiki/Jyutping)
- For users of other romanization schemes (e.g. Yale, EduHK), please download the relevant patch file [here](https://github.com/tanxpyox/rime-cantonese-schemes).

**Demo**

| Jyutping                   | Jyutping (IPA version)        |
| -------------------------- | ------------------------- |
| ![示例 1](./demo/tone.gif) | ![示例 2](./demo/ipa.gif) |

* Please find the typesetting tools for other romanization schemes here: [`tanxpyox/rime-cantonese-schemes-editor`](https://github.com/tanxpyox/rime-cantonese-schemes-editor)

## Installation

Please check out our installation guide [here](https://github.com/rime/rime-cantonese/releases).

Feel free to ask for help in the Telegram group if you encounter any problem.

## Instructions

### Tonal markers

While tone markers are not obligatory for typing characters, you may use the following keystrokes to specify the tone to disambiguate:

1. v: High level, e.g. `siv` → 「詩」; High level checked, e.g. `sikv` →「色」
2. x: Medium rising, e.g. `six` →「史」
3. q: Medium level, e.g. `siq`→「試」; Medium level checked, e.g. `sekq` →「錫」
4. vv: Low falling, e.g. sivv →「時」
5. xx: Low rising, e.g. `sixx` →「市」
6. qq: Low level, e.g. `siqq`→「事」; Low level checked, e.g. `sikqq` →「食」

### Fuzzy input

This schema **does not support by default** any fuzzy or 'lazy' pronunciations, i.e. pairs like **n-/l-** and **&empty;-/ng-** are contrastive. If you want the schema to accommodate for fuzzy pronunciations, uncomment the relevant lines under the `speller:algebra` section in the schema file. e.g. If you want the input method to support the **n-/l-** → **l-** merger, use:

```yaml
# 取消下行註釋, 支援 n- 併入 l- , 如「你」讀若「理」
- derive/^n(?!g)/l/
```

and redeploy. Then voila, `lei hou` will now be recognized internally as 'nei hou'.

### Regional Character Variations

This schema uses the OpenCC standard character set by default--coded as「傳統漢字」in the file. If you want to switch over to the Hong Kong, Taiwan or Mainland Chinese standard, click <kbd>Ctrl</kbd> + <kbd>`</kbd> and choose the relevant standard from the options list.

### Emoji input
Click <kbd>Ctrl</kbd> + <kbd>`</kbd> and then <kbd>2</kbd> to access the settings menu. Then, from the menu, choose【有emoji】to enable emoji input - doing so will allow the system to recognize and convert certain Chinese words into their corresponding emoji icons.

The full list of emoji icons can be found [here](https://github.com/rime/rime-emoji/tree/master/opencc).

Please use the following snippet under `switches` in `jyut6ping3.schema.yaml` to permenantly enable emoji input.

```yaml
- name: emoji_suggestion
  # 取消下行註釋，預設啓動 emoji (i.e. uncomment the next line to permanently enable emoji input)
  reset: 1
  states: [ 冇 Emoji, 有 Emoji ]
```

### Reverse lookup

This schema also allows the user to lookup Cantonese words with Mandarin Pinyin, stroke order and Cangjie code. Click the following button in edit mode to enable the respective reverse lookup option:

- Mandarin Pinyin: <kbd>`</kbd>
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
