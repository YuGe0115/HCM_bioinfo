#!/usr/bin/zsh
# 这是一个Zsh脚本，使用Zsh作为解释器
# 功能：处理VCF（Variant Call Format）文件，进行变体注释和过滤

ref_path=/data/public/Reference

singularity exec /home/public/singularity/ensembl-vep.sif vep \
  --cache \
  --merged \
  --dir_cache ${ref_path}/VEP \
  --species homo_sapiens \
  --cache_version 113 \
  --assembly GRCh38 \
  --dir_plugins ${ref_path}/VEP/plugins \
  --gencode_basic \
  --exclude_predicted \
  --pick \
  --max_af \
  --hgvs \
  --symbol \
  --numbers \
  --total_length \
  --sift b \
  --polyphen b \
  --vcf \
  --stats_text \
  --plugin CADD,${ref_path}/CADD/whole_genome_SNVs_inclAnno.tsv.gz,${ref_path}/CADD/gnomad.genomes.r4.0.indel_inclAnno.tsv.gz \
  --plugin Conservation,${ref_path}/Conservation_release-113/gerp_conservation_scores.homo_sapiens.GRCh38.bw \
  --plugin dbscSNV,${ref_path}/dbscSNV/dbscSNV1.1_GRCh38.txt.gz \
  --plugin pLI,${ref_path}/ExACpLI/ExACpLI_values.txt \
  --plugin LoFtool,${ref_path}/LoFtool/LoFtool_scores.txt \
  --plugin Phenotypes,/data/yuge/0523new_try/Phenotypes/Phenotypes.pm_homo_sapiens_113_GRCh38.gvf.gz \
  --plugin dbNSFP,${ref_path}/dbNSFP/dbNSFP4.9a_grch38.gz,MutationTaster_pred,Polyphen2_HDIV_pred,LRT_pred,MutationAssessor_pred,PROVEAN_pred \
  --input_file /data/yuge/0523new_try/vcf_merge/all_samples_merged.vcf.gz \
  --output_file /data/yuge/0523new_try/vcf_merge/all_samples_merged_annotated.vcf.gz \
  --compress_output bgzip \
  --stats_file /data/yuge/0523new_try/vcf_merge/all_samples_merged_annotated.stats.txt \
  --fork 4