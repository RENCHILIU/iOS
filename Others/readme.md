
# Structure

## Domain
renchiliu.com
## Server
Linux CentOS 7
AliCloud
## Docker 
### Nginx
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

### Halo
Blog app. 
- Ports 
```
8090
```


