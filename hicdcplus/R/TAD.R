library('HiCDCPlus')

#ICE normalization using HiTC
hic_path<-system.file("extdata", "GSE63525_HMEC_combined_example.hic", package = "HiCDCPlus")
gi_list=hic2icenorm_gi_list(hic_path,binsize=50e3,chrs=c('chr21','chr22'))


# call TAD
tads<-gi_list_topdom(gi_list,chrs=c("chr21","chr22"),window.size = 10)


#Finding A/B compartment using Juicer
extract_hic_eigenvectors(
  hicfile=system.file("extdata", "GSE63525_HMEC_combined_example.hic", package = "HiCDCPlus"),
  mode = "KR",
  binsize = 50e3,
  chrs = "chr22",
  gen = "Hsapiens",
  gen_ver = "hg19"
)
