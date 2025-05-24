#!/bin/bash

# 运行 Sarek 工作流的 Nextflow 命令
nextflow run /home/public/nextflow/nf-core-sarek_3.5.1/3_5_1 \
    -profile singularity \
    --input /scratch/yuge/HCM_bioinfo/samplesheet.csv \
    --outdir /data/yuge/0523new_try \
    --genome GATK.GRCh38 \
    --igenomes_base /data/public/Reference/igenomes \
    --wes \
    --intervals /data/public/Reference/Intervals/gencode.v43.annotation_exons_chrM_100bp_slopped.bed \
    --tools deepvariant \
    -resume