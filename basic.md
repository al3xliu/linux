### part of basic

#### make a hard disk partition

  /var /opt /boot /swap(size is always  same as memmory's)

#### format disk and mount
  check disk
  ```
    lsblk
  ```

  ```
    fdisk /dev/sdb1
  ```

  make fs
  ```
    mkfs.ext4 /dev/sdb1
  ```

  mount disk
  ```
    mount /dev/sdb1 /data
  ```

  modify fs tab
  ```
    vim /etc/fstab
  ```

  the fstab file is as below

  ```
    # <device>             <dir>         <type>    <options>             <dump> <fsck>
    /dev/sda1              /             ext4      defaults,noatime      0      1
    /dev/sda2              none          swap      defaults              0      0
    /dev/sda3              /home         ext4      defaults,noatime      0      2
  ```

  <dump> is checked by the dump(8) utility.
  <fsck> sets the order for filesystem checks at boot time; see fsck(8).
