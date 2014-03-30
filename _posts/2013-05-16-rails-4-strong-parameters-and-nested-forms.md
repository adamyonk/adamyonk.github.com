---
layout: post
title: "Rails 4, Strong Parameters, and Nested Forms"
date: 2013-05-16 13:19:06 -0500
categories: rails
---

I recently started building a Rails 4 app and ran into some hangups when using strong parameters with nested models and forms. It seems to be lacking documentation for this specific scenario, so I wanted to share my findings.

In a scenario where you have an album that `has_many` songs, and you want to be able to edit both with the same form, you need to add every nested attribute that you plan to pass through to the `params.permit()`. This is the setup that ended up working for me:

<script src="https://gist.github.com/adamyonk/5593868.js"></script>

Do you know of a better or easier way? [Let me know!][email]

[email]: mailto:adamyonk@me.com?subject=Rails%204,%20Strong%20Parameters,%20and%20Nested%20Forms