#! /bin/bash
## author: Charles Bian
## Software: seqkit , numer
## sequence is from Gisaid website (Virus=hCov-19,Host=human )
## Template=NC_045512.2 (NCBI) 

date

input=Cov19_1.fasta
ref=NC_045512.txt

## clear the sequence
seqkit grep -s -p -$input -v > Gisaid_RMD.fasta

##Covert the DOS/windows file format to UNIX format for both ref and input file
sed 's/^M$//' Gisaid_clear.fasta > Gisaid_clear_format.fasta
sed 's/^MS//' NC_045512.txt > ref.fa

## remove fasta sequence with duplicated ID
awk '/^>/{f=!d[$1];d[$1]=1}f' Gisaid_clear_format.fasta > Gisaid_RMD.fasta

## calculate total sample
grep -c '^>' Gisaid_RMD.fasta

## downsampling fasta seq:
seqkit sample --proportion 0.15 Gisaid_RMD.fasta > Gisaid_RMD_15.fasta

## Snap Calling
nucmer --forward -p numer ref.fa Gisaid_RMD.fasta
show-coords -r -c -l nucmer.delta > nucmer.coords
show-snps nucmer.delta -T -l > nucmer.snps

##
seqkit grep -s -i -p AACGAACTTCTCCTGCTAGAAT $input -v  > ChinaCDC-N-F-not-AAC.fasta
seqkit grep -s -i -p AACGAACTTCTCCTGCTAGAAT Gisaid_RMD.fasta > ChinaCDC-N-F-AAC.fasta

grep "^>" Gisaid_RMD.fasta | cut -d '|' -f 1| cut -d '/' -f 2 -> country-infor.txt
grep "^>" ChinaCDC-N-F-AAC.fasta | cut -d '|' -f 1| cut -d '/' -f 2 -> AAC-country-infor.txt

#seqkit grep -s -i -p AACGAACTTCTCCTGCTAGAAT Gisaid_RMD.fasta > ChinaCDC-N-F-AAC.fasta | grep "^>" | cut -d '|' -f 1| cut -d '/' -f 2 -> AAC-country-infor.txt

## Assay primer postion find
seqkit locate -p $id NC_045512.2.fa

cat Primer_info.txt | while read id; do (seqkit locate -p $id NC_045512.2.fa| cut -f 5,6,7 | tail -n 1 >> loate.txt)  done

##
seqkit grep -s -i -p AACGAACTTCTCCTGCTAGAAT gisaid_RMD.fasta > ChinaCDC-N-F-AAC.fasta
seqkit grep -s -i -p AACGAACTTCTCCTGCTAGAAT gisaid_hcov-19_2020_04_30_06.fasta -v  > ChinaCDC-N-F-not-AAC.fasta

## get the virus islation/strain information
grep "^>" gisaid_hcov-19_2020_04_27_12.fasta |cut -d '|' -f 2

grep "^>" gisaid_hov | cut -d '|' -f 2,3 > Sample-infor.txt
## get the country information
grep "^>" gisaid_hcov-19_2020_04_27_12.fasta |cut -d '|' -f 1| cut -d '/' -f 2

seqkit amplicon  -F AGTTGTGATCAACTCCGCGA -R TAAGACGGGCTGCACTTACA gisaid_hcov-19_2020_04_27_12.fasta | seqkit stat

exit 0
