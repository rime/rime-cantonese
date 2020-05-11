<div lang="yue-HK">

# Rime 粵語拼音方案

配方：℞ `cantonese`

配方入邊 `jyut6ping3` 係聲調顯示版方案，`jyut6ping3_ipa` 係 IPA 顯示版方案。

**Telegram 用户交流組**：[t.me/rime_cantonese](https://t.me/rime_cantonese)

**Gitter 交流室**：[![Gitter](https://badges.gitter.im/rime-cantonese/community.svg)](https://gitter.im/rime-cantonese/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

**拼音方案**

- 本方案**只係**支持「香港語言學學會粵語拼音方案」（簡稱「**粵拼**」）：
    - [Jyutping 粵拼 | lshk](https://www.lshk.org/jyutping)
    - [粵拼：香港語言學學會粵語拼音方案](https://www.jyutping.org/jyutping/)
    - [香港語言學學會粵語拼音方案](https://zh.wikipedia.org/wiki/香港語言學學會粵語拼音方案)
- 另外有由第三方開發者製作，只供教育用途嘅分歧拼音方案補丁，方便用家從其他方案過渡至粵拼。詳情請參閱[呢度](https://github.com/tanxpyox/rime-cantonese-schemes)。

**演示**

| 粵語拼音                   | 粵語拼音（IPA 版）        |
| -------------------------- | ------------------------- |
| ![示例 1](./demo/tone.gif) | ![示例 2](./demo/ipa.gif) |

## 安裝

詳細教程請見[安裝教程](https://github.com/rime/rime-cantonese/releases)。

如果有遇到任何問題，歡迎加入上面嘅 Telegram 交流組尋求幫助。

## 使用説明

### 聲調輸入

輸入個陣可以忽略聲調，如果想打埋聲調，對應鍵位係：

1. 陰平 `v`；打 `siv` 出「詩」
2. 陰上 `x`；打 `six` 出「史」
3. 陰去 `q`；打 `siq` 出「試」
4. 陽平 `vv`；打 `sivv` 出「時」
5. 陽上 `xx`；打 `sixx` 出「市」
6. 陽去 `qq`；打 `siqq` 出「事」

### 添加模糊音支援

本方案預設**唔支援**任何模糊音同懶音，即區分 n-/l-, &empty;-/ng- 等常見懶音。如果想支援模糊音，先打開 `jyut6ping3.schema.yaml` 或者 `jyut6ping3_ipa.schema.yaml`（IPA 版），拉到下面 `speller:algebra` 部分，可以見到幾行註釋咗嘅代碼。想要支援某個或者幾個模糊音，就將相應嘅嗰行代碼取消註釋（刪咗前面個 `#` 去），例如要支援 n-/l- 不分，就改成噉：

```yaml
    # 取消下行註釋，支援 n- 併入 l- ，如「你」讀若「理」
    - derive/^n(?!g)/l/
```

然後重新部署，試下打 lei hou，發現都出得到「你好」嘞。

### 用字標準切換

本方案預設採用 OpenCC 用字標準，喺方案選單中顯示為「傳統漢字」。亦都支援**香港傳統漢字**、**臺灣傳統漢字**同**大陆简化汉字**。要切換用字標準，撳 <kbd>Ctrl</kbd> 同 <kbd>`</kbd> 兩粒掣，就會顯示選單，然後就可以揀用字標準嘞。

### 反查

本方案支援普通話拼音、筆劃、倉頡反查，反查掣：

- 朙月拼音：<kbd>`</kbd>
- 五筆畫：<kbd>x</kbd>
- 倉頡五代：<kbd>v</kbd>

### 特殊符號輸入

本方案支援特殊符號輸入，輸入方法係 <kbd>/</kbd> + 符號代碼。

<!-- 
[`symbols.yaml`](https://github.com/rime/rime-prelude/blob/master/symbols.yaml)
[`symbols_cantonese.yaml`](symbols_cantonese.yaml)
-->

## 資料參考

### 字音

- LSHK 字音表 - [資料 (laubonghaudoi/cantonese_orthography)](https://github.com/laubonghaudoi/cantonese_orthography/blob/master/LSHK%20Jyutping%20-%20Char%20-%20JP.csv)
- 粵音小鏡 - [資料 (laubonghaudoi/cantonese_orthography)](https://github.com/laubonghaudoi/cantonese_orthography/blob/master/%E7%B2%B5%E9%9F%B3%E5%B0%8F%E9%8F%A1(20160723).xls)
- 廣州話正音字典 - [資料來源 (jyutnet/cantonese-books-data)](https://github.com/jyutnet/cantonese-books-data/tree/master/2004_%E5%BB%A3%E5%B7%9E%E8%A9%B1%E6%AD%A3%E9%9F%B3%E5%AD%97%E5%85%B8)
- 常用字廣州話讀音表 - [資料來源 (jyutnet/cantonese-books-data)](https://github.com/jyutnet/cantonese-books-data/tree/master/1992_%E5%B8%B8%E7%94%A8%E5%AD%97%E5%BB%A3%E5%B7%9E%E8%A9%B1%E8%AE%80%E9%9F%B3%E8%A1%A8)
- 粵語審音配詞字庫 - [原網站](https://humanum.arts.cuhk.edu.hk/Lexis/lexi-can/) - [資料來源 (sgalal/lexi_can_crawler)](https://github.com/sgalal/lexi_can_crawler)
- 電腦用漢字粵語拼音表 - [資料來源 (lshk-org/jyutping-table)](https://github.com/lshk-org/jyutping-table)
- 香港增補字符集 - [原網站](https://www.ogcio.gov.hk/tc/our_work/business/tech_promotion/ccli/hkscs/)

### 詞語

- 香港語言學學會粵拼詞表 - [原網站](https://corpus.eduhk.hk/JPwordlist/) - [資料來源 (sgalal/lshk-word-list-crawler)](https://github.com/sgalal/lshk-word-list-crawler)
- 粵典 - [原網站](https://words.hk/)
- open Cantonese dictionary - [原網站](http://kaifangcidian.com/han/yue)
- open-source Cantonese-to-English dictionary (CC-Canto) - [原網站](http://www.cccanto.org/)
- Kingsley Bolton, Christopher Hutton《A Dictionary of Cantonese Slang》

</div>
