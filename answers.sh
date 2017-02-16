#! /usr/bin/env bash 

#datasets='/Users/jayhesselberth/devel/MOLB7621/data-sets'
# Which state has the highest popultion?

#states="$datasets/states.tab.gz"

#answer_1=$(zcat $states \
 #   | grep -v '^#' \
  #  | cut -f1,2 \
   # | sort -k2n \
    #| tail -n1 \
   # | cut -f1 \
   # | sed 's/"//g') 

#echo "answer-1: $answer_1"

# Q1: Which state in states.tab.gz has the lowest murder rate?
# A1:
datasets='/vol2/home/shawjes/data-sets'
states="$datasets/misc/states.tab.gz" # Must use double quotes and use $ to de-reference datasets object
echo $q1
a1=$(zcat $states \
    | grep -v '^#' \
    | cut -f1,6 \
    | sort -k2n)
echo "a1: $a1"
# North Dakota has the lowest murder rate (1.4).

# Q2: How many sequence records are in the sample.fa file?
# A2:
grep -c '^>' sample.fa
# This code is efficient because it only has to scan the first character
# of each line in order to decide whether or not to keep the entire line. 
# '>' indicates the beginning of a new sequence record in the FASTA file format.
# n=4 sequence records are in the sample.fa file.

# Q3: How many unique CpG IDs are in cpg.bed.gz?
# A3:
zcat cpg.bed.gz > cpg.bed
sort cpg.bed | uniq -c | head
sort cpg.bed | uniq -c | wc -l
# The cpg.bed.gz file contains 28691 unique CpG IDs.

# Q4: How many sequence records are in the SP1.fq file?
# A4:
# References:
# *https://en.wikipedia.org/wiki/FASTQ_format#Format
# * http://thegenomefactory.blogspot.com/2011/09/counting-sequences-with-unix-tools.html
# The FASTQ file format includes four lines per sequence. Therefore, we can calculate the number of sequences in this file by dividing the total number of lines in the file by 4.
LINES=`cat SP1.fq | wc -l`
echo $LINES
# The FASTQ file (SP1.fq) has 1000 lines.
READS=`expr $LINES / 4`
echo $READS
# The FASTQ file (SP1.fq) contains 250 sequence records, described in 1000 lines of sequence descriptors, sequence data, and read quality data.

# Q5: How many words are on lines containing the word bloody in hamlet.txt? (Hint: use wc to count words).
# A5:
grep 'bloody' hamlet.txt | wc -w
# 50 words are on lines containing the word ‘bloody.’
grep 'bloody' hamlet.txt -i | wc -w
# If we ignore case with the -i option, we find that 57 words are on lines containing the word ‘bloody’ or ‘Bloody.’

# Q6: What is the length of the sequence in the first record of sample.fa? (Hint: use wc to count characters).
# A6: 
cat sample.fa
grep -v '^>' sample.fa > sample01.txt
cat sample01.fa
awk '{ print length($0); }' sample01.txt
# The first sequence record in the sample.fa file is 20 bases in length.

# Q7: What is the name of the longest gene in genes.hg19.bed.gz?

awk '{len=$3-$2} {print $0,len}' genes.hg19.bed > genes01.hg19.txt
head genes01.hg19.txt
sort -nrk7 genes01.hg19.txt | head -10
sort -nrk7 genes01.hg19.txt | head -1 > LargestGene.txt
cat LargestGene.txt
# The largest gene within the file genes.hg19.bed is LOC100288142.

# Q8: How many unique chromosomes are in genes.hg19.bed.gz?
head genes.hg19.bed
cut -f1 genes.hg19.bed | sort | uniq
cut -f1 genes.hg19.bed | sort | uniq | wc -l
# The file ‘genes.hg19.bed contains 25 unique chromosomes.

# Q9: How many intervals are associated with CTCF (not CTCFL) in peaks.chr22.bed.gz?
zcat peaks.chr22.bed.gz > peaks.chr22.bed
head peaks.chr22.bed
awk '$4 == "CTCF" { print $0 }' peaks.chr22.bed | head
awk '$4 == "CTCF" { print $0 }' peaks.chr22.bed |  wc – l
# n=3325 intervals are associated with CTCF.
# Note: grep erroneously returns “CTCFL” as well as the desired “CTCF.”
grep CTCF peaks.chr22.bed | head

# Q10: On what chromosome is the largest interval in lamina.bed?

# A10:
awk '{interval=$3-$2} {print $0,interval}' lamina.bed > lamina01.txt
head lamina01.txt
sort -nrk5 lamina01.txt | head -10
sort -nrk5 lamina01.txt | head -1 > LargestLamina.txt
cat LargestLamina.txt
# The largest interval in the lamina.bed file is on chromosome 9.

