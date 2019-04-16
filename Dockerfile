FROM katta/openwrt-rootfs
MAINTAINER daiwenzh5 <daiwenzh5@163.com>
RUN mkdir -p /var/lock \
  && mkdir -p /var/run \
  && opkg update \
  && opkg install \
    luci \
    luci-ssl \
    luci-theme-openwrt \
  && rm /var/opkg-lists/* \
  && /etc/init.d/dropbear enable \
  && mkdir -p /usr/local/kms

# 添加vlmcsd-x64-musl-static文件到/usr/local/kms目录
ADD vlmcsd-x64-musl-static /usr/local/kms
# 添加运行脚本
ADD run.sh /bin/run.sh
EXPOSE 80 443 22 1688

# CMD ["/sbin/init"]
# CMD ["/usr/local/kms/vlmcsd-x64-musl-static"]
CMD ["sh", "/bin/run.sh"] # 同CMD sh /bin/run.sh
