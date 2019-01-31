#!/usr/bin/env bash

scriptDir=$(dirname "$0")

#####  get feature weights: salmonella
if [ ! -f $scriptDir/../data/proteome_prediction_salmonella/proteome_99287.featureWeights.txt ];then
	TriPepSVM.sh -i $scriptDir/../data/proteome_99287.fasta -o $scriptDir/../data/proteome_prediction_salmonella -id 590 -pos 1.8 -neg 0.2 -thr 0.28 -r TRUE
fi

#####  get feature weights: human
if [ ! -f $scriptDir/../data/proteome_prediction_human/proteome_9606.featureWeights.txt ];then
	TriPepSVM.sh -i $scriptDir/../data/proteome_9606.fasta -o $scriptDir/../data/proteome_prediction_human -id 9606 -pos 1.8 -neg 0.2 -thr 0.68
fi 

#####  get feature weights: ecoli
if [ ! -f $scriptDir/../data/proteome_prediction_ecoli/proteome_83333.featureWeights.txt ];then
	TriPepSVM.sh -i $scriptDir/../data/proteome_83333.fasta -o $scriptDir/../data/proteome_prediction_ecoli -id 561 -pos 1 -neg 0.1 -thr 0.3
fi 

##### plot feature weights human vs. salmonella
Rscript $scriptDir/source/plotRanking.r $scriptDir/../data/proteome_prediction_salmonella/proteome_99287.featureWeights.txt $scriptDir/../data/proteome_prediction_human/proteome_9606.featureWeights.txt \
Salmonella Human $scriptDir/../data/kmer_enriched_human.txt $scriptDir/figure_4_1.pdf

##### plot feature weights ecoli vs. human
Rscript $scriptDir/source/plotRanking.r $scriptDir/../data/proteome_prediction_ecoli/proteome_83333.featureWeights.txt $scriptDir/../data/proteome_prediction_human/proteome_9606.featureWeights.txt \
E.coli Human $scriptDir/../data/kmer_enriched_human.txt $scriptDir/figure_4_2.pdf

##### plot feature weights ecoli vs. salmonella
Rscript $scriptDir/source/plotRanking.r $scriptDir/../data/proteome_prediction_ecoli/proteome_83333.featureWeights.txt $scriptDir/../data/proteome_prediction_salmonella/proteome_99287.featureWeights.txt \
E.coli Salmonella $scriptDir/../data/kmer_enriched_human.txt $scriptDir/figure_4_3.pdf

