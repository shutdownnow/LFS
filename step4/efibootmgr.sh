sed -e '/extern int efi_set_verbose/d' -i src/efibootmgr.c

make EFIDIR=LFS EFI_LOADER=grubx64.efi

make install EFIDIR=LFS
