#!/bin/bash

# define the whitelist for binary file
whitelist="bin|sbin|lib"

# find the running binary file is not in whitelist
rootkit=$(find /proc -type l -name "*exe" -exec ls -al {} + 2>/dev/null \
		| awk '{if($11!="") print $11}' | grep -vE $whitelist | sort -u)

# result
if [ -z "${rootkit}" ]; then
	echo "Your system is clean."
else
	echo "This binary is not in whitelist:\n$rootkit"
fi
