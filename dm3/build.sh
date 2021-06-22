#!/bin/bash

#PBS -l select=1:ncpus=8 
#PBS -P MST109178
#PBS -j eo
#PBS -q ct160
#PBS -M harry063098@gmail.com
#PBS -m e

#########################################
# reference : https://training.galaxyproject.org/training-material/topics/epigenetics/tutorials/hicexplorer/tutorial.html
#########################################
# activate virtual env.
source ~/anaconda3/etc/profile.d/conda.sh
conda activate hicexplorer

hicFindRestSites --fasta align/dm3.fasta --searchPattern GATC -o contact_matrix/rest_site_positions.bed

#########################################
# build hic matrix  10k
#########################################
hicBuildMatrix -s align/R1.bam align/R2.bam -o contact_matrix/10k_dm3.h5 --binSize 10000  \
		--QCfolder QC --restrictionCutFile contact_matrix/rest_site_positions.bed   \
		--restrictionSequence GATC --danglingSequence GATC



#########################################
# plot contact matrix 
# plot 1M(whole), 1M(chrX), 10k(chrX) 
#########################################
cd contact_matrix
hicMergeMatrixBins -m dm3.h5 -o 1M_dm3.h5 -nb 100
hicPlotMatrix -m 1M_dm3.h5 -o plot/1M_dm3.png --clearMaskedBins --log1p --chromosomeOrder chr2L chr2R chr3L chr3R chrX
hicPlotMatrix -m 1M_dm3.h5 -o plot/1M_dm3_chrX.png --clearMaskedBins --log1p --chromosomeOrder chrX
hicPlotMatrix -m 10k_dm3.h5 -o plot/10k_dm3.png --clearMaskedBins --log1p --chromosomeOrder chr2L chr2R chr3L chr3R chrX


#########################################
# correct matrix
# plot 10k correct (chrX)
#########################################

hicCorrectMatrix diagnostic_plot --matrix 10k_dm3.h5 -o plot/diagnostic_plot.png
hicCorrectMatrix correct --matrix dm3.h5 --perchr --filterThreshold -1.6 1.8   \ 
			  --chromosomes chr2L chr2R chr3L chr3R chrX   \
			  -o correct_10k_dm3.h5
hicPlotMatrix -m correct_10k_dm3.h5 -o plot/correct_10k_dm3.png --clearMaskedBins --log1p --chromosomeOrder chr2L chr2R chr3L chr3R chrX



#########################################
# TAD (in different threshold)
#########################################
cd ../TAD
hicFindTADs -m ../contact_matrix/correct_10k_dm3.h5 --outPrefix correct_10k_dm3_thr0.05    \
	    --correctForMultipleTesting fdr  \
	    --minDepth 30000 --maxDepth 100000  --step 10000  \
	    --thresholdComparisons 0.05 --delta 0.01
hicFindTADs -m ../contact_matrix/correct_10k_dm3.h5 --outPrefix correct_10k_dm3_thr0.01    \
              --correctForMultipleTesting fdr  \
              --minDepth 30000 --maxDepth 100000  --step 10000  \
              --thresholdComparisons 0.01 --delta 0.01
hicFindTADs -m ../contact_matrix/correct_10k_dm3.h5 --outPrefix correct_10k_dm3_thr0.005    \
             --correctForMultipleTesting fdr  \
            --minDepth 30000 --maxDepth 100000  --step 10000  \
             --thresholdComparisons 0.005 --delta 0.01
hicPlotTADs --tracks TAD_config/track1.ini -o track_img/track1_chrX_6800000_8500000.png --region chrX:6800000-8500000
hicPlotTADs --tracks TAD_config/track1.ini -o track_img/track1_chrX_1000000_3000000.png --region chrX:1000000-3000000
