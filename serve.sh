#!/usr/bin/env bash
# 本地预览站点：./serve.sh  → 打开 http://<本机IP>:4000
#
#   ./serve.sh                 # 含草稿、改文件自动刷新
#   PORT=5000 ./serve.sh       # 换端口
set -euo pipefail

for d in "$HOME/.local/share/gem/ruby/3.2.0/bin" "$HOME/.gem/ruby/3.2.0/bin"; do
  if [[ -x "$d/jekyll" ]]; then
    PATH="$d:$PATH"
  fi
done

if ! command -v jekyll >/dev/null; then
  echo "没找到 jekyll，请先安装: gem install --user-install jekyll minima -v 2.5.1" >&2
  exit 1
fi

site_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$site_root"

# 输出到自己的目录，避免和别的东西（比如以 root 跑过的构建）抢 _site
dest="$site_root/.site-preview"

host_ip="$(hostname -I 2>/dev/null | awk '{print $1}')"
echo "本地预览: http://127.0.0.1:${PORT:-4000}/   (局域网: http://${host_ip:-本机IP}:${PORT:-4000}/)"

exec jekyll serve --host 0.0.0.0 --port "${PORT:-4000}" --destination "$dest" --drafts --livereload "$@"
