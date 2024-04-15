# Nginx + WebUI + Keepalived + Docker

#### 介绍
根据自己需求在原作者 nginxWebUI:4.0.2 版本基础上增加了 keepalived 模块并打包为 docker 镜像。

在多主机环境中可以提高 nginx 的可用性。

使用时需另外映射目录：

`/etc/keepalived` 存放keepalived的检测脚本及配置文件

docker cli：
```
docker run -itd -v /home/nginxWebUI:/home/nginxWebUI -v /home/keepalived:/etc/keepalived -e BOOT_OPTIONS="--server.port=8080" --net=host ghcr.io/0johny0/nginxwebui:403
```
