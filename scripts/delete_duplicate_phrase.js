const fs = require("fs");

const lines = new Set(
  fs
    .readFileSync("jyut6ping3.words.dict.yaml", "utf-8")
    .split("\n")
    .slice(13)
    .map((o) => o.split("\t")[0])
);

fs.writeFileSync(
  "jyut6ping3.phrase.dict.yaml",
  fs
    .readFileSync("jyut6ping3.phrase.dict.yaml", "utf-8")
    .split("\n")
    .filter((o) => !o || !lines.has(o))
    .join("\n")
);
