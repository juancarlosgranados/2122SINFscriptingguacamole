#!/bin/bash
#Sanity check
REQUIRED_PKG="clamav"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo "You Need to install " $REQUIRED_PKG: "you can try $ sudo apt-get install clamav or the method of install of your distro" $PKG_OK
if [ "" = "$PKG_OK" ]; then
echo "No $REQUIRED_PKG. ..."
fi

#MainProgram
DIR=/home/juacon/Documents
log=$HOME/virusScan.sh
{
echo "The extensions are"
ls | awk -F'\.' 'NF>1 {ext[$NF]++} END {for (i in ext) print ext[i],i}'
} > $log

scanned=0
for FILE in "$DIR"/*
do
     # check file length is nonzero otherwise commands may be repeated
     if [ -s "$FILE" ]; then
          {
          date
          clamscan -r "$FILE"
          } >> $log
          ((scanned++))
          while read line
          do
              line="${line% FOUND}"
              virus_name="${line#* }"
              file_name="${line%: *}"
              ((virus_count=$virus_count+1))

              printf "  %s\n" "${file_name}"            # Output to screen
              printf "%s\n" "${file_name}" >&3          # Output to log
          done < <(grep " FOUND$" $scan_log) 3>log
          echo "The files infected have been moved to the folder at /home/cmccabe/quarantine"
     fi
done
[ $scanned -eq 0 ] && echo "nothing detected by scan" >> $log
