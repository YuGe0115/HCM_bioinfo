#!/usr/bin/zsh
# 这是一个Zsh脚本，使用Zsh作为解释器
# 功能：处理VCF（Variant Call Format）文件，进行变体注释和过滤

ref_path=/data/public/Reference

singularity exec /home/public/singularity/ensembl-vep.sif vep \
    --offline --cache --dir_cache ${ref_path}/VEP     # 使用离线模式和缓存
    --species homo_sapiens_merged/113_GRCh38 --assembly GRCh38  # 指定人类GRCh38基因组
    --dir_plugins ${ref_path}/VEP/plugins             # 插件目录
    --gencode_basic --exclude_predicted --pick        # 使用基础Gencode注释，排除预测结果，选择最佳注释
    --max_af --hgvs --symbol --numbers --total_length  # 添加最大等位基因频率、HGVS记法、基因符号等
    --sift b --polyphen b               # 包含SIFT和PolyPhen预测（both）
    --vcf --stats_text                                # 输出VCF格式和统计文本
    # 加载各种功能预测插件
    --plugin AlphaMissense,file=${ref_path}/AlphaMissense/AlphaMissense_hg38.tsv.gz 
    --plugin CADD,${ref_path}/CADD/whole_genome_SNVs_inclAnno.tsv.gz,${ref_path}/CADD/gnomad.genomes.r4.0.indel_inclAnno.tsv.gz 
    --plugin Conservation,${ref_path}/Conservation_release-113/gerp_conservation_scores.homo_sapiens.GRCh38.bw 
    --plugin dbscSNV,${ref_path}/dbscSNV/dbscSNV1.1_GRCh38.txt.gz 
    --plugin DisGeNET,file=/data/merlin/Reference/DisGeNET/all_variant_disease_pmid_associations_final.tsv.gz 
    --plugin pLI,${ref_path}/ExACpLI/ExACpLI_values.txt 
    --plugin LoFtool,${ref_path}/LoFtool/LoFtool_scores.txt 
    --plugin dbNSFP,${ref_path}/dbNSFP/dbNSFP4.9a_grch38.gz,MutationTaster_pred,Polyphen2_HDIV_pred,LRT_pred,MutationAssessor_pred,PROVEAN_pred 
    --input_file /data/yuge/0523new_try/vcf_merge/all_samples_merged.vcf.gz               # 输入文件
    --output_file /data/yuge/0523new_try/vcf_merge/all_samples_merged_annotated.vcf.gz  # 输出注释后的VCF
    --stats_file /data/yuge/0523new_try/vcf_merge/all_samples_merged_annotated.stats.txt       # 统计文件
    --fork 4