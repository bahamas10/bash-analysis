# analysis
#
# Various tools for text extraction, representation, and analysis
#
# Author: Dave Eddy <dave@daveeddy.com>
# Credits: Brendan Gregg http://www.brendangregg.com/
# License: MIT
# Date: 3/2/2013

# Calculate the average of input numbers
#
# $ cat data
# 100
# 100
# 0
# $ avg < data
# 66.666
avg() {
	local f=${1:-1}
	awk -F "${2:- }" "length(\$$f) { i+=1; sum+=\$$f; } END { print sum/i }"
}

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

# Figure out the max number of given input
#
# $ cat data
# 1
# 2
# 3
# $ max < data
# 3
max() {
	local f=${1:-1}
	awk -F "${2:- }" "
	length(\$$f) {
		if (max == \"\" || \$$f > max)
			max = \$$f
	}
	END { print max; }"
}

# Figure out the min number of given input
#
# $ cat data
# 1
# 2
# 3
# $ min < data
# 1
min() {
	local f=${1:-1}
	awk -F "${2:- }" "
	length(\$$f) {
		if (min == \"\" || \$$f < min)
			min = \$$f
	}
	END { print min; }"
}

# Print a summary for input data
# show average, sum, min and max
summarize() {
	local f=${1:-1}
	awk -F "${2:- }" "
	length(\$$f) {
		if (max == \"\")
			max = min = \$$f;
		i += 1;
		sum += \$$f;
		if (\$$f > max)
			max = \$$f
		if (\$$f < min)
			min = \$$f
	}
	END {
		print \"lines\\t\", i;
		print \"min\\t\", min;
		print \"max\\t\", max;
		print \"sum\\t\", sum;
		print \"avg\\t\", sum/i;
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
