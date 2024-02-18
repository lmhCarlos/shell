# xargs命令

xargs 命令紧跟在管道操作符之后，以标准输入作为主要的元数据流，并使用stdin并通过提供命令行参数来执行其他命令

```
comand | xargs
```



## 1. 将多行输入转化成单行输入

~~~
cat hello.txt | args
~~~



![image-20240218233947211](/Users/apple/Library/Application Support/typora-user-images/image-20240218233947211.png)



## 2. 将单行输入转化成多行

-n 代表每行的最大参数个数

~~~shell
cat Hello.txt | xargs -n 3
~~~



![image-20240218233837711](/Users/apple/Library/Application Support/typora-user-images/image-20240218233837711.png)



### 3.用自定义定界符来分割参数

-d选项为输入一个定制的定界符

结合-n选项，将输入划分为多行，而每行包行两个参数

![image-20240218235004721](/Users/apple/Library/Application Support/typora-user-images/image-20240218235004721.png)



#### 4.读取stdin，将格式化参数是传递给命令

定义一个文件read.txt, 格式如下图所示：

定义一个脚本cecho.sh, 脚本内容时 $*'#',内容被传进去后，打印参数以#号结尾；

-I 指定一个替换字符串；

![image-20240219002454630](/Users/apple/Library/Application Support/typora-user-images/image-20240219002454630.png)



