+++
layout = "post"
title = "Building a small Web Redirector using Nginx"
date = "2014-02-22"
tags = ["web", "web server", "nginx", "deployment"]
+++

When you own a custom domain like me (`pboehm.org`), there are unlimited
possibilities what you can do with it. One thing is to write a redirector to
use subdomains pointing to your profile-pages on several services like Flickr
or Github. Another purpose could be the redirection of `www.DOMAIN` and
`DOMAIN` to `blog.DOMAIN`, which could be hosted on Github Pages that is
limited to one CNAME per page.

<!--more-->

### DNS settings

To do this kind of redirection, you need access to some host on the internet
(where Nginx is available), which should have a subdomain pointing to it,
through a `CNAME`-, `A`- or `AAAA`-Record. In this post, it is
`redirector.example.org`.

For each subdomain, which should be redirected later, you should create a
`CNAME` entry, pointing to your redirector host (`redirector.example.org`).

### Nginx setup

Nginx should be available as a binary package in most linux distributions and should be installed first. On Ubuntu/Debian you can do it with:

    sudo apt-get install nginx

As the last step, you have to configure Nginx to redirect all your stuff. The
following path to the configuration file is valid for Ubuntu/Debian. Please
look for the right path if the path is not valid on your distribution.

    vim /etc/nginx/sites-enabled/default

```
server {
	root /usr/share/nginx/html;
	listen 80;
	server_name example.org www.example.org;
	rewrite ^ http://blog.example.org$request_uri? permanent;
}

server {
	root /usr/share/nginx/html;
	listen 80;
	server_name github.example.org git.example.org;
	rewrite ^ https://github.com/YOUR_USERNAME permanent;
}

server {
	root /usr/share/nginx/html;
	listen 80;
	server_name flickr.example.org;
	rewrite ^ http://www.flickr.com/photos/YOUR_USERNAME/ permanent;
}
```

With these lines, you will redirect the standard subdomains `example.org` and
`www.example.org` to `blog.example.org`. `git|github.example.org` to your
Github profile and `flickr.example.org` to your Flickr profile.

For each target you want to redirect to, you have to write one `server`-block,
which listens on the specific subdomains.

Now you have to restart Nginx:

    service nginx restart
