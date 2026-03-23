将一个大文件按固定字符及某一字符串范围拆分成多个小文件
```
# 打开文件  
file = open("T18class.txt","r")  
target_char = ">"  
max_distance = 5600000  
content = file.read()  
file.close()  
def xun(xun1):  
    start_index = xun1  
    end_index = content.find(target_char, start_index + max_distance)  
    sums = end_index + max_distance  
    if sums<len(content):  
        middle_content = content[start_index :end_index]  
        filename=str(start_index)+"~"+str(end_index)+".txt"  
        with open(filename, 'w', encoding='utf-8') as fp:  
            fp.write(middle_content)  
        fp.close()  
        xun(end_index)  
    else:  
        other=content[end_index:]  
        ilename = str(end_index-max_distance)+"~"+str(len(content)) + ".txt"  
        with open(ilename, 'w', encoding='utf-8') as fp:  
            fp.write(other)  
        fp.close()  
xun(0)
```
