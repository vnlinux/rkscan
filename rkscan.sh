#!/bin/bash

# define the white list of binary path (one path per line)
whitepath="/bin
/sbin
/usr/bin
/usr/sbin
/usr/lib
"

# find the binary excuted not in white paths
for path in $whitepath
do
	exclude+="grep -v '^$path' | "
done

cmd="find /proc -type l -name '*exe' -exec ls -al {} + 2>/dev/null | awk '{if(\$11!=\"\") print \$11}' | $exclude sort -u"

rootkit=$(eval $cmd)

# result
if [ -z "${rootkit}" ]; then
	echo "Your system is clean."
else
	echo "This binary is not in whitelist:\n$rootkit"
fi
