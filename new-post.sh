#!/usr/bin/env bash
# 新建一篇文章（或草稿），自动生成符合规范的文件名和 front matter。
#
#   ./new-post.sh "Add SPI support for RTEMS RPi4B BSP"
#   ./new-post.sh -t "RTEMS, SPI" "Another post"
#   ./new-post.sh -d "还没写完的想法"          # 存到 _drafts/，不会发布
#   ./new-post.sh "中文标题" zhongwen-biaoti   # 第二个参数可指定英文文件名
set -euo pipefail

site_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
draft=0
tags=""
positional=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    -d|--draft) draft=1; shift ;;
    -t|--tags) tags="${2:-}"; shift 2 ;;
    -h|--help) sed -n '2,7p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    -*) echo "未知参数: $1" >&2; exit 1 ;;
    *) positional+=("$1"); shift ;;
  esac
done

title="${positional[0]:-}"
slug="${positional[1]:-}"

if [[ -z "$title" ]]; then
  echo "用法: $(basename "$0") [-d] [-t \"tag1, tag2\"] \"文章标题\" [文件名-slug]" >&2
  exit 1
fi

if [[ -z "$slug" ]]; then
  slug="$(printf '%s' "$title" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//')"
  if [[ -z "$slug" ]]; then
    slug="post-$(date +%H%M%S)"
    echo "提示: 标题里没有英文字符，已用占位文件名，建议再传一个 slug，例如:" >&2
    echo "      ./new-post.sh \"$title\" wo-de-biaoti" >&2
  fi
fi

today="$(date +%Y-%m-%d)"
if [[ "$draft" -eq 1 ]]; then
  dir="$site_root/_drafts"
  file="$dir/$slug.md"
else
  dir="$site_root/_posts"
  file="$dir/$today-$slug.md"
fi

mkdir -p "$dir"
if [[ -e "$file" ]]; then
  echo "文件已存在，换个标题或 slug: $file" >&2
  exit 1
fi

if [[ -n "$tags" ]]; then
  tag_line="tags: [$(printf '%s' "$tags" | tr -d ' ' | sed -E 's/^,+//; s/,+$//')]"
else
  tag_line="tags: []"
fi

title_escaped="${title//\"/\\\"}"

{
  echo '---'
  echo 'layout: single'
  printf 'title: "%s"\n' "$title_escaped"
  if [[ "$draft" -eq 0 ]]; then
    printf 'date: %s %s %s\n' "$today" "$(date +%H:%M:%S)" "$(date +%z)"
  fi
  echo "$tag_line"
  echo '---'
  echo
  echo '在这里写正文。'
  echo
  echo '图片放进 picture/ 目录，然后这样引用：'
  echo
  echo '![图片说明](/picture/example.png)'
  echo
} > "$file"

echo "已创建: ${file#"$site_root"/}"
if [[ "$draft" -eq 1 ]]; then
  echo "写完后执行: ./publish.sh $(basename "$file")"
else
  echo
  echo "接下来:"
  echo "  1. 编辑该文件"
  echo "  2. ./publish.sh --push        # 提交并推送到 GitHub"
fi
