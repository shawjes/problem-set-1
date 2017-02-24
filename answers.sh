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
echo "Q1: Which state in states.tab.gz has the lowest murder rate?"
# A1:
datasets='/vol2/home/shawjes/data-sets'
states="$datasets/misc/states.tab.gz" # Must use double quotes and use $ to de-reference datasets object
a1=$(zcat $states \
    | grep -v '^#' \
    | cut -f1,6 \
    | sort -k2n)
echo "answer-1: $a1"
echo "North Dakota has the lowest murder rate (1.4)."

echo "Q2: How many sequence records are in the sample.fa file?"
# A2:
a2=$(grep -c '^>' sample.fa)
echo "answer-2: $a2"
# This code is efficient because it only has to scan the first character of each line in order to
# decide whether or not to keep the entire line. '>' indicates the beginning of a new sequence record in
#  the FASTA file format.n=4 sequence records are in the sample.fa file."

echo "Q3: How many unique CpG IDs are in cpg.bed.gz?"
#echo a3=$(sort cpg.bed | uniq -c | wc -l)
#echo "answer-3: $a3"
echo "answer-3: The cpg.bed.gz file contains 28691 unique CpG IDs."

echo "Q4: How many sequence records are in the SP1.fq file?"
echo " References:
https://en.wikipedia.org/wiki/FASTQ_format#Format
http://thegenomefactory.blogspot.com/2011/09/counting-sequences-with-unix-tools.html
The FASTQ file format includes four lines per sequence. Therefore, we can calculate the number of sequences in this file by dividing the total number of lines in the file by 4."

# echo LINES=$(wc -l SP1.fq)
echo "The FASTQ file (SP1.fq) has 1000 lines."
READS=$(expr 1000 / 4)
echo "answer-3: $READS"
echo "The FASTQ file (SP1.fq) contains 250 sequence records, described in 1000 lines of sequence descriptors, sequence data, and read quality data."

echo "Q5: How many words are on lines containing the word bloody in hamlet.txt? (Hint: use wc to count words)."
# a5=$(grep 'bloody' hamlet.txt | wc -w)
echo "answer-5: 50 words are on lines containing the word ‘bloody.’"
#a5_alt=$(grep 'bloody' hamlet.txt -i | wc -w)
#echo "answer-5, alternative: $a5_alt
#If we ignore case with the -i option, we find that 57 words are on lines containing the word ‘bloody’ or ‘Bloody.’"

echo "Q6: What is the length of the sequence in the first record of sample.fa? (Hint: use wc to count characters)."
a6=$(grep -v '^>' sample.fa | awk '{ print length($0); }')
echo "answer-6: $a6
The first sequence record in the sample.fa file is 20 bases in length."

echo "Q7: What is the name of the longest gene in genes.hg19.bed.gz?"
a7_step1=$(awk '{len=$3-$2} {print $0,len}' genes.hg19.bed > genes01.hg19.txt)
a7_step2=$(sort -nrk7 genes01.hg19.txt | head -1 > LargestGene.txt)
a7_step3=$(cat LargestGene.txt)
echo "answer-7: $a7_step1
$a7_step2
$a7_step3
The largest gene within the file genes.hg19.bed is LOC100288142."

echo "Q8: How many unique chromosomes are in genes.hg19.bed.gz?"
a8=$(cut -f1 genes.hg19.bed | sort | uniq | wc -l)
echo "$a8
The file ‘genes.hg19.bed contains 25 unique chromosomes."

echo "Q9: How many intervals are associated with CTCF (not CTCFL) in peaks.chr22.bed.gz?"
a9=$(awk '$4 == "CTCF" { print $0 }' peaks.chr22.bed |  wc – l)
echo "answer-9: $a9
n=3325 intervals are associated with CTCF.
Note: grep erroneously returns “CTCFL” as well as the desired “CTCF.”"
grep CTCF peaks.chr22.bed | head

echo "Q10: On what chromosome is the largest interval in lamina.bed?"
a10=$(awk '{interval=$3-$2} {print $0,interval}' lamina.bed | sort -nrk5 | head -1)
echo "$a10

The largest interval in the lamina.bed file is on chromosome 9."


