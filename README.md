bash-analysis
============

Various tools for text extraction, representation, and analysis

Functions
---------

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
- `$2` - The field separator to be passed to awk, defaults to ` `

### `freq`

Foor mans frequency count

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

Using the data from above we can count the frequency of shells found in
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

### `limitcolumns`

Limit the number of columns printed to terminal size or 80 if size cannot be
determined

    $ cat file.txt
    some really long line
    some short line
    $ cat file.txt | limitcolumns 20
    some really long li>
    some short line

- `$1` - the number of columns to limit the output to, defaults to terminal
width, falling back on `80`

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
- `$2` - The field separator to be passed to awk, defaults to ` `

Installation
------------

### basher

Use [basher](https://github.com/bahamas10/basher) to manage this plugin

After installing `basher`, install this plugin by running

    basher install git://github.com/bahamas10/bash-analysis.git

Or install manually for `basher` with

    cd ~/.basher/plugins
    git clone git://github.com/bahamas10/bash-analysis.git

### manually

    git clone git://github.com/bahamas10/bash-analysis.git
    cd bash-analysis
    cat analysis.bash >> ~/.bashrc
    exec bash

License
-------

MIT
