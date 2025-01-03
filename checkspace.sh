#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
        usedinhome=$(df -h /home/$USER | cut -d "G" -f 4 | cut -d "%" -f 1 | cut -d " " -f 3)
        echo "Used space in /home/$USER:$usedinhome%"

        echo "You must be root to check the whole disk." 1>&2
        exit 1
fi

usedspaceondisk=$(df -h --total | grep -i total | cut -d "G" -f 4 | cut -d "%" -f 1 | cut -d " " -f 3)

echo "Used space on the disk:\n$usedspaceondisk%"

if [ $usedspaceondisk -gt 90 ]; then
        echo "Do you want to clean the cache now? Y/n"
        read choice

        if [ "$choice" = "Y" ] || [ "$choice" = "y" ]; then
                echo "Cleaning the cache"
                free && sync && echo 3 > /proc/sys/vm/drop_caches && free
                echo "The used space is now:$usedspaceondisk%"

        elif [ "$choice" = "N" ] || [  "$choice" = "n" ]; then
                echo "Please check your cache manually"
        else
                exit 1
        fi

        echo "Do you want to remove files in the /tmp folder?"
        read choice

        if [ "$choice" = "Y" ] || [ "$choice" = "y" ]; then
                echo "Removing files in /tmp"
                rm -rf /tmp/*
                echo "The used space is now:$usedspaceondisk%"
        elif [ "$choice" = "N" ] || [  "$choice" = "n" ]; then
                echo "Please check your /tmp folder manually"
        else
                exit 1
        fi

        if [ $usedspaceondisk -gt 60 ]; then
                echo "The used space is still above the limit:$usedspaceondisk%\nPlease remove unnecessary files and documents, clean the trash and the Downloads folder."
        fi
else
        echo "Everything is fine, keep going ^^"
fi
