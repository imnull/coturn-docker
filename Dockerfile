FROM ubuntu:latest
MAINTAINER marvin <imnull@outlook.com>


RUN mkdir -p /root/workspace/git/coturn

# 更新包列表
RUN apt-get update && apt-get upgrade -y && \
# 安装你需要的软件
apt-get install -y \
git wget vim libmicrohttpd-dev build-essential \
sqlite3 libsqlite3-dev pkgconf libssl-dev libssl-doc \
libevent-dev && \
mkdir -p /root/workspace/git/coturn && \
wget -P /root/workspace/ https://github.com/digitalocean/prometheus-client-c/releases/download/v0.1.3/libprom-dev-0.1.3-Linux.deb && \
wget -P /root/workspace/ https://github.com/digitalocean/prometheus-client-c/releases/download/v0.1.3/libpromhttp-dev-0.1.3-Linux.deb && \
dpkg -i /root/workspace/libprom-dev-0.1.3-Linux.deb && \
dpkg -i /root/workspace/libpromhttp-dev-0.1.3-Linux.deb && \
git clone https://github.com/coturn/coturn.git /root/workspace/git/coturn && \
cd /root/workspace/git/coturn && \
  ./configure --prefix=/etc/coturn && \
  make && \
  make install

RUN cat <<EOF >/etc/init.d/coturn
#!/bin/sh
### BEGIN INIT INFO
# Provides:          coturn
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Coturn TURN Server
# Description:       Coturn TURN Server
### END INIT INFO

DAEMON=/etc/coturn/bin/turnserver
CONFIG_FILE=/etc/turnconfig/turnserver.conf

case "\$1" in
  start)
    echo "Starting Coturn TURN Server"
    \$DAEMON -c \$CONFIG_FILE
    ;;
  stop)
    echo "Stopping Coturn TURN Server"
    pkill -f "\$DAEMON"
    ;;
  restart)
    echo "Restarting Coturn TURN Server"
    \$0 stop
    sleep 1
    \$0 start
    ;;
  *)
    echo "Usage: \$0 {start|stop|restart}"
    exit 1
    ;;
esac

exit 0
EOF

RUN chmod +x /etc/init.d/coturn

# 设置环境变量
# ENV MY_VARIABLE my_value

# 暴露端口
# 暴露 Coturn 默认端口（3478）和 STUN 默认端口（5349）
EXPOSE 3478/tcp
EXPOSE 3478/udp
EXPOSE 5349/tcp
EXPOSE 5349/udp

# 暴露范围为49152-65535的UDP端口
EXPOSE 49152-65535/udp

# 定义启动命令
ENTRYPOINT service coturn start

