---
layout:     post                    # 使用的布局（不需要改）
title:      设计模式总结              # 标题
subtitle:   坚持坚持再坚持      #副标题
date:       2020-04-13              # 时间
author:     hxc                      # 作者
header-img:    #这篇文章标题背景图片
catalog: true                       # 是否归档
categories: 设计模式
tags:                               #标签
    - 设计模式
---
# 我的设计模式整理

[TOC]

## 1 创建型模式

### 1.1 简单工厂模式(Simple Factory)

#### 1.1.1 基本概念

简单工厂模式是类的创建模式，又叫做静态工厂方法（Static Factory Method）模式。简单工厂模式是由一个工厂对象决定创建出哪一种产品类的实例。

在创建一个对象时不向客户暴露内部细节，并提供一个创建对象的通用接口。

#### 1.1.2 结构

简单工厂把实例化的操作单独放到一个类中，这个类就是简单工厂类(Simple Factory)，让简单工厂类来决定应该用哪个具体子类来实例化 (而不是在客户端中决定)。

这样做能把客户类和具体子类的实现解耦，客户类不再需要知道有哪些子类以及应当实例化哪个子类。

客户类往往有多个，如果不使用简单工厂，那么所有的客户类都要知道所有子类的细节。而且一旦子类发生改变，例如增加子类，那么所有的客户类都要进行修改。

结构:

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/04_simple_01.png) 

#### 1.1.3 案例

>模拟在`type == 1`的时候创建`ConcreteProduct1`、在`type == 2`的时候创建`ConcreteProduct2`、其他时候创建`ConcreteProduct`。

```java
public interface Product {
}
```

```java
public class ConcreteProduct implements Product {
}
```

```java
public class ConcreteProduct1 implements Product {
}
```

```java
public class ConcreteProduct2 implements Product {
}
```

如果我们按照下面的方式创建，则我们在客户端包含了这些需要判断条件的实例化代码，则可以将这些实例化代码放到简单工厂中:

```java
public class MyTest {
    // 不好的设计
    public static void main(String[] args) {
        int type = 1;
        Product product;
        if (type == 1) {
            product = new ConcreteProduct1();
        } else if (type == 2) {
            product = new ConcreteProduct2();
        } else {
            product = new ConcreteProduct();
        }
        // do something with the product
    }
}
```

于是我们可以增加一个简单工厂类:

```java
public class SimpleFactory {

    // 也可以将createProduct写成静态的
    public Product createProduct(int type) {
        if (type == 1) {
            return new ConcreteProduct1();
        } else if (type == 2) {
            return new ConcreteProduct2();
        }
        return new ConcreteProduct();
    }
}
```

然后我们的测试类可以写成下面的样子:

```java
public class MyTest {

    public static void main(String[] args) {
        SimpleFactory simpleFactory = new SimpleFactory();
        Product product = simpleFactory.createProduct(1);
        // do something with product
    }
}
```

这样既让客户端和具体类解耦，而且在客户端也看不到具体的繁杂的实例化代码。

#### 1.1.4 总结

缺点 : 这个工厂类集中了所有的创建逻辑，当有复杂的多层次等级结构时，所有的业务逻辑都在这个工厂类中实现。什么时候它不能工作了，整个系统都会受到影响。

我们强调`职责单一`原则，一个类只提供一种功能

### 1.2 工厂方法(Factory Method)

#### 1.2.1 基本概念

`工厂方法模式`是类的创建模式，又叫做`虚拟构造子(Virtual Constructor)模式`或者`多态性工厂（Polymorphic Factory）模式`。 `工厂方法模式`的用意是定义一个创建产品对象的`工厂接口`，将实际创建工作推迟到子类中。

或者说引入工厂模式的目的就是我们需要多个工厂，但是每个工厂内部又要划分情况，如果只用一个工厂的话，会产生多种复合的情况。

比如说我们有两个工厂，每个工厂有3种情况，如果用简单工厂模式，要分为 3 * 2 = 6种情况，所以可以用工厂方法模式解决。

#### 1.2.2 结构

在简单工厂中，创建对象的是另一个类，而在工厂方法中，是由大工厂的子类(或者实现类)来创建对象。

即上面有一个大工厂，下面是分类的工厂。

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/05_method_03.png) 

#### 1.2.3 案例

> 案例，模拟需要生成中国食物A，中国食物B，美国食物A，美国食物B。

代码逻辑结构图:

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/05_method_01.png) 

基本结构图:

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/04_method_02.png) 

先给出这些食物(Product):

```java
public interface Food {
}

public class AmericanFoodA implements Food {
}

public class AmericanFoodB implements Food {
}

public class ChineseFoodA implements Food {
}

public class ChineseFoodB implements Food {
}
```

然后是抽象工厂:

```java
public interface FoodFactory {
    Food makeFood(String name);
}
```

然后就是两个子工厂:

```java
public class ChineseFoodFactory implements FoodFactory {
    @Override
    public Food makeFood(String name) {
        if (name.equals("A")) {
            return new ChineseFoodA();
        } else if (name.equals("B")) {
            return new ChineseFoodB();
        } else {
            return null;
        }
    }
}
```

```java
public class AmericanFoodFactory implements FoodFactory {
    @Override
    public Food makeFood(String name) {
        if (name.equals("A")) {
            return new AmericanFoodA();
        } else if (name.equals("B")) {
            return new AmericanFoodB();
        } else {
            return null;
        }
    }
}
```

最后测试:

```java
public class MyTest {
    public static void main(String[] args) {
        // 先选择一个具体的工厂
        FoodFactory factory = new ChineseFoodFactory();

        // 由第一步的工厂产生具体的对象，不同的工厂造出不一样的对象
        Food food = factory.makeFood("A"); //  chineseFood * A
    }
}
```

#### 1.2.4 总结

工厂方法模式和简单工厂模式在结构上的不同很明显。

`工厂方法模式的核心是一个抽象工厂类，而简单工厂模式把核心放在一个具体类上。`

工厂方法模式退化后可以变得很像简单工厂模式。设想如果非常确定一个系统只需要一个具体工厂类，那么不妨把抽象工厂类合并到具体工厂类中去。由于只有一个具体工厂类，所以不妨将工厂方法改为静态方法，这时候就得到了简单工厂模式。

### 1.3 抽象工厂模式(Abstract Factory)

#### 1.3.1 基本概念

当涉及到`产品族`的时候，就需要引入抽象工厂模式了。

每一个模式都是针对一定问题的解决方案。抽象工厂模式与工厂方法模式的最大区别就在于，`工厂方法模式`针对的是`一个产品等级结构`；而`抽象工厂模式`则需要面对`多个产品等级`结构。

在学习抽象工厂具体实例之前，应该明白两个重要的概念：`产品族`和`产品等级`。

所谓产品族，是指位于不同产品等级结构中，`功能相关联的产品组成的家族`。比如`AMD的主板`、`芯片组`、`CPU`组成一个`家族`，Intel的主板、芯片组、CPU组成一个家族。而这两个家族都来自于三个产品等级：`主板`、`芯片组`、`CPU`。一个等级结构是由相同的结构的产品组成，示意图如下：

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/06_abstract_06.png) 

#### 1.3.2 结构



#### 1.3.3 案例
一个经典的例子是造一台电脑。我们先不引入抽象工厂模式，看看怎么实现。

因为电脑是由许多的构件组成的，我们将 CPU 和主板进行抽象，然后 CPU 由 CPUFactory 生产，主板由 MainBoardFactory 生产，然后，我们再将 CPU 和主板搭配起来组合在一起，如下:

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/06_abstract_01.png) 

代码组织结构:

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/06_abstract_02.png) 


这个时候的客户端调用是这样的（测试类）：

```
public class MyTest {
    public static void main(String[] args){
        // 得到 Intel 的 CPU
        CPUFactory intelCPUFactory = new IntelCPUFactory();
        CPU cpu = intelCPUFactory.makeCPU();

        // 得到 AMD 的主板
        MainBoardFactory mainBoardFactory = new AmdMainBoardFactory();
        MainBoard mainBoard = mainBoardFactory.makeMB();
		
        // 组装 CPU 和主板
        Computer computer = new Computer(cpu, mainBoard);
        System.out.println(computer);
    }
}
```

单独看 CPU 工厂和主板工厂，它们分别是前面我们说的`工厂模式`。

这种方式也容易扩展，因为要给电脑加硬盘的话，只需要加一个 HardDiskFactory 和相应的实现即可，不需要修改现有的工厂。

但是，这种方式有一个问题，那就是如果 `Intel 家产的 CPU 和 AMD 产的主板不能兼容使用`，那么这代码就容易出错，因为客户端并不知道它们不兼容，也就会错误地出现随意组合。

下面就是我们要说的产品族的概念，它代表了组成某个产品的一系列附件的集合：


![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/06_abstract_03.png) 

当涉及到这种产品族的问题的时候，就需要抽象工厂模式来支持了。我们不再定义 CPU 工厂、主板工厂、硬盘工厂、显示屏工厂等等，我们直接定义电脑工厂，每个电脑工厂负责生产所有的设备，这样能保证肯定不存在兼容问题。


![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/06_abstract_04.png) 

这个时候，对于客户端来说，不再需要单独挑选 CPU厂商、主板厂商、硬盘厂商等，直接选择一家品牌工厂，品牌工厂会负责生产所有的东西，而且能保证肯定是兼容可用的。

改装的抽象工厂模式代码组织结构如下:


![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/06_abstract_05.png) 

主要的代码:

三个工厂:(一个超类工厂`PCFactory`，两个大厂工厂`AmdFactory`、`InterFactory`)

```java
public interface PCFactory {

    CPU makeCPU();
    MainBoard makeMB();
    // HardDisk makeHD();
}
```

```java
public class AmdFactory implements PCFactory{

    @Override
    public CPU makeCPU() {
        return new AmdCPU();
    }

    @Override
    public MainBoard makeMB() {
        return new AmdMainBoard();
    }
}
```


```java
public class IntelFactory implements PCFactory {

    @Override
    public CPU makeCPU() {
        return new IntelCPU();
    }

    @Override
    public MainBoard makeMB() {
        return new IntelMainBoard();
    }
}
```

最后的测试类:

```java
public class MyTest {
    public static void main(String[] args){
        // 第一步就要选定一个“大厂”
        PCFactory cf = new AmdFactory();
        // 从这个大厂造 CPU
        CPU cpu = cf.makeCPU();
        // 从这个大厂造主板
        MainBoard board = cf.makeMB();

        //... 从这个大厂造硬盘。等等

        // 将同一个厂子出来的 CPU、主板、硬盘组装在一起
        Computer computer = new Computer(cpu, board);
    }
}
```

#### 1.3.4 总结

当然，抽象工厂的问题也是显而易见的，比如我们要加个显示器，就需要修改所有的工厂，给所有的工厂都加上制造显示器的方法。这有点违反了对修改关闭，对扩展开放这个设计原则。

### 1.4 单例模式(Singleton)

#### 1.3.1 基本概念、

单例模式属于创建型设计模式。

确保一个类只有一个实例，并提供该实例的全局访问点。

实现: 使用一个`私有构造函数`、一个`私有静态变量`以及一个`公有静态函数来实现`。

#### 1.3.2 结构

类图:

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/14_singleton.png)

私有构造函数保证了不能通过构造函数来创建对象实例，只能通过公有静态函数返回唯一的私有静态变量。

#### 1.3.3 案例

#### 1.3.4 总结

### 1.5 创建者模式(Builder)

#### 1.3.1 基本概念

#### 1.3.2 结构

#### 1.3.3 案例

#### 1.3.4 总结

### 1.6 原型模式(Prototype)

## 2 结构型模式

### 2.1 外观-门面模式(Facade)
#### 2.1.1 基本概念

门面模式(Facade Pattern)：外部与一个子系统的通信必须通过一个统一的外观对象进行，为子系统中的一组接口提供一个一致的界面，外观模式定义了一个高层接口，这个接口使得这一子系统更加容易使用。门面模式又称为外观模式，它是一种对象结构型模式。

#### 2.1.2 结构
门面模式没有一个一般化的类图描述，最好的描述方法实际上就是以一个例子说明。

由于门面模式的结构图过于抽象，因此把它稍稍具体点。假设子系统内有三个模块，分别是ModuleA、ModuleB和ModuleC，它们分别有一个示例方法，那么此时示例的整体结构图如下：

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/07_adapter_30.png)
 在这个对象图中，出现了两个角色：
- **门面(Facade)角色** ：客户端可以调用这个角色的方法。此角色知晓相关的（一个或者多个）子系统的功能和责任。在正常情况下，本角色会将所有从客户端发来的请求委派到相应的子系统去。

- **子系统(SubSystem)角色** ：可以同时有一个或者多个子系统。每个子系统都不是一个单独的类，而是一个类的集合（如上面的子系统就是由ModuleA、ModuleB、ModuleC三个类组合而成）。每个子系统都可以被客户端直接调用，或者被门面角色调用。子系统并不知道门面的存在，对于子系统而言，门面仅仅是另外一个客户端而已。

#### 2.1.3 案例

子系统角色中的类:

```java
public class ModuleA {
    //示意方法
    public void testA(){
        System.out.println("调用ModuleA中的testA方法");
    }
}
```

```java
public class ModuleB {
    //示意方法
    public void testB(){
        System.out.println("调用ModuleB中的testB方法");
    }
}
```

```java
public class ModuleC {
    //示意方法
    public void testC(){
        System.out.println("调用ModuleC中的testC方法");
    }
}
```

门面角色类：

```java
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

```java
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

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/07_adapter_01.png)

从用户的角度看不到被**适配者**。

用户调用适配器转换出来的目标接口方法。适配器再调用被适配者的相关接口方法。

用户收到反馈结果，感觉只是和目标接口交互。

- 类适配器

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/07_adapter_05.png)

通过多重继承目标接口和被适配者类方式来实现适配。

#### 2.2.3 案例

> 案例: 将火鸡冒充成鸭子
##### 2.2.3.1 对象适配器模式

逻辑图:

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/07_adapter_03.png)

代码组织结构图:

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/07_adapter_02.png)

被适配者火鸡Turkey:

```java
public interface Turkey {
    void gobble(); // 火鸡叫声
    void fly();
}
```

```java
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

```java
/** 鸭子的接口 */
public interface Duck {
    void quack();//鸭子叫声
    void fly();
}
```

适配器TurkeyAdapter:

```java
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

```java
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

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/07_adapter_04.png)

虽然Java不支持多继承，但是可以实现的同时继承。

只有TurkeyAdapter有一些代码变动，其他不变:

```java
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

```java
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

#### 2.3.1 基本概念

代理模式(Proxy Pattern) ：给某一个对象提供一个代 理，并由代理对象控制对原对象的引用。代理模式的英 文叫做Proxy或Surrogate，它是一种对象结构型模式。

#### 2.3.2 结构

代理可以看做就是在被代理对象外面包裹一层（和装饰者类似但又不同）

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/11_proxy_02.png)

#### 2.3.3 案例

比如我们有一个可以移动的坦克，它的主要方法是move()，但是我们需要记录它移动的时间，以及在它移动前后做日志，其静态代理的实现模式就类似下面的图:

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/11_proxy_01.png)

实现如下：

```java
public interface Movable {
    void move();
}
```

```java
public class Tank implements Movable {
    @Override
    public void move() {
        // 坦克移动
        System.out.println("Tank Moving......");
        try {
            Thread.sleep(new Random().nextInt(5000)); // 随机产生 1~5秒, 模拟坦克在移动　
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
```

两个代理类: `TankTimeProxy`和`TankLogProxy`:

```java
public class TankTimeProxy implements Movable {

    private Movable tank;

    public TankTimeProxy(Movable tank) {
        this.tank = tank;
    }

    @Override
    public void move() {
        // 在前面做一些事情: 记录开始时间
        long start = System.currentTimeMillis();
        System.out.println("start time : " + start);

        tank.move();

        // 在后面做一些事情: 记录结束时间,并计算move()运行时间
        long end = System.currentTimeMillis();
        System.out.println("end time : " + end);
        System.out.println("spend all time : " + (end - start)/1000 + "s.");
    }
}
```

```java
public class TankLogProxy implements Movable {

    private Movable tank;

    public TankLogProxy(Movable tank) {
        this.tank = tank;
    }

    @Override
    public void move() {
        // tank 移动前记录日志
        System.out.println("Tank Log start.......");

        tank.move();

        // tank 移动后记录日志
        System.out.println("Tank Log end.......");
    }
}
```
测试

```java
public class Client {
    public static void main(String[] args){
        Movable target = new TankLogProxy(new TankTimeProxy(new Tank()));    //先记录时间，再记录日志
//        Movable target = new TankTimeProxy(new TankLogProxy(new Tank())); //先记录日志，再记录时间
        target.move();
    }
}
```

输出

```java
Tank Log start.......
start time : 1551271511619
Tank Moving......
end time : 1551271514522
spend all time : 2s.
Tank Log end.......
```

这其中有两个很重要的点，那就是:

- 两个代理对象内部都有着被代理对象(target)实现的接口的引用；
- 且两个代理对象都实现了被代理对象(target)实现的接口；


### 2.4 组合模式(Composite)
### 2.5 装饰模式(Decorator)

#### 2.5.1 基本概念

装饰者模式是结构型设计模式。

装饰模式以对**客户端透明的方式扩展对象的功能**，是继承关系的一个替代方案。

允许向一个现有的对象添加新的功能。同时又不改变其结构，它是作为现有的类的一个包装。

主要解决的问题: 一般我们为了扩展一个类经常使用继承方式实现，由于继承为类引入静态特征，并且随着扩展功能的增多，**子类会很膨胀**。

#### 2.5.2 结构

结构：

> 装饰者（Decorator）和具体组件（ConcreteComponent）都继承自组件（Component）；
> 所谓装饰，就是把这个装饰者套在被装饰者之上，从而动态扩展被装饰者的功能；
> 装饰者的方法有一部分是自己的，这属于它的功能(半透明的装饰者模式)。然后调用被装饰者的方法实现，从而也保> 留了被装饰者的功能；

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/03_decorator_02.png)


#### 2.5.3 案例

装饰者模式案例

> 模拟在餐馆点饮料，我们可以点咖啡，而咖啡有Decaf咖啡和Espresso咖啡，而这两种咖啡都可以加牛奶和巧克力进去。

具体的代码组织结构图:

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/03_decorator_01.png)

具体代码:

先看最高的`component`包下的`Drink`类:

```java
/**
 * Component的超类
 * 单品和装饰者都要继承自这个类
 */
public abstract class Drink {

    private String description = ""; //一开始没有描述
    private double price = 0; //一开始价格为0

    /**
     * 抽象方法
     *  1、如果是单品的话就直接是自己的价格
     *  2、如果是装饰者的话就还要加上装饰品自己的价格
     */
    public abstract double cost();


    // setter getter

    public String getDescription() {
        return description;
    }
    public double getPrice() {
        return price;
    }
    public void setDescription(String description) { //描述的时候顺便把价格描述一下
        this.description = description;
    }
    public void setPrice(double price) {
        this.price = price;
    }
}
```

下面看两个具体的Component:

```java
/** ConcreteComponent 1*/
public class Decaf extends Drink {

    public Decaf() {
        super.setDescription("Decaf");
        super.setPrice(3); //3块钱
    }

    @Override
    public double cost() {
        return getPrice();//super.getPrice()//这个就是父类的价格(自己什么也没加 (没有被装饰))
    }

    // 重写getter 后面加上自己的花费
    @Override
    public String getDescription() {
        return super.getDescription() + "-" + cost();
    }
}
```

```java
/** ConcreteComponent 2
 *  也可以在ConcreteComponent和Drink类有一个过渡的类)  (比如Coffee类)
 */
public class Espresso extends Drink {

    public Espresso(){
        super.setDescription("Espresso");
        super.setPrice(4);
    }

    @Override
    public double cost() {
        return getPrice();//super.getPrice()//这个就是父类的价格(自己什么也没加)
    }

    @Override
    public String getDescription() {
        return super.getDescription() + "-" + cost();
    }
}
```

下面看`decorator`下的三个类:

第一个是装饰者的超类，继承自`Drink`类:

```java
public class Decorator extends Drink{
    /**
     * 这个引用很重要，可以是单品，也可以是被包装过的类型，所以使用的是超类的对象
     * 这个就是要被包装的单品(被装饰的对象)
     */
    private Drink drink; //这里要拿到父类的引用，因为要控制另一个分支(具体的组件)

    public Decorator(Drink drink) {
        this.drink = drink;
    }

    /**
     * 如果drink是已经被装包过的，那么就会产生递归调用　　最终到单品
     */
    @Override
    public double cost() {
        return super.getPrice() + drink.cost(); // 自己的价格和被包装单品的价格
    }

    @Override
    public String getDescription() {
        return super.getDescription() + "-" + super.getPrice()
                + " && " + drink.getDescription();
    }
}
```

然后是两个装饰者:

```java
/**
 * 这个是具体的装饰者() --> 继承自中间的装饰着Decorator
 */
public class Chocolate extends Decorator{

    public Chocolate(Drink drink) { //如果父类搞了一个　带参数的构造函数，子类必须显示的使用super调用
        super(drink);
        super.setDescription("Chocolate");
        super.setPrice(1);
    }
}
```

```java
public class Milk extends Decorator{

    public Milk(Drink drink) {
        super(drink); //调用父类的构造函数
        super.setDescription("Milk");
        super.setPrice(3);
    }
}
```

//测试类:

```java
public class MyTest {
    public static void main(String[] args) {
        //只点一个单品 (Decaf 咖啡)
        Drink order = new Decaf();
        System.out.println("order description : " + order.getDescription());
        System.out.println("order price : " + order.cost());

        System.out.println("---------------加了调料的----------------");

        order = new Milk(order);// 加了牛奶
        order = new Chocolate(order);
        order = new Chocolate(order); // 加了两个巧克力
        System.out.println("order description : " + order.getDescription());
        System.out.println("order price : " + order.cost());
    }
}
```

程序输出:

```java
order description : Decaf-3.0
order price : 3.0
---------------加了调料的----------------
order description : Chocolate-1.0 && Chocolate-1.0 && Milk-3.0 && Decaf-3.0
order price : 8.0
```

### 2.6 桥模式(Bridge)
### 2.7 亨元模式(Flyweight)

## 3 行为型模式
### 3.1 观察者模式(Observer)

#### 3.1.1 基本概念

观察者模式是行为型设计模式。

- 定义`对象间`的一种`一对多`的依赖关系，当一个对象的状态发生改变时，所有`依赖`于它的对象都得到`通知`并被`自动更新`；
- 被依赖的对象为`Subject(被观察者)`，依赖的对象为`Observer`，Subject通知Observer变化；
- Subject : `登记注册register/attach`、`移除remove`、`通知notify`；
- Observer : `接收变化update`；
    可以把观察者模式想象成订报纸一样，出版者+订阅者 = 观察者模式；


#### 3.1.2 结构

观察者模式所涉及的角色有：

- `抽象主题(Subject)角色`：抽象主题角色把所有对观察者对象的引用保存在一个聚集（比如List对象）里。抽象主题提供一个接口，可以增加和删除观察者对象，抽象主题角色又叫做抽象被观察者(Observable)角色；

- `具体主题(ConcreteSubject)角色`：将有关状态存入具体观察者对象；在具体主题的内部状态改变时，给所有登记过的观察者发出通知。具体主题角色又叫做具体被观察者(Concrete Observable)角色；

- `抽象观察者(Observer)角色`：为所有的具体观察者定义一个接口，在得到主题的通知时更新自己，这个接口叫做更新接口。

- `具体观察者(ConcreteObserver)角色`：存储与主题的状态自恰的状态。具体观察者角色实现抽象观察者角色所要求的更新接口，以便使本身的状态与主题的状态相协调。如果需要，具体观察者角色可以保持一个指向具体主题对象(Concrete Subject)的引用；

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/02_observer_02.png) 

#### 3.1.3 案例

案例：

> 实现的功能是气象站的管理，给你一个WeatherData类(被观察者)，提供了获取温度，湿度，和气压的函数，要你设计类并添加一些公告板(观察者)，可以显示相关的信息

基本结构图:

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/02_observer_01.png) 

下面使用自定义的观察者实现。

基本代码结构组织图:

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/02_observer_03.png) 

先看被观察者包`subjects`里面的两个:

- Subject接口:

```java
/**被观察者接口*/
public interface Subject {
    void registerObservers(Observer o);//注册
    void removeObservers(Observer o); //移除
    void notifyObservers(); //通知
}
```

- WeatherData类 (被观察者的实现):

```java
/**
 * 被观察者的实现
 * 里面有:
 *   1、观察者接口的集合数据结构
 * 　2、实现添加观察者方法(registerObservers)
 *   3、移除观察者方法(removeObservers)
 *   4、通知所有观察者的方法(notifyObservers)
 */
public class WeatherData implements Subject {

    private double temperature;
    private double humidity;
    private double pressure;

    // 可以提供getter()方法

    private ArrayList<Observer>observers;

    public WeatherData() {
        observers = new ArrayList<>();
    }

    public void setData(double temperature, double humidity, double pressure){
        this.temperature = temperature;
        this.humidity = humidity;
        this.pressure = pressure;

        dataChanged();//更新完信息就马上通知观察者
    }

    //数据改变之后就通知观察者(从气象站得到更新的观测值之后，通知观察者)
    public void dataChanged(){
        notifyObservers();
    }

    @Override
    public void registerObservers(Observer o) {
        observers.add(o);
    }

    @Override
    public void removeObservers(Observer o) {
        int index = observers.indexOf(o);
        if(index >= 0){
            observers.remove(o);
        }
    }

    @Override
    public void notifyObservers() {
        for(int i = 0; i < observers.size(); i++){
            Observer observer = observers.get(i);
            observer.update(temperature, humidity, pressure);
        }
    }
}
```

然后再看observers包的接口和实现类:

- Observer接口:

```java
/** 观察者 接口*/
public interface Observer {
    void update(double temperature, double humidity, double pressure);
}
```

两个实现类:

```java
/** 观察者1 */
public class CurrentConditionDisplay implements Observer {

    private double temperature;
    private double humidity;
    private double pressure;

    @Override
    public void update(double temperature, double humidity, double pressure) {
        this.temperature = temperature;
        this.humidity = humidity;
        this.pressure = pressure;
        display();
    }

    public void display() {
        System.out.println("CurrentDisplay : " +
                "[" + temperature  +
                ", " + humidity  +
                ", " + pressure + "]");
    }
}
```

```java
/** 观察者2  明天的天气展示 : Math.random * 当前设置值, 主要是为了展示和上一个观察者的不同*/
public class TomorrowConditionDisplay implements Observer {

    private double temperature;
    private double humidity;
    private double pressure;

    @Override
    public void update(double temperature, double humidity, double pressure) {
        this.temperature = temperature;
        this.humidity = humidity;
        this.pressure = pressure;
        display();
    }

    // ( (int)(10 * Math.random())/2 + 1)  生成 [1,5]的随机数
    public void display() {
        System.out.println("TomorrowDisplay : " +
                "[" + temperature * ( (int)(10 * Math.random())/2 + 1) +
                ", " + humidity * ( (int)(10 * Math.random())/2 + 1) +
                ", " + pressure * ( (int)(10 * Math.random())/2 + 1) + "]");
    }
}
```

最后测试

```java
public class MyTest {
    public static void main(String[] args) {
        WeatherData weatherData = new WeatherData(); // 创建一个被观察者(Subject的实现类)

        // 创建两个观察者 (Observer的实现类)
        CurrentConditionDisplay current = new CurrentConditionDisplay();
        TomorrowConditionDisplay tomorrow = new TomorrowConditionDisplay();

        // 在被观察者的List中注册两个观察者
        weatherData.registerObservers(current);
        weatherData.registerObservers(tomorrow);

        // 设置完(天气更新)就会自动通知两个观察者
        weatherData.setData(10,100,50);

        System.out.println("----------移除Tomorrow公告板----------");
        weatherData.removeObservers(tomorrow);

        weatherData.setData(20,200,25);
    }
}
```

程序输出

```
CurrentDisplay : [10.0, 100.0, 50.0]
TomorrowDisplay : [10.0, 100.0, 150.0]
----------移除Tomorrow公告板----------
CurrentDisplay : [20.0, 200.0, 25.0]
```
#### 3.1.4 总结
使用场景

- 一个抽象模型有两个方面，其中一个方面依赖于另一个方面。将这些方面封装在独立的对象中使它们可以各自独立地改变和复用。
- 一个对象的改变将导致其他一个或多个对象也发生改变，而不知道具体有多少对象将发生改变，可以降低对象之间的耦合度。
- 一个对象必须通知其他对象，而并不知道这些对象是谁。
- 需要在系统中创建一个触发链，A对象的行为将影响B对象，B对象的行为将影响C对象……，可以使用观察者模式创建一种链式触发机制。


### 3.2 策略模式(Strategy)

#### 3.2.1 基本概念

策略模式是`行为型`设计模式。

其用意是针对一组算法，将`每一个算法封装`到具有`共同接口`的独立的类中，从而使得它们可以`相互替换`。

策略模式使得算法可以在不影响到客户端的情况下发生变化。

#### 3.2.2 结构

下面是基本结构:

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/01_stratgy_01.png) 


三类角色:

- `环境(Context)角色`：持有一个`Strategy`的引用。
- `抽象策略(Strategy)角色`：这是一个抽象角色，通常由一个`接口或抽象类实现`。此角色给出所有的具体策略类所需的接口。
- `具体策略(ConcreteStrategy)角色`：包装了相关的算法或行为。


#### 3.2.3 案例

案例实现:

> 定义一族算法，可以实现对两个数的操作，例如+、-、*、/等。

实现代码整体框架图:

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/01_stratgy_02.png) 

具体代码实现:

`Context类`:

```java
/**
 * Context 是一个使用了某种策略的类。 实现了 Strategy 接口的实体策略类
 */
public class Context {

    private Strategy strategy;

    public Context(Strategy strategy) {
        this.strategy = strategy;
    }

    public int executeStrategy(int num1, int num2){
        return strategy.doOperation(num1, num2);
    }
}
```

Strategy接口:

```
/**策略的公共接口*/
public interface Strategy {
    int doOperation(int num1, int num2);
}
```

三种对应的算法实现:

```java
/** 算法１: 实现加法 */
public class OperationAdd implements Strategy {
    @Override
    public int doOperation(int num1, int num2) {
        return num1 + num2;
    }
}
```

```java
/** 算法2：实现减法 */
public class OperationSubstract implements Strategy{
    @Override
    public int doOperation(int num1, int num2) {
        return num1 - num2;
    }
}
```

```java
/** 算法3: 实现乘法 */
public class OperationMultiply implements Strategy{
    @Override
    public int doOperation(int num1, int num2) {
        return num1 * num2;
    }
}
```

测试类：

```java
public class MyTest {
    public static void main(String[] args) {

        Context context = new Context(new OperationAdd());

        System.out.println("10 + 5 = " + context.executeStrategy(10, 5));

        context = new Context(new OperationSubstract());
        System.out.println("10 - 5 = " + context.executeStrategy(10, 5));

        context = new Context(new OperationMultiply());
        System.out.println("10 * 5 = " + context.executeStrategy(10, 5));
    }
}
```

程序输出:

```
10 + 5 = 15
10 - 5 = 5
10 * 5 = 50
```

#### 3.2.4 总结

- 策略模式的重心不是如何实现算法，而是如何组织、调用这些算法；
- 策略模式一个很大的特点就是各个策略算法的平等性。对于一系列具体的策略算法，大家的地位是完全一样的，正因为这个平等性，才能实现算法之间可以相互替换；
- 使用`策略模式`可以避免使用`多重条件(if-else)语句`；

### 访问者模式(Visitor)
### 解析器模式(Interpreter)
### 中介者模式(Mediator)
### 迭代器模式(Iterator)
### 状态模式(State)
### 命令模式(Command)
### 模板模式(Template Method)
### 责任链模式(Chain of Responsibility)
### 备忘录模式(Memento)

### uml基础篇

#### 1. 类图基础属性

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/uml1.png) 

```
-表示private  
#表示protected 
~表示default,也就是包权限  
_下划线表示static  
斜体表示抽象 
```
#### 2. 类与类之间的关系

在UML类图中，常见的有以下几种关系: `泛化（Generalization）`, `实现（Realization）`，`关联（Association)`，`聚合（Aggregation）`，`组合(Composition)`，`依赖(Dependency)`

关系图

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/uml10.png) 

例子图

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/uml2.png) 

#### 2.1 泛化

泛化(Generalization)表示类与类之间的继承关系，接口与接口之间的继承关系，或类对接口的实现关系

##### 2.1.1 继承

- 定义

继承表示是`一个类`（称为子类、子接口）`继承另外的一个类`（称为父类、父接口）的功能，`并可以增加它自己的新功能的能力`。

- 表示方法

继承使用空心三角形+实线表示。

- 形象示例

鸟类继承抽象类动物

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/uml3.png) 
 
 - 代码示例
 
 java中常见的List集合的继承关系做为例子，List（子接口）接口继承自Collection接口（父接口），而ArrayList类（子类）继承自AbstractList（父类）这个抽象类。java 用extends关键字

 
##### 2.1.2 实现 
 
- 定义
 
 实现表示一个class类实现interface接口（可以是多个）的功能。
 
- 表示方法

    1.矩形表示法 
    
    使用空心三角形+虚线表示
    
    比如：大雁需要飞行，就要实现飞()接口
    
    ![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/uml4.png) 
    
    2.棒棒糖表示法 
    
    使用实线表示
    
    ![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/uml5.png) 

##### 2.2 依赖 

1. 定义

对于两个相对独立的对象，当一个对象负责构造另一个对象的实例，或者依赖另一个对象的服务时，这两个对象之间主要体现为依赖关系。

是说一个类用到了另一个类。这种使用关系是具有`偶然性的`、`临时性的`、非常弱的。比如下图中的依赖关系，司机开车，要依赖车。在代码上表现的话一般为`函数参数`，或者`局部变量`或者对`静态方法`的调用。如下图的UML类图中Driver 对Car的依赖就是`通过函数参数`的方式。注意依赖关系只能是`单向的`，并且依赖关系强调的是**使用上的关系**。

2. 表示方法

依赖关系用虚线箭头表示。

3. 示例

动物依赖氧气和水。调用新陈代谢方法需要氧气类与水类的实例作为参数

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/uml6.png)

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/uml12.png)
代码 
```
abstract class Animal
{
   public bolism(Oxygen oxygen,Water water)
    {
    
    } 
}
```


##### 2.3 关联 

1. 定义

对于两个相对独立的对象，当一个对象的实例与另一个对象的一些特定实例存在固定的对应关系时，这两个对象之间为关联关系。

- 关联关系强调的是一种结构上的关系
- 他可以是单向的或者双向的
- 从语义级别(上下文)可以分为`聚合`和`组合`，在代码实现上关联 和聚合是很像的，主要区别在语义上
- 一般来说双方关系是平等的，比如我和我的朋友
- 在java语言上一般表现为全局变量
- 如person类和company类,顾客和地址,客户和订单

`重数性关联`: 重数性关联关系又称为多重性关联关系(Multiplicity)，表示一个类的对象与另一个类的对象连接的个数。在UML中多重性关系可以直接在关联直线上增加一个数字表示与之对应的另一个类的对象的个数。

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/uml13.png)

2. 表示方法

关联关系用实线箭头表示。

3. 示例

企鹅需要‘知道’气候的变化，需要‘了解’气候规律。当一个类‘知道’另一个类时，可以用关联。

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/uml7.png)

```
class Penguin :Bird
{
   private Climateclimate;//在企鹅Penguin中，引用到气候Climate对象
}
```

##### 2.4 聚合 

- 定义

表示一种弱的‘拥有’关系，即has-a的关系，体现的是A对象可以包含B对象，但B对象不是A对象的一部分。 两个对象具有各自的生命周期。

- 聚合关系是`关联关系`的一种，表示`整体和部分`之间的关系，如学校和老师，车子和轮胎。

- 表示方法

聚合关系用空心的菱形+实线箭头表示。

- 示例

1.每一只大雁都属于一个大雁群，一个大雁群可以有多只大雁。当大雁死去后大雁群并不会消失，两个对象生命周期不同。

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/uml8.png)

2.聚合关系在类中是通过`成员对象`来体现的，成员是整体的一部分，成员也可以脱离整体而存在。如老师是学校的一部分，同时老师也是独立的个体，可以单独存在。

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/uml14.png)
代码
```
classWideGooseAggregate
{
   private WideGoose[]arrayWideGoose;
   //在雁群WideGooseAggregate类中，有大雁数组对象arrayWideGoose
}
```
##### 2.5 组合 

1. 定义

组合是一种强的‘拥有’关系，是一种contains-a的关系，体现了严格的部分和整体关系，部分和整体的生命周期一样,部分对象不能脱离整体对象而单独存在，如人的身体和大脑之间的关系，大脑不能脱离身体而单独存在。。

2. 表示方法

组合关系用实心的菱形+实线箭头表示，还可以使用连线两端的数字表示某一端有几个实例。

3. 示例

1.鸟和翅膀就是组合关系，因为它们是部分和整体的关系，并且翅膀和鸟的生命周期是相同的。

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/uml9.png)

代码
```
class Bird 
{
  private Wing wing;
  public Bird()
   {
      wing=new Wing();
    //在鸟Bird类中，初始化时，实例化翅膀Wing,它们之间同时生成
   }
}
```

2. 比如人和腿的关系，腿不能脱离人单独存在，腿的生命周期也不能别人这个整体还长。还有人和大脑，大雁与翅膀

![图片](https://huangxinchun.github.io/HxcBlog/images/imagesDesignPatterns/uml15.png)

```
//人和嘴是一种组合关系
public class Person {
   private Mouth mouth;
   public Person() {
       mouth = new Mouth();
   }
   ……
}
public class Mouth {
   ……
}
```


