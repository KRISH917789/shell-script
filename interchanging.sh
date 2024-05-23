#!/bin/bash

# Check if input file is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

input_file=$1

# Check if file exists
if [ ! -f $input_file ]; then
    echo "File not found: $input_file"
    exit 1
fi

# Interchange rows and columns
awk '
{
    for (i=1; i<=NF; i++)  {
        if (NR==1) {
            row[i] = $i;
        } else {
            row[i] = row[i] " " $i;
        }
    }
    if (NR > 1) {
        print prevrow;
    }
    prevrow = $0;
}
END {
    print prevrow;
    for (i=1; i<=NF; i++) {
        print row[i];
    }
}' $input_file
