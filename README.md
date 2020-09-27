[English](README-en.md) | [官話](README-cmn.md)

<div lang="yue-HK">

<h1 align="center">Rime 粵語拼音方案</h1>

<p align="center">
<a href="https://github.com/rime/rime-cantonese/issues"><img src="https://img.shields.io/badge/%E6%AD%A1%E8%BF%8E-%E5%8F%83%E8%88%87%E8%B2%A2%E7%8D%BB-1dd3b0?style=for-the-badge&logo=github"/></a>
<a href="https://github.com/rime/rime-cantonese/releases"><img src="https://img.shields.io/github/v/release/rime/rime-cantonese?color=38618c&label=%E7%A9%A9%E5%AE%9A%E7%99%BC%E4%BD%88%E7%89%88%E6%9C%AC&style=for-the-badge"/></a>
<a href="https://travis-ci.com/github/rime/rime-cantonese"><img src="https://img.shields.io/travis/com/rime/rime-cantonese?label=%E5%B0%81%E8%A3%9D%E7%A8%8B%E5%BC%8F&logo=travis-ci&logoColor=white&style=for-the-badge"/></a>
</p>

本項目由「粵語計算語言學基礎建設組」([@CanCLID](https://github.com/CanCLID)) 開發同維護，主體部分循「[共享創意-署名-4.0國際](http://creativecommons.org/licenses/by/4.0/)」協議發佈，`jyut6ping3.maps` 循「[開放資料庫授權-1.0](https://opendatacommons.org/licenses/odbl/)」協議發佈。

---

配方：℞ `cantonese`

配方入邊 `jyut6ping3` 係聲調顯示版方案，`jyut6ping3_ipa` 係 IPA 顯示版方案。

**Telegram 用户交流組**：[![t.me/rime_cantonese](https://img.shields.io/badge/rime_cantonese-blue?style=flat-square&logo=telegram)](https://t.me/rime_cantonese)

**Gitter 交流室**：[![Gitter](https://img.shields.io/badge/rime_cantonese-blueviolet?style=flat-square&logo=gitter)](https://gitter.im/rime-cantonese/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

**拼音方案**

- 本方案**凈係**支援「香港語言學學會粵語拼音方案」（簡稱「**粵拼**」）：
    - [Jyutping 粵拼 | lshk](https://www.lshk.org/jyutping)
    - [粵拼：香港語言學學會粵語拼音方案](https://www.jyutping.org/jyutping/)
    - [香港語言學學會粵語拼音方案](https://zh.wikipedia.org/wiki/香港語言學學會粵語拼音方案)
- IPA 顯示版以 Bauer, Robert S., and Paul K. Benedict. *Modern Cantonese Phonology*. Berlin: Mouton de Gruyter, 1997. 為準 (詳見 Section 1.3 Cantonese rimes, 48-92)
- 其他拼音方案嘅補丁：詳情請參閱 [`CanCLID/rime-cantonese-schemes`](https://github.com/CanCLID/rime-cantonese-schemes)。

**演示**

| 粵語拼音                   | 粵語拼音（IPA 版）        |
| -------------------------- | ------------------------- |
| ![聲調版](./demo/tone.gif) | ![IPA 版](./demo/ipa.gif) |

* 其他拼音方案嘅排版工具：[`CanCLID/rime-cantonese-schemes-editor`](https://github.com/CanCLID/rime-cantonese-schemes-editor)

## 安裝

詳細教程請見[安裝教程](https://github.com/rime/rime-cantonese/releases)。

如果有遇到任何問題，歡迎加入上面嘅 Telegram 交流組搵幫手。

## 使用説明

### 聲調輸入

輸入嗰陣可以忽略聲調，如果想打埋聲調，對應鍵位係：

1. v：陰平，打 `siv` 出「詩」；上陰入，打 `sikv` 出「色」
2. x：陰上，打 `six` 出「史」
3. q：陰去，打 `siq` 出「試」；下陰入，打 `sekq` 出「錫」
4. vv：陽平，打 `sivv` 出「時」
5. xx：陽上，打 `sixx` 出「市」
6. qq：陽去，打 `siqq` 出「事」；陽入，打 `sikqq` 出「食」

### 添加模糊音支援

本方案預設**唔支援**任何模糊音同懶音，即區分 n-/l-, &empty;-/ng- 等常見懶音。如果想支援模糊音，先打開 `jyut6ping3.schema.yaml`，拉到下面 `speller/algebra:` 部分，可以見到幾行註釋咗嘅代碼。想要支援某個或者幾個模糊音，就將相應嘅嗰行代碼取消註釋（刪咗前面個 `#` 去），例如要支援 n-/l- 不分，就改成噉：

```yaml
# 取消下行註釋，支援 n- 併入 l- ，如「你」讀若「理」
- derive/^n(?!g)/l/
```

然後重新部署，試下打 lei hou，發現都出得到「你好」嘞。

### 用字標準切換

本方案預設採用 OpenCC 用字標準，喺方案選單中顯示為「傳統漢字」。亦都支援**香港傳統漢字**、**臺灣傳統漢字**同**大陆简化汉字**。要切換用字標準，撳 <kbd>Ctrl</kbd> 同 <kbd>`</kbd> 兩粒掣，就會顯示選單，然後就可以揀用字標準嘞。

### Emoji 輸入

撳 <kbd>Ctrl</kbd> 同 <kbd>`</kbd> 兩粒掣打開選單，然後撳 <kbd>2</kbd>，揀「有 Emoji」就可以啓用 emoji——當你打一個中文詞嘅時候，選字表就會出現對應嘅 emoji 符號嘞。

emoji 碼表可以喺[呢度](https://github.com/rime/rime-emoji/tree/master/opencc)搵到。

如果想永久啓用 emoji 嘅話，可以修改 `jyut6ping3.schema.yaml` 嘅 `switches` 做：

```yaml
- name: emoji_suggestion
  # 取消下行註釋，預設啓動 emoji
  reset: 1
  states: [ 冇 Emoji, 有 Emoji ]
```

### 反查

本方案支援普通話拼音、[粵語兩分](https://github.com/CanCLID/rime-loengfan)、筆畫、倉頡反查，反查掣：

- 普通話拼音：<kbd>`</kbd>
- 粵語兩分：<kbd>r</kbd>
- 筆畫：<kbd>x</kbd>
- 倉頡五代：<kbd>v</kbd>

### 特殊符號輸入

本方案支援特殊符號輸入，輸入方法係 <kbd>/</kbd> + 符號代碼。

符號代碼睇呢度：

- [`symbols.yaml`](https://github.com/rime/rime-prelude/blob/master/symbols.yaml)
- [`symbols_cantonese.yaml`](symbols_cantonese.yaml)

## 字音及詞庫資料來源

見本倉庫 [Wiki](https://github.com/rime/rime-cantonese/wiki)。

## 貢獻指南

如果有任何修改意見，或者你想一齊參與呢個項目幫我哋手，可以直接[新開一個 issue 提出](https://github.com/rime/rime-cantonese/issues)，亦都可以加入上面嘅 [Telegram 交流組](https://t.me/rime_cantonese)直接反饋意見。

</div>
