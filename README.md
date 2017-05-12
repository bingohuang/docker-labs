![dockercon-cool-hacks](http://bingohuang.nos-eastchina1.126.net/docker-labs2.jpg)

DockerCon 2017 刚刚落下帷幕，引燃了Docker社区。除了主场，我还发现一个比较有意思的环节，叫做 [`Cool Hacks`](https://blog.docker.com/2017/04/dockercon-2017-mobys-cool-hack-sessions/)。

在每年的 `DockerCon Cool Hacks` 中，都会推出一些比较酷的特性和产品。今年就推出了这个开源项目: [`Play With Docker`](http://labs.play-with-docker.com/)，我把它叫做`Docker在线实验室`。

![play-with-docker](http://bingohuang.nos-eastchina1.126.net/docker-labs%2Fplay-with-docker.jpg)

## 一、简介

`Play With Docker` 是一个运行在浏览器中的Docker Playground，无需安装任何环境，就可以在线体验 Docker。

其实在DockerCon之前我就关注过此项目，今年3月，为了给网易举办的[Docker Meetup](http://www.huodongxing.com/event/9376622259800)，提供一套在线演练和操作环境，配合Docker Labs做实操演练，基于开源版本做了本地化和镜像优化，并部署在网易云基础服务中，非常实用，收效甚佳。

在线体验: http://labs.bingohuang.com

## 二、用处
一个Docker在线环境有什么用处呢？

1. 有时你看到一个不错的Docker应用，或是Docker教程，想马上动手一试，万一没有现成的环境
2. 国内的网络，安装Docker和下载Docker镜像都不尽人意，你不想浪费时间
3. 本地虽有Docker环境，但无奈内存或磁盘等资源不够，你不想浪费资源

以上几种场景，[Docker在线实验室](http://labs.bingohuang.com/)都可以为你提供现成的便利。

## 三、介绍

访问[Docker实验室](http://labs.bingohuang.com/)，你会发现共两个页面，一个欢迎页，一个主界面。
![docker-labs-welcome](http://bingohuang.nos-eastchina1.126.net/docker-labs%2Fdocker-labs-welcome.png)
![docker-labs-index](http://bingohuang.nos-eastchina1.126.net/docker-labs%2Fdocker-labs-index.png)
相对简洁明了，无需赘述功能，欢迎多多试用。

这里介绍几个有意思的特性:

1. 每次开启实验室，相当于一个独立的Session，如果想访问相同的实验室，请记住你的URL，特别是后面一串随机字符串，否则你只能找我或者后台管理员了
2. 有实验室就要有工作台，工作台本身就是一个独立的Docker容器，基于Alpine Linux 操作系统，其中再预装Docker环境，背后用到的正是Docker in Docker技术(又叫`DIND`)
3. 每一个工作台有一个交互终端(Terminal)，用于远程操作和实验，简洁实用
4. 终端可以切换全屏(快捷键`Alt+Enter`)，可以调整字体大小(见设置)，方便演示
5. 每个工作台会提供IP信息，以及内存和CPU的使用率，用的是`docker stats`接口
6. 支持 Web 应用在线部署和访问(见下一节中的`Nginx`实例)
7. 工作台之间的IP是联通的，支持集群管理，比如用Swarm管理Docker集群

其它特性还有待你来发现。

当然，云主机毕竟资源有限，对实验室和工作台都会有一些限制:
1. 为防止资源占据太久，每个实验室会有时间限制，默认3个小时
2. 为防止资源占据太多，工作台有个数上限，默认是5个
3. 为了防止自动不断的创建实验室，会有Google人机验证过程(该限制我暂时去掉，提高体验)
4. 特别警告: 该实验室是一个Docker沙盒环境，注意个人信息保密


同时，也做了一些优化:
1. 暂时去掉了Google人机验证，方便没有翻墙的用户，提高用户体验
2. 工作台镜像保持最新Docker社区版本，当前是 `17.05.0-ce`-TODO
3. 为快速拉取镜像，添加了多个镜像加速器(包括网易云、阿里云和DaoCloud)
4. 使用Haproxy做了简单负载和路由，所以你在URL中可以看到host1和host2两种地址
5. 部署在网易云基础服务的云主机中

如有发现实验室不可用，欢迎随时联系我。

## 四、使用
以 `Hello world` 和 `Nginx` 为例，初步介绍该实验室的使用。

访问[首页](http://labs.bingohuang.com)， 点击`开启一个新实验室`，点击`+创建工作台`，点击终端界面，记住`Alt+Enter`可切换全屏。

在终端中，运行 `Hello world`:
```
docker run hello-world
```
继而会下载镜像并运行容器，终端输出如下:

![terminal-hello-world](http://bingohuang.nos-eastchina1.126.net/docker-labs%2Fterminal-hello-world.png)

在终端中，运行 `Nginx`:
```
docker  run -d -p 8080:80 nginx
```
同样也会下载镜像并运行容器，`-d`将容器置于后端运行，`-p`设置端口映射。

此时，在控制台的IP地址右边(需`Alt+Enter`切换为非全屏)，将会出现你映射的容器端口，点击后可以访问你的Web应用。

![terminal-nginx](http://bingohuang.nos-eastchina1.126.net/docker-labs%2Fterminal-nginx.png)

是不是挺酷的，还不赶紧来[体验](http://labs.bingohuang.com/)下!

> 下篇文章，我将介绍一些更极客的内容，包括该Docker实验室的安装部署以及Swarm集群的搭建，敬请期待，同时已开源在Github中，欢迎Star。

## 五、参考链接
- [`Docker Cool hacks`](https://blog.docker.com/2017/04/dockercon-2017-mobys-cool-hack-sessions/)
- [`Play with Docker`官方体验版](http://labs.play-with-docker.com/) - 请自备梯子
- [`Play with Docker`开源地址](https://github.com/play-with-docker/play-with-docker)
- [`Docker Labs`网易云版](http://labs.bingohuang.com/) - 访问无障碍
- [`Docker Labs`开源地址](https://github.com/bingohuang/docker-labs)
