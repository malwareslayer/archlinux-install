# Setup

## Logical Volume Management

### Physical Volume

```
pvcreate --dataalignment 2m --metadatasize 2m /dev/nvmeXnYpZ
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

For `<user name>`

```
lvcreate -l+100%FREE --name <user name> system
```

## File System

```
mkfs.fat -F /dev/nvmeXnYpZ
```

**Note**: some `/boot` should be for bootable extended

### File System Root & User

For `root`

```
mkfs.ext4 -O 64bit,bigalloc,dir_index,dir_nlink,ea_inode,ext_attr,extent,encrypt,extra_isize,fast_commit,filetype,flex_bg,has_journal,huge_file,inline_data,large_dir,large_file,metadata_csum,metadata_csum_seed,orphan_file,orphan_present,resize_inode,sparse_super,sparse_super2,stable_inodes,verity /dev/X/Y
```

For `<user name>`

```
mkfs.ext4 -O 64bit,bigalloc,dir_index,dir_nlink,ea_inode,ext_attr,extent,encrypt,extra_isize,fast_commit,filetype,flex_bg,has_journal,huge_file,inline_data,large_dir,large_file,metadata_csum,metadata_csum_seed,orphan_file,orphan_present,resize_inode,sparse_super,sparse_super2,stable_inodes,verity /dev/X/Y
```

```
homectl create <user name> \
    --real-name="" \
    --email-addres="" \
    --location="Asia/Jakarta" \
    --timezone="Asia/Jakarta" \
    --capability-bounding-set=CAP_NET_BIND_SERVICE,CAP_SYS_NICE,CAP_SYS_TIME \
    --capability-ambient-set=CAP_BPF,CAP_PERFMON \
    --shell="/usr/bin/fish" \
    --drop-caches=true \
    --fs-type=ext4 \
    --storage=luks \
    --luks-discard=true \
    --luks-offline-discard=true \
    --luks-volume-key-size=512 \
    --luks-cipher=aes \
    --luks-cipher-mode=xts-plain64 \
    --luks-pbkdf-type=argon2id \
    --luks-pbkdf-hash-algorithm=sha256 \
    --luks-pbkdf-time-cost=4 \
    --luks-pbkdf-memory-cost=67108864 \
    --luks-pbkdf-parallel-threads=4 \
    --luks-sector-size=4096 \
    --home-dir="/home/<user name>" \
    --image-path=/dev/home/<user name>
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