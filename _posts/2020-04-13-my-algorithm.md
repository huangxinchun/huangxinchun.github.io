---
layout:     post                    # 使用的布局（不需要改）
title:      数据结构与算法总结              # 标题
subtitle:   坚持坚持再坚持      #副标题
date:       2020-04-13              # 时间
author:     hxc                      # 作者
header-img:    #这篇文章标题背景图片
catalog: true                       # 是否归档
categories: 数据结构与算法
tags:                               #标签
    - 数据结构与算法
---
# 我的数据结构与算法整理

[TOC]

# 一. 基础概念

数据结构：是指数据相互之间存在`一种`或`多种`特定关系的`数据元素的集合`用计算机`存储`、`组织`数据的方式。数据结构分别为`逻辑结构`、（存储）`物理结构`和`数据的运算`三个部分。

![图](https://shenxiaozi007.github.io/HxcBlog/images/imagesAlgorithm/shuju1.png)
  
## 1 数据结构概述

数据结构的主要任务是通过`分析数据对象`的结构特征，包括`逻辑结构`及`数据对象之间的关系`，然后把`逻辑结构`表示成`计算机能实现的物理结构`，从而便于计算机`处理`。
### 1.1 概念术语

1. 数据（Data）是能被计算机处理的`符号`或`符号集合`，含义广泛，可理解为“原材料”。如字符、图片、音视频等。

2. 数据元素（data element）是`数据的基本单位`。例如一张学生统计表。

3. 数据项（data item）`组成数据元素`的`最小单位`。例如一张学生统计表，有编号、姓名、性别、籍贯等数据项。

4. 数据对象（data object）是性质相同的`数据元素的集合`，是数据的一个子集。例如正整数N={1，2，3，····}。

5. 数据结构（data structure）是`数据的组织形式`，数据元素之间存在的一种或多种特定关系的数据元素集合。

6. 数据类型（data type）是按照`数据值的不同`进行划分的可操作性。在C语言中还可以分为原子类型和结构类型。原字类型是不可以再分解的基本类型，包括`整型`、`浮点型`、`字符型`等。结构类型是由若干个类型组合而成，是可以再分解的。
下图展示出他们之间的关系：

![图](https://shenxiaozi007.github.io/HxcBlog/images/imagesAlgorithm/shuju2.png)

### 1.2 数据的逻辑结构

系统的逻辑结构（logical structure）是从`思想的角度`上对`系统分类`，把`系统`分成`若干个逻辑单元`，`不同逻辑单元`分别实现自己的功能。数据的逻辑结构是对`数据之间关系的描述`，有时就把`逻辑结构`简称为`数据结构`，数据的逻辑结构分为以下四种：

1. 集合结构：集合结构的集合中任何两个数据元素之间都没有`逻辑关系`，组织形式松散,仅仅是因为他们挤在一个被称作“集合”的盒子里。

![图](https://shenxiaozi007.github.io/HxcBlog/images/imagesAlgorithm/shuju3.png)

2. 线性结构：线性的数据元素结构关系是`一对一`的，并且是`有序的`，就像a-b-c-d-e-f-g·····被一根线穿连起来。常用的线性结构：数组、栈、队列、字符串、线性表。

![图](https://shenxiaozi007.github.io/HxcBlog/images/imagesAlgorithm/shuju4.png)

3.树形结构：树状结构是一个或多个节点的有限集合,也就是一对多的关系。

![图](https://shenxiaozi007.github.io/HxcBlog/images/imagesAlgorithm/shuju5.png)

4. 图结构：图的数据元素结构关系是`多对多`的。就是我们常见的各大城市的铁路图，一个城市有很多线路连接不同城市。

![图](https://shenxiaozi007.github.io/HxcBlog/images/imagesAlgorithm/shuju6.png)

### 1.3 数据的存储（物理）结构

`存储结构`（storage structure）也称为`物理结构`（physical structure），指的是数据的`逻辑结构`在计算机中的`存储形式`。数据的存储结构一般可以反映`数据元素之间的逻辑关系`。分为`顺序存储结构`和`链式存储结构`。

1. 顺序存储结构：顺序存储方法它是把`逻辑上相邻的结点`存储在`物理位置相邻`的存储单元里，结点间的`逻辑关系`由`存储单元的邻接关系`来体现，由此得到的存储表示称为顺序存储结构。

![图](https://shenxiaozi007.github.io/HxcBlog/images/imagesAlgorithm/shuju7.png)

2. 链式存储结构：是把数据元素存放在`任意的存储单元`里，这组存储单元可以是`连续的`，也可以是`不连续的`，数据元素的存储关系并`不能`反映其`逻辑关系`，因此需要借助`指针`来表示`数据元素之间的逻辑关系`。

![图](https://shenxiaozi007.github.io/HxcBlog/images/imagesAlgorithm/shuju8.png)

> 小结：数据的逻辑结构和物理结构是密切相关的，在学习数据的过程中会发现，任何一个算法的设计取决于选定的数据逻辑结构，而算法的实现依赖于所采用的存储结构。

### 1.4 抽象数据类型

- 概念
抽象数据类型（abstract data type，ADT）是描述具有某种`逻辑关系的数据模型`，并对在数学模型上进行的`一组操作`。抽象数据类型描述的是`一组逻辑上的特性`，与在计算机内部表示无关，计算机中的`整数数据类型`是一个`抽象数据类型`，不同处理器可能实现方法不同，但其逻辑特性相同，即加、减、乘、除等运算是一致的。`“抽象”`的意思是`数据类型的数学抽象特性`而不是指它们的`实现方法`。抽象数据类型体现了程序设计中的问题分解、抽象、信息隐藏等特性，可以把现实中的大问题分解为多个规模小且容易处理的小问题，然后建立起一个能被计算机处理的数据，并把每个功能模块的实现细节作为一个独立的单元，从而使具体实现过程隐藏起来。就`类似建一栋房子`，分成若干个小任务，如地皮规划、图纸设计、施工、装修等，整个过程与抽象数据类型中的问题分解类似。而搬砖人不需要了解图纸设计如何，设计图纸人员不需要了解施工的地基、砌墙的具体细节，装修工人不用关系图纸和搬砖过程，这就是抽象类型中的信息隐藏。

- 案例
抽象数据类型的概念可能让初学者不太容易理解。例如`线性表的抽象`数据类型的描述数据对象集合：线性表的数据对象集合为{a1,a2,a3,····,an},每个元素的`类型均为DataType`。其中，除了第一个元素a1外，每一个元素有且只有一个直接前驱元素；除了最后一个元素an外，每一个元素有且只有一个直接后继元素。数据元素之间的关系是一对一的。

### 1.5 数据结构与算法

算法（algorithm）是解决特定问题求解步骤的描述，在计算机中表现为有限的操作序列。在数据类型建立起来之后，就要对这些数据类型进行操作，建立起运算的集合即程序。运算的建立、方法好坏直接决定着计算机程序原型效率的高低。

- 数据结构和算法的关系, 两者既有联系又有区别。
   1. 联系是:程序=算法+数据结构。`数据结构`是`算法实现的基础`，算法总是要`依赖某种数据结构来实现`的。算法的`操作对象`是`数据结构`。
   2. 区别是:数据结构关注的是数据的`逻辑结构`、存储结构等一些基本操作，而算法更多的是关注如何在`数据结构的基本上`解决实际问题。算法是`编程思想`，数据结构则是这些`思想的基础`。
   
如图:

![图](https://shenxiaozi007.github.io/HxcBlog/images/imagesAlgorithm/shuju9.png)

- 算法的五大特性
   1. 有穷性，是指算法在执行有限的步骤之后，自动结束而不是出现无限循环，并且每一个步骤在可接受的时间内完成。

   2. 确定性，是指算法执行的每一步骤在一定条件下只有一条执行路径，也就是相同输入只能有一个唯一的输出结果。

   3. 可行性，是指算法每一步骤都必须可行，能够通过有限的执行次数完成。

   4. 输入，是指算法具有零个或多个输入。

   5. 输出，是指算法至少有一个或多个输出。
   
- 数据结构算法设计要求
    1. 正确性
    2. 可读性
    3. 健壮性
    4. 时间效率高和储存量低
    
### 1.6 时间复杂度

在进行算法分析时，语句总是执行次数 T(n) 是关于问题规模 n 的函数。进而分析次数T(n)随规模n的变化情况并确定T(n)的数量级。算法的时间复杂度就是算法的时间度量，记作T(n) = O（f（n））。它表示随问题规模n的增大，算法的执行时间的增长率和f（n）的增长率相同，称作算法的渐进时间复杂度，简称为时间复杂度。其中，f（n）是问题规模n的某个函数。

算法的时间复杂度是衡量一个算法好坏的重要指标。一般情况下，随着规模n的增大，次数T(n)的增长较慢的算法为最优算法。常见时间复杂度从小到大依次排列：O(1) < O(log2n) < O(n) < O(n²）<O(n³) ····<O(n!)

常见的算法复杂度
- 常数阶
```
//1常数阶   执行3次。O(1)
void testNum1(int n){
    int sum = 0 ;//执行一次
    sum = (n+1)*n/2; //执行一次
    printf("sum=%d\n",sum);//执行一次
}
```
- 线性阶
```
//x=x+1; 执行n次 O(n)
void add2(int x,int n){
    for (int i = 0; i < n; i++) {
        x = x+1;
    }
}

```

- 平方阶

```
//x=x+1; 执行n*n次 ->O(n^2)
void add3(int x,int n){
    for (int i = 0; i< n; i++) {
        for (int j = 0; j < n ; j++) {
            x=x+1;
        }
    }
}
```

- 对数阶

```
/* 2的x次方等于n x = log2n  ->O(logn)*/
void testA(int n){
    int count = 1;         //执行1次
    //n = 10
    while (count < n) {
        count = count * 2;
    }
}

```

- 立方阶

```
void testB(int n){
    int sum = 1;                         //执行1次
    for (int i = 0; i < n; i++) {        //执行n次
        for (int j = 0 ; j < n; j++) {   //执行n*n次
            for (int k = 0; k < n; k++) {//执行n*n*n次
                sum = sum * 2;          //执行n*n*n次
            }
        }
    }
}
```

![图](https://shenxiaozi007.github.io/HxcBlog/images/imagesAlgorithm/shuju10.png)


例如：
- 1;      // 时间复杂度为O(1)

- for(i =1 ; i<=n ;i++){  x= x+1;}    // 时间复杂度为O(n)，称为线性阶

- for(i =1 ; i<=n ; i++）{for(j=1;j<=n;j++){  x=x+1 } }  // 时间复杂度为O(n²),称为平方阶

![图](https://shenxiaozi007.github.io/HxcBlog/images/imagesAlgorithm/shuju11.png)

### 1.7 空间复杂度

空间复杂度（space complexity）作为算法所需存储空间的量度，记做S(n) = O (f(n))。其中，n为问题的规模；f（n）为语句关于n的所占存储空间的函数。

一般情况下，一个程序在机器上运行时，除了需要存储程序本身的指令、常数、变量和输入数据外，还需要存储对数据操作的存储单位。若输入数据所占空间只取决于问题本身，和算法无关，这样只需要分析该算法在实现时所需的辅助单元即可。若算法执行时所需的辅助空间相对于输入数据量而言是个常量，则称此算法为原地工作，空间复杂度为O(1)。


## 第一章 稀疏数组和队列
### 1 稀疏数组定义
#### 1.1 稀疏数组定义

当一个数组中`大部分`元素为０，或者为`同一个值`的`数组`时，可以使用`稀疏数组`来保存该数组。

稀疏数组的处理方法是:
- 记录数组一共有`几行几列`，有多少个`不同的值`
- 把具有不同值的元素的行列及值记录在一个小规模的数组中，从而缩小程序的规模

#### 1.2 应用实例

使用稀疏数组，来保留类似前面的二维数组(棋盘、地图等等)
把稀疏数组存盘，并且可以从新恢复原来的二维数组数

![图](https://shenxiaozi007.github.io/HxcBlog/images/imagesAlgorithm/alg1.png)
   
![图](https://shenxiaozi007.github.io/HxcBlog/images/imagesAlgorithm/alg2.png)

代码实现
```java
package com.atguigu.sparsearray;

public class SparseArray {

	public static void main(String[] args) {
		// 创建一个原始的二维数组 11 * 11
		// 0: 表示没有棋子， 1 表示 黑子 2 表蓝子
		int chessArr1[][] = new int[11][11];
		chessArr1[1][2] = 1;
		chessArr1[2][3] = 2;
		chessArr1[4][5] = 2;
		// 输出原始的二维数组
		System.out.println("原始的二维数组~~");
		for (int[] row : chessArr1) {
			for (int data : row) {
				System.out.printf("%d\t", data);
			}
			System.out.println();
		}

		// 将二维数组 转 稀疏数组的思
		// 1. 先遍历二维数组 得到非0数据的个数
		int sum = 0;
		for (int i = 0; i < 11; i++) {
			for (int j = 0; j < 11; j++) {
				if (chessArr1[i][j] != 0) {
					sum++;
				}
			}
		}

		// 2. 创建对应的稀疏数组
		int sparseArr[][] = new int[sum + 1][3];
		// 给稀疏数组赋值
		sparseArr[0][0] = 11;
		sparseArr[0][1] = 11;
		sparseArr[0][2] = sum;
		
		// 遍历二维数组，将非0的值存放到 sparseArr中
		int count = 0; //count 用于记录是第几个非0数据
		for (int i = 0; i < 11; i++) {
			for (int j = 0; j < 11; j++) {
				if (chessArr1[i][j] != 0) {
					count++;
					sparseArr[count][0] = i;
					sparseArr[count][1] = j;
					sparseArr[count][2] = chessArr1[i][j];
				}
			}
		}
		
		// 输出稀疏数组的形式
		System.out.println();
		System.out.println("得到稀疏数组为~~~~");
		for (int i = 0; i < sparseArr.length; i++) {
			System.out.printf("%d\t%d\t%d\t\n", sparseArr[i][0], sparseArr[i][1], sparseArr[i][2]);
		}
		System.out.println();
		
		//将稀疏数组 --》 恢复成 原始的二维数组
		/*
		 *  1. 先读取稀疏数组的第一行，根据第一行的数据，创建原始的二维数组，比如上面的  chessArr2 = int [11][11]
			2. 在读取稀疏数组后几行的数据，并赋给 原始的二维数组 即可.
		 */
		
		//1. 先读取稀疏数组的第一行，根据第一行的数据，创建原始的二维数组
		
		int chessArr2[][] = new int[sparseArr[0][0]][sparseArr[0][1]];
		
		//2. 在读取稀疏数组后几行的数据(从第二行开始)，并赋给 原始的二维数组 即可
		
		for(int i = 1; i < sparseArr.length; i++) {
			chessArr2[sparseArr[i][0]][sparseArr[i][1]] = sparseArr[i][2];
		}
		
		// 输出恢复后的二维数组
		System.out.println();
		System.out.println("恢复后的二维数组");
		
		for (int[] row : chessArr2) {
			for (int data : row) {
				System.out.printf("%d\t", data);
			}
			System.out.println();
		}
	}

}

```

### 2 队列
#### 2.1 队列定义

- 队列是一个`有序列表`，可以用`数组`或是`链表`来实现。
- 遵循`先入先出`的原则。即：先存入队列的数据，要先取出。后存入的要后取出
示意图：(使用数组模拟队列示意图)

![图](https://shenxiaozi007.github.io/HxcBlog/images/imagesAlgorithm/alg3.png)

#### 2.2 数组模拟队列

- 队列本身是有序列表，若使用数组的结构来存储队列的数据，则队列数组的声明如下图, 其中 maxSize 是该队列的最大容量。

- 因为队列的输出、输入是分别从前后端来处理，因此需要两个变量 front及 rear分别记录队列前后端的下标，front 会随着数据输出而改变，而 rear则是随着数据输入而改变，如图所示:

![图](https://shenxiaozi007.github.io/HxcBlog/images/imagesAlgorithm/alg4.png)

- 当我们将数据存入队列时称为”addQueue”，addQueue 的处理需要有两个步骤：思路分析 
    1. 将尾指针往后移：rear+1 , 当front == rear 【空】
    2. 若尾指针 rear 小于队列的最大下标 maxSize-1，则将数据存入 rear所指的数组元素中，否则无法存入数据。 rear  == maxSize - 1[队列满]

代码实现
- 出队列操作getQueue
- 显示队列的情况showQueue
- 查看队列头元素headQueue
- 退出系统exit

```java
package com.atguigu.queue;

import java.util.Scanner;

public class ArrayQueueDemo {

	public static void main(String[] args) {
		//测试一把
		//创建一个队列
		ArrayQueue queue = new ArrayQueue(3);
		char key = ' '; //接收用户输入
		Scanner scanner = new Scanner(System.in);//
		boolean loop = true;
		//输出一个菜单
		while(loop) {
			System.out.println("s(show): 显示队列");
			System.out.println("e(exit): 退出程序");
			System.out.println("a(add): 添加数据到队列");
			System.out.println("g(get): 从队列取出数据");
			System.out.println("h(head): 查看队列头的数据");
			key = scanner.next().charAt(0);//接收一个字符
			switch (key) {
			case 's':
				queue.showQueue();
				break;
			case 'a':
				System.out.println("输出一个数");
				int value = scanner.nextInt();
				queue.addQueue(value);
				break;
			case 'g': //取出数据
				try {
					int res = queue.getQueue();
					System.out.printf("取出的数据是%d\n", res);
				} catch (Exception e) {
					// TODO: handle exception
					System.out.println(e.getMessage());
				}
				break;
			case 'h': //查看队列头的数据
				try {
					int res = queue.headQueue();
					System.out.printf("队列头的数据是%d\n", res);
				} catch (Exception e) {
					// TODO: handle exception
					System.out.println(e.getMessage());
				}
				break;
			case 'e': //退出
				scanner.close();
				loop = false;
				break;
			default:
				break;
			}
		}
		
		System.out.println("程序退出~~");
	}

}

// 使用数组模拟队列-编写一个ArrayQueue类
class ArrayQueue {
	private int maxSize; // 表示数组的最大容量
	private int front; // 队列头
	private int rear; // 队列尾
	private int[] arr; // 该数据用于存放数据, 模拟队列

	// 创建队列的构造器
	public ArrayQueue(int arrMaxSize) {
		maxSize = arrMaxSize;
		arr = new int[maxSize];
		front = -1; // 指向队列头部，分析出front是指向队列头的前一个位置.
		rear = -1; // 指向队列尾，指向队列尾的数据(即就是队列最后一个数据)
	}

	// 判断队列是否满
	public boolean isFull() {
		return rear == maxSize - 1;
	}

	// 判断队列是否为空
	public boolean isEmpty() {
		return rear == front;
	}

	// 添加数据到队列
	public void addQueue(int n) {
		// 判断队列是否满
		if (isFull()) {
			System.out.println("队列满，不能加入数据~");
			return;
		}
		rear++; // 让rear 后移
		arr[rear] = n;
	}

	// 获取队列的数据, 出队列
	public int getQueue() {
		// 判断队列是否空
		if (isEmpty()) {
			// 通过抛出异常
			throw new RuntimeException("队列空，不能取数据");
		}
		front++; // front后移
		return arr[front];

	}

	// 显示队列的所有数据
	public void showQueue() {
		// 遍历
		if (isEmpty()) {
			System.out.println("队列空的，没有数据~~");
			return;
		}
		for (int i = 0; i < arr.length; i++) {
			System.out.printf("arr[%d]=%d\n", i, arr[i]);
		}
	}

	// 显示队列的头数据， 注意不是取出数据
	public int headQueue() {
		// 判断
		if (isEmpty()) {
			throw new RuntimeException("队列空的，没有数据~~");
		}
		return arr[front + 1];
	}
}

```
#### 2.3 数组模拟环形队列

对前面的数组模拟队列的优化，充分利用数组.因此将数组看做是一个环形的。(通过取模的方式来实现即可)
![图](https://shenxiaozi007.github.io/HxcBlog/images/imagesAlgorithm/alg6.png)

- 尾索引的下一个为头索引时表示队列满，即将队列容量空出一个作为约定,这个在做判断队列满的时候需要注意 (rear + 1) % maxSize == front 满] 
- rear == front [空]

测试示意图:
![图](https://shenxiaozi007.github.io/HxcBlog/images/imagesAlgorithm/alg5.png)

代码实现
```
package com.atguigu.queue;

import java.util.Scanner;

public class CircleArrayQueueDemo {

	public static void main(String[] args) {
		
		//测试一把
		System.out.println("测试数组模拟环形队列的案例~~~");
		
		// 创建一个环形队列
		CircleArray queue = new CircleArray(4); //说明设置4, 其队列的有效数据最大是3
		char key = ' '; // 接收用户输入
		Scanner scanner = new Scanner(System.in);//
		boolean loop = true;
		// 输出一个菜单
		while (loop) {
			System.out.println("s(show): 显示队列");
			System.out.println("e(exit): 退出程序");
			System.out.println("a(add): 添加数据到队列");
			System.out.println("g(get): 从队列取出数据");
			System.out.println("h(head): 查看队列头的数据");
			key = scanner.next().charAt(0);// 接收一个字符
			switch (key) {
			case 's':
				queue.showQueue();
				break;
			case 'a':
				System.out.println("输出一个数");
				int value = scanner.nextInt();
				queue.addQueue(value);
				break;
			case 'g': // 取出数据
				try {
					int res = queue.getQueue();
					System.out.printf("取出的数据是%d\n", res);
				} catch (Exception e) {
					// TODO: handle exception
					System.out.println(e.getMessage());
				}
				break;
			case 'h': // 查看队列头的数据
				try {
					int res = queue.headQueue();
					System.out.printf("队列头的数据是%d\n", res);
				} catch (Exception e) {
					// TODO: handle exception
					System.out.println(e.getMessage());
				}
				break;
			case 'e': // 退出
				scanner.close();
				loop = false;
				break;
			default:
				break;
			}
		}
		System.out.println("程序退出~~");
	}

}


class CircleArray {
	private int maxSize; // 表示数组的最大容量
	//front 变量的含义做一个调整： front 就指向队列的第一个元素, 也就是说 arr[front] 就是队列的第一个元素 
	//front 的初始值 = 0
	private int front; 
	//rear 变量的含义做一个调整：rear 指向队列的最后一个元素的后一个位置. 因为希望空出一个空间做为约定.
	//rear 的初始值 = 0
	private int rear; // 队列尾
	private int[] arr; // 该数据用于存放数据, 模拟队列
	
	public CircleArray(int arrMaxSize) {
		maxSize = arrMaxSize;
		arr = new int[maxSize];
	}
	
	// 判断队列是否满
	public boolean isFull() {
		return (rear  + 1) % maxSize == front;
	}
	
	// 判断队列是否为空
	public boolean isEmpty() {
		return rear == front;
	}
	
	// 添加数据到队列
	public void addQueue(int n) {
		// 判断队列是否满
		if (isFull()) {
			System.out.println("队列满，不能加入数据~");
			return;
		}
		//直接将数据加入
		arr[rear] = n;
		//将 rear 后移, 这里必须考虑取模
		rear = (rear + 1) % maxSize;
	}
	
	// 获取队列的数据, 出队列
	public int getQueue() {
		// 判断队列是否空
		if (isEmpty()) {
			// 通过抛出异常
			throw new RuntimeException("队列空，不能取数据");
		}
		// 这里需要分析出 front是指向队列的第一个元素
		// 1. 先把 front 对应的值保留到一个临时变量
		// 2. 将 front 后移, 考虑取模
		// 3. 将临时保存的变量返回
		int value = arr[front];
		front = (front + 1) % maxSize;
		return value;

	}
	
	// 显示队列的所有数据
	public void showQueue() {
		// 遍历
		if (isEmpty()) {
			System.out.println("队列空的，没有数据~~");
			return;
		}
		// 思路：从front开始遍历，遍历多少个元素
		// 动脑筋
		for (int i = front; i < front + size() ; i++) {
			System.out.printf("arr[%d]=%d\n", i % maxSize, arr[i % maxSize]);
		}
	}
	
	// 求出当前队列有效数据的个数
	public int size() {
		// rear = 2
		// front = 1
		// maxSize = 3 
		return (rear + maxSize - front) % maxSize;   
	}
	
	// 显示队列的头数据， 注意不是取出数据
	public int headQueue() {
		// 判断
		if (isEmpty()) {
			throw new RuntimeException("队列空的，没有数据~~");
		}
		return arr[front];
	}
}
```

## 第二章 链表
## 第三章 栈
## 第四章 递归
## 第五章 排序算法
## 第六章 查找算法
## 第七章 树结构的基础部分
## 第八章 树结构的实际应用
## 第九章 多路查找树
## 第十章 图

