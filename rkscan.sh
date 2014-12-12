#!/bin/bash

# define the whitelist
whitelist="bin|sbin|lib"

# find the executed command not in whitelist
rootkit=$(find /proc -type l -name "*exe" -exec ls -al {} + 2>/dev/null | awk '{if($11!="") print $11}' | grep -vE $whitelist | sort -u)

# result
if [ -z "${rootkit}" ]; then
	echo "Your system is clean."
else
	echo "Your system is infected with:\n$rootkit"
fi

exit
