#!/usr/bin/env bash

for f in *; do
    if [ -d "$f" ]; then
        # $f is a directory
        cd $f;
        rm *.bam;
        rm *.bam.bai;
        rm *ref.fa.fai;
        mv snps.log $f.log;
        mv snps.csv $f.csv;
        cp $f.csv ../Snippy_CSVs;
        echo "YAY";
        cd ../;
    fi
done
