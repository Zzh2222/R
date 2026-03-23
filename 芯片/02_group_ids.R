# Group(实验分组)和ids(探针注释)
rm(list = ls())  
load(file = "step1output.Rdata")
# 1.Group----
library(stringr)
# 标准流程代码是二分组，多分组数据的分析后面另讲
#⭐要修改的地方：分组信息,必须学会ifelse和str_detect
k = str_detect(pd$title,"Normal");table(k) #不在title就在pd的其他列
Group = ifelse(k,"Normal","Disease")

# 需要把Group转换成因子，并设置参考水平，指定levels
#⭐要修改的地方，对照组在前，处理组在后
Group = factor(Group,levels = c("Normal","Disease"))
Group

#⭐检查自己得到的分组是否正确
data.frame(pd$title,Group)
#2.探针注释的获取-----------------
#四种方法，方法1里找不到就从方法2找，以此类推。
#方法1 BioconductorR包(最常用)
#⭐要操作的地方
library(tinyarray)
gpl_number #首先看看编号是多少
#View(pkg_all) 
#然后在pkg_all里搜索gpl编号，找到对应的R包前缀(第二列)，没搜到就是没有R包,再看方法2。
#也可以用代码直接得到对应的R包前缀：
pkg_all[pkg_all$gpl==gpl_number,2]
#⭐要操作的地方
#用上面找到的前缀替换下面所有的hgu133plus2，共5处
if(!require(hgu133plus2.db))BiocManager::install("hgu133plus2.db",ask = F,update = F)
library(hgu133plus2.db)
ls("package:hgu133plus2.db") #列出R包里都有啥
ids <- toTable(hgu133plus2SYMBOL) #把R包里的注释表格变成数据框
# 方法2 下载并读取GPL网页的表格文件，按列取子集
#⭐要操作的地方
library(tinyarray)
get_gpl_txt(gpl_number) #获取表格文件的下载链接
# 接下来是复制网址去浏览器下载、放在工作目录下、读取、提取探针id和基因symbol(没有现成的需要拆分和转换)，不同文件代码不统一，等看同学们的例子。
# 注意:最终的数据ids只能有两列，第一列列名是probe_id,第二列列名是symbol,且都是字符型，否则后面代码要报错咯。
# 方法3 官网下载注释文件并读取
# 方法4 自主注释，了解一下
#https://mp.weixin.qq.com/s/mrtjpN8yDKUdCSvSUuUwcA

#⭐检查自己的探针注释是否正确,全部是TRUE或者绝大多数是TRUE，就是正确的。
table(ids$probe_id %in% rownames(exp))

save(exp,Group,ids,file = "step2output.Rdata")

#比较复杂的探针注释参考资料
#资料1：拆分取列https://www.yuque.com/xiaojiewanglezenmofenshen/kzgwzl/sv262capcgg9o8s5
#资料2：多种id的转换https://www.yuque.com/xiaojiewanglezenmofenshen/kzgwzl/pn0s1mmsaxocfynb?singleDoc# 《又一个有点难的探针注释（多种id的转换）》
