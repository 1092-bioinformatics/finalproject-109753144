# [HiCExplorer] + [HiC-DC+] 
## Members
* 陳韋翰, 109753144

<br /><br />
## Demo 
>Note that the follwing script doesn't provide paring arguments, so the file path used in scripts may need to bi modified manually !
#### Align sequencing data on the reference genome 
```R
bash dm3/align.sh
```
#### Run Hi-C process and call TADs (using HiCExplorer package) 
```R
bash dm3/build.sh
```
#### Call siginificant interactions(using HiC-DC+ package)
```R
Rscript hicdcpro/R/sig_inter.R
```
#### Call TADs (using HiC-DC+ package)
```R
Rscript hicdcpro/R/TAD.R
```
#### Perform differential analysis (using HiC-DC+ package)
```R
Rscript hicdcpro/R/diff_inter.R
```

<br /><br />
## Folder description
This section describe main folders and its subfolders 
### docs
* slides
* img - image used in slides (these image also have its copy in there source folder)
### dm3
All BWA and HiCexplorer file.Include scripts, data, output file, output image.
* align  -  all BWA alignment input data, output data
* contact_matrix  -  all Hi-C matrix-related files, include .h5 file and contact map image 
* QC - output QC file from the process of building Hi-C matrix 
* TAD - all TAD-related files
* extend_data - other data used in ploting TAD image

### hicdcplus
All HiC-DC+ file.Include scripts, data, output file, output image.
* R - all scripts
* data - all data include inputs and outputs 
* diff_analysis_example - files output from differentail anaysis
* img - image plot by **JuiceBox**

<br /><br />
## Dependency 
- for bwa (install guide see Reference 1.)
	- bwa 0.7.17
- for HiCExplorer (install guide see Reference 2.)
	- python 3.8.10
	- hicexplorer 3.6
- for HiC-DC+ (install guide see Reference 4.)
	- R 4.1.0
	- Bioconductor (BiocManager) 3.13
	- HiCDCPlus 1.0.0
<br /><br />
## References
1. BWA usage guild :
	 http://starsyi.github.io/2016/05/24/BWA-%E5%91%BD%E4%BB%A4%E8%AF%A6%E8%A7%A3/
2. HiCExlorer official documents :
	 https://hicexplorer.readthedocs.io/en/latest/
3. HiCExplorer example with dm3 :
	 https://galaxyproject.github.io/training-material/topics/epigenetics/tutorials/hicexplorer/tutorial.html
4. HiC-DC+ official documents and example usage :
	 https://bitbucket.org/leslielab/hicdcplus/src/master/
5. HiC-CD+ paper :
	 https://www.nature.com/articles/s41467-021-23749-x
