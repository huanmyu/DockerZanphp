# DockerZanphp
使用docker来建立zanphp编译环境

## 快速开始
镜像组建编译的时间比较长，所以我把镜像上传到了阿里云和DockerHub上

通过docker pull命令把镜像拉下来之后就可以直接去`运行容器`了

- 阿里云
```sh
docker pull registry.cn-hangzhou.aliyuncs.com/bowen/docker-zanphp
docker tag registry.cn-hangzhou.aliyuncs.com/bowen/docker-zanphp docker-zanphp:0.1
```
- DockerHub
```sh
docker pull bowenchen886/docker-zanphp:0.1
docker tag bowenchen886/docker-zanphp:0.1 docker-zanphp:0.1
```

## 创建镜像
```sh
git clone https://github.com/bowenchen6/DockerZanphp.git
cd DockerZanphp
docker build -t docker-zanphp:0.1 .
```

## 运行容器
```sh
docker run --name zanphp -p 8030:8030 -d docker-zanphp:0.1
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

