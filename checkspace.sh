#!/bin/sh

usedspace=$(df -h --total | grep -i total | cut -d "G" -f 4 | cut -d "%" -f 1)

echo "The used space on the disk is:$usedspace%"

if [ $usedspace -gt 60 ]; then
        echo "Do you want to clean the cache now? Y/n"
        read choice

        if [ "$choice" = "Y" ] || [ "$choice" = "y" ]; then
                echo "Cleaning the cache"
                free && sync && echo 3 > /proc/sys/vm/drop_caches && free
                echo "The used space is now:$usedspace%"

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
                echo "The used space is now:$usedspace%"
        elif [ "$choice" = "N" ] || [  "$choice" = "n" ]; then
                echo "Please check your /tmp folder manually"
        else
                exit 1
        fi

        if [ $usedspace -gt 60 ]; then
                echo "The used space is still above the limit:$usedspace%\nPlease remove unnecessary files and documents, clean the trash and the Downloads folder."
        fi
else
        echo "Everything is fine, keep going ^^"
fi
