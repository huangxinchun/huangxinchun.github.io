---
layout:     post                    # 使用的布局（不需要改）
title:      设计模式总结              # 标题
subtitle:   坚持坚持再坚持      #副标题
date:       2020-04-13              # 时间
author:     hxc                      # 作者
header-img:    #这篇文章标题背景图片
catalog: true                       # 是否归档
tags:                               #标签
    - 设计模式
---
# 我的设计模式整理

[TOC]

## 1 创建型模式

### 1.1 简单工厂模式(Simple Factory)

#### 1.1.1 基本概念

#### 1.1.2 结构

#### 1.1.3 案例

### 1.2 工厂方法(Factory Method)
### 1.3 抽象工厂模式(Abstract Factory)
### 1.4 单例模式(Singleton)
### 1.5 创建者模式(Builder)
### 1.6 原型模式(Prototype)


## 2 结构型模式
### 2.1 外观-门面模式(Facade)
#### 2.1.1 基本概念

门面模式(Facade Pattern)：外部与一个子系统的通信必须通过一个统一的外观对象进行，为子系统中的一组接口提供一个一致的界面，外观模式定义了一个高层接口，这个接口使得这一子系统更加容易使用。门面模式又称为外观模式，它是一种对象结构型模式。

#### 2.1.2 结构
门面模式没有一个一般化的类图描述，最好的描述方法实际上就是以一个例子说明。

由于门面模式的结构图过于抽象，因此把它稍稍具体点。假设子系统内有三个模块，分别是ModuleA、ModuleB和ModuleC，它们分别有一个示例方法，那么此时示例的整体结构图如下： 

![图片](/images/imagesDesignPatterns/07_adapter_30.png)

在这个对象图中，出现了两个角色：

- **门面(Facade)角色** ：客户端可以调用这个角色的方法。此角色知晓相关的（一个或者多个）子系统的功能和责任。在正常情况下，本角色会将所有从客户端发来的请求委派到相应的子系统去。

- **子系统(SubSystem)角色** ：可以同时有一个或者多个子系统。每个子系统都不是一个单独的类，而是一个类的集合（如上面的子系统就是由ModuleA、ModuleB、ModuleC三个类组合而成）。每个子系统都可以被客户端直接调用，或者被门面角色调用。子系统并不知道门面的存在，对于子系统而言，门面仅仅是另外一个客户端而已。

#### 2.1.3 案例

子系统角色中的类:
```
public class ModuleA {
    //示意方法
    public void testA(){
        System.out.println("调用ModuleA中的testA方法");
    }
}
```

```
public class ModuleB {
    //示意方法
    public void testB(){
        System.out.println("调用ModuleB中的testB方法");
    }
}
```

```
public class ModuleC {
    //示意方法
    public void testC(){
        System.out.println("调用ModuleC中的testC方法");
    }
}
```

门面角色类：

```
public class Facade {
    //示意方法，满足客户端需要的功能
    public void test(){
        ModuleA a = new ModuleA();
        a.testA();
        ModuleB b = new ModuleB();
        b.testB();
        ModuleC c = new ModuleC();
        c.testC();
    }
}
```

客户端角色类：

```
public class Client {
 
    public static void main(String[] args) {
        
        Facade facade = new Facade();
        facade.test();
    }
 
}
```


### 2.2 适配器模式(Adapter)
#### 2.2.1 基本概念
将一个类的接口，转换成客户期望的另一个接口。适配器是将不兼容的类或者接口整合一起来对外提供服务。

适配器可以理解为我们日常用的电脑充电器: 家庭电压为`220V`，而电脑充电频率是`20V`左右。需要适配器

#### 2.2.2 结构

适配器可以分为两种: 对象适配器和类适配器。

- 对象适配器

![图片](/images/imagesDesignPatterns/07_adapter_01.png)

从用户的角度看不到被**适配者**。

用户调用适配器转换出来的目标接口方法。适配器再调用被适配者的相关接口方法。

用户收到反馈结果，感觉只是和目标接口交互。

- 类适配器

![图片](/images/imagesDesignPatterns/07_adapter_05.png)

通过多重继承目标接口和被适配者类方式来实现适配。

#### 2.2.3 案例

> 案例: 将火鸡冒充成鸭子
##### 2.2.3.1 对象适配器模式

逻辑图:

![图片](/images/imagesDesignPatterns/07_adapter_03.png)

代码组织结构图:

![图片](/images/imagesDesignPatterns/07_adapter_02.png)

被适配者火鸡Turkey:

```
public interface Turkey {
    void gobble(); // 火鸡叫声
    void fly();
}
```

```
/** 野火鸡 */
public class WildTurkey implements Turkey{
    @Override
    public void gobble() {
        System.out.println("Go Go!");
    }

    @Override
    public void fly() {
        System.out.println("I am Flying a short distance!");
    }
}
```

目标对象Duck:

```
/** 鸭子的接口 */
public interface Duck {
    void quack();//鸭子叫声
    void fly();
}
```

适配器TurkeyAdapter:

```
/**
 * 在外面表现是 鸭子(目标)，但是实质是火鸡(被适配者)
 */
public class TurkeyAdapter implements Duck { //实现目标的接口

    private Turkey turkey; //这种对象型适配器必须要组合  被适配者，也就是要有适配者的引用

    public TurkeyAdapter(Turkey turkey) {
        this.turkey = turkey;
    }

    // 实际是火鸡在叫
    @Override
    public void quack() {
        turkey.gobble();//外面表现是quack,但是内部是turkey.gobble()
    }

    @Override
    public void fly() {
        //由于火鸡飞的短，所以多飞几次，让火鸡更像鸭子
        for(int i = 0; i < 6; i++){
            turkey.fly();
        }
    }
}
```

测试:

```
public class MyTest {

    public static void main(String[] args) {
        WildTurkey turkey = new WildTurkey();
        Duck duck = new TurkeyAdapter(turkey);
        duck.quack(); //看似是鸭子，其实内置是火鸡
        duck.fly();
    }
}
```

输出:
```
Go Go!
I am Flying a short distance!
I am Flying a short distance!
I am Flying a short distance!
I am Flying a short distance!
I am Flying a short distance!
I am Flying a short distance!
```

##### 2.2.3.2 类适配器模式

基本结构图:

![图片](/images/imagesDesignPatterns/07_adapter_04.png)

虽然Java不支持多继承，但是可以实现的同时继承。

只有TurkeyAdapter有一些代码变动，其他不变:

```
/**
 * 和 对象适配器模式唯一的不同就是  : 适配器直接继承 被适配者 (而不是组合)
 */
public class TurkeyAdapter extends WildTurkey implements  Duck {

    @Override
    public void quack() {
        super.gobble(); //直接继承 被适配者
    }

    @Override
    public void fly() {
        //让火鸡飞6次，飞的像鸭子
        super.fly();
        super.fly();
        super.fly();
        super.fly();
        super.fly();
        super.fly();
    }
}
```

测试:

```
public class MyTest {

    public static void main(String[] args) {
        TurkeyAdapter duck = new TurkeyAdapter();//直接new即可
        duck.quack();
        duck.fly();
    }
}
```

输出和上面对象适配器一样。

### 2.3 代理模式(Proxy)
### 2.4 组合模式(Composite)
### 2.5 装饰模式(Decorator)
### 2.6 桥模式(Bridge)
### 2.7 亨元模式(Flyweight)

## 3 行为型模式
### 观察者模式(Observer)
### 策略模式(Strategy)

### 访问者模式(Visitor)
### 解析器模式(Interpreter)
### 中介者模式(Mediator)
### 迭代器模式(Iterator)
### 状态模式(State)
### 命令模式(Command)
### 模板模式(Template Method)
### 责任链模式(Chain of Responsibility)
### 备忘录模式(Memento)




