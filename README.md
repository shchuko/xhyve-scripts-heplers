# xHyve scripts-heplers

A couple of scripts helps you make things faster

Create/attach(mount)/detach(umount) **bootloader drive** (ex. [OpenCore](https://github.com/acidanthera/OpenCorePkg)):

*  `create_booter_img_512M.sh` - create 512M raw drive image, GPT-partitioned:

   1. 256M fat32 (EFI)

   2. 256M fat32

   Usage:
   
      - `create_booter_img_512M.sh`
      
      - `create_booter_img_512M.sh image_to_create.iso`

* `attach_booter_img.sh` - attach, mount a drive

  Usage: `./attach_booter_img.sh image_to_attach.img /mount/point/1 /mount/point/2`


* `detach_booter_img.sh` - detach, umount a drive attached by command above

  Usage: `./detach_booter_img.sh image_to_detach.img /point/to/umount/1 /point/to/umount/2`

Other:

* `source.sh` - source this script to extend $PATH with current $PWD to use the scripts-heplers from everywhere

