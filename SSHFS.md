```
sudo nano /etc/fstab
root@home-assistant.lan:/homeassistant /mnt/homeassistant fuse.sshfs noauto,x-systemd.automount,_netdev,nofail,reconnect,ServerAliveInterval=15,ServerAliveCountMax=3,allow_other,idmap=user,IdentityFile=/home/raf/.ssh/id_rsa,Ciphers=chacha20-poly1305@openssh.com,Compression=no,cache=yes,kernel_cache,entry_timeout=60,attr_timeout=60,negative_timeout=30 0 0
```

```
sudo umount -l /mnt/homeassistant
sudo systemctl daemon-reload
sudo systemctl start mnt-homeassistant.mount
cd /mnt/homeassistant
```

```
git config --global --add safe.directory /mnt/homeassistant
git rev-parse --is-inside-work-tree
git config core.fsmonitor false
git config core.untrackedCache false
git config core.fsmonitor false
git config core.untrackedCache false
git config gc.auto 0
git -c status.showUntrackedFiles=no status
```
