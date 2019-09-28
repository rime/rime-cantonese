# Rime 粵語拼音方案

配方： ℞ `sgalal/rime-cantonese`

本配方爲[rime-jyutping](https://github.com/rime/rime-jyutping)的帶聲調及IPA顯示版。配方內`jyut6ping3`爲聲調顯示版方案，`jyut6ping3_ipa`爲IPA顯示版方案。

**配方目前尚處開發階段，歡迎PR或於Issue區反饋意見**

### 拼音方案

- [Jyutping 粵拼| lshk](https://www.lshk.org/jyutping)
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

### 字音收錄原則

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

繁體字判斷標準（尚不完善）

<pre>
若是 Unicode 基本區漢字
    若能使用 Big5 (cp950) 編碼 -> 是繁體字
    否則 -> 不是繁體字
否則
    若是 Unicode 其他漢字區（除兼容區外）漢字 -> 是繁體字
    否則 -> 不是繁體字
</pre>


該詞表中包括單字和詞語。將詞表中的單字捨棄，並將詞語併入碼表。

### Single Characters

Export Cantonese pronunciation data in kCantonese to `build/single_char/data/0-Unihan.json`.

Download and process the five data files mentioned above to `/build/single_char/data/0-*`.

Sanitize the five data files and save to `/build/single_char/data/1-*`.

Generate the result according to the principles, then save to variable `d_single_char`.

### Words

Download LSHK Word List to `/build/word/data/香港語言學學會粵拼詞表.txt`.

Read the file, discard single characters in the file and save the remained data to variable `d_word`.

Write `d_single_char` and `d_word` to file.

### Build Scripts

```sh
$ pip install unihan-etl pandas sortedcontainers
$ unihan-etl -f kCantonese -F json --destination build/single_char/data/0-Unihan.json
$ build/build.py
```