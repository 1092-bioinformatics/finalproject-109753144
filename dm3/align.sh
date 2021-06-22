#!/bin/bash

#PBS -l select=1:ncpus=8 
#PBS -P MST109178
#PBS -j eo
#PBS -q ct160
#PBS -M harry063098@gmail.com
#PBS -m e

cd align
bwa_path='~/lib/bwa/bwa'

# build reference genome index
${bwa_path} index dm3.fasta -p dm3

# align double strand
${bwa_path} mem dm3.fasta HiC_S2_1p_10min_lowU_R1.fastq > R1.bam
${bwa_path} mem dm3.fasta HiC_S2_1p_10min_lowU_R2.fastq > R2.bam 
