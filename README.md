# Play with Docker - 非常酷的Docker在线实验室 (上)

![dockercon-cool-hacks](http://bingohuang.nos-eastchina1.126.net/docker-labs2.jpg)

[`DockerCon 2017`](https://2017.dockercon.com/) 刚刚落下帷幕，引燃了Docker社区。除了主场，我还发现一个比较有意思的环节，叫做 [`Cool Hacks`](https://blog.docker.com/2017/04/dockercon-2017-mobys-cool-hack-sessions/)。

在每年的 `DockerCon Cool Hacks` 中，都会推出一些比较酷的特性和产品。今年就推出了这个开源项目: [`Play With Docker`](http://labs.play-with-docker.com/)，我把它叫做
 [`Docker在线实验室`](http://labs.bingohuang.com)。

## 一、简介

`Play With Docker`(`Docker在线实验室`) 是一个运行在浏览器中的Docker Playground，无需安装任何环境，就可以在线体验 Docker。

其实在DockerCon之前我就关注过此项目，今年3月，为了给网易举办的[Docker Meetup](http://www.huodongxing.com/event/9376622259800)，提供一套在线演练和操作环境，配合Docker Labs做实操演练，我基于开源版本做了本地化和镜像优化，并部署在网易云基础服务中，非常实用，收效甚佳。

欢迎上来体验: http://labs.bingohuang.com

## 二、用处
一个Docker在线环境有什么用处呢？

1. 有时你看到一个不错的Docker应用，或是Docker教程，想马上动手一试，苦于当下没有现成的环境
2. 国内的网络，安装Docker和下载Docker镜像都不尽人意，你不想浪费时间
3. 本地虽有Docker环境，但无奈内存或磁盘等资源不够，你不想浪费资源

以上几种场景，[Docker在线实验室](http://labs.bingohuang.com/)都可以为你提供现成的便利。

## 三、介绍

访问[Docker实验室](http://labs.bingohuang.com/)，你会发现共两个页面，一个欢迎页，一个主界面。

![docker-labs-welcome](http://bingohuang.nos-eastchina1.126.net/docker-labs%2Fdocker-labs-welcome.png)

![docker-labs-index](http://bingohuang.nos-eastchina1.126.net/docker-labs%2Fdocker-labs-index.png)

简洁明了，无需赘述功能，欢迎多多试用。

#### 这里介绍几个有意思的特性:

1. 每次开启实验室，相当于一个独立的Session，如果想访问相同的实验室，请记住你的**URL**，特别是后面一串随机字符串，否则你只能重建一遍，或者联系我（me@bingohuang.com)
2. 有实验室就要有工作台，工作台本身就是一个独立的Docker容器，基于Alpine Linux 操作系统，其中再预装Docker环境，背后用到的正是Docker in Docker技术(又叫`DIND`)
3. 每一个工作台有一个交互终端(Terminal)，用于远程操作和实验，简洁实用
4. 终端可以切换全屏(快捷键`Alt+Enter`)，可以调整字体大小(见设置)，方便演示
5. 每个工作台会提供IP信息，以及内存和CPU的使用率，用的是`docker stats`接口
6. 支持 Web 应用在线部署和访问(见下一节中的`Nginx`实例)
7. 工作台之间的IP是联通的，支持集群管理，比如用Swarm管理Docker集群

#### 其它特性还有待你来发现。

当然，云主机毕竟资源有限，对实验室和工作台都会有一些限制:
1. 为防止资源占据太久，每个实验室会有时间限制，默认3个小时，所以在您不用时，最好点击关闭实验室，节约资源^_^
2. 为防止资源占据太多，工作台有个数上限，默认是5个
3. 为了防止自动不断的创建实验室，会有Google人机验证过程(该限制我暂时去掉，提高体验)
4. 特别警告: 该实验室是一个Docker沙盒环境，注意个人信息保密

####同时，也做了一些其他优化:

1. 暂时去掉了Google人机验证，方便没有翻墙的用户，提高用户体验
2. 工作台镜像保持最新Docker社区版本，当前是 `17.05.0-ce`
3. 为快速拉取镜像，添加了多个镜像加速器(包括网易云、阿里云和DaoCloud)
4. 使用Haproxy做了简单负载和路由，所以你在URL中可以看到host1和host2两种地址
5. 部署在网易云基础服务的云主机中

如有发现实验室不可用或任何其他问题，欢迎随时联系我（me@bingohuang.com)。

## 四、使用
以 `Hello world` 和 `Nginx` 为例，初步介绍该实验室的使用。

#### 1、`Hello world`
访问[首页](http://labs.bingohuang.com)， 点击`开启一个新实验室`，点击`+创建工作台`，点击终端界面，记住`Alt+Enter`可切换全屏。

在终端中，运行 `Hello world`:
```
docker run hello-world
```
继而会下载镜像并运行容器，终端输出如下:

![terminal-hello-world](http://bingohuang.nos-eastchina1.126.net/docker-labs%2Fterminal-hello-world.png)

#### 2、`Nginx`

在终端中，运行 `Nginx`:
```
docker  run -d -p 8080:80 nginx
```
同样也会下载镜像并运行容器，`-d`将容器置于后端运行，`-p`设置端口映射。

此时，在控制台的IP地址右边(需`Alt+Enter`切换为非全屏)，将会出现你映射的容器端口。

![terminal-nginx-port](http://bingohuang.nos-eastchina1.126.net/docker-labs%2Fterminal-nginx-port.png)

点击后可以访问你的Web应用。

![terminal-nginx](http://bingohuang.nos-eastchina1.126.net/docker-labs%2Fterminal-nginx.png)

是不是挺酷的，还不赶紧来[**体验**](http://labs.bingohuang.com/)下!

> 下篇文章，我将本着`知其然并知其所以然`的宗旨，介绍Docker实验室的两种安装部署方式，敬请期待，同时已开源在[Github](https://github.com/bingohuang/docker-labs)中，欢迎[**Star**](https://github.com/bingohuang/docker-labs)。

> [Play with Docker - 非常酷的Docker在线实验室 (下)](http://ks.netease.com/blog?id=7587)

## 五、参考链接
- [`Docker Labs`网易云版](http://labs.bingohuang.com/) - 访问无障碍
- [`Docker Labs`开源地址](https://github.com/bingohuang/docker-labs)
- [`Docker Cool hacks`](https://blog.docker.com/2017/04/dockercon-2017-mobys-cool-hack-sessions/)
- [`Play with Docker`官方体验版](http://labs.play-with-docker.com/) - 请自备梯子
- [`Play with Docker`开源地址](https://github.com/play-with-docker/play-with-docker)

---

# Play with Docker - 非常酷的Docker在线实验室 (下)

![play-with-docker](http://bingohuang.nos-eastchina1.126.net/docker-labs%2Fplay-with-docker.jpg)

## 一、简介

[文章上篇](http://ks.netease.com/blog?id=7463)，介绍了Docker在线实验室的特性及使用，发表之后，吸引了不少同学上来[体验试用](http://labs.bingohuang.com)，本着`知其然并知其所以然`的宗旨，不少同学还很想知道这么酷的Docker实验室是怎么独立部署的？那[这篇文章](http://ks.netease.com/blog?id=7587)就给大家介绍如何部署这个Docker在线实验室，分为**本地部署**和**在线部署**两种方式。

## 二、本地部署
**本地部署**对于调试和开发，都非常有必要，这里将从[代码](https://github.com/bingohuang/docker-labs)级别，以 `Mac` OS为例，来介绍如何做本地部署。

####  1、前置条件
在本地部署之前，需准备以下环境：
1. **操作系统**：Mac、Linux、Windows 不限，推荐Mac和Linux，这里以Mac为例
2. **安装 `git`**：用于clone代码仓库，更新项目依赖
3. **安装 `go`**：要求 `1.7.1+`，当前最新`1.8.2`，安装方式多样，可参考[官网安装](https://golang.org/doc/install)，Mac下 brew 安装也非常方便，我还推荐一种跨平台多版本管理的安装方式 `gvm` ，具体可以参考[这篇文章](http://bingohuang.com/go-gvm/)。
4. **安装`Docker`**：要求 `1.13+`，当前最新`17.05.0-ce`，[官方文档](https://docs.docker.com/)非常详细，不再赘述。Mac下推荐使用 [Docker for Mac](https://docs.docker.com/docker-for-mac/)，Windows下推荐使用[Docker for Windows](https://docs.docker.com/docker-for-windows)
5. **安装 `docker-compose`**：当前最新 `1.13.0`，推荐[命令行安装](https://github.com/docker/compose/releases)，如果安装了`Docker for Mac`或 `Docker for windows`，将自带安装 `docker-compose`，无需另行安装

#### 2、本地部署

1) 本地环境需要**开启 swarm 模式**，因为需要用到 swarm 的 overlay 网络：
- `docker swarm init`

2) 主动**加载 IPVS 内核模块**：（实测 Mac 下不需要, Linux下操作没问题）
- `sudo modprobe xt_ipvs`

3) 下载基础**Docker镜像**：（后续执行 `docker-compose up -d`也会自动下载）
- `docker pull hub.c.163.com/library/haproxy:1.7.5`
- `docker pull hub.c.163.com/library/golang:1.8.2`
- `docker pull hub.c.163.com/bingohuang/dind:17.05.0-ce-dind`

4) 配置好 **`GOPATH`** 之后，在相应目录下**clone代码**：
- `mkdir -p $GOPATH/src/github.com/bingohuang && cd $GOPATH/src/github.com/bingohuang`
- `git clone https://github.com/bingohuang/docker-labs.git`
- `cd docker-labs`

5) 使用 `go get` **安装工程依赖**：(从 [Github](https://github.com/bingohuang) 下载依赖代码，有代理速度更佳)
- `go get -v -d -t ./...`

6) **容器编排运行**，在工程目录下执行 `docker-compose` 相关命令，确保`80`端口未被占用，或者修改 `docker-compose.yml` 文件中的 `haproxy` 的端口
- `docker-compose up -d`  - 后台启动容器
- `docker-compose log -f`  - 查看容器日志
- `docker-compose down` - 删除所有容器

7) 日志中无明显错误，可在**浏览器中访问**看看：[http://localhost](http://localhost)
- *注：确保 `hosts` 中绑定了 `localhost` 到 `127.0.0.1` 的映射*
- 首先来到 `欢迎界面`，点击`开启一个新实验室`
- 接着看到 `实验室界面`，点击`+创建工作台`
- 正常会弹出 `工作台界面`，右侧会出现终端及node信息
- 在终端中输入 `docker version` `docker info` ，如能正常查看到 docker 版本和信息，说明部署成功
- （使用详情见[Play with Docker - 非常酷的Docker在线实验室 (上)](http://bingohuang.com/)）

## 三、在线部署
**在线部署**可以让你随时随地的在线访问，并且让更多的人用到你的实验室。如果想搭建一个在线的Docker实验室，只需要使用云主机和Docker即可。这里将借助[网易云基础服务](https://c.163yun.com/)的云主机和Docker，来介绍如何做在线部署。

#### 1、前置条件
和本地部署相比，首先准备一台云主机，再 就是安装Docker即可：

1) 创建**云主机**：一台云主机必不可少，推荐 `Linux` 操作系统，这里以 `Debian 8` 为例，步骤如下：
- 注册并登录[网易云控制台](https://console.163yun.com/)，选择[云计算基础服务](https://c.163yun.com/dashboard)，选择[云主机](https://c.163yun.com/dashboard#/m/win/)
- 点击 `创建云主机`，接下来的界面很好理解，镜像推荐选择 `Debian 8.6`，规格按自己需求而定，记得添加秘钥，方便后续SSH登录，最后点击`立即创建`
- 很快虚拟机就创建成功，默认只有内网IP，我们先不急着绑定外网，可以通过 [VPN](https://c.163yun.com/dashboard#/m/account/security/)+[秘钥](https://c.163yun.com/dashboard#/m/sshkeys/)，登录到该云主机当中
- _注：后续需要对外访问，还是需要绑定外网，在云主机详情页即可绑定操作_
![163yun-vm-create](http://bingohuang.nos-eastchina1.126.net/docker-labs%2F163yun-vm-create.png)

2) 安装 **docker**：需SSH登录到云主机之上，安装 docker可参考[官网](https://docs.docker.com/engine/installation/linux/debian/)安装方式，或参考[这篇文章](https://bingohuang.gitbooks.io/docker_practice/content/install/ubuntu.html)，还有一键安装方式，如下：
- `curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -`

#### 2、在线部署
在线部署在本地部署的基础上做了简化，省去了从代码层面执行的过程，相应的步骤如下：

1) 开启 **swarm** 模式，加载 **IPVS** 内核模块
- `docker swarm init`
- `sudo modprobe xt_ipvs`

2) 下载 **Docker 镜像**：
- `docker pull hub.c.163.com/bingohuang/dind:17.05.0-ce-dind`
- `docker pull hub.c.163.com/bingohuang/docker-labs:1.0`
- 注：为了简单起见，可以用我打好的公开镜像，如需自己打镜像，可以参考[代码仓库](https://github.com/bingohuang/docker-labs)中的[`docker-build.sh`](https://github.com/bingohuang/docker-labs/blob/bingohuang/docker-build.sh)脚本、[`Dockerfile.build`](https://github.com/bingohuang/docker-labs/blob/bingohuang/Dockerfile.build)和[`Dockerfile.dind`](https://github.com/bingohuang/docker-labs/blob/bingohuang/Dockerfile.dind)

3) **万事俱备，只欠东风**，真正部署就相对简单了，只需要执行一个脚本[`docker-run.sh`](https://github.com/bingohuang/docker-labs/blob/bingohuang/docker-run.sh)：
```shell
$ ./docker-run.sh 1.0 17.05.0-ce-dind
```
第一个参数 `1.0` 表示 `docker-labs` 的镜像版本，第二个参数 `17.05.0-ce-dind` 表示 `dind` 的镜像版本

脚本内容如下，具体步骤参考注释：
```shell
#!/bin/bash

# 读取两个镜像版本
labs_version=$1
echo "labs_version=$labs_version"
dind_version=$2
echo "dind_version=$dind_version"

# 拉取或更新两个镜像
docker pull hub.c.163.com/bingohuang/docker-labs:$labs_version
docker pull hub.c.163.com/bingohuang/dind:$dind_version

# 删除之前的容器
docker rm -f docker-labs
# 运行容器，注意注入环境变量
docker run -d \
--publish=80:3000 \
--volume /var/run/docker.sock:/var/run/docker.sock \
-e GOOGLE_RECAPTCHA_DISABLED="true" \
-e DIND_IMAGE="hub.c.163.com/bingohuang/dind:$dind_version"  \
-e EXPIRY="3h" \
--name docker-labs \
hub.c.163.com/bingohuang/docker-labs:$labs_version
# 查看容器时时日志
docker logs -f docker-labs
```

4) **检验是否部署成功**
- 通过 `docker ps -a` 查看容器状态
- 通过 `docker logs -f docker-labs` 查看容器
- 通过 `curl http://localhost` 查看是否联通
- 如果你连接了云主机的VPN，此时也可以在浏览器中通过内网IP访问

5) **绑定公网IP**
- 需要在**云主机详情页**绑定公网IP，比如我这里绑定的公网IP是：`59.111.97.225`
- 浏览器打开 http://59.111.97.225/ 可以看到欢迎页
- 但要想正常`开启一个新实验室`，还需**绑定域名**

6) **本地域名绑定**
- 此种方法简单，只需添加hosts，检验是否部署成功，类似如下：
    - `59.111.97.225 	docker-labs.com`
    - `59.111.97.225 	host1.docker-labs.com`
    - 如果你创建了一个带端口访问的Docker容器（参见[上篇](http://ks.netease.com/blog?id=7463)的Nginx示例），要想访问该端口，还要添加如下类似的绑定：
    - `59.111.97.225 	pwd10_0_3_3-80.host1.docker-labs.com`
- 以上绑定略显繁琐，更方便的方法是在本地架设一台 [**dnsmasq**](http://www.ilanni.com/?p=10624) 服务器，并添加如下配置：
    - `address=/localhost/127.0.0.1`

7) **公网域名解析**
- 如果你有公网域名（比如我的 [bingohuang.com](http://bingohuang.com/)，就可以设置域名解析，将 `labs.bingohuang.com `和 `*.labs.bingohuang.com` 都指向该公网IP即可
- 最后访问你绑定的公网域名，你就拥有了Docker在线实验室了，是不是很酷呢！

## 四、小结
总的来说，Docker在线实验室，提供了一个让你轻快的体验在云上构建和运行Docker容器的环境。每个云上的环境都是一个独立的沙盒（Docker容器），沙盒中再套容器，即 DIND（Docker-in-Docker）技术，沙盒基于 Alpine Linux 操作系统，配备最新  Docker 社区版本，最终，让你随时玩转 Docker。

## 五、参考链接
- [`Docker Labs`网易云版](http://labs.bingohuang.com/) - 访问无障碍
- [`Docker Labs`开源地址](https://github.com/bingohuang/docker-labs)
- [`Docker Cool hacks`](https://blog.docker.com/2017/04/dockercon-2017-mobys-cool-hack-sessions/)
- [`Play with Docker`官方体验版](http://labs.play-with-docker.com/) - 请自备梯子
- [`Play with Docker`开源地址](https://github.com/play-with-docker/play-with-docker)
