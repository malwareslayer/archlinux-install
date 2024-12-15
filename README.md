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

For `<username>`

```
lvcreate -l+100%FREE --name <user name> system
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
    --setenv="XDG_CONFIG_HOME=$HOME/.config" \
    --setenv="XDG_CACHE_HOME=$HOME/.cache" \
    --setenv="XDG_DATA_HOME=$HOME/.local/share" \
    --setenv="XDG_STATE_HOME=$HOME/.local/state" \
    --setenv="XDG_CONFIG_DIRS=/etc/xdg" \
    --setenv="XDG_RUNTIME_DIR=/run/user/$(id -u)" \
    --setenv="XDG_DATA_DIRS=/usr/share:/usr/local/share:$XDG_DATA_HOME:$XDG_DATA_HOME/flatpak/exports/share:/var/lib/flatpak/exports/share" \
    --setenv="GOPATH=$XDG_DATA_HOME/go" \
    --setenv="GOCACHE=$XDG_CACHE_HOME/go/" \
    --setenv="GOMODCACHE=$XDG_DATA_HOME/go/pkg/mod" \
    --setenv="GOBIN=$HOME/.local/bin" \
    --setenv="LIBVA_DRIVER_NAME=radeonsi" \
    --setenv="VDPAU_DRIVER=radeonsi" \
    --setenv="AMD_VULKAN_ICD=RADV" \
    --setenv="VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/amd_pro_icd32.json:/usr/share/vulkan/icd.d/amd_pro_icd64.json:/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json:/usr/share/vulkan/icd.d/lvp_icd.i686.json:/usr/share/vulkan/icd.d/lvp_icd.x86_64.json" \
    --setenv="__GLX_VENDOR_LIBRARY_NAME=mesa" \
    --setenv="__EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json" \
    --setenv="MESA_LOADER_DRIVER_OVERRIDE=radeonsi" \
    --setenv="GALLIUM_DRIVER=zink" \
    --setenv="GDK_BACKEND=wayland" \
    --setenv="QT_QPA_PLATFORM=wayland" \
    --setenv="QT_AUTO_SCREEN_SCALE_FACTOR=1" \
    --setenv="QT_QPA_PLATFORMTHEME=qt5ct" \
    --setenv="SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"
```

## File System Table

```
# Static information about the filesystems.
# See fstab(5) for details.

# <file system> <dir> <type> <options> <dump> <pass>

UUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX       /               ext4            defaults,rw,relatime,journal_checksum,delalloc,data=ordered,discard     0 1

UUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX       /home/<user>    ext4            defaults,rw,relatime,journal_checksum,delalloc,data=ordered,discard     0 1

UUID=XXXX-XXXX          /efi            vfat            defaults,rw,relatime,fmask=0137,dmask=0027,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro  0 2

UUID=XXXX-XXXX          /boot           vfat            defaults,rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro  0 2

none                    /dev/shm        tmpfs           defaults,rw,relatime,size=16G 0 0

tmpfs                   /tmp            tmpfs           defaults,rw,relatime,size=8G 0 0
```