+++
layout = "post"
title = "Authentication for WebSockets"
date = "2014-07-19"
tags = ["web", "web server", "webshell", "nginx", "websocket", "lua", "deployment"]


+++

I'm using [websocketd](https://github.com/joewalnes/websocketd) for a little
side project, called [webshell](https://github.com/pboehm/webshell), which is a
little shell in your browser that runs predefined commands. It is obvious that
this shouldn't be accessible by everyone! So there is a need for
authentication. For most of my projects I use HTTP Basic Auth, which [is not
supported](https://code.google.com/p/chromium/issues/detail?id=123862) by
Chrome when using WebSockets. The solution is a cookie based authentication
built using Lua directly in nginx (used as a reverse proxy).

## Cookie-based authentication for WS

The Nginx-Lua-integration is available as a separate module, which is available
through the `nginx-extras` package in general. The configuration below should
be placed in a suitable config file (e.g. `/etc/nginx/sites-enabled/default`).

```nginx
init_by_lua 'ACCESS_TOKEN_VALUE = ngx.md5("" .. math.random(10000, 90000))';
```

This generates the value for the auth cookie. Please generate a better token
value in a multi-user environment, as with this, every cookie has the same
value. For a single user environment this should be no problem. This code runs
once on nginx startup.


```nginx
server {
    return 404;
}

server {
        listen   80;
        server_name shell.example.org;

        location /auth {
                auth_basic           "closed site";
                auth_basic_user_file /etc/nginx/htpasswd;
                access_by_lua '
                    local expires = 3600 * 24 * 30 -- 30 days
                    ngx.header["Set-Cookie"] = "ACCESS_TOKEN=" ..
                                                ACCESS_TOKEN_VALUE ..
                                               "; Path=/; Expires=" ..
                                               ngx.cookie_time(ngx.time() + expires)
                    return ngx.redirect("/");                ';
        }
```

First you have to update the value of `server_name`. Then you have to generate
a htpasswd using the `htpasswd` command which is part of the apache-utils
package.

```nginx
        location / {
                access_by_lua '
                    local cookie_value = ngx.var.cookie_ACCESS_TOKEN
                    if cookie_value == ACCESS_TOKEN_VALUE then
                        return
                    end

                    ngx.exec("/auth/")
                ';

                proxy_pass          http://127.0.0.1:8888;

                proxy_http_version  1.1;
                proxy_set_header    Upgrade $http_upgrade;
                proxy_set_header    Connection "upgrade";
                proxy_set_header    Host            $host;
                proxy_set_header    X-Real-IP       $remote_addr;
                proxy_set_header    X-Forwarded-for $remote_addr;
                proxy_buffering     off;
                proxy_read_timeout  386400;
        }
}
```

This snippet includes the standard settings for reverse proxying (`proxy_*`)
and another Lua construct, which checks the auth cookie and renders the `/auth`
location in case of a mismatch. Please update the `proxy_pass` value so that it
matches your application needs.
