# [HiCExplorer] + [HiC-DC+] 
## Members
* 陳韋翰, 109753144


## Demo 
**Note that the follwing script doesn't provide paring arguments, so the file path used in scripts may need to bi modified manually !**
### Align sequencing data on the reference genome 
```R
bash dm3/align.sh
```
### Run Hi-C process and call TADs (using HiCExplorer package) 
```R
bash dm3/build.sh
```
### Call siginificant interactions and differential analysis (using HiC-DC+ package)
```R
Rscript
```


## Folder description

### docs
slides
### dm3
***All BWA and HiCexplorer file.***Include scripts, data, output file, output image.
* align  -  all BWA alignment input data, output data
* contact_matrix  -  all Hi-C matrix-related files, include .h5 file and contact map image 
* QC - output QC file from the process of building Hi-C matrix 
* TAD - all TAD-related files
* extend_data - other data used in ploting TAD image

### code
### result

## Dependency

## References
* BWA usage guild : http://starsyi.github.io/2016/05/24/BWA-%E5%91%BD%E4%BB%A4%E8%AF%A6%E8%A7%A3/
* HiCExlorer official documents : https://hicexplorer.readthedocs.io/en/latest/
* HiCExplorer example with dm3 : https://galaxyproject.github.io/training-material/topics/epigenetics/tutorials/hicexplorer/tutorial.html
* HiC-DC+ official documents and example usage : https://bitbucket.org/leslielab/hicdcplus/src/master/
* HiC-CD+ paper : https://www.nature.com/articles/s41467-021-23749-x
