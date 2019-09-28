# rime-cantonese

Rime Cantonese input schema (The Linguistic Society of Hong Kong Cantonese Romanisation Scheme)

Rime 粵語拼音輸入方案（香港語言學學會粵語拼音方案）

## 收錄原則

### 單字

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

五份資料如下

* LSHK 字音表 - [資料 (laubonghaudoi/cantonese_orthography)](https://github.com/laubonghaudoi/cantonese_orthography/blob/master/LSHK%20Jyutping%20-%20Char%20-%20JP.csv)
* 粵音小鏡 - [資料 (laubonghaudoi/cantonese_orthography)](https://github.com/laubonghaudoi/cantonese_orthography/blob/master/%E7%B2%B5%E9%9F%B3%E5%B0%8F%E9%8F%A1(20160723).xls)
* 廣州話正音字典 - [資料來源 (jyutnet/cantonese-books-data)](https://github.com/jyutnet/cantonese-books-data/tree/master/2004_%E5%BB%A3%E5%B7%9E%E8%A9%B1%E6%AD%A3%E9%9F%B3%E5%AD%97%E5%85%B8)
* 常用字廣州話讀音表 - [資料來源 (jyutnet/cantonese-books-data)](https://github.com/jyutnet/cantonese-books-data/tree/master/1992_%E5%B8%B8%E7%94%A8%E5%AD%97%E5%BB%A3%E5%B7%9E%E8%A9%B1%E8%AE%80%E9%9F%B3%E8%A1%A8)
* 粵語審音配詞字庫 - [原網站](https://humanum.arts.cuhk.edu.hk/Lexis/lexi-can/) - [資料來源 (sgalal/lexi_can_crawler)](https://github.com/sgalal/lexi_can_crawler)

### 詞語

資料：香港語言學學會粵拼詞表 - [原網站](https://corpus.eduhk.hk/JPwordlist/) - [資料來源 (sgalal/lshk-word-list-crawler)](https://github.com/sgalal/lshk-word-list-crawler)

該詞表中包括單字和詞語。將單字與上述步驟中的單字合併，並將詞語加入碼表。

## 詞庫製作流程

### Single Characters

Export Cantonese pronunciation data in kCantonese to `build/single_char/data/0-Unihan.json`.

```sh
$ pip install --user unihan-etl
$ unihan-etl -f kCantonese -F json --destination build/single_char/data/0-Unihan.json
```

Download and process the five data files mentioned above to `/build/single_char/data/0-*`.

Sanitize the data files and save to `/build/single_char/data/1-*`.

Generate the result according to the principles.

### Words

Download the data file to `/build/word/data/香港語言學學會粵拼詞表.txt`.

Read the file and merge the data with single characters.

Write the result to file.

```sh
$ build/build.py
```

## Features

(1) Input words by Cantonese romanization (Jyutping)

![demo0](demo/0.png)

(2) Reverse lookup Cantonese by romanization of Standard Chinese (Hanyu Pinyin)

![demo1](demo/1.png)

(3) Other features like acronym and Simplified Chinese

![demo2](demo/2.png)

## License

Code for building the data is distributed under MIT license.

Dictionary data follows the original license.
