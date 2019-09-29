# Rime 粵語拼音方案

配方：℞ `sgalal/rime-cantonese`

本配方爲 [rime/rime-jyutping](https://github.com/rime/rime-jyutping) 的帶聲調及 IPA 顯示版。配方內 `jyut6ping3` 爲聲調顯示版方案，`jyut6ping3_ipa` 爲 IPA 顯示版方案。

**配方目前尚處開發階段，歡迎 PR 或於 Issue 區反饋意見**

## 拼音方案

- [Jyutping 粵拼 | lshk](https://www.lshk.org/jyutping)
- [香港語言學學會粵語拼音方案](https://zh.wikipedia.org/wiki/香港語言學學會粵語拼音方案)

## 使用方法

| 聲調版                    | IPA版                    |
| ------------------------- | ------------------------ |
| ![示例1](./demo/tone.gif) | ![示例2](./demo/ipa.gif) |

輸入時候可以忽略聲調，若要輸入聲調，則對應鍵位爲：

1. 陰平 `v`；如要輸入「詩」則鍵入`siv`
2. 陰上 `x`；如要輸入「史」則鍵入`six`
3. 陰去 `q`；如要輸入「試」則鍵入`siq`
4. 陽平 `vv`；如要輸入「時」則鍵入`sivv`
5. 陽上 `xx`；如要輸入「市」則鍵入`sixx`
6. 陽去 `qq`；如要輸入「事」則鍵入`siqq`

## 數據來源

### 字音

- LSHK 字音表 - [資料 (laubonghaudoi/cantonese_orthography)](https://github.com/laubonghaudoi/cantonese_orthography/blob/master/LSHK%20Jyutping%20-%20Char%20-%20JP.csv)
- 粵音小鏡 - [資料 (laubonghaudoi/cantonese_orthography)](https://github.com/laubonghaudoi/cantonese_orthography/blob/master/%E7%B2%B5%E9%9F%B3%E5%B0%8F%E9%8F%A1(20160723).xls)
- 廣州話正音字典 - [資料來源 (jyutnet/cantonese-books-data)](https://github.com/jyutnet/cantonese-books-data/tree/master/2004_%E5%BB%A3%E5%B7%9E%E8%A9%B1%E6%AD%A3%E9%9F%B3%E5%AD%97%E5%85%B8)
- 常用字廣州話讀音表 - [資料來源 (jyutnet/cantonese-books-data)](https://github.com/jyutnet/cantonese-books-data/tree/master/1992_%E5%B8%B8%E7%94%A8%E5%AD%97%E5%BB%A3%E5%B7%9E%E8%A9%B1%E8%AE%80%E9%9F%B3%E8%A1%A8)
- 粵語審音配詞字庫 - [原網站](https://humanum.arts.cuhk.edu.hk/Lexis/lexi-can/) - [資料來源 (sgalal/lexi_can_crawler)](https://github.com/sgalal/lexi_can_crawler)

### 詞語

- [香港語言學學會粵拼詞表](https://corpus.eduhk.hk/JPwordlist/) - [資料來源 (sgalal/lshk-word-list-crawler)](https://github.com/sgalal/lshk-word-list-crawler)

## 詞庫製作流程

**字音收錄原則**

<pre>
對於 Unihan 資料中的某個字
    若不是繁體字 -> 捨棄
    若是繁體字
        若只有一音 -> 收錄
        若有多個音
            若五份資料中任意一份有此字
                若其中某一個或多個發音見於五份資料中任意一份 -> 收錄這幾個發音
                若每個音都不見於五份資料中任意一份 -> Unihan 和五份資料中的發音均收錄
            若五份資料中每份均無此字 -> 全部收錄
</pre>

**繁體字判斷標準**

<pre>
若是 Unicode 基本區漢字
    若能使用 Big5 (cp950) 編碼 -> 是繁體字
    否則 -> 不是繁體字
否則
    若是 Unicode 其他漢字區（除兼容區外）漢字 -> 是繁體字
    否則 -> 不是繁體字
</pre>

該判斷標準尚不完善，例如「𬶕」字位於拓展區，判斷為繁體字，但實際上為簡體字。

**詞語收錄原則**

香港語言學學會粵拼詞表中包括單字和詞語。將詞表中的單字捨棄，詞語併入碼表。

詞表中的詞語遵循香港用字標準。在收錄時，使用 [opencc-python](https://github.com/sgalal/opencc-python) 將詞語轉換爲 OpenCC 標準。

本方案詞庫製作流程詳見 [Wiki](https://github.com/sgalal/rime-cantonese/wiki/%E6%9C%AC%E6%96%B9%E6%A1%88%E7%A2%BC%E8%A1%A8%E8%A3%BD%E4%BD%9C%E6%B5%81%E7%A8%8B)。
