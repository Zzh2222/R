rm(list = ls())
#打破下载时间的限制,改前60秒，改后10w秒
options(timeout = 100000) 
options(scipen = 20)#不要以科学计数法表示

#传统下载方式
library(GEOquery)
eSet = getGEO("GSE7305", destdir = '.', getGPL = F)
#网速太慢，下不下来怎么办
#1.从网页上下载/发链接让别人帮忙下，放在工作目录里
#2.试试geoChina,只能下载2019年前的表达芯片数据
#library(AnnoProbe)
#eSet = geoChina("GSE7305") #选择性代替第8行
#研究一下这个eSet
class(eSet)
length(eSet)

eSet = eSet[[1]] 
class(eSet)

#(1)提取表达矩阵exp
exp <- exprs(eSet)
#⭐第一个要检查的地方👇，表达矩阵行列数，正常是几万行，列数=样本数，
#如果0行说明不是表达芯片或者是遇到特殊情况，不能用此流程分析
dim(exp)
#⭐二个要检查的地方👇
range(exp)#看数据范围决定是否需要log，是否有负值，异常值，如有负值，结合箱线图进一步判断
#⭐可能要修改的地方👇
exp = log2(exp+1) #需要log才log，不需要log要注释掉这一句
#⭐第三个要检查的地方👇
boxplot(exp,las = 2) #看是否有异常样本

#(2)提取临床信息
pd <- pData(eSet)
#⭐多分组中提取两分组的代码示例，二分组不需要
if(F){
  library(stringr)
  #因为现在这个例子不是多分组，所以编造一列做示例。
  pd$fake = paste0(rep(c("a","b","c","d"),each = 5),1:5)
  k1 = str_detect(pd$fake,"b");table(k1)
  k2 = str_detect(pd$fake,"c");table(k2)
  pd = pd[k1|k2,]
}
#(3)让exp列名与pd的行名顺序完全一致
p = identical(rownames(pd),colnames(exp));p
if(!p) {
  s = intersect(rownames(pd),colnames(exp))
  exp = exp[,s]
  pd = pd[s,]
}

#(4)提取芯片平台编号，后面要根据它来找探针注释
gpl_number <- eSet@annotation;gpl_number
save(pd,exp,gpl_number,file = "step1output.Rdata")

# 原始数据处理的代码，按需学习
# https://mp.weixin.qq.com/s/0g8XkhXM3PndtPd-BUiVgw
