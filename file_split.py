# -*- coding:utf-8 -*-
## Date: 2022-1-9
## Author: Charles Bian
## This file is to split the file.

tsvfile = open('dev.tsv','r',encoding='utf-8').readlines()

filename = 1

for i in range(len(tsvfile)):
    if i % 10000 == 0:
        open(str(filename)+'.tsv','w+',encoding='utf-8').writelines(tsvfile[i:i+10000])
        filename = 1+filename
