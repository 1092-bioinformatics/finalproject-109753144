library('HiCDCPlus')

outdir <- '.'

#generate features
construct_features(output_path=paste0(outdir,"/hg38_50kb_GATC"),
                   gen="Hsapiens",gen_ver="hg38",
                   sig="GATC",bin_type="Bins-uniform",
                   binsize=50000,
                   chrs=c("chr21","chr22"))


#add .hic counts
hicfile_paths<-c(
  system.file("extdata", "GSE131651_NSD2_LOW_arima_example.hic", package = "HiCDCPlus"),
  system.file("extdata", "GSE131651_NSD2_HIGH_arima_example.hic", package = "HiCDCPlus"),
  system.file("extdata", "GSE131651_TKOCTCF_new_example.hic", package = "HiCDCPlus"),
  system.file("extdata", "GSE131651_NTKOCTCF_new_example.hic", package = "HiCDCPlus"))
indexfile<-data.frame()

for(hicfile_path in hicfile_paths){
  output_path<-paste0(outdir,'/',gsub("^(.*[\\/])", "",gsub('.hic','.txt.gz',hicfile_path)))

  #generate gi_list instance
  gi_list<-generate_bintolen_gi_list(bintolen_path=paste0(outdir,"/hg38_50kb_GATC_bintolen.txt.gz"),gen="Hsapiens",gen_ver="hg38")
  gi_list<-add_hic_counts(gi_list,hic_path = hicfile_path)

  #expand features for modeling
  gi_list<-expand_1D_features(gi_list)
  #run HiC-DC+ on 2 cores
  set.seed(1010)
  gi_list<-HiCDCPlus(gi_list,ssize=0.1)


  for (i in seq(length(gi_list))){
    indexfile<-unique(rbind(indexfile, as.data.frame(gi_list[[i]][gi_list[[i]]$qvalue<=0.05])[c('seqnames1', 'start1','start2')]))
  }

  #write results to a text file
  gi_list_write(gi_list,fname=output_path)
}


#save index file---union of significants at 50kb
colnames(indexfile)<-c('chr','startI','startJ')
data.table::fwrite(indexfile, paste0(outdir,'/GSE131651_analysis_indices.txt.gz'),sep='\t',row.names=FALSE,quote=FALSE)


#Differential analysis using modified DESeq2 (see ?hicdcdiff)
hicdcdiff(input_paths=list(NSD2=c(paste0(outdir,'/GSE131651_NSD2_LOW_arima_example.txt.gz'),
                                  paste0(outdir,'/GSE131651_NSD2_HIGH_arima_example.txt.gz')),
                           TKO=c(paste0(outdir,'/GSE131651_TKOCTCF_new_example.txt.gz'),
                                 paste0(outdir,'/GSE131651_NTKOCTCF_new_example.txt.gz'))),
          filter_file=paste0(outdir,'/GSE131651_analysis_indices.txt.gz'),
          output_path=paste0(outdir,'/diff_analysis_example/'),
          fitType = 'mean',
          binsize=50000,
          diagnostics=TRUE)

