# Rime 粵語拼音方案

配方：℞ `sgalal/rime-cantonese`

本配方係 [rime/rime-jyutping](https://github.com/rime/rime-jyutping) 嘅帶聲調版同 IPA 顯示版。配方入邊 `jyut6ping3` 係聲調顯示版方案，`jyut6ping3_ipa` 係 IPA 顯示版方案。

#### 拼音方案

- [Jyutping 粵拼 | lshk](https://www.lshk.org/jyutping)
- [香港語言學學會粵語拼音方案](https://zh.wikipedia.org/wiki/香港語言學學會粵語拼音方案)

#### 演示

| 聲調版                     | IPA 版                    |
| -------------------------- | ------------------------- |
| ![示例 1](./demo/tone.gif) | ![示例 2](./demo/ipa.gif) |

## 用法

### 聲調輸入

輸入嗰陣可以忽略聲調，如果想打埋聲調，對應鍵位係：

1. 陰平 `v`；打 `siv` 出「詩」
2. 陰上 `x`；打 `six` 出「史」
3. 陰去 `q`；打 `siq` 出「試」
4. 陽平 `vv`；打 `sivv` 出「時」
5. 陽上 `xx`；打 `sixx` 出「市」
6. 陽去 `qq`；打 `siqq `出「事」

### 添加模糊音支持

本方案默認 **唔兼容** 任何模糊音同懶音，即區分泥來、疑影等常見懶音。如果想支持模糊音，先打開 `jyut6ping3.schema.yaml` 或者 `jyut6ping3.dict.yaml`，拉到下面 `speller:algebra` 部分，可以見到幾行註釋咗嘅代碼。想要支持某個或者幾個懶音，就將相應嘅嗰行代碼取消註釋（刪咗前面個 `#` 去），例如要支持 n-/l- 不分，就改成噉：

```yaml
    # 取消下行註釋，支援 n- 併入 l- ，如「你」讀若「理」
    - derive/^n/l/
```

然後重新佈署，試下打 /lei hou/，發現都出得到「你好」了。

### 字體切換

本方案默認採用 OpenCC 用字標準，喺方案選單中顯示爲「不轉換」。亦都支援香港繁體、臺灣正體同大陸簡體。要切換字體，撳 <kbd>Ctrl</kbd> 同 <kbd>`</kbd> 兩粒掣，就會顯示選單，然後就可以選擇字體了。

#### 注意

OpenCC中默認「涌」同「湧」係異體字關係，但係粵語中湧讀/jung2/，涌讀/cung1/，係兩隻唔同嘅字。所以喺開啓香港字體後無論打/cung1/定係/jung2/都淨係出「湧」，打唔出「涌」，因爲所有嘅「涌」都轉成咗「湧」。要想打出「涌」字，要將字體切換返「不轉換」再打/cung1/先得。

## 數據來源

### 字音

- LSHK 字音表 - [資料 (laubonghaudoi/cantonese_orthography)](https://github.com/laubonghaudoi/cantonese_orthography/blob/master/LSHK%20Jyutping%20-%20Char%20-%20JP.csv)
- 粵音小鏡 - [資料 (laubonghaudoi/cantonese_orthography)](https://github.com/laubonghaudoi/cantonese_orthography/blob/master/%E7%B2%B5%E9%9F%B3%E5%B0%8F%E9%8F%A1(20160723).xls)
- 廣州話正音字典 - [資料來源 (jyutnet/cantonese-books-data)](https://github.com/jyutnet/cantonese-books-data/tree/master/2004_%E5%BB%A3%E5%B7%9E%E8%A9%B1%E6%AD%A3%E9%9F%B3%E5%AD%97%E5%85%B8)
- 常用字廣州話讀音表 - [資料來源 (jyutnet/cantonese-books-data)](https://github.com/jyutnet/cantonese-books-data/tree/master/1992_%E5%B8%B8%E7%94%A8%E5%AD%97%E5%BB%A3%E5%B7%9E%E8%A9%B1%E8%AE%80%E9%9F%B3%E8%A1%A8)
- 粵語審音配詞字庫 - [原網站](https://humanum.arts.cuhk.edu.hk/Lexis/lexi-can/) - [資料來源 (sgalal/lexi_can_crawler)](https://github.com/sgalal/lexi_can_crawler)

### 詞語

- 香港語言學學會粵拼詞表 - [原網站](https://corpus.eduhk.hk/JPwordlist/) - [資料來源 (sgalal/lshk-word-list-crawler)](https://github.com/sgalal/lshk-word-list-crawler)

## 詞庫製作流程

本方案詞庫製作流程詳見本倉庫 [`build`](https://github.com/sgalal/rime-cantonese/tree/build) 分支。
