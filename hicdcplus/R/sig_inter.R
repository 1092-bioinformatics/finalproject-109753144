library('HiCDCPlus')

# Feature Generation
outdir<-'.'
construct_features(output_path=paste0(outdir,"/hg19_50kb_GATC"),
                   gen="Hsapiens",gen_ver="hg19",
                   sig="GATC",
                   bin_type="Bins-uniform",
                   binsize=50000,
                   chrs=c("chr21","chr22"))

# bintolen<-data.table::fread(paste0(outdir,"/hg19_50kb_GATC_bintolen.txt.gz"))
# tail(bintolen,20)


#generate gi_list instance
gi_list<-generate_bintolen_gi_list(
bintolen_path=paste0(outdir,"/hg19_50kb_GATC_bintolen.txt.gz"))
#add .hic counts
hicfile_path<-system.file("extdata", "GSE63525_HMEC_combined_example.hic", package = "HiCDCPlus")
gi_list<-add_hic_counts(gi_list,hic_path = hicfile_path)


#expand features for modeling
gi_list<-expand_1D_features(gi_list)
#run HiC-DC+ on 2 cores
set.seed(1010) #HiC-DC downsamples rows for modeling
gi_list<-HiCDCPlus_parallel(gi_list,ncore=2)


#write normalized counts (observed/expected) to a .hic file
hicdc2hic(gi_list,hicfile=paste0(outdir,'/GSE63525_HMEC_combined_result.hic'),mode='normcounts',gen_ver='hg19')
#write results to a text file
gi_list_write(gi_list,fname=paste0(outdir,'/GSE63525_HMEC_combined_result.txt.gz'))
