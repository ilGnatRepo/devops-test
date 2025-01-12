#!/bin/sh
# 启动 rpcbind 服务
service rpcbind start
# 启动 NFS 服务
service nfs-kernel-server start
# 启动 rpc.mountd 并指定端口
/usr/sbin/rpc.mountd -p 20048
# 导出文件系统
exportfs -rv
# 保持容器运行
exec tail -f /dev/null