# CoTurn docker镜像创建

按自己的需要生产coturn服务器镜像。

当前脚本基于`aliyun`Ubuntu 20.04环境运行。

## install

在你的机器上安装`docker-ce`。如果已经安装请忽略。

## reset

删除测试镜像和容器

## create

创建容器

## Dockerfile

Docker镜像脚本

## Makefile

构建镜像脚本

## Run

```sh
$ ./reset

coturn
Untagged: coturn:latest
Deleted: sha256:a139170cfc6f8d0327b0176fdb158caca68ef9d9fa43aad8bc7073846c64508a

$ make

docker build -t coturn .
[+] Building 0.7s (9/9) FINISHED                                                                                                                                                                               docker:default
 => [internal] load build definition from Dockerfile                                                                                                                                                                     0.0s
 => => transferring dockerfile: 2.10kB                                                                                                                                                                                   0.0s
 => [internal] load .dockerignore                                                                                                                                                                                        0.0s
 => => transferring context: 2B                                                                                                                                                                                          0.0s
 => [internal] load metadata for docker.io/library/ubuntu:latest                                                                                                                                                         0.5s
 => [1/5] FROM docker.io/library/ubuntu:latest@sha256:e6173d4dc55e76b87c4af8db8821b1feae4146dd47341e4d431118c7dd060a74                                                                                                   0.0s
 => CACHED [2/5] RUN mkdir -p /root/workspace/git/coturn                                                                                                                                                                 0.0s
 => CACHED [3/5] RUN apt-get update && apt-get upgrade -y && apt-get install -y git wget vim libmicrohttpd-dev build-essential sqlite3 libsqlite3-dev pkgconf libssl-dev libssl-doc libevent-dev && mkdir -p /root/work  0.0s
 => CACHED [4/5] RUN cat <<EOF >/etc/init.d/coturn                                                                                                                                                                       0.0s
 => CACHED [5/5] RUN chmod +x /etc/init.d/coturn                                                                                                                                                                         0.0s
 => exporting to image                                                                                                                                                                                                   0.1s
 => => exporting layers                                                                                                                                                                                                  0.0s
 => => writing image sha256:a139170cfc6f8d0327b0176fdb158caca68ef9d9fa43aad8bc7073846c64508a                                                                                                                             0.0s
 => => naming to docker.io/library/coturn     

$ ./create

d9448a8c87c602a88c5fe4e183fa78ceaa339656fb01de79fafcc6f1cb0b8e8b

# docker logs -f coturn

Starting Coturn TURN Server
0: (9): INFO: System cpu num is 2
0: (9): INFO: log file opened: /var/log/turn_9_2024-01-18.log
0: (9): INFO: System enable num is 2
0: (9): INFO: Listener address to use: 0.0.0.0
0: (9): INFO: log file opened: /etc/turnlog/turnserver_2024-01-18.log
0: (9): INFO: Coturn Version Coturn-4.6.2 'Gorst'
0: (9): INFO: Max number of open files/sockets allowed for this process: 1048576
0: (9): INFO: Due to the open files/sockets limitation, max supported number of TURN Sessions possible is: 524000 (approximately)
0: (9): INFO: 

==== Show him the instruments, Practical Frost: ====

0: (9): INFO: OpenSSL compile-time version: OpenSSL 3.0.2 15 Mar 2022 (0x30000020)
0: (9): INFO: TLS 1.3 supported
0: (9): INFO: DTLS 1.2 supported
0: (9): INFO: TURN/STUN ALPN supported
0: (9): INFO: Third-party authorization (oAuth) supported
0: (9): INFO: GCM (AEAD) supported
0: (9): INFO: SQLite supported, default database location is /etc/coturn/var/db/turndb
0: (9): INFO: Redis is not supported
0: (9): INFO: PostgreSQL is not supported
0: (9): INFO: MySQL is not supported
0: (9): INFO: MongoDB is not supported
0: (9): INFO: Default Net Engine version: 3 (UDP thread per CPU core)
0: (9): INFO: Domain name: 
0: (9): INFO: Default realm: mrnull
0: (9): ERROR: CONFIG: Empty cli-password, and so telnet cli interface is disabled! Please set a non empty cli-password!
0: (9): WARNING: cannot find certificate file: turn_server_cert.pem (1)
0: (9): WARNING: cannot start TLS and DTLS listeners because certificate file is not set properly
0: (9): WARNING: cannot find private key file: turn_server_pkey.pem (1)
0: (9): WARNING: cannot start TLS and DTLS listeners because private key file is not set properly
0: (9): INFO: Certificate file found: //turn_server_cert.pem
0: (9): INFO: Private key file found: //turn_server_pkey.pem
0: (9): INFO: Relay address to use: 0.0.0.0
0: (9): INFO: pid file created: /var/run/turnserver.pid
0: (9): INFO: IO method: epoll (with changelist)
0: (9): WARNING: STUN CHANGE_REQUEST not supported: only one IP address is provided
0: (9): INFO: Wait for relay ports initialization...
0: (9): INFO:   relay 0.0.0.0 initialization...
0: (9): INFO:   relay 0.0.0.0 initialization done
0: (9): INFO: Relay ports initialization done
0: (9): INFO: Total General servers: 2
0: (10): DEBUG: turn server id=0 created
0: (10): INFO: IPv4. TCP listener opened on : 0.0.0.0:3478
0: (11): DEBUG: turn server id=1 created
0: (9): INFO: IPv4. UDP listener opened on: 0.0.0.0:3478
0: (11): INFO: IPv4. TCP listener opened on : 0.0.0.0:3478
0: (9): INFO: Total auth threads: 3
0: (9): INFO: prometheus exporter server will start using EPOLL
0: (9): INFO: prometheus collector started successfully

```


