<div lang="yue-HK">

# Rime 粵語拼音方案

配方：℞ `cantonese`

本配方係 [rime/rime-jyutping](https://github.com/rime/rime-jyutping) 嘅帶聲調版同 IPA 顯示版。配方入邊 `jyut6ping3` 係聲調顯示版方案，`jyut6ping3_ipa` 係 IPA 顯示版方案。

**拼音方案**

- [Jyutping 粵拼 | lshk](https://www.lshk.org/jyutping)
- [香港語言學學會粵語拼音方案](https://zh.wikipedia.org/wiki/香港語言學學會粵語拼音方案)

**演示**

| 粵語拼音                   | 粵語拼音（IPA 版）        |
| -------------------------- | ------------------------- |
| ![示例 1](./demo/tone.gif) | ![示例 2](./demo/ipa.gif) |

## 使用説明

### 聲調輸入

輸入嗰陣可以忽略聲調，如果想打埋聲調，對應鍵位係：

1. 陰平 `v`；打 `siv` 出「詩」
2. 陰上 `x`；打 `six` 出「史」
3. 陰去 `q`；打 `siq` 出「試」
4. 陽平 `vv`；打 `sivv` 出「時」
5. 陽上 `xx`；打 `sixx` 出「市」
6. 陽去 `qq`；打 `siqq `出「事」

### 添加模糊音支援

本方案默認 **唔支援** 任何模糊音同懶音，即區分泥來、疑影等常見懶音。如果想支援模糊音，先打開 `jyut6ping3.schema.yaml` 或者 `jyut6ping3.dict.yaml`，拉到下面 `speller:algebra` 部分，可以見到幾行註釋咗嘅代碼。想要支援某個或者幾個懶音，就將相應嘅嗰行代碼取消註釋（刪咗前面個 `#` 去），例如要支援 n-/l- 不分，就改成噉：

```yaml
    # 取消下行註釋，支援 n- 併入 l- ，如「你」讀若「理」
    - derive/^n/l/
```

然後重新部署，試下打 lei hou，發現都出得到「你好」了。

### 用字標準切換

本方案默認採用 OpenCC 用字標準，喺方案選單中顯示為「不轉換」。亦都支援香港繁體、臺灣正體同大陆简体。要切換用字標準，撳 <kbd>Ctrl</kbd> 同 <kbd>`</kbd> 兩粒掣，就會顯示選單，然後就可以選擇用字標準了。

**注意**：OpenCC 中默認「涌」同「湧」係異體字關係，但係粵語中湧讀 jung2，涌讀 cung1，係兩隻唔同嘅字。所以喺開啟香港字體後無論打 cung1 定係 jung2 都淨係出「湧」，打唔出「涌」，因為所有嘅「涌」都轉成咗「湧」。要想打出「涌」字，要將用字標準切換返「不轉換」再打 cung1 先得。

### 添加 Emoji 支援

Windows 系統下打開【小狼毫】輸入法設定 -> 獲取更多輸入方案，然後運行下面命令：

```bash
emoji
```

Linux 同 macOS 系統下打開終端，`cd` 到 [plum](https://github.com/rime/plum) 路徑下，然後運行下面命令：

```bash
bash rime-install emoji
```

Android 系統下，只需要前往 <https://github.com/rime/rime-emoji/tree/master/opencc> 下載入邊嘅三個文件 `emoji.json`、`emoji_category.txt`、`emoji_word.txt`，複製到 `rime` 文件夾嘅 `opencc` 文件夾入邊。

然後打字嗰陣就可以見到候選詞有 Emoji 了。

## 數據來源

### 字音

- LSHK 字音表 - [資料 (laubonghaudoi/cantonese_orthography)](https://github.com/laubonghaudoi/cantonese_orthography/blob/master/LSHK%20Jyutping%20-%20Char%20-%20JP.csv)
- 粵音小鏡 - [資料 (laubonghaudoi/cantonese_orthography)](https://github.com/laubonghaudoi/cantonese_orthography/blob/master/%E7%B2%B5%E9%9F%B3%E5%B0%8F%E9%8F%A1(20160723).xls)
- 廣州話正音字典 - [資料來源 (jyutnet/cantonese-books-data)](https://github.com/jyutnet/cantonese-books-data/tree/master/2004_%E5%BB%A3%E5%B7%9E%E8%A9%B1%E6%AD%A3%E9%9F%B3%E5%AD%97%E5%85%B8)
- 常用字廣州話讀音表 - [資料來源 (jyutnet/cantonese-books-data)](https://github.com/jyutnet/cantonese-books-data/tree/master/1992_%E5%B8%B8%E7%94%A8%E5%AD%97%E5%BB%A3%E5%B7%9E%E8%A9%B1%E8%AE%80%E9%9F%B3%E8%A1%A8)
- 粵語審音配詞字庫 - [原網站](https://humanum.arts.cuhk.edu.hk/Lexis/lexi-can/) - [資料來源 (sgalal/lexi_can_crawler)](https://github.com/sgalal/lexi_can_crawler)
- 香港增補字符集 - [原網站](https://www.ogcio.gov.hk/tc/our_work/business/tech_promotion/ccli/hkscs/)

### 詞語

- 香港語言學學會粵拼詞表 - [原網站](https://corpus.eduhk.hk/JPwordlist/) - [資料來源 (sgalal/lshk-word-list-crawler)](https://github.com/sgalal/lshk-word-list-crawler)
- 粵典 - [原網站](https://words.hk/)
- open Cantonese dictionary - [原網站](http://kaifangcidian.com/han/yue)
- open-source Cantonese-to-English dictionary (CC-Canto) - [原網站](http://www.cccanto.org/)

## 詞庫製作流程

本方案詞庫製作流程詳見本倉庫 [`build`](https://github.com/sgalal/rime-cantonese/tree/build) 分支。

</div>
