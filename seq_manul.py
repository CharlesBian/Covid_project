#coding:utf-8
## Date: 2022-1-4
## Author: Charles Bian
## This file is to make the download file for EMBL_ENA

import csv
csvFile = open("dev2.csv",'w',newline='',encoding='utf-8')
writer = csv.writer(csvFile)
csvRow = []
count = 0

f = open("embl-covid19-idlist_701_715.txt",'r',encoding='utf-8')

for line in f:
    count = count + 1
    csvRow = line.split()
    temp_label = csvRow.pop()
    csvRow = ["".join(csvRow),temp_label]
    print(csvRow)
    writer.writerow(csvRow)
f.close()
csvFile.close()
with open('dev2.csv',encoding='utf-8') as f:
    data = f.read().replace(',','\t')
with open('1.tsv','w',encoding='utf-8') as f:
    f.write(data)
f.close()