#!/usr/bin/env bash

#SBATCH --partition=exacloud
#SBATCH --job-name=ZZ_SNPs
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --time=12:00:00
#SBATCH --mail-user=kriegema@ohsu.edu

#This is going to make an array of all the sample names in the current directory. You can modify this if the sample names are different.
arr=()
for entry in "*.fastq"
do
  Name=$(echo ${entry} | sed 's=./==g' | sed 's/_R[1 2]_paired.fastq//g');
  echo $Name
  arr+=($Name)
done

#Makes an array of unique values of sample identifiers
uniqs_arr=($(for ip in "${arr[@]}"; do echo "${ip}"; done | sort -u))
len_uniqs_arr=${#uniqs_arr[@]};

#For each unique sample, we will use trimmomatic to produce output.
COUNTER=0
for value in "${uniqs_arr[@]}"
do
  let COUNTER=COUNTER+1;
  echo "Snippy analysis in progress for sample "$value;
  echo "Progress: " $COUNTER "out of" $len_uniqs_arr" total samples";

  if [[ $value == R* ]];
  then
  snippy --outdir $value"_snippyoutput" --ref 159-comX-renG-erm.fa pZX9-comR.fa  --R1 $value"_R1_paired.fastq" --R2 $value"_R2_paired.fastq";
  
  elif [[ $value == X* ]];
  then
  snippy --outdir $value"_snippyoutput" --ref 159-ssb2-gusA-erm.fa pZX9-comX.fa --R1 $value"_R1_paired.fastq" --R2 $value"_R2_paired.fastq";
  fi

done
