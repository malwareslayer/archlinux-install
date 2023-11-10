# archlinux-install
My Boilerplate Setup With Tweak &amp; Config Archlinux Installer

### ext4

```
mkfs.ext4 -O fast_commit,metadata_csum,encrypt /dev/X/Y
```

Note: Don't use fscrypt (encrypt) if you don't need it and change homed.conf `DefaultStorage=storage`

### fstab

```
# tweak user options: rw,relatime,journal_checksum,delalloc,data=ordered

tmpfs						/tmp            tmpfs		rw,relatime,nodev,nosuid,size=16G 0 0

/tmp                        /var/tmp        none		rw,relatime,nodev,nosuid,bind 0 0

hugetlbfs					/dev/hugepages	hugetlbfs	rw,relatime,mode=01770,gid=kvm 0 0
```

### user

```
homectl update <username> \
    --setenv="PATH=$PATH:$HOME/.local/bin" \
    --setenv="XDG_CONFIG_HOME=$HOME/.config" \
    --setenv="XDG_DATA_HOME=$HOME/.local/share" \
    --setenv="XDG_STATE_HOME=$HOME/.local/state" \
    --setenv="XDG_CACHE_HOME=$HOME/.cache" \
    --setenv="XDG_RUNTIME_DIR=/run/user/$(id -u $USER)" \
    --setenv="GOCACHE=$XDG_CACHE_HOME/go/build" \
    --setenv="GOMODCACHE=$XDG_CACHE_HOME/go/pkg/mod" \
    --setenv="GOPATH=$XDG_DATA_HOME/go" \
    --setenv="MOZ_ENABLE_WAYLAND=1" \
    --setenv="GDK_BACKEND=wayland,x11" \
    --setenv="QT_QPA_PLATFORM=wayland-egl;wayland;xcb" \
    --setenv="QT_QPA_PLATFORMTHEME=gtk4" \
    --setenv="QT_AUTO_SCREEN_SCALE_FACTOR=1"
```
