---
layout: post
title: "CSS Map Pins"
date: 2013-05-17 14:57:00 -0500
tags: css
---

I spend a fair amount of time trying to get this shape nailed down in CSS, so I wanted to share and save someone the time. The secret was in setting the second set of radii on the `box-shadow` property. [MDN][mdn] has a helpful visual to help wrap your mind around that lesser-known feature of box-shadow.

{% comment %}
<pre class="codepen" data-height="300" data-type="result" data-href="Edxia" data-user="adamyonk" data-safe="true"><code></code><a href="http://codepen.io/adamyonk/pen/Edxia">Check out this Pen!</a></pre>
<script async src="http://codepen.io/assets/embed/ei.js"></script>
{% endcomment %}

<a class="jsbin-embed" href="http://jsbin.com/bepoco/embed?output">JS Bin on jsbin.com</a><script src="http://static.jsbin.com/js/embed.min.js?3.35.9"></script>

[mdn]: https://developer.mozilla.org/en-US/docs/Web/CSS/border-radius