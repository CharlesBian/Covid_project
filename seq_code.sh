#! /bin/bash
## author: Charles Bian
## Software: seqkit , numer
## sequence is from Gisaid website (Virus=hCov-19,Host=human )
## Template=NC_045512.2.fa (NCBI) 

date
input=*.fasta
ref=NC_045512.2.fa

## clear the sequence
seqkit grep -s -p -$input -v |sed 's/^M$//' |awk '/^>/{f=!d[$1];d[$1]=1}f' >Gisaid_RMD.fasta

## remove fasta sequence with duplicated ID

## calculate total sample

## downsampling fasta seq:

## Snap Calling

## Assay primer postion find

## get the virus islation/strain information

## get the country information


exit 0
