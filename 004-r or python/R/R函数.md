`R`
## for循环
```
gene <- c(10,20,10)
gene_total <- 0
for (i in gene){
gene_total <- gene_total+i
}
```
## 函数
帮助文档使用’？‘加函数名
```

c()#创建向量，向量与表格从1开始数，列表从0开始和python一样
gene[c(3,5)]#向量取值，从gene中取第三个和第五个元素
sum(gene)#求和
max()#最大值
sd()#标准差
mean()#平均值
sum(gene,na.rm = TRUE)#表示遇到NA的数据的参数会删除
cor()#计算相关性
round(gene,digits = 2)#保留两位有效小数,=0时取整
read.table(file = '路径'，header = TRUE,row.names = 1,sep = '\t')#读取文件
write.table(gene,file = '需要保存的文件路径和名字'，sep = '\t',quote =FALSE#是否取消引号)#csv文件固定分割符为','可以用Excel打开，写为write.csv()
data.frame()#创建表格
dev.off()#
```
## 其他
```
getwd()#打印绝对路径
```

## select函数
```
## R语言删除某列
library(dplyr)
## 按索引删除(删除第三列，注意负号，不加负号表示仅保存这列)
data <- select(data,-3)相当于data[,-3]

## 按列名删除单列
data <- select(data,-lieming)
## 按列名删除多列
data <- select(data,-c(lieming1,lieming2))
## 选择包含"a"的列
select(d, contains("a"))
```
