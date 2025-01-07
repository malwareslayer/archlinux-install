# Setup

## Logical Volume Management

### Physical Volume

```
pvcreate --dataalignment 1m --metadatasize 2m /dev/nvmeXnYpZ
```

### Volume Group

```
vgcreate --physicalextentsize 16m system /dev/nvmeXnYpZ
```

```
vgcreate --physicalextentsize 16m home /dev/nvmeXnYpZ
```

### Logical Volume

For `root`

```
lvcreate -l+100%FREE --name root system
```

## File System

```
mkfs.fat -F 32 /dev/nvmeXnYpZ
```

**Note**: some `/boot` should be for bootable extended

### File System Root & User

For `root`

```
mkfs.ext4 -O 64bit,bigalloc,dir_index,dir_nlink,ea_inode,ext_attr,extent,encrypt,extra_isize,fast_commit,filetype,flex_bg,has_journal,huge_file,inline_data,large_dir,large_file,metadata_csum,metadata_csum_seed,orphan_file,orphan_present,resize_inode,sparse_super,sparse_super2,stable_inodes,verity /dev/X/Y
```

For `<username>`

```
homectl create <username> \
    --real-name="" \
    --email-addres="" \
    --location="Asia/Jakarta" \
    --timezone="Asia/Jakarta" \
    --shell="/usr/bin/fish" \
    --drop-caches=true \
    --fs-type=ext4 \
    --storage=luks \
    --luks-discard=true \
    --luks-offline-discard=true \
    --luks-pbkdf-type=argon2id \
    --luks-pbkdf-hash-algorithm=sha256 \
    --home-dir="/home/<user name>" \
    --image-path=/dev/nvmeXnY
```

After Installation

```
homectl update <username> --capability-ambient-set=CAP_BPF CAP_PERFMON CAP_NET_BIND_SERVICE CAP_SYS_NICE CAP_SYS_TIME
```

```
homectl update <username> \
    --setenv="GDK_BACKEND=wayland" \
    --setenv="GOBIN=$HOME/.local/bin" \
    --setenv="GOCACHE=$XDG_CACHE_HOME/go/" \
    --setenv="GOMODCACHE=$XDG_DATA_HOME/go/pkg/mod" \
    --setenv="GOPATH=$XDG_DATA_HOME/go" \
    --setenv="QT_AUTO_SCREEN_SCALE_FACTOR=1" \
    --setenv="QT_QPA_PLATFORM=wayland" \
    --setenv="QT_QPA_PLATFORMTHEME=qt5ct" \
    --setenv="SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"
    --setenv="XDG_CACHE_HOME=$HOME/.cache" \
    --setenv="XDG_CONFIG_DIRS=/etc/xdg" \
    --setenv="XDG_CONFIG_HOME=$HOME/.config" \
    --setenv="XDG_DATA_DIRS=/usr/share:/usr/local/share:$XDG_DATA_HOME:$XDG_DATA_HOME/flatpak/exports/share:/var/lib/flatpak/exports/share" \
    --setenv="XDG_DATA_HOME=$HOME/.local/share" \
    --setenv="XDG_RUNTIME_DIR=/run/user/$(id -u)" \
    --setenv="XDG_STATE_HOME=$HOME/.local/state" \
    --setenv="__EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json" \
    --setenv="__GLX_VENDOR_LIBRARY_NAME=mesa" \
```

## File System Table

```
# Static information about the filesystems.
# See fstab(5) for details.

# <file system> <dir> <type> <options> <dump> <pass>

UUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX       /               ext4            rw,relatime,journal_checksum,delalloc,data=ordered,discard     0 1

UUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX       /home/<user>    ext4            rw,relatime,journal_checksum,delalloc,data=ordered,discard     0 1

UUID=XXXX-XXXX          /efi            vfat            rw,relatime,fmask=0137,dmask=0027,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro  0 2

UUID=XXXX-XXXX          /boot           vfat            rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro  0 2

tmpfs                   /dev/shm        tmpfs           rw,relatime,size=16G 0 0

tmpfs                   /tmp            tmpfs           rw,relatime,size=8G 0 0
```
