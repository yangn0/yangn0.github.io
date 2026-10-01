#!/usr/bin/env bash
# 发布草稿（日期改成今天）并把改动推送到 GitHub。
#
#   ./publish.sh my-note           # 发布 _drafts/my-note.md
#   ./publish.sh --all             # 发布 _drafts/ 下所有草稿
#   ./publish.sh --push            # 只做 git add/commit/push（写完文章常用）
#   ./publish.sh my-note --push    # 发布草稿 + 推送
set -euo pipefail

site_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
drafts_dir="$site_root/_drafts"
posts_dir="$site_root/_posts"
do_push=0
all=0
name=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --all) all=1; shift ;;
    --push) do_push=1; shift ;;
    -h|--help) sed -n '2,6p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    -*) echo "未知参数: $1" >&2; exit 1 ;;
    *) name="$1"; shift ;;
  esac
done

today="$(date +%Y-%m-%d)"
stamp="$(date '+%Y-%m-%d %H:%M:%S %z')"
published=()

publish_one() {
  local draft="$1" base target
  base="$(basename "$draft" .md)"
  base="${base#????-??-??-}"          # 去掉可能残留的日期前缀
  target="$posts_dir/$today-$base.md"

  if [[ -e "$target" ]]; then
    echo "跳过，今天已有同名文章: $target" >&2
    return 0
  fi

  mkdir -p "$posts_dir"
  awk -v d="$stamp" '
    { lines[NR] = $0 }
    END {
      start = 0; stop = 0
      for (i = 1; i <= NR; i++) {
        if (lines[i] ~ /^---[[:space:]]*$/) {
          if (start == 0) { start = i } else { stop = i; break }
        }
      }
      if (start == 0 || stop == 0) {
        for (i = 1; i <= NR; i++) print lines[i]
        exit
      }
      d_idx = 0; t_idx = 0; l_idx = 0
      for (i = start + 1; i < stop; i++) {
        if (d_idx == 0 && lines[i] ~ /^date:/) d_idx = i
        if (t_idx == 0 && lines[i] ~ /^title:/) t_idx = i
        if (l_idx == 0 && lines[i] ~ /^layout:/) l_idx = i
      }
      if (d_idx > 0)        { lines[d_idx] = "date: " d }
      else if (t_idx > 0)   { lines[t_idx] = lines[t_idx] "\ndate: " d }
      else if (l_idx > 0)   { lines[l_idx] = lines[l_idx] "\ndate: " d }
      else                  { lines[start] = lines[start] "\ndate: " d }
      for (i = 1; i <= NR; i++) print lines[i]
    }
  ' "$draft" > "$target"

  rm -f -- "$draft"
  published+=("$target")
  echo "已发布: ${target#"$site_root"/}"
}

if [[ "$all" -eq 1 ]]; then
  shopt -s nullglob
  for f in "$drafts_dir"/*.md; do
    publish_one "$f"
  done
  shopt -u nullglob
elif [[ -n "$name" ]]; then
  f="$name"
  [[ "$f" = *.md ]] || f="$f.md"
  [[ "$f" = /* ]] || f="$drafts_dir/$(basename "$f")"
  if [[ ! -f "$f" ]]; then
    echo "找不到草稿: $f" >&2
    exit 1
  fi
  publish_one "$f"
elif [[ "$do_push" -eq 0 ]]; then
  echo "用法: $(basename "$0") <草稿名> [--push] | --all [--push] | --push" >&2
  exit 1
else
  echo "没有指定草稿，只提交并推送当前改动。"
fi

if [[ ${#published[@]} -eq 0 && "$do_push" -eq 0 ]]; then
  echo "没有需要发布的草稿。"
  exit 0
fi

if [[ "$do_push" -eq 1 ]]; then
  cd "$site_root"
  git add -A
  if [[ ${#published[@]} -gt 0 ]]; then
    msg="Publish post: $(date +%Y-%m-%d)"
  else
    msg="Update site: $(date +%Y-%m-%d)"
  fi
  if git diff --cached --quiet; then
    echo "没有需要提交的改动，直接推送已有提交。"
  else
    git commit -m "$msg"
  fi
  git push
  echo "已推送到 GitHub，约 1 分钟后见 https://yangn0.github.io/"
else
  echo
  echo "推送到线上:"
  echo "  git add -A && git commit -m \"Publish post\" && git push"
fi
