The script can be used as non-root and root. 

As non-root, ```sh checkspace.sh``` shows the used space for your home directory only.
```console
Used space in /home/johndoe:
74%
You must be root to check the whole disk.
```

As root, sudo ```sudo sh checkspace.sh``` shows the used space for the whole disk.
```console
Used space on the disk:
72%
Everything is fine, keep going ^^
```

If the space used for the whole disk is above 90%, an interactive mode will ask if you want to empty the cache, and then it will ask for the /tmp folder.

```console
Do you want to clean the cache now? Y/n
Y
Cleaning the cache
(...)
Do you want to remove files in the /tmp folder? Y/n
Y
Removing files in /tmp
```
