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

tmpfs				/tmp		tmpfs	rw,nodev,nosuid,size=4G 0 0

tmpfs				/run		tmpfs	rw,nodev,nosuid,size=4G 0 0

/tmp                            /var/tmp        none	rw,nodev,nosuid,bind 0 0

/run				/var/run	none	rw,nodev,nosuid,bind 0 0

tmpfs				/dev/shm	tmpfs	rw,size=4G 0 0
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
    
    --setenv="ANDROID_HOME=$HOME/Android" \
```