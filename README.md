# archlinux-install
Boilerplate Setup With Tweak &amp; Config Archlinux Installer

### ext4

```
mkfs.ext4 -O fast_commit,metadata_csum,encrypt /dev/X/Y
```

#### Note: Don't use fscrypt (encrypt) if you don't need it and change homed.conf `DefaultStorage=storage`

### fstab

```
# tweak user options: rw,relatime,journal_checksum,delalloc,data=ordered

tmpfs						/tmp		    tmpfs       rw,nodev,nosuid,noexec,size=4G 0 0

/tmp                        /var/tmp        none        rw,nodev,nosuid,noexec,bind 0 0

tmpfs						/dev/shm	    tmpfs	    rw,nodev,nosuid,noexec,size=2G 0 0

tmpfs						/run		    tmpfs       rw,nodev,nosuid,size=2G 0 0

hugetlbfs                   /dev/hugepages  hugetlbfs   mode=01770,gid=kvm 0 0
```

