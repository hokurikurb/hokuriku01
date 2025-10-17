# 北陸Ruby会議01
- https://regional.rubykaigi.org/hokuriku01/

## 構成
### Icons
- Font Awesome 7
  - https://fontawesome.com/search?ic=free&o=r

## デプロイ
- GitHub Pages
  - main ブランチに push 時に GitHub Actions でデプロイ
  - `/docs` 以下がコンテンツとして公開されます
  - https://hokurikurb.github.io/hokuriku01/
- 地域Ruby会議(`regional.rubykaigi.org`)への反映
  - GitHub Pages に反映後に自動で反映
  - 地域Ruby会議(`ruby-no-kai/rko-router`)で proxy (キャッシュ: 10min)
