---
layout: page
title: About
description: 知识的积累
keywords: hxc
comments: true
menu: 关于
permalink: /about/
---

> 爱上你的命运「Amor fati」

娱乐和辛苦不会被记住，但是知识会！

## Contact Me

{% for website in site.data.social %}
* {{ website.sitename }}：[@{{ website.name }}]({{ website.url }})
{% endfor %}

## Skill Keywords

{% for category in site.data.skills %}
### {{ category.name }}
<div class="btn-inline">
{% for keyword in category.keywords %}
<button class="btn btn-outline" type="button">{{ keyword }}</button>
{% endfor %}
</div>
{% endfor %}
