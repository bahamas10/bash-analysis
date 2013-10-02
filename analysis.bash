# analysis
#
# Various tools for text extraction, representation, and analysis
#
# Author: Dave Eddy <dave@daveeddy.com>
# Credits: Brendan Gregg http://www.brendangregg.com/
# License: MIT
# Date: 3/2/2013

# Add commas to a given inputs numbers
#
# $ echo '100000 / 100000000' | commas
# 100,000 / 100,000,000
commas() {
	sed -e :a -e 's/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/;ta'
}

# Grab a field from given input
# Adapted from http://www.brendangregg.com/Shell/field
#
# $ echo -e '  three    different\tcolumns ' | field 2
# different
field() {
	awk -F "${2:- }" "{ print \$${1:-1} }"
}

# Poor mans frequency count
#
# $ cat data
# a
# b
# c
# c
# $ cat data | freq
#    1 a
#    1 b
#    2 c
freq() {
	sort | uniq -c | sort -n
}

# Print gaps in numbers (inclusively)
# http://stackoverflow.com/questions/15867557/finding-gaps-sequential-numbers
#
# $ cat data
# 1
# 2
# 3
# 6
# 10
# $ cat data
# 4-5
# 7-9
gaps() {
	awk '$1 != (p+1) { print p+1 "-" $1-1 } { p = $1 }'
}

# Limit the number of columns printed to terminal size
# or 80 if size cannot be determined
#
# $ cat file.txt
# some really long line
# some short line
# $ cat file.txt | limitcolumns 20
# some really long li>
# some short line
limitcolumns() {
	local cols=$1
	local red=$(tput setaf 1)
	local reset=$(tput sgr0)
	cols=${cols:-$COLUMNS}
	cols=${cols:-$(tput cols)}
	cols=${cols:-80}
	awk "
	{
		if (length(\$0) > $cols)
			\$0 = substr(\$0, 0, $cols - 1) \"$red>$reset\";
		print \$0
	}"
}

# Total a given field using awk
# Taken from http://www.brendangregg.com/Shell/total
#
# $ cat data
# 1
# 2
# 4
# $ cat data | total
# 7
total() {
	awk -F "${2:- }" "{ s += \$${1:-1} } END { print s }"
}
