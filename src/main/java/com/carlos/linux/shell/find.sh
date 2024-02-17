#! /bin/bash

find的用法

列出当前目录下所有的目录或者文件
find base_path
find /usr/tmp/test
# .表示当前目录
find .

根据文件名或者正则表达式匹配
# 查询/usr/tmp/test下以名称匹配所有 “.txt”为后缀的文件（-name）
find /usr/tmp/test -name "*.txt" --print
# 查询/usr/tmp/test下以名称不匹配 “.txt”为后缀的文件（-name）
find /usr/tmp/test ! -name "*.txt" --print
# 查询/usr/tmp/test下以名称匹配所有 “hello”为前缀的文件，并忽略大小写（-name）
find /usr/tmp/test -iname "hello*" --print
#多条件匹配 -o代表or，\( 和 \) 将内部的内容视为一个整体
find /usr/tmp/test \( -name "*.txt" -o  -name "*.pdf" \) -print

# 查询/usr/tmp/test下以名称匹配所有包含“test”的文件路径 或者 文件（-path）
find /usr/tmp/test -path "test*" --print

# 正则表达式匹配 在当前目录下.py 或者 .sh 结尾的文件
find . -regex ".*\(\.py\ | \.sh\)$"
# 正则表达式匹配 在当前目录下.py 或者 .sh 结尾的文件,并忽略大小写
find . -iregex ".*\(\.py\ | \.sh\)$"


根据文件类型搜索
#只列出所有目录
find . -type d -print
#只列出普通文件
find . -type f -print
#只列出链接
find . -type l -print

type类型   参数
普通文件     f
符号链接     l
目录        d
字符设备     c
块设备       b
套接字       s
Fifo        p

根据深度搜索
#允许查询当前目录下最多一个深度内查找
find . -maxdepth 1 -type f -print
#允许查询当前目录下最少从2个深度开始查找
find . -mindeptj 2 -type f -print

根据文件时间进行搜索
#三种时间戳（时间单位是天）
-atime 用户最近一次访问文件的时间
-mtime 文件内容最后一次被修改的时间
-ctime 文件元数据（metadata，例如权限或者所有权）最后一次被修改的时间

#打印最近七天内被访问过的所有文件（-表示小于，+表示大于）
find . -type f -atime -7 -print
#打印出恰好在七天前被访问过的所有文件
find . -type f -atime 7 -print
#打印出所有文件时间超过7天的所有文件
find . -type f -atime +7 -print

-amin （访问时间）
-mmin （修改时间）
-cmin （变化时间）

#打印出访问时间超过7分钟的所有文件
find . -type f -amin +7 -print

#找出比参考文件修改时间更长的文件(-newer)
find . -type f -newer file.txt --print

根据文件大小搜索
b 块
c 字节
w 字（2字节）
k 千字节
M 兆字节
G 吉字节

#搜索大于2k的文件
find . -type f -size +2k
#搜索小于2k的文件
find . -type f -size -2k
#搜索等于2k的文件
find . -type f -size 2k

删除匹配文件
#删除当前目录下所有以".swp"结尾的文件
find  . -type f -name "*.swp" -delete

基于文件取消权限和所有全匹配
#打印出权限为644的文件
find . -type f -perm 644 --print
#打印出用户名或者用户id是carlos的文件
find . -type f -user carlos -print

结合find 执行命令或动作
#将root用户的所有权变更成另一个用户 {}是一个特殊的字符串，对于每一个匹配的文件，会被替换成响应的文件名；
find . -type f -user root -exec chown slynux {} \;
#将当前目录下所有的c文件拼接起来写入单个文件all_c_file.txt,然后执行cat命令
find . -type f -name "*.c" -exec cat {} \;>all_c_file.txt
#将10天前的“.txt”文件复制到OLD目录中
find . -type f -mtime +10 -name "*.txt" -exec cp {} OLD \;

技巧：在执行多个命令时，可以写到一个shell脚本中
-exec ./commands.sh {} \;
#打印
find . -type f -mtime +10 -name "*.txt" -exec printf "text file: %s\n" {} \;
#find跳过某个特定的目录
find devel/source_path \( -name ".git" -prune \) -o \( -type f -print \)




