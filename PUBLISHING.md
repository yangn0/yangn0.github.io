# 怎么写一篇新文章

文章都在 `_posts/` 目录，文件名必须是 `年-月-日-英文文件名.md`。
只要往这个目录放一个 `.md` 文件并 push，GitHub Pages 会在 1 分钟内自动重新构建。

## 推荐方式：本地脚本

```bash
./new-post.sh "Add watchdog support to RPi4B" -t "RTEMS, RPi4B"
```

脚本会自动算好日期、生成不带空格的文件名、写好 front matter，然后告诉你文件路径。
用编辑器写完正文后：

```bash
./publish.sh --push
```

一点背景：`--push` 会执行 `git add -A`、`git commit`、`git push`，推送后线上才开始重建。

## 先写草稿

没写完的内容可以先放草稿区，草稿不会出现在网站上：

```bash
./new-post.sh -d "SMP 调度笔记" smp-scheduling-notes
# 之后某天想发布：
./publish.sh smp-scheduling-notes --push
# 或者一次发布全部草稿：
./publish.sh --all --push
```

发布时脚本会把 `_drafts/` 里的文件移到 `_posts/`，并把 `date` 改成当天。

## 不想用命令行：网页上传

在 GitHub 仓库页面点 **Add file → Create new file**，路径直接写：

```
_posts/2026-10-01-my-post.md
```

内容格式：

```markdown
---
layout: post
title: "My post title"
date: 2026-10-01 21:30:00 +0800
tags: [RTEMS, RPi4B]
---

正文从这里开始，用 Markdown 写。
```

要点：文件开头的 `---` 必须保留，`layout: post` 不能少，`title` 建议用双引号包住。

## 图片

图片统一放在 `picture/` 目录（网页上传时把图片拖进这个目录即可），正文里用绝对路径引用：

```markdown
![SPI 结构图](/picture/SPI-RTEMS.png)
```

图片文件名尽量用英文和小写，不要带空格，否则链接里的空格会被转义得很长。

## front matter 字段

| 字段 | 是否必填 | 说明 |
|---|---|---|
| `layout` | 必填 | 固定写 `post` |
| `title` | 必填 | 文章标题，用双引号包住 |
| `date` | 可选 | 不写就用文件名里的日期（按 `_config.yml` 里的 `Asia/Shanghai` 时区） |
| `tags` | 可选 | 形如 `[RTEMS, RPi4B]`，会自动出现在文章顶部和顶部导航的 Tags 页里 |
| `author` | 可选 | 不写就用站点默认作者 |

## 写完怎么确认

线上地址是 <https://yangn0.github.io/>。push 之后看仓库的 **Actions** 或 commit 右侧的状态点，
变绿就说明构建成功；如果是红的，点进去看日志，最常见的原因是 front matter 少了 `---`。

## 发布前先在本地看效果

```bash
./serve.sh                      # 打开 http://<本机IP>:4000
```

会自动带上 `_drafts/` 里的草稿，改文件即时刷新。确认没问题再 `./publish.sh --push`。
想换端口：`PORT=5000 ./serve.sh`。

## 本地环境

这台机器上已经装好（都在用户目录，不需要 root）：

- Ruby 3.2.3（apt 装的）
- Jekyll 4.4.1 + jekyll-feed / jekyll-seo-tag / jekyll-sitemap
- minima 2.5.1（和 GitHub Pages 线上用的版本一致）

换机器时照着重装一遍：

```bash
gem install --user-install jekyll jekyll-feed jekyll-seo-tag jekyll-sitemap
gem install --user-install minima -v 2.5.1
```

`serve.sh` 会自动把 `~/.local/share/gem/ruby/3.2.0/bin` 加进 PATH，所以不用手动配环境。
