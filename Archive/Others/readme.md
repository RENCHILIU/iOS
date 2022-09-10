
# Structure

![image](https://raw.githubusercontent.com/RENCHILIU/iOS/master/Others/blog%20structure.png)

## Domain
renchiliu.com
## Server
Linux CentOS 7
AliCloud
## Docker 
### [Nginx](https://hub.docker.com/r/staticfloat/nginx-certbot/)
- Ports 
```
80:80/tcp
443:443/tcp
```

- Configuration 
```
server {
    listen              443 ssl;
    server_name         renchiliu.com;
    ssl_certificate     /etc/letsencrypt/live/renchiliu.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/renchiliu.com/privkey.pem;

    location / {
          proxy_pass http://47.251.37.210:8090/;
    }
}
```

### [Halo](https://hub.docker.com/r/halohub/halo)
Blog app. 
- Ports 
```
8090
```


