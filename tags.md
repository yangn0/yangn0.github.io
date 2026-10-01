---
layout: page
title: Tags
permalink: /tags/
---

{%- assign sorted_tags = site.tags | sort -%}
{%- if sorted_tags.size > 0 -%}
<div class="tag-index">
  {%- for tag in sorted_tags -%}
  {%- assign tag_name = tag[0] -%}
  {%- assign tag_posts = tag[1] -%}
  <div class="tag-group">
    <h2 id="{{ tag_name | slugify }}">{{ tag_name }}</h2>
    <ul>
      {%- for post in tag_posts -%}
      <li>
        <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
        <span class="post-date">{{ post.date | date: "%Y-%m-%d" }}</span>
      </li>
      {%- endfor -%}
    </ul>
  </div>
  {%- endfor -%}
</div>
{%- else -%}
<p>No tags yet.</p>
{%- endif -%}
