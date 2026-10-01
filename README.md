Hi,

My name is Ning Yang (杨宁). 

I am a master's student at Yanshan University in China, and I am majoring in Computer Technology. My research chiefly focuses on RTEMS.

This is my English blog.

## 写新文章

```bash
./new-post.sh "Post title" -t "RTEMS, RPi4B"   # 生成 _posts/年-月-日-slug.md
./publish.sh --push                            # 提交并推送，1 分钟后线上生效
```

详细说明（草稿、图片、网页上传方式）见 [PUBLISHING.md](PUBLISHING.md)。

站点首页在 `index.md`，顶部导航在 `_config.yml` 的 `header_pages`，标签汇总页自动生成于 `/tags/`。

本地预览：`./serve.sh`（打开 <http://127.0.0.1:4000/>，包含草稿并自动刷新）。
