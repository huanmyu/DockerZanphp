# DockerZanphp
使用docker来建立zanphp编译环境

## 创建镜像
```sh
git clone https://github.com/bowenchen6/DockerZanphp.git
cd DockerZanphp
docker build -t docker-zanphp .
```

## 运行容器
```sh
docker run --name zanphp -p 8030:8030 -d docker-zanphp
docker exec -it zanphp bash
cd /zan/zan-installer
./zan  //安装zanphp的httpdemo或者tcpdemo
```

![zanphp httpdemo安装示意图](http://od4lfzi41.bkt.clouddn.com/zan.png)

```sh
cd ../zanphp-http/zanhttp-demo
php bin/httpd
```
## 访问httpdemo
打开浏览器,访问[127.0.0.1:8030](http://127.0.0.1:8030)
