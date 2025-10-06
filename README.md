# 北陸Ruby会議01
- https://regional.rubykaigi.org/hokuriku01/

## 構成
### HTML テンプレート
- Twenty by HTML5 UP
  - https://html5up.net/twenty
  - > Based on Twenty by HTML5 UP (but dropped tons of things to simplify)

### Icons
- Font Awesome 5
  - https://fontawesome.com/v5/search?ic=free&o=r
- Google Fonts
  - https://github.com/hokurikurb/hokuriku01/blob/main/assets/css/main.css#L2

## デプロイ
- GitHub Pages
  - main ブランチに push 時に GitHub Actions でデプロイ
  - `/docs` 以下がコンテンツとして公開されます
  - https://hokurikurb.github.io/hokuriku01/
- 地域Ruby会議(`regional.rubykaigi.org`)への反映
  - GitHub Pages に反映後に自動で反映
  - 地域Ruby会議(`ruby-no-kai/rko-router`)で proxy (キャッシュ: 10min)
