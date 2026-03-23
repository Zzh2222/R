rm(list = ls())  
options(timeout = 100000) 
load(file = 'step4output.Rdata')
library(clusterProfiler)
library(ggthemes)
library(org.Hs.eg.db)
library(dplyr)
library(ggplot2)
library(stringr)
library(enrichplot)

#(1)输入数据
gene_diff = deg$ENTREZID[deg$change != "stable"] 

#(2)富集
#⭐下面的三句都要注意物种
ekk <- enrichKEGG(gene = gene_diff,organism = 'hsa')
#其他物种https://www.genome.jp/kegg/catalog/org_list.html
ekk <- setReadable(ekk,OrgDb = org.Hs.eg.db,keyType = "ENTREZID")
#如果ekk是空的，这句就会报错，因为没富集到任何通路。
ego <- enrichGO(gene = gene_diff,OrgDb= org.Hs.eg.db,
                ont = "ALL",readable = TRUE)
#setReadable和readable = TRUE都是把富集结果表格里的基因名称转为symbol
class(ekk)

#(3)可视化
#barplot可以换成dotplot
barplot(ego, split = "ONTOLOGY") + 
  facet_grid(ONTOLOGY ~ ., space = "free_y",scales = "free_y") 
barplot(ekk)
#如果ekk中没有padj<0.05的通路，就会报错，因为默认只画padj<0.05,没有参数


# 更多资料---
# GSEA：https://www.yuque.com/docs/share/a67a180f-dd2b-4f6f-96c2-68a4b86fe862?#
# Y叔的书：http://yulab-smu.top/clusterProfiler-book/index.html
# GOplot：https://mp.weixin.qq.com/s/LonwdDhDn8iFUfxqSJ2Wew
# 网上的资料和宝藏无穷无尽，学好R语言慢慢发掘~
