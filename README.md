bash-analysis
============

Various tools for text extraction, representation, and analysis

Functions
---------

### `avg`

Calculate the average of input numbers

    $ cat data
    100
    100
    0
    $ avg < data
    66.666

### `commas`

Add commas to a given inputs numbers

    $ echo '100000 / 100000000' | commas
    100,000 / 100,000,000

### `field`

Grab a field from given input, Adapted from
http://www.brendangregg.com/Shell/field

    $ cat data.txt
    1 dave
    2 mike
    3 skye
    4 shaggy
    $ cat data.txt | field 2
    dave
    mike
    skye
    shaggy

or specify a field separator as the second argument

    $ cat /etc/passwd | field 7 :
    /usr/bin/false
    /bin/sh
    /usr/bin/false
    ...

- `$1` - The field number to extract, defaults to `1`
- `$2` - The field separator to be passed to awk, defaults to ` ` (whitespace)

### `freq`

Poor mans frequency count

    $ cat data
    a
    b
    c
    c
    c
    $ cat data | freq
       1 a
       1 b
       3 c

Using the data from above we can count the shells found in
`/etc/passwd`

    $ cat /etc/passwd | field 7 : | freq
          1 /bin/bash
          1 /bin/ksh
          1 /opt/local/bin/pdksh
          1 /usr/bin/pfksh
          1 /usr/bin/pfsh
          1 /usr/lib/uucp/uucico
          3 /usr/bin/bash
          7 /usr/bin/false
         52 /opt/local/bin/bash

### `gaps`

Print gaps in numbers (inclusively), adapted from
http://stackoverflow.com/questions/15867557/finding-gaps-sequential-numbers

    $ cat data
    1
    2
    3
    6
    10
    $ cat data | gaps
    4-5
    7-9

### `max`

Figure out the max number of given input

    $ cat data
    1
    2
    3
    $ max < data
    3

### `min`

Figure out the min number of given input

    $ cat data
    1
    2
    3
    $ min < data
    1

### `summarize`

Print a summary for input data: show average, sum, min and max

    $ cat data
    1
    3
    5
    7
    8
    9
    $ summarize < data
    lines    6
    min  1
    max  9
    sum  33
    avg  5.5

### `total`

Total a given field using awk, adapted from
http://www.brendangregg.com/Shell/total

    $ cat data
    1
    2
    4
    $ cat data | total
    7

- `$1` - The field number to extract, defaults to `1`
- `$2` - The field separator to be passed to awk, defaults to ` ` (whitespace)

Installation
------------

### bics

Use [bics](https://github.com/bahamas10/bics) to manage this plugin

After installing `bics`, install this plugin by running

    bics install git://github.com/bahamas10/bash-analysis.git

### manually

    git clone git://github.com/bahamas10/bash-analysis.git
    cd bash-analysis
    cat analysis.bash >> ~/.bashrc
    exec bash

License
-------

MIT
