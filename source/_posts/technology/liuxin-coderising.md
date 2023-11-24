---
title: 码农翻身
categories: Technology
tags:
  - 刘欣
  - coderising
abbrlink: ce95
date: 2021-11-10 21:42:59
---

刘欣，15年的软件行业从业经验，前IBM系统架构师。
擅长企业应用架构和设计，领导过多个企业级应用架构设计和开发工作。

## 半小时漫画计算机

### 操作系统

多线程抢占式调度。
协程：可自主暂停 <= 运行控制权转移，完全由程序调度和掌控。

CPU => 取指令，译码，执行，写回。

浮点数运算：小数变整数，记录小数位。
`Java: BigDecimal. Python: Decimal. Ruby: BigDecimal`

#### 一切皆文件

```c
// File
int (*open)(...)
void (*close)(...)
int (*read)(...)
int (*write)(...)

// Socket=(IP, Port)
服务器监听 listen
客户端连接 connect
然后读写 read/write
最后关闭 close
```

#### 函数栈

栈帧：栈中的元素。
ESP=Extended Stack Pointer 扩展栈指针寄存器。存放函数栈顶指针
EBP=Extended Base Pointer 扩展基址指针寄存器。存放函数栈底指针

#### C文件编译

![C文件编译](https://cdn.jsdelivr.net/gh/sstian/images/blogimg/C文件编译.jpg)

#### 32位CPU寄存器

![32位CPU寄存器](https://cdn.jsdelivr.net/gh/sstian/images/blogimg/32位CPU寄存器.png)

![32位CPU寄存器-可编程](https://cdn.jsdelivr.net/gh/sstian/images/blogimg/32位CPU寄存器-可编程.png)

![32位CPU寄存器-通用](https://cdn.jsdelivr.net/gh/sstian/images/blogimg/32位CPU寄存器-通用.png)

![32位CPU寄存器-段](https://cdn.jsdelivr.net/gh/sstian/images/blogimg/32位CPU寄存器-段-2.png)

### 数据库

#### 事务

A = Atomicity 原子性：要么不做，要么全做。
C = Consistency 一致性：数据库保持完整性。
I = Isolation 隔离性：多事务并发执行。
D = Durability 持久性：数据的修改是永久的。

排它锁/X锁：Exclusive Lock。用于写数据。
共享锁/S锁：Share Lock。用于读数据。

| 加锁程度          | 隔离级别                  | 更新丢失 | 脏读 | 不可重复读 | 幻读     |
| ----------------- | ------------------------- | -------- | ---- | ---------- | -------- |
| X, 直到事务结束   | 读未提交 Read Uncommitted | Y        |      |            |          |
| X+S: 读完立即释放 | 读已提交 Read Committed   | Y        | Y    |            |          |
| X+S, 直到事务结束 | 可重复读 Repeatable Read  | Y        | Y    | Y - 锁行   |          |
| 串行执行          | 串行化 Serializable       | Y        | Y    | Y          | Y - 锁表 |

#### 日志

初始值：A=200, B=100

| 流程 | 事务T1      | Undo日志文件 |                                        | Redo日志文件 |                                        |
| ---- | ----------- | ------------ | -------------------------------------- | ------------ | -------------------------------------- |
| 1    |             | <T1, 开始>   | 事务开始                               | <T1, 开始>   | 事务开始                               |
| 2    |             | <T1, A, 200> | 记录A的**初始值**                      |              |                                        |
| 3    | A := A - 50 |              |                                        |              |                                        |
| 4    |             |              |                                        | <T1, A, 150> | 记录A的**最新值**                      |
| 5    |             | <T1, B, 100> | 记录B的**初始值**                      |              |                                        |
| 6    | B := B + 50 |              |                                        |              |                                        |
| 7    |             |              |                                        | <T1, B, 150> | 记录B的**最新值**                      |
| 8    |             |              |                                        | <T1, 提交>   | 事务提交，<br />在A, B**写入磁盘之前** |
| 9    | 把A写入磁盘 |              |                                        |              |                                        |
| 10   | 把B写入磁盘 |              |                                        |              |                                        |
| 11   |             | <T1, 提交>   | 事务提交，<br />在A, B**写入磁盘之后** | <T1, 结束>   |                                        |

**恢复策略：**

- Undo日志文件
  1. 系统重启时，检查Undo日志文件；
  2. 对于事务T1，若没有`<T1, 提交>`记录，表示该事务在执行过程中失败了，则恢复操作；
  3. 利用Undo日志中记录的A, B的初始值。由于幂等性，恢复多少遍结果都一样；
  4. 恢复完，在日志文件中加上`<T1, 回滚>`，表示下次不再恢复与T1相关的。
  
- Redo日志文件
  1. 在Redo日志文件中查找日志：有`<T1, 提交>`但没有`<T1, 结束>`；
  2. 把A, B的新值写入磁盘；
  3. 最后加上`<T1, 结束>`。

### 编程语言

#### 执行方式

> MSIL=Microsoft Intermediate Language 微软中间语言

| 执行方式             | 编程语言                                      | 特点               |
| -------------------- | --------------------------------------------- | ------------------ |
| 1. 编译执行          | Ada, C, C++, Rust, Go                         | 执行快；难以跨平台 |
| 2. 字节码：编译+解释 | Java                                          |                    |
|                      | Clojure, Scala, Jython, JRuby, Groovy, Kotlin | 编译成Java字节码   |
|                      | Ruby, PHP, Perl, Python                       | 创建自己的字节码   |
|                      | C#, VB.NET                                    | MSIL               |

#### 面向对象圣经

又名“神不在的星期天”

| 序列 | 内容                         | 说明                                                         | 相关人物                                               |
| ---- | ---------------------------- | ------------------------------------------------------------ | ------------------------------------------------------ |
| 1    | 编译器                       |                                                              | John Warner Backus 计算机科学先驱之一、图灵奖获得者    |
| 2    | 函数、数据结构               | 程序=算法+数据结构                                           | Dennis Ritchie C语言之父、UNIX创造者之一               |
| 3    | Object                       | `typedef struct Stack {...} Stack;`                          | Alan Kay 面向对象编程思想的创始人之一                  |
| 4    | Class                        | 重复的方法代码公共化，隐藏this/self。`Stack* stack = new Stack();` |                                                        |
| 5    | 继承、多态、设计模式 => 复用 | 优先使用组合而不是继承，面向接口编程而不是面向实现编程       | Erich Gamma ... 《设计模式：可复用面向对象软件的基础》 |
| 6    | 抽象                         | 系统需求抽象成高层的概念，在概念层次进行编程                 |                                                        |
| 7    | 休息……                       |                                                              |                                                        |

#### 通用特性

冯·诺依曼计算机

| 通用特性                     | 说明                                                       | 范例                                           |
| ---------------------------- | ---------------------------------------------------------- | ---------------------------------------------- |
| 面向对象                     | 封装、继承、多态，Prototype / Mixin / Traits / Duck Typing |                                                |
| 函数式编程                   | 高阶函数、闭包、惰性求值、递归、不可变状态、无副作用……     | JVM: Lisp, Clojure                             |
| 元编程                       |                                                            | Java动态代理CgLib，Lisp宏                      |
| 并发模型                     | 同步与互斥、锁、死锁、软件事务内存……                       | Java线程，Python协程，Go routine, Erlang Actor |
| 虚拟机和垃圾回收             |                                                            | JVM垃圾回收                                    |
| 静态类型、动态类型、类型推导 | 静态类型：编译期确定。动态类型：运行期确定                 |                                                |
| 抽象语法树                   | AST=Abstract Syntax Trees                                  |                                                |
| 指针                         |                                                            | C语言的灵魂                                    |
| 其它                         | 错误处理（异常）、泛型、同步异步、序列化                   |                                                |

## 码农翻身

- 用通俗易懂的方式讲解技术。用故事讲解技术的本质。
- 软件开发不就是抽象嘛。
- 既然改变不了别人，那就改变一下自己吧。
- 创造一个新工具，造福大家的想法一直激励着自己，有时候甚至觉得很快乐，不觉得累，每天都恋恋不舍地去上床睡觉。
- 大部分人只会抱怨项目很无趣、没有挑战，遇到问题也只会安于现状。只有少数人会发现工作中的“痛点”，并且真正动手解决它，给公司带来价值。这是提高自己，让自己和别人区分开来的重要方法。
- 源码之前，了无秘密。
- 软件的复杂性，尤其是复杂在细节上。
- 只要思考就有进步。
- 所谓编程，就是把自然语言的需求翻译成计算机语言，让计算机去执行。需要养成面向计算机的思维方式。
- 抽象大法好，用起来多简单、多友好。
- 不要被纷繁的现象迷住了双眼，要看透背后的本质，做出适当的抽象。
- 轻敌是最可怕的。
- 公平实在是一个稀缺货，不公平才是常态！年轻人不要总是抱怨这个社会，没用的，还是老老实实地奋斗吧。
- 每个人都要誓死捍卫自己的密码。
- 最宝贵的东西是数据，外界系统可以变，但是数据不能丢。（数据无价）

好莱坞原则：不要给我们打电话，我们会打给你的（Don't call us, we'll call you）。

### 1. 计算机

速度飞快的CPU，健忘的内存，慢如蜗牛的硬盘，任劳任怨的网卡……

#### 线程
线程：把一个进程当成资源的容器，在里面运行几个轻量级的进程。线程共享进程的所有资源，如地址空间、全局变量、文件源等。

多个资源加锁，按照资源“大小”比较，从最大的开始加锁。
资源“大小”：把资源变成一个数来比较，比如，可以用用字符串的hashcode来比较。

#### TCP/IP
TCP连接是虚拟的，连接的状态信息并不会在路上保存；相反，连接的状态信息是在两端维持的。
三次握手主要是为了验证客户端和服务器的发信和收信能力没问题，证明连接是通的。

所谓的TCP，无非就是在那些不可靠传输的基础上建立一种可靠的发送办法，基本上就是失败重发。
比如，滑动窗口，累积确认，分组缓存，流量控制。

| 次序 | 客户端 | 服务器 |
| ---- | ------ | ------ |
| 1    | ==>>   | ==>>   |
| 2    | <<==   | <<==   |
| 3    | ==>>   | ==>>   |

| 客户端知道的 | 发信 | 收信 |
| ------------ | ---- | ---- |
| 客户端       | 2    | 2    |
| 服务器       | 2    | 2    |

| 服务器知道的 | 发信 | 收信 |
| ------------ | ---- | ---- |
| 客户端       | 1    | 3    |
| 服务器       | 3    | 1    |

> 要想知道自己和对方的发送和接收能力是否正常，只需要自己向对方发信并且接收到对方的回复即可。

#### CPU
DMA = Direct Memory Access 直接内存访问
程序都是由顺序、跳转（分支、循环）组成的。

#### 进程
1. 批处理系统

2. 多道程序
PCB = Processing Control Block 进程控制块
MMU = Memory Management Unit 内存管理单元
静态重定位：直接修改程序的指令。
动态重定位：指令的地址，加上基址寄存器保存的起始地址。

3. 分时系统
时间片：CPU运行时间拆分，一个进程运行一段时间让出CPU，让别的进程使用。

对每个程序，不要全部装入内存，要分块装载。比如，先装载最重要的代码指令，在运行中再按需装载其他的。
页框 Page Frame：物理地址空间的小的内存块，每个为4KB。装载程序时按照页框大小进行。

虚拟内存：程序中的指令使用该空间，CPU的MMU把它们映射为真实的物理地址。
分页。页 Page：把虚拟地址空间分块，每个为4KB。
页表：用来映射虚拟页面和物理页面。

分段：一个程序被分成代码段、数据段、堆栈段（运行时堆、用户栈）等。

程序 - 段页式管理
[分段] -> 逻辑地址：段号 =段表=>基址 | 偏移量
[分页] -> 虚拟地址：页号 =页表=>页框号 | 偏移量
       -> 物理地址

进程结束后，内存中的数据会被清理、覆盖。

#### 磁盘
文件对人类来说是最小的存储单位。
每个目录也是一个inode，有目录的属性、存放该目录内容的磁盘块号等，在磁盘块中材真正地存放着目录下的内容。

超级块中包含磁盘块总数、每个磁盘块的大小、空闲块的个数、inode个数等重要信息。
文件系统的种类：NTFS, FAT, Ext2, Ext3, ...

#### I/O设备
卡：适配器。

I/O设备分类：
- 分类1：
  - 块设备：数据存储在固定大小的块中，每个块都有一个地址。如：硬盘、CD-ROM、U盘等。
  - 字符设备：由一个个字符组成的流，没有地址。如：键盘、鼠标、打印机。
- 分类2：
  - 存储设备。如：硬盘。
  - 传输设备。如网卡、调制解调器。
  - 人机交互设备。如：键盘、鼠标、显示器。

#### 数据库
事务日志，两条简单的规则：
- 在把新数据写入硬盘的数据文件之前，先把对应的日志写入硬盘的日志文件。
- [提交事务 T1]等的undo日志记录一定要在所有的新数据写入硬盘之后再写入。

数据库实现：查询解释器，查询执行引擎，缓冲区管理，授权管理，事务管理；数据，索引，元数据。

#### Socket
Socket = (IP, Port)

TCP是两个进程之间的通信。
TCP的连接必须得通过（client ip, client port, server ip, server port）来确定。
进程号是一个动态的东西，如果服务器端的进程重启了，进程号就变了。

Bill Joy，天才程序员，主要工作包括BSD UNIX操作系统、实现TCP/IP协议栈、vi编辑器、C Shell、NFS、SPARC处理器、JINI等。

```c
// Socket client伪代码
clientfd = socket(...);
connect(clientfd, serverip, serverport, ...);
send(clientfd, data);
receive(clientfd, ...);
close(clientfd);
```

```c++
// 浅浅封装一下
class Socket {
  private: 
    clientfd;
  public:
    Socket(serverip, serverport, ...) {
      this->clientfd = socket(...);
      connect(this->clientfd, serverip, serverport, ...);
    }
    Send(data) {
      send(this->clientfd, data);
    }
    Receive(...) {
      receive(this->clientfd, ...);
    }
    ~Socket() {
      close(this->clientfd);
    }
};

auto mySocket = new Socket(...);
mySocket->Send(data);
mySocket->Receive(...);
```

#### 翻译语言
机器语言。0 1
汇编语言。助记符。贴近机器，运行效率高；难以结构化编程。
高级语言。面向人类

编译的过程：
源程序 
-> 词法分析：“大刀向源程序头上砍去”，分成的每个片段叫作Token。
-> 语法分析：根据上下文无关语法理论，将Token按照语法规则构建成AST，其中的表示式递归定义。AST = Abstract Syntax Tree 抽象语法树
-> 语义分析：检查标识符的类型及作用域是否正确、运算是否合法、取值范围有没有问题等。
-> 中间代码生成 
-> 代码优化 
-> 代码生成。

#### 进程同步
多线程并发运行解决共享变量的方法：加锁。

1. 自旋锁：无限循环。
    不可重入：不能重新进入同一个函数。
    解决方法：引入计数器，申请时计数器+1，释放时计数器-1，计数器为0才表示真正地释放锁。

2. 信号量 Semaphore：一个整数，基于该整数的两个操作 - wait & signal。
操作系统在内核实现操作，可以通过屏蔽中断不让程序进行切换，保证原子性。

wait & signal
```c
int s;

wait(s) {
  while(s <= 0) {
    ;
  }
  s--;
}

signal(s) {
  s++;
}

// 互斥使用 - 信号量
int lock = 1;
wait(lock);   // => 获得一个互斥锁
// do some things...
signal(lock); // => 释放锁
```

改进的 wait & signal
解决“忙等待”（wait()函数在s <= 0时一直循环浪费CPU）
```c
typeof struct {
  int value;
  struct process* list;
} semaphore;

wait(semaphore* s) {
  s->value--;
  if (s->value < 0) {
    让自己进入阻塞状态，加入等待队列 s->list;
  }
}

signal(semaphore* s) {
  s->value++;
  if (s->value <= 0) {
    从等待队列 s->list 中唤醒一个，让它可以继续执行;
  }
}
```

解决生产者和消费者的同步问题 - 信号量
```c
// 简化起见，使用“忙等待”版本的信号量
int lock = 1;
int empty = 5;  // 初始队列有5个空位
int full = 0;

// 生产者
while(true) {
  // if empty <= 0，表示队列已满，没有空位，需要等待
  wait(empty);
  // 加锁
  wait(lock);
  做事情
  // 释放锁
  signal(lock);
  // 通知消费者，有东西了
  signal(full);
}

// 消费者
while(true) {
  // if full <= 0，表示队列空了，需要等待
  wait(full);
  // 加锁
  wait(lock);
  做事情
  // 释放锁
  signal(lock);
  // 通知生产者，有空位了
  signal(empty);
}
```

解决生产者和消费者的同步问题 - JAVA BlockingQueue
```java
// 建立一个队列
BlockingQueue queue = new LinkedBlockingQueue(5);

// 生产者
// 如果队列满，则线程自动阻塞，直到有空闲位置
queue.put(xxx);

// 消费者
// 如果队列空，则线程自动阻塞，直到有数据
queue.take();
```

#### 递归
递归：一个函数调用了自己。
每个递归函数必须有一个终止条件，否则会无限递归，导致栈溢出。

尾递归：递归调用是函数体中最后执行的语句，并且它的返回值不属于表达式的一部分。现代编译器据此生成优化的代码，复用栈帧。

每个栈帧表示被调用中的一个函数。

计算n的阶乘 factorial。（未考虑边界条件，如n<=0）
```c
// 1. 递归
int fac(int n) {
  return (n == 1 ? 1 : n * fac(n-1));
}

fac(4) = 4 * fac(3) = 4 * 6 = 24
fac(3) = 3 * fac(2) = 3 * 2 = 6
fac(2) = 2 * fac(1) = 2 * 1 = 2
fac(1) = 1

// 2. 尾递归
int fac(int n, int result) {
  return (n == 1 ? result : fac(n-1, n * result));
}

fac(4, 1)
= fac(3, 4*1)
= fac(2, 3*4*1)
= fac(1, 2*3*4*1)
= fac(1, 24)
= 24

// 3. 迭代
int fac(int n) {
  int result = 1;
  for(int i = 2; i <= n; ++i) {
    result *= i;
  }
  return result;
}
```

### 2. Java

Java是一门静态的强类型的编程语言。

#### Java Class
classpath：列举所有应该检查的目录。
ClassLoader：Bootsrap ClassLoader -> Extension ClassLoader -> App ClassLoader

基于堆栈的虚拟机，虚拟机的所有指令都是在对栈进行操作。

#### 持久化
ORM = Object-Relational Mapping 对象关系映射

轻量级O/R Mapping框架：
- Hiberante
- iBatis => MyBatis => MyBatis Plus
- Spring -> JdbcTemplate

#### JDBC
JDBC = Java Database Connectivity

所谓应用层的协议，就是你发什么请求、我给你什么响应、消息的格式和次序等。

连接 Connection：接口，用来代表和数据库的连接。
状态 Statement：接口，用来执行SQL。
结果集 ResultSet：接口，用来表示SQL返回的结果，提供对数据遍历的方法，比如，next(), getInt(xxx), getString(xxx), ...
驱动 Driver：接口，
Connection可以创建Satement，Statement执行查询可以得到ResultSet。

JDBC类之间的关系
```java
Connection conn = ...;  // 获取数据库连接
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery("select id, name from users");
while(rs.next()) {
  int id = rs.getInt("id");
  String name = rs.getString("name");
  ......
}
```

#### 分布式事务
全局事务管理器，负责协调各个数据库的事务提交。

强一致性：让两个数据库保持实时的一致性。
最终一致性：可以忍受一段时间的不一致，只要最终一致就行。

XA协议：事务管理器 Transaction Manager，局部资源管理器 Local Resource Manager。

幂等性：重复执行，结果一致。

1. 两阶段提交：
- 预提交阶段 prepare
- 提交阶段 commit

2. 三阶段提交：
- canCommit
- preCommit
- doCommit

3. 基于消息队列 message queue
基本可用，最终一致性。

#### 消息队列
JNDI = Java Naming and Directory Interface Java命名和目录接口
JMS = Java Message Service Java消息服务

点对点模型 Point to Point
发布/订阅模型 Publish/Subscribe

JMS代码
```java
// 从配置中找到ConnectionFactory和Destination(Queue)
Context ctx = new InitialContext(properties);

QueueConnectionFactory factory = (QueueConnectionFactory)ctx.lookup("<orderConnFactory>");

Queue orderQueue = (Queue)ctx.lookup("orderQueue");
Queue deliverQueue = (Queue)ctx.lookup("deliverQueue");
// 创建Connection和Session
Connection conn = factory.crateConnection();

QueueSession session = conn.createQueueSession(false, Session.AUTO_ACKNOWLEDGE);

// 创建消息生产者并发送消息
MessageProducer producer = session.createProducer(orderQueue);

TextMessage msg = session.createTextMessage("hello world");

// 创建消息消费者并接收消息
MessageConsumer consumer = session.createConsumer(deliverQueue);
TextMessage deliverMsg = (TextMessage)consumer.receive();
String text = deliverMsg.getText();
```

![码农翻身-消息队列-JMS](https://cdn.jsdelivr.net/gh/sstian/images/blogimg/码农翻身-消息队列-JMS.jpg)

#### 动态代理
动态代理：在运行时动态地生成类，作为一个真实对象的代理来做事情。因为不能修改现有的类。

```java
// HelloWorld
public interface IHelloWorld {
  public void sayHello();
}
public class HelloWorld implements IHelloWorld {
  public void sayHello() {
    System.out.println("hello world");
  }
}

// LoggerHandler
public class LoggerHandler implements InvocationHander {
  private Object target;

  public LoggerHandler(Object target) {
    this.target = target;
  }
  public Object invove(Object proxy, Method method, Object[] args) throws Throwable {
    Logger.startLog();
    Object result = method.invoke(target, args);
    Logger.endLog();
    return result;
  }
}

// 使用动态代理增强HelloWorld
IHelloWorld hw = new HelloWorld();
LoggerHandler handler = new LoggerHandler(hw);
IHelloWorld proxy = (IHelloWorld)Proxy.newProxyInstance(
  Thread.currentThread().getContextClassLoader(),
  hw.getClass().getInterfaces(),
  handler
  );
proxy.sayHello();
```

#### 注解
所谓的注解，有点像加强版的注释。

使用注解，配置靠近代码，容易阅读、容易修改。
对于需要集中配置的场合，可以使用XML，比如，数据源的配置。

元数据 Metadata：描述数据的数据。可以给其他数据提供描述性信息。

元注解：注解的注解。
- @Target：表示该注解的应用目标，可以是类、方法、方法参数等。
- @Retention：表示该注解保留到何时，可以是只在源码中、在.class文件中、在运行时。

注解的定义和使用只是定义了行为语义。
在运行时通过反射的方式获取应用目标的注解，逻辑处理后，通过反射的方式去执行。
```java
// 自定义@Test注解
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface Test {
  boolean ignore() default false;
}

// 使用@Test注解
public class CalculatorTest {
  @Test
  public void testAdd() {
    System.out.println("test add method");
  }

  @Test(ignore=true)
  public void testSubtract() {
    System.out.println("test substract method");
  }
}

// 获取@Test注解
public class TestUtil {
  public static void main(String[] args) throws Exception {
    CalculatorTest obj = new CalculatorTest();
    run(obj);
  }
  public static void run(Object obj) throws Excpetion {
    for (Method m : obj.getClass().getMethods()) {
      Test t = m.getDeclaredAnnotation(Test.class);
      if (t != null && !t.ignore()) {
        m.invoe(obj);
      }
    }
  }
}
```

#### 泛型
不用膨胀法，而用擦除法（一个参数化的类型经过擦除后会去除参数）。

#### 日志系统
Logger
Appender
Formatter

正交性：变化被封装在一个维度上，接口可以任意组合。

SLF4J = Simple Logging Facade for Java
Log4j = Log for Java

应用程序 
-> 抽象层 (SLF4J API)
  -> Logback
  -> 适配层 -> Log4j, JDK java.util.logging, tinylog, ...

SLF4J + Logback
Apache Common Logging + Log4j

#### 序列化
~~RMI = Remote Method Invocation 远程方法调用~~
RPC = Remote Procedure Call 远程过程调用

#### 加锁
JNI = Java Native Interface Java本地接口
可以用C语言实现，然后在Java中封装。

1. 互斥锁
互斥：同一时刻只有获得锁的那个线程才有资格去操作共享资源，其它线程都被阻塞了，被放到一个锁池（Lock Pool）的地方，什么也做不了。
synchronized - 悲观锁
```java
public class Sequence {
  private int value;
  public synchronized int next() { 
    return value++; 
  }
}
```
2. CAS = Compare and Swap - 乐观锁
操作系统和硬件保证原子执行。
如果内存的值被被人修改过，那就再次循环尝试。
Atomic类：AtomicBoolean, AtomicInteger, AtomicLong, AtomicIntegerArry, AtomicLongArray, AtomicReference, AtomicStampedReference.
ConcurrentLinkedQueue
```java
public class Sequence {
  private AtomicInteger count = new AtomicInteger(0);
  public int next {
    while (true) {
      int current = count.get();
      int next = current + 1;
      if (count.compareAndSet(current, next)) {
        return next;
      }
    }
  }
}
```

#### Spring
AOP = Aspect Oriented Programming 面向切面编程
IoC = Inversion of Control 控制反转
DI = Dependency Injection 依赖注入

CGLib = Code Generation Library

动态生成代理类的两种方法：
- 使用Java动态代理，要求业务类必须有接口 interface。
- 使用CGLib，会生成一个业务类的子类来作为代理类，只要业务类没有被标记为final即可。

容器创建对象：
1. 调用方说：给我一个xxx对象
2. 容器，创建代理类，设置AOP的代码
3. 返回xxx的代理对象

### 3. Web
WSDL = Web Service Description Language Web服务描述语言
SOAP = Simple Object Access Protocol 简单对象访问协议
Web服务的描述方式和数据传输方式：
- WSDL + SOAP。烦琐，都是XML，数据标签冗余。
- 轻量级的HTTP + JSON

#### HTTPS
CA = Certificate Authority 认证中心

Hash，哈希/散列
常见算法：MD5, SHA等
重要特性：
- 不可逆性：从Hash值反推出原消息是不可能的。
- 抗冲突性：给定消息M1，不存在另一条消息M2，使得Hash(M1)=Hash(M2)。
- 分布均匀性：Hash算法的结果是均匀分布的。

原始信息 --Hash算法--> 消息摘要 --用CA的私钥加密--> 数字签名
数字证书 = 原始信息 + 数字签名

对称加密 => 非对称加密 => 非对称+对称 => 数字证书

简化版的HTTPS流程（没有包含Pre-Master Secret）：
浏览器 -- 服务器
==>> 浏览器发出安全请求（https://xxx.com）
<<== 服务器发送数字证书（包含服务器的公钥）
==== 浏览器用预置的CA列表验证证书，如果有问题，则提示风险
==>> 浏览器生成随机的对称秘钥，用服务器的公钥加密
==== 服务器用自己的私钥进行解密，得到对称秘钥
<==> 双方都知道了对称秘钥，用它来加密通信

#### 授权
1. token -> appid + secrect
2. 授权码 Authorization Code + token -> appid + secret + code

OAuth = Open Authorization
认证方式：
- Resource Owner Password Credential Grant 资源所有者密码凭证许可
- Implicit Grant 隐式许可
- Authorization Code Grant 授权码许可

资源所有者，资源服务器，客户端，授权服务器

#### 系统的高可用和负载均衡
Redis的Java客户端软件Jedis。
使用Jedis访问缓存：

```java
// 初始化pool，192.168.0.10为缓存服务器地址
JedisPool pool = new JedisPool(new JedisPoolConfig(), "192.168.0.10");
try (Jedis jedis = pool.getResource()) {
  User user = ...要保存的用户对象...
  jedis.set(user.getID(), user.toJSONString());
}
// 关闭pool
pool.close();
```

1. 缓存服务器集群的负载均衡
- ~~余数算法~~
对于用户要存储的(key, value)，计算出key的一个整数Hash值，然后用这个Hash值对服务器数据求余数。
但是在增删缓存服务器时，缓存会失效。
- 一致性哈希算法
当增删缓存服务器时，只会影响相邻节点的缓存数据，其它部分的数据与原来保持一致。
能极大地解决缓存失效问题，把失效的缓存控制在特定的区间。
- 哈希槽 Hash Slot
共有16384个槽，每台服务器分管其中一部分。
分发数据 - CRC16(key)%16384，对key产生一个整数值然后求余

CRC = Cyclic Redundancy Check 循环冗余校验

2. 高可用的Nginx
Keepalived - 将Nginx集群分成master-slave结构，同一时刻只有一个工作，另一个原地待命，挂掉则接管；对外只提供一个IP地址。

3. 高可用的Tomcat
把session放到Redis集群中

4. 数据库的读写分离：
一个master库，多个slave库。
master库可读可写，slave库只能读、不能写。最后还要将master库的数据尽快复制到slave库，让数据保持一致。

#### 微服务 microservice
OA = Office Automation 办公自动化
CRM = Customer Relationship Management 客户关系管理系统
ERP = Enterprise Resource Planning 企业资源计划
SOA = Service Oriented Architecture 面向服务架构
ESB = Enterprise Service Bus 企业服务总线
SCA = Service Component Architecture 服务组件架构
BEPL = Business Execution Process Language 业务执行过程语言

不是集成，而是拆分。
让小组件能完全独立地开发、测试和部署。

#### 框架
最佳实践：不断寻找好的实现方式，找到以后就把各种经验固化下来。
框架就像一个模板，里面预置了一些公认的最佳实践。
框架是一个半成品，是无法独立运行的，必须由开发人员按照它定义的规则，把项目代码放置到指定的地方，由框架整合起来，这才是一个完整的应用程序。

学无止境啊！
Java SE - 集合、线程、反射、I/O、泛型、注解……
Java后端 - 系统架构设计、缓存、性能、高可用性、分布式、安全、备份……

#### HTTP Server
fd = file descriptor 文件描述符，是一个整数

1. 单进程，阻塞式
2. 多进程

3. select模型
一个进程最多只能监控1024个socket。

![码农翻身-http_server-select模型](https://cdn.jsdelivr.net/gh/sstian/images/blogimg/码农翻身-http_server-select模型.jpg)

4. epoll模型
操作系统只会告诉http server那些可以读/写（准备就绪）的socket，
不需要遍历全部集合，只需要处理那些有变化的、活跃的socket fd。

![码农翻身-http_server-epoll模型](https://cdn.jsdelivr.net/gh/sstian/images/blogimg/码农翻身-http_server-epoll模型.jpg)

### 4. 代码管理那些事儿

VCS = Version Control System 版本控制系统
- 集中式：代码仓库共享，只在服务器端，如：CVS, SVN
- 分布式：每个人都有一个本地私有代码仓库，服务器端代码仓库共享，如：Git, Mercury, IBM RTC

Pull Request 拉取请求：请求项目维护者拉取自己的修改。
GitHub：Web版本的代码托管平台

Maven之路径的约定：“约定重于配置”
| 文件                     | 路径               |
| ------------------------ | ------------------ |
| Java源文件               | src/main/java      |
| Resource文件             | src/main/resources |
| Web应用的源码            | src/main/webapp    |
| Java单元测试源文件       | src/test/java      |
| Java单元测试Resource文件 | src/test/resources |
| 编译后的Java class文件   | target/classes     |

面向对象的代码是针对接口编程的。
重构的过程基本就是一个重新设计的过程。很少公司能推倒重来，要么业务发生了变革，要么技术进行了转型；慢慢重构，所谓的革新，而不是革命。
TDD = Test Driven Development 测试驱动开发

《修改代码的艺术》，接缝：程序中一些特殊的点，在这些点上无需修改现有代码，只需要编写扩展代码就可以达到改动程序行为的目的。Mock代码通常可以在这里安插。
Mock工具：EasyMock, Jmockit
如何做单元测试，关键在于如何处理遗留代码。
优秀的单元测试：
1.单元测试是“白盒测试”，应该覆盖各个分支流程、异常条件。
2.单元测试面向的是一个单元（Unit），是由Java中的一个类或者几个类组成的单元。
3.单元测试的运行速度一定要快！
4.单元测试一定是可重复执行的！
5.单元测试之间不能有相互依赖，应该是独立的！
6.单元测试代码和业务代码同等重要，要一并维护！

### 5. 我的编程语言简史

前端“三剑客”：
HTML负责结构布局
CSS负责美化展示
JavaScript负责交互逻辑

JavaScript，操作HTML的DOM和浏览器。
XMLHttpRequest，允许JavaScript直接向服务器发起接口调用。
AJAX = Asynchronous JavaScript And XML，用作的异步处理方式，使得网页局部刷新。

Node.js，使用Chrome V8引擎执行JavaScript，用于服务端。只用一个线程处理所有请求，事件驱动编程。

C语言，代码的可移植性，并非程序的可移植性。做系统级编程，使用指针直接操作内存、和硬件交互，追求性能和效率。
代码指源代码，不同系统平台使用条件编译。程序指编译后的。
*.exe一旦运行，那就是一个独立的进程，拥有一个独立的地址空间，被CPU独立调度。
Java虚拟机（java.exe）才是一个进程，*.class被装载以后只能在这个进程里作为一个线程来运行。
链接：把一个符号（调用的函数的名称）和这个符号的地址（调用的函数的真正地址，有该函数的指令）绑定起来。
C在编译时链接，即静态链接。Java在运行时链接，即动态链接。

C++之父：现在C++教育似乎进入了一个怪圈，要教会一个人C++，唯一的办法就是把他教成C++高手。
学习编程语言的经验：多读书，多实践，多看优秀的源码。
书籍：《C++ Primer》《深入理解C++对象模型》《Effective C++》《VC++技术内幕》《深入浅出MFC》

Java，最适合后端编程。Applet，速度慢，还丑。
书籍：《Effective Java》《Java编程思想》《Java核心技术》《深入Java虚拟机》

DSL = Domain Specific Language 领域特定语言
SQL就是对数据库操作的DSL。

Ruby on Rails (RoR) 利用Ruby语言近乎“变态”的灵活性，以及“约定重于配置”的实践，把Web开发简化到了极致。
Ruby代码简洁、优雅、富有表现力。

在一台冯·诺依曼计算机中，最核心的就是CPU和指令，指令和数据就存放在内存当中，CPU每次取出一条指令，译码、执行，然后把结果写回内存，本质就这么简单。

函数式编程 Functional Programming：
一种"编程范式"（programming paradigm），即如何编写程序的方法论。
属于"结构化编程"的一种，主要思想是把运算过程尽量写成一系列嵌套的函数调用。
特性：声明式，闭包/仿函数（functor）对象和高阶函数，惰性计算，用递归而不用迭代。
特点：
1. 函数是"第一等公民"
函数与其他数据类型一样，处于平等地位，可以赋值给其他变量，也可以作为参数，传入另一个函数，或者作为别的函数的返回值。
2. 只用"表达式"，不用"语句"
每一步都是单纯的运算，而且都有返回值。
"表达式"（expression）是一个单纯的运算过程，总是有返回值；"语句"（statement）是执行某种操作，没有返回值。
3. 没有"副作用"
函数要保持独立，所有功能就是返回一个新的值，没有其他行为，尤其是不得修改外部变量的值。
"副作用"（side effect），指的是函数内部与外部互动（最典型的情况，就是修改全局变量的值），产生运算以外的其他结果。
4. 不修改状态
只是返回新的值，不修改系统变量。使用参数保存状态，最好的例子就是递归。
5. 引用透明性
同样的输入，函数总是返回同样的结果。

### 6. 老司机的精进

世上哪儿有等你完全准备好以后才开始的事情？你觉得完全准备好以后，黄花菜都凉了。
对于性格内向的程序员，很多时候你认为基本准备好了其实就够了，凡是必先骑上虎背，勇敢地迈出去，努力地争取一下，你就会发现自己登上了更高一层的台阶。

码农“潜规则”：
1. 局部性原理
在一段时间内，整个程序的执行仅限于程序的某一部分，相应地，程序访问的存储空间也局限于某个内存区域。局部性原理具体分为两类。
1.时间局部性：如果程序中的某条指令一旦执行，则不就之后该指令可能再次被执行；如果某数据被访问，则不久之后该数据可能再次被访问。
2.空间局部性：是指一旦程序访问了某个存储单元，则不久之后，其附近的存储单元也将被访问。
2. 缓存
3. 抽象
《深入理解计算机系统》：指令集是对CPU的抽象，文件是对输入/输出设备的抽象，虚拟存储是对程序存储的抽象，进程是对一个正在运行的程序的抽象，而虚拟机是对整个计算机（包括操作系统、处理器和程序）的抽象。
4. 分层
通过层次把复杂的、可能变化的东西隔离开来，某一层只能访问它的直接上层和下层，不能跨层访问。隔离变化。
5. 异步调用
6. 分而治之
基本思想是：将一个规模比较大的问题分解为多个规模较小的子问题，这些子问题相互独立且与原问题性质相同，求出子问题的解，最后组合起来就可得到原问题的解。

架构师的总结：
1. 好奇心
没有好奇心，没有兴趣，怎么会产生Passion（激情）呢？对技术的好奇心/兴趣是一切的基础。
2. 养成计算机的思维方式
程序员的基本功：养成计算机的思维方式，流畅地把人类语言的需求转换成计算机语言。
基本功的训练就是算法和数据结构；经验是多做习题，让思维在脑子里固化，以后的编程就可以信手拈来了。
3. 扎实基础，融会贯通
计算机组成原理、操作系统、编译原理、计算机网络、数据库、汇编语言。
4. 要透彻地理解一门技术的本质
只有学会使用是不行的，不但要知道How，还要知道Why。
停下来，思考，才是进步的本质。
5. 能写漂亮的代码
写出漂亮代码并不容易，需要思路清晰，有良好的编程基础，有优秀的抽象能力，以及对一门语言的熟练掌握。
6. 抽象的能力
把纷杂的事物抽象到数学层面，已经非常难了；哲学层面是尽头。
正交在数学上指的是线性无关。正交的威力在于互不影响、扩展方便。
抽象能力的训练没有捷径，就是积累经验、勤于思考、善于学习。
7. 技术领导力
要用技术的影响力来领导人，而不是权威和职位。
有了技术领导力，你在团队里发出的声音才会被倾听、被尊重。
贴上标签：大牛（大佬）。

看书，知识体系更加完整、理解更有深度。
写作：写笔记、写博客，从内容的消费者变成内容的生产者。
“转教别人”（Teach others）的办法属于主动学习，效率是最高的。

## 公众号文章

程序员的圣地：
- 量子力学
- 晶体管
- 逻辑电路
- 指令集/机器语言
- 汇编语言
- 高级语言
- 应用程序

技术管理者：既要管人，又要管事。特点是快速学习。通过漂亮的代码“征服”程序员，通过良好的沟通说服程序员。进可成为某个领域的专家，退可转型为管理者。

- 基础不牢，地动山摇。
- Joel Spolsky：抽象只能节省你的工作时间，不能节省你的学习时间。
- Lisp大佬Richard P. Gabriel：Worse is better。软件设计有四个目标：简单性，正确性，一致性，完整性。
