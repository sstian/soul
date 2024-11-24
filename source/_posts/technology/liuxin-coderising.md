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
| 元编程                       | 使用模板，用程序生成程序                                   | Java动态代理CgLib，Lisp宏                      |
| 并发模型                     | 同步与互斥、锁、死锁、软件事务内存……                       | Java线程，Python协程，Go routine, Erlang Actor |
| 虚拟机和垃圾回收             | 字节码，垃圾回收算法                                       | JVM垃圾回收                                    |
| 静态类型、动态类型、类型推导 | 静态类型：编译期确定。动态类型：运行期确定                 |                                                |
| 抽象语法树                   | AST=Abstract Syntax Trees                                  |                                                |
| 指针                         | 内存地址                                                   | C语言的灵魂                                    |
| 其它                         | 错误处理（异常）、泛型、同步异步、序列化                   |                                                |

## 码农翻身 1 *

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

#### Microservice 微服务
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

## 码农翻身 2 *

PBC = Personal Business Commitment 个人业务承诺
VCS = Version Control System 版本控制系统

GNU = GNU's Not Unix!
> GNU = Generic Non-conmercial Unix ?

bootstraping 自举

- Why有时候比How重要得多，懂得Why以后，再去看How，就犹如开启了“上帝视角”，一切都变得简单起来。
- 历史的车轮滚滚向前，想逆潮流而动，无异于螳臂当车。
- “大牛”的风格：多说无益，直接上代码。Talk is cheap, Show me the code!

### 1. 基础知识

#### 负载均衡
LVS = Linux Virtual Server：工作在OSI 模型的四层，基于IP进行负载均衡。
工作模式：
- NAT = Network Address Translation
- DR = Direct Routing 直接路由
- TUN = Tunneling 隧道

#### 双击热备
Simple Point of Failure 单点失败

动态绑定解绑VIP（Virtual IP），使其在不同服务器之间移动。

#### 阻塞与异步
不同设备的速度：

|                                | 时间     | 相当于   |
| ------------------------------ | -------- | -------- |
| 1个CPU周期                     | 0.3纳秒  | 1秒      |
| 内存访问                       | 120纳秒  | 6分钟    |
| 读写机械硬盘                   | 1~10毫秒 | 1~12个月 |
| 网络访问（从旧金山大澳大利亚） | 183毫秒  | 19年     |

Node.js，单线程（好处是不用对内存的数据加锁），非阻塞IO，事件循环。
![Node.js-事件循环](https://cdn.jsdelivr.net/gh/sstian/images/blogimg/Node.js-事件循环.JPG)

#### 零拷贝 zero copy
用户态 // 
内核态 // 数据 -> [硬盘] --DMA复制--> [内核缓冲区] --复制--> [socket缓冲区]

网卡驱动可以直接从内核缓冲区中读取数据。
从内核角度来看，除了把文件从硬盘中读取出来，没有任何额外的copy操作。
zero copy减少了上下文的切换，避免了数据被不断地在用户态和核心态之间搬运，不要CPU参与数据复制，提高了系统性能。
引入该技术的实例，Nginx、Apache等Web服务器。

#### 内存
地址从低到高，以字节为单位。
- 先高位再地位 -> 大端法 -- 网络字节序
- 先地位再高位 -> 小端法 -- 主机字节序

网络字节序 --lton()-->|<--ntol()-- 主机字节序

信息 = 位 + 上下文

程序想通过指针访问自己根本没有访问权限的区域，操作系统会引发segment fault，杀死这个程序，释放它的内存空间，生成core dump文件。

### 2. 后端

#### 状态
无状态的HTTP管理会话：
session id -> session sticky复制 -> 集中存储session id 
-> 验证：token（组合数据和签名），有效期，黑名单（有效期还没到，但是要立即失效的token）

#### 缓存
解决数据同步/缓存同步的一种方法：Cache Aside Pattern
- 读数据流程：1. 从缓存中读取。2. 缓存中有数据，直接返回；缓存中没有数据，访问数据库。3. 把从数据库中读取的值写入缓存。
- 写数据流程：1. 更新数据库。2. 使缓存中的数据失效。

缓存穿透：查询一个根本不存在的数据,缓存层和持久层都不会命中。
  可选解决方式：布隆过滤器 Bloom Filter，一种数据结构，只需要极少的空间就可以判断出一个元素绝对不在一个集合内或者可能在一个集合内。
  （一定的误报也是被允许的，没有完美的事情，总要付出代价的。）
缓存失效：超级热门的数据失效了。
  可选解决方式：Redis分布式锁。

#### 数据复制
**机械硬盘**，磁头在光滑的**盘片**上滑来滑去，寻找**磁道**，定位**扇区**，读取数据。

读写分离：
1. 基于SQL语句的复制。
    “重放”（重新执行）SQL。
    缺点：不能解决存在随机数RAND的记录。
2. 基于行的复制。
    记录SQL操作的日志：
    insert语句，记录所有列的新值；
    delete语句，记录被删除的行，用主键标识；
    update语句，记录更新的行，用主键标识，以及更新的列和新值。
    缺点：处理大量数据时性能低下。
3. 两者的混合模式。

数据延迟：复制数据需要时间，能保证最终一致性，不能保证实时一致性。
  可选解决方式：将不能容忍延迟的操作放在主库里读写。

#### 分布式ID - Snowflake
专门解决分布式系统的唯一ID问题。
64位整数：
- 1位 暂时不用。
- 41位 时间戳，精确到毫秒。
- 10位 机器ID，可以自由分配，例如5位机房号+5位机器号
- 12位 序列哈

Snoeflake的特性：
1. ID 生成算法没有网络调用，不用数据库，非常快！
2. 同一台机器，在同一时间（毫秒）内生成的ID是不同的。
3. 将毫秒数放在最高位，生成的ID是趋势递增的。

> 分布式ID - Snowflake
> 分布式事务 - 两阶段提交
> 分布式存储 - HDFS
> 分布式服务：微服务
> 分布式计算：云计算
> 分布式VCS：Git
> 分布式搜索引擎：Elastic Search

#### Serverless 无服务器
Serverless，不是没有服务器，而是服务器对用户是透明的。应用的装载、启动、卸载、路由均需要平台来搞定。
更适合无状态的应用，比如图像和视频的加工、转换，物联网设备状态的信息处理等。
不适合需要保存 会话状态、数据持久化 的应用。应以“服务”的方式呈现，即BaaS = Backend as a Service

API GateWay，转发请求到确定的某个函数。

#### NoSQL 非关系型数据库
关系型数据库，模式+规范化。必须事先定义好模式（表结构）才能保存数据。
数据库厂商的“方言”和存储过程，规则各异。
O/R Mapping - Java Hibernate/iBatis/JPA，.NET NHibernate

NoSQL = Not Only SQL
优点：支持分布式和集群。
弱点：缺乏模式（如表结构），数据完整性约束很弱，对事务的支持很弱甚至没有。
分类：
1. 键值对 key-value：Redis, Memcached。当缓存用。
2. JSON文档：MongoDB, CouchDB。树状结构数据。
3. 图结构：Neo4j。表示社交网络、推荐系统的系统。
4. 列式数据库：HBase, Cassandra。两级嵌套的Map；存储移动互联网产生的海量数据，如日志、聊天记录、监控数据、物联网数据等，结构化不强。

### 3. 中间件

#### Elastic Search
Lucene -> Elastic Search（2010.02）

inverted index 倒排索引

Lucene，类图设计：
1. 文档分析设计：
Document类，表示HTML/PDF/Word/DB的抽象，属性叫作Field；原始内容划分为一个个Term
Analyzer抽象类，负责对Document进行分析
    子类：StandardAnalyzer, SimpleAnalyzer, ...
IndexWriter类，将分析结果加入索引库
Directory抽象类，表示索引文件的存储
    子类：RAMDirectory, FSDirectory
2. 用户搜索设计：
QueryParser，解析用户输入的搜索字符串为Query
Query，表示用户的搜索要求。子类：
    TermQuery，查询特定Field上的Term
    BooleanQuery，将各个查询用AND,OR,NOT组合起来
    WildcardQuery，支持通配符的查询
IndexSearcher，接收Query，实现搜索

Elastic Search，用RESTful方式表示索引。
如：/myapp/blog/1001
/myapp 表示 索引库 -- 数据库
/blog 表示 索引的类型 -- 数据库的表
1001 表示 数据的ID -- 数据库的表的记录

分布式存储，存储海量的索引数据。
1. 索引分片：索引 index，分片 shard，机器/节点 node。
`shard编号 = hash(文档的ID) % shard总数`
用户在创建索引库的时候，必须指定shard的数量，并且不能更改。`"number_of_shards": 3`
2. 索引备份：主分片 primary shard。`"number_of_replicas": 3`

客户端读写文档。
可以让请求发送到集群的任意一个节点，并且让每个节点都具备处理任何请求的能力。
要求各个节点之间互通有无。
选举主节点 Master，维护整个集群的状态，如增加或移除节点、创建或删除索引库、维护主分片和集群的关系等。

Web, RESTful, REST API, HTTP+JSON

好的设计是成功的一半。好的设计一般都比较漂亮。
软件设计就是一个不断抽象的过程。
好用就是最大的“生产力”。

#### HDFS
HDFS = Hadoop Distributed File System。（Hadoop，玩具象的名字）
适合“一次写入，多次读取”。

元数据Metadata：文件分块信息和位置、系统中服务器信息和占据的空间等。
NameNode，存储元数据的服务器。
DataNode，存储数据的服务器。
NameNode和DataNode需要定期通信，设计一个通信协议。

读取文件，NameNode值返回文件的分块及该分块所在的DataNode列表。“距离”：数据中心 > 机架 > 机器。
写入文件，把多个DataNode组成一个管道Pipeline，让数据在管道内“流动”起来，只把数据发送给第一个DataNode，第一个给第二个发送备份，以此类推。

MapRecude，程序1为Mapper，程序2为Reducer。
Map，数据的变换。
Reduce，给定一个函数和初始值，每次对列表中的一个元素调用该函数，不断地“折叠”一个列表，最终把它变成一个值。
实现并行计算，尽可能地让计算靠近数据，降低网络流量的开销。

Divide and Conquer 分而治之
“魔鬼”都是存在于细节中的，一遇到异常分支，程序就变得异常复杂。
什么是框架？框架自然是搭建好基础设施，把重复的工作都做了，让用户写的程序越简单越好的强大工具。

#### Quartz 任务调度系统
设计灵活，可扩展，持久化 -> RAM/DB，高可用 -> 集群。

设计类：
Job接口，表示要执行的任务
  实现类：SendMailJob, CopyDataJob, ...
Trigger接口，表示定时触发。实现类：
  SimpleTrigger，指定Job开始的时间、触发的时间的间隔、运行多少次
  CronTrigger，可以像crontab那样定义Job运行的时间
  ……
Scheduler接口，调度器，接收Job，按照各种Trigger运行。

持久化设计：
JobStore接口，表示Job的存储。实现类：
  RAMJobStore，把Job运行情况保存在内存中
  DbJobStore，把Job运行情况保存在数据库中
DriverDelegate接口，用于屏蔽数据库细节，供DbJobStore使用
  实现类：StdJDBCDelegate
    继承类：OracleDelegate, Db2Delegate, ... 不用数据库独有的实现

高可用设计：
把定时任务调度系统部署到多台机器上，形成几个备份；集中存储调度信息。

保证同一时刻一个Job只能在一个实例上运行：
多加一个数据表 LOCKS，里面的每一行记录都可以当作一把“锁”来用，即数据库的行锁，别的事务只能等待当前事务被提交以后才能访问。
比如 `select * from LOCKS where LOCK_NAME = "TRIGGER" for update`

#### 数据查询方式的演变
1. rexec
一台机器上远程执行另一台机器的命令
> remote execute

2. RPC
CORBA = Common Object Request Broker Architecture 公共对象请求代理体系结构
RMI = Remote Method Invocation 远程方法调用
客户端代理 Stub，服务器端代理 Skeleton

3. XML-RPC
HTTP+XML
用XML描述接口：
```xml
<methodCall>
  <methodName>findUser</methodName>
    <params>
      <param>
        <value><int>10001</int></value>
      </param>
    </params>
</methodCall>
```
用XML描述对象：
```xml
<value>
  <struct>
    <member>
      <name>name</name>
      <value><string>Andy</string></value>
    </member>
    <member>
      <name>age</name>
      <value><int>22</int></value>
    </member>
  </struct>
</value>
```

4. Web Service
一套协议：
- WSDL = Web Services Description Language Web服务描述语言：用于描述一个服务的接口名、输入/输出、参数类型等信息。
- UDDI = Universal Description Discovery and Integration：实现服务的注册和发现。
- SOAP = Simple Object Access Protocol 简单对象访问协议：类似XML-RPC，但是更加规范、正式、复杂……

服务提供者 --发布WSDL--> UDDI
服务消费者 --发现服务和它的地址--> UDDI
服务消费者 --调用（SOAP）--> 服务提供者

5. RESTful API
HTTP+JSON
用URI表示资源，用HTTP方法充当动词。
存在的问题：1 发送请求过多。2. 太多的额外信息。
关系模型在表示树形/图形关联的时候，非常不方便。

6. GraphQL
HTTP+JSON, 后端数据模型师图Graph
定义类型及属性：
```graphql
type Artical {
  id INT!
  tile String!
  abstract String!
  author User
}

type User {
  id INT!
  name Sting!
  avatar_url String!
  friends [User]
}
```

Google Protobuf，Dubbo

无论什么技术，都有非常古老的遗留系统需要维护，真是“命苦”的程序员啊。

#### ZooKeeper
ZooKeeper的关键概念和API：

| 概念    | 描述                                                         |
| ------- | ------------------------------------------------------------ |
| session | 表示某个客户系统（如 Batch Job）和 ZooKeeper 之间的连接会话。Batch Job 连接上ZooKeeper 以后会周期性地发送心跳信息，如果 ZooKeeper 在特定时间内收不到心跳信息，就会认为这个Batch Job 已经挂掉了，session 就会结束 |
| znode   | 树形结构中的每个节点叫作 znode，按类型可以分为永久的znode（除非主动删除，否则一直存在）、临时的 znode（session 结束就会被删除）和顺序的 znode（分布式锁中的 process_01、process_02...） |
| Watch   | 某个客户系统（如 Batch Job）可以监控 znode节点的变化（删除、修改数据等），这样 Batch Job 可以采取相应的动作，如抢着创建节点 |

#### JPDA调试
Java文件编译成class文件后，LineNumberTable区域描述了Java源码和字节码行号（字节码偏移量）之间的对应关系，用来添加断点调试。

C调试器 gdb，Java调试器 Java Debugger。

为了保证被调试程序的独立性，调试器和被调试程序不能处于一个JVM中，通过共享内存的方式通信。

JPDA = Java Platform Debugger Architecture：Java平台调试器架构，是一套Java虚拟机自带的调试体系。
由三个部分组成：
- JVM TI = Java VM Tool Interface：定义VM（虚拟机）的调试服务。包括但不限于：JVM分析，监控，调试，线程分析，以及覆盖率分析等功能。由JVM提供，与具体语言无关。
- JDWP = Java Debug Wire Protocol：定义调试器与调试者的通信协议，即传输信息和请求数据格式，但不限制传输机制（socket, serial line, share memory, ...）。
- JDI = Java Debug Interface：Java语言实现的Debug Inteface，可以直接使用其编写远程调试工具。

先通过JDI接口创建断点，然后在断点处获取变量的值。背后会用JDWP向JVM TI发出请求，获取数据。
创建一个断点：
```java
ClassPrepareEvnet event = ......
ClassType classType = (ClassType)event.referenceType();

// 获取表示第10行的Location对象
Location location = classType.locationOfLine(10).get(0);

// 通过Location对象创建一个断点
BreakpointRequest bpReg = vm.eventRequestManager().createBreakpointRequest(location);
bpReg.enable();
```

在断点处获取变量的值：
```java
// 到达了一个断点处
BreakpointEvent event = ......
// 获取当前的线程
ThreadReference threadReference = event.thread();

// 获取当前的栈帧
StackFrame stackFrame = threadReference.frame(0);

// 从栈帧中得到本地变量i
LocalVariable localVariable = stackFrame.visibleVariableByName("1");
Value value = stackFrame.getValue(localVariable);
int i = ((IntegerValue)value).value();
System.out.println("The local variable i is " + i)
```

### 4. 编程语言的特性

#### Python
泛型：
Java泛型可以在编译期做类型检查。
Python中的变量不需要声明类型，不用做编译器类型检查；运行时检查。
```java
List<String> files = new ArrayList<String>();
string file = files.get(0);  // 不必做强制类型转换
files.add(new File(...));   // 编译错误
```

反射：
```java
public class User {
  public void login(...) {
    ...
  }
}
```
```python
class User:
  def login(self):
    print("This is login")


methods = [x for x, y in User.__dict__.items() if type(y) == FunctionType]
print(methods)  # ["login"]


url = "/use?action=login"
# 根据URL解析得到类和方法，代码略
clz = "User"
action = "login"
# 根据名称获得User对象和方法
user = globals()[clz]()
func = getattr(user, action)  # 获取login方法
func()  # 输出 “This is login”
```

动态代理：
Java的增强，只能修改字节码，创建新的类，封装老的类。
Python是动态语言，运行时可以修改。
```python
class User:
  def loin(self):
    print("user login")

  def logout(self):
    print("user logout")

class Proxy:
  def __init__(self, target):
    self .target = target

  # 每当调用方法或访问字段的时候，Python都会通过__getattribute__先找到这个方法或字段，然后才进行真正的调用
  def __getattribute__(self, name):
    target = object.__getattribute__(self, "target")
    attr = object.__getattribute__(target, name)

    if name == "login":
      def newFunc(*args, **kwargs):
        print ("login start")
        result = attr(*args, **kwargs)
        print("login end")
        return result
    else:
      return attr

u = User()
p = Proxy(u)

p.login()   # 实际上调用的是动态创建的方法
p.logout()  # 调用的是原来的方法
```

GIL = Global Interpreter Lock 全局解释器锁
程序的瓶颈不在CPU，而在于I/O；利用多核，使用多进程；测试用例很关键。

Python之禅：
```
The Zen of Python, by Tim Peters

Beautiful is better than ugly.
Explicit is better than implicit.
Simple is better than complex.
Complex is better than complicated.
Flat is better than nested.
Sparse (稀疏的) is better than dense (稠密的).
Readability counts.
......
```

《设计模式》《Head First 设计模式》
Python没有接口：
Python的鸭子类型 Duck Typing。
语言不重要，编程思想才重要。
```python
class Duck:
  def fly(self):
    print("Duck flying")

class Plane:
  def fly(self):
    print("Plane flying")

def lift_off(entity):
  entity.fly()


duck = Duck()
plane = Plane()

lift_off(duck)
lift_off(plane)
```

Adapter模式：
弊端是不知道方法的参数类型，重构困难。
```python
def log(file, msg):
  file.write("[{}] - {}".format(datetime.now(), msg))

class DBAdapter:
  def __init__(self, db):
    self.db = db

  def write(self, msg):
    self.db.insert(msg)


db_adapter = DBAdapter(db)
log(db_adapter, "sev1 error accurred")
```

单例模式：
利用Python的module实现信息的隐藏。
```python
# 定义
# singleton.py
class Singleton:
  def __init__(self):
    self.name = "I am singleton"

instance = Singleton()
del Singgleton  # 删除构造函数


# 使用
# test_singleton.py
import singleton

print(singleton.instance.name)  # I am singleton

instance = Singleton()  # NameError: name 'Singleton' is not defined
```

Visitor模式：
本质在于分离结构和操作。Python使用generator优雅实现。
```python
# 方法1. 类式实现
class TreeNode:
  def __init__(self, data):
    self.data = data
    self.left = None
    self.right = None

  # 中序遍历
  def accept(self, visitor):
    if self.left is not None:
      self.left.accept(visitor)

    visitor.visit(self.data)

    if self.right is not None:
      self.right.accept(visitor)

class PrintVisitor:
  def visit(self, node):
    print(node.data)


root = TreeNode("1")
root.left = TreeNode("2")
root.right = TreeNode("3")

visitor = PrintVisitor()
root.accept(visitor) # 2 1 3


# 方法2. 生成器实现
class TreeNode:
  def __iter__(self):
    return self.__generator()

  def __generator(self):
    if self.left is not None:
      yield from iter(self.left)

     yield from self.data

    if self.right is not None:
       yield from iter(self.right)


root = TreeNode("1")
root.left = TreeNode("2")
root.right = TreeNode("3")

for elf in root:
  print(ele)
```

Python解释器：
Python看似解释执行，实际上把Python文件进行编译，形成字节码；基于栈的虚拟机。
垃圾回收机制：引用计数法，标记-清除法，分代回收法等。
“一核有难，多核围观”。
Jython：用Java写的Python解释器。在底层被编译为Java字节码，运行在Java虚拟机中，没有GIL。
Python的设计目标是易于使用，易于扩展。

#### JavaScript
没有了选择的烦恼，但同时减少了选择的权利，是好还是坏？

> 类是对象的抽象，数据+行为。接口是类的抽象。
> 接口 -> 类 -> 对象

创建对象：
```js
// 方法1. 函数式
function Student(name) {
  this.name = name;
}

Student.prototype.sayHello = function () {
  console.log(`Hi, I am ${this.name}`);
}


let andy = new Student("Andy");
andy.sayHello();  // Hi, I am Andy


// 方法2. 类式语法糖
class Student {
  constructor(name) {
    this.name = name;
  }

  sayHello() {
    console.log(`Hi, I am ${this.name}`);
  }
}


let alan = new Student("Alan");
alan.sayHello();  // Hi, I am Alan
```

JavaScript的this，谁调用this指向谁。`who.func(); this is who.`

#### Go
气血逆行，胸口烦闷，恶心难受。

Go语言设计者，UNIX之父 Ken Thompson。
类型后置；用大小写实现信息隐藏，用组合代替继承，用隐式实现接口来实现多态。
支持高并发编程，用协程方式，创建Goroutine。

封装：
```go
type Employee struct {
  FirstName string  // 首字母大写，表示包外可以直接访问
  lastName string   // 首字母小写，只能在包内访问
  age int
}

func (e Employee) SayHello() {
  fmt.Printf("Hi, I am %s %s, welcome!\n", e.FirstName, e.lastName)
}


e := Employee{"Andy", "Liu", 30}
e.SayHello()
```
继承：
```go
type Manager struct {
  Employee
  privilege string
}


e := Employee{"Harry", "Liu", 30}
m := Manager{e, "manager"}
m.SayHello()  // 直接使用了Employee的SayHello方法
```

多态：
```go
type Flyable struct {
  fly()
}

type Duck struct {
  name string
}

func (d Duck) fly() {
  fmt.Println("Duck flying")
}

type Plane struct {
  name string
}

func (p Plane) fly() {
  fmt.Println("Plane flying")
}

func liftOff(e Flyable) {
  e.fly()
}


func main() {
  liftOff(Duck{"duck"})
  liftOff(Plane{"plane"})
}
```

#### Java

##### Vert.x
异步操作的事件驱动：事件，事件队列，事件循环

Vert.x 的 Verticle实例可以被部署到不同的JVM中，通过 Event Bus 消息传递交互，实现分布式通信。
```java
import io.vertx.core.AbstractVerticle;

public class Server extends AbstractVerticle {
  public void start() {
    vertx.createHttpServer().requestHandler(req -> {
      req.response()
        .putHeader("content-type", "text/plain")
        .end("Hello World");
    }).listen(8080);
  }
}
```

##### ServiceLoader
jar文件是类的压缩包，classpath是把这些类平铺。

ServiceLoader，实现模块化的封装。不破坏封装性，具有灵活性，相当于在运行时装配对象。
JDK必须实现这个ServiceLoader，才能获取具体的实现。
```
// 接口模块 org.foo.api
[module.info.java]
module org.foo {
  exports org.foo.api
}
[org.foo.api]
[  FooService]


// 实现模块 org.foo.provider
[module.info.java]
module org.foo {
  require org.foo.api;
  privides org.foo.api.FooService with org.foo.provider.FooServiceImpl
}

[org.foo.provider]
[  FooServiceImpl]


// Client使用
Iterable<FooService> iter = ServiceLoader.load(FooService.class);
……遍历iter，获取FooService类并且使用……
```

### 5. 编程语言的本质

#### 面向对象
编程的关键不在于是否使用了面向对象的语言。编程的关键就是找到、抽象出稳定的接口。
编程/抽象，就是发现变化，隔离变化，使用各种语言都可以。
> 封装变化点

“变态”的应用层，“不讲道理”的业务逻辑。

```
Logger:
  interface Formatter:
    implement: TextFormatter, HTMLFormatter, XMLFormatter
  interface Appender:
    implement: FileAppender, DbAppender, MailAppender
```

TIOBE = The Importance Of Being Earnest 认真的重要性：编程语言排行榜，反映某个编程语言的热门程度的指标

C语言实现面向对象：
```c
// 1. 封装
/* animal.h */
struct Animal;
struct Animal* Animal_create(int age);
void Animal_init(struct Animal* self, int age);
void Animal_run(struct Animal* self);


/* animal.c */
struct Animal {
  int age;
};

struct Animal* Animal_Create(int age) {
  struct Animal* animal = malloc(sizeof(struct Animal));
  animal -> age = age;
  return animal;
}

void Animal_init(struct Animal* self, int age) {
  self = Animal_Create(age);
}

void Animal_run(struct Animal* self) {
  println("Animal_run(): %d", self->age);
}


/* main.c */
struct Animal* a = Animal_Create(3);
Animal_run(a);


// 2. 继承
struct Dog {
  struct Animal base;
  int color;
};

struct Animal* Dog_Create(int age, int color) {
  struct Dog* dog = malloc(sizeof(struct Dog));
  Animal_init((struct Animal*)dog, age);
  dog -> color = color;
  return dog;
}


struct Dog* d = Dog_Create(3, 5);
Animal_run((struct Animal*)d);


// 3. 多态、虚函数表和虚函数指针
// 虚函数表
struct AnimalVtbl {
  void (*eat)(struct Animal* self);
  void (*speak)(struct Animal* self);
}

struct Animal {
  struct Animal* vptr;  // 指向虚函数表的指针
  int age;
};

void Animal_eat(struct Animal* self) {
  // 查找虚函数表，需要子类把vptr指向不同的虚函数表
  return (*self->vptr->eat)(self);
}


struct Dog* d2 = Dog_Create(4, 6);
Animal_eat((struct Animal*)d);
```

#### 元编程
使用模板，用程序生成程序。

Lisp：
代码就是数据，代码可以在运行时被修改。
程序和数据的表示方式是一致的。

C语言的宏是编译器的文本替换。

#### 汇编语言
汇编语言的指令类型：
- 数据传输类：用于把数据从一个位置复制到另一个位置。
- 算数和逻辑运算类：用于进行加减乘除、AND/OR、左移右移等。
- 控制类：用于比较两个值，并跳转到某个位置。

高级语言的if...else, while, do...while, for -> if+goto -> 汇编语言的比较和跳转

所谓高级语言，主要是为了方便人类的编写和阅读的，从而提升人类的编程效率。

机器语言，只有0和1！

### 6. 网络安全

#### 浏览器安全
同源，{protocal, host, port} 必须一样。
XMLHttpRequest遵守同源策略。
跨域加载资源：`<script src="xxx">, <img src="xxx">, <link href="xxx">`
跨域访问方式：1. 代理模式：通过服务器端中转。2. CORS = Cross Origin Resource Sharing，需要服务器配合。

#### 信息安全
1. 代码注入。XSS = Cross Site Scripting 跨站脚本
防范：Cookie加上HttpOnly，浏览器禁止JavaScript读取Cookie；过滤输入，编码/转义输出。
`Set-Cookie: JSESSIONID=xxxxxx;Path=/;Domain=book.com;HttpOnly`

2. 伪造请求CSRF = Cross Site Request Forgery 跨站请求伪造
防范：表单额外添加一个token
`<input type="hidden" name="token" value="dfaf;ccxoe983243xdadg2305885"/>`

3. SQL注入
防范：不要拼接字符串，使用预编译语句，绑定变量。
```java
String sql = "select id from users where name = ?";
PreparedStatement ps = conn.prepareStatement(sql);
ps.setString(1, request.getParameter("name"));
ps.executeQuery();
```

4. 密码破解。Hask破解法：猜测；查表。
防范：加盐，给每个密码加一个随机数，作为一列存储在数据库中。

5. 缓冲区溢出攻击。
用户输入的数据是从低地址向高地址存放的。
```c
int hello() {
  int x = 10;
  int y = 20;
  int sum = add(x, y);
  printf("the sum is %d\n", sum);
  return sum;
}

int add(int x, int y) {
  char buf[8];
  int sum;
  // scanf函数没有检查边界，黑客会将代码注入栈帧中，修改返回的地址，程序会跳转到指定的地方执行！
  scanf("%s", buf);
  sum x + y;
  return sum;
}
```

#### 加密
1. 中间人攻击。防范：
浏览器端：
**username**
hash(password, salt) -> **has_password**
发送 -> (username, has_password)

2. 重放攻击。防范：
浏览器端：
**username**
**captcha**
hash(password, salt) -> has_password1
hash(has_password1, captcha ) -> **has_password2**
发送 -> (username, has_password2, captcha)

3. 中间人改写。防范：
使用HTTPS

### 7. “老司机”工作经验

费曼：“凡是我们读到的东西，我们都尽量把它转换成某种现实中存在的东西，从这里我学到一个本领——凡是我所读的内容，我总设法通过某种转换来弄明白它究竟是什么意思，它到底在说什么。”
在讲解一个概念的时候，举例和类比很重要，人类习惯于通过例子来学习，从具体走向抽象。
费曼技巧/费曼学习法：“以教促学”：
- 第一步，（自学），选择新概念/新知识，自己先去学习它。
- 第二步，（教授），假装当一个老师，去教授别人。
- 第三步，（重温），如果你在教授别人的过程中遇到了麻烦，卡壳了，就返回去学习。
- 第四步，（简化），简化你的语言。
> 学习技巧：
> 输入 -- 输出 -- 改进 | 简化
> 学习 -- 分享 -- 反馈 | 类比
> 形容词：专注/沉浸/心流；专心致志/全神贯注/聚精会神/心无旁骛/废寝忘食 -> 忘我

长久不变的东西，主要包括：
C语言，Linux，面向对象设计和抽象，网络和Web编程基础，分布式系统的基础知识，计算机基础知识。

用你的技术赚更多的钱。
想从老板那里拿到更高的工资，最好的办法就是，你能帮老板赚更多的钱。
一般程序员和优秀程序员的一大区别就是用技术产生价值的能力，而那些最优秀的程序员，则能够用技术开创一个全新的行业。
用技术给公司带来价值的方法：
1. 能通过新的工具、流程、方法来提升开发效率和测试效率，这是最简单的。（提升效率）
2. 熟悉业务，能够用最合适的技术来实现最大的业务价值。（实现价值）
3. 能把技术直接输出到客户那里。再加上一定的客户资源，离自己创业不远了。（输出客户）
4. 在技术方面和厉害，设计的系统能直接给公司带来收益。（带来收益）

阅读源码的三种境界：
1. 昨夜西风凋碧树，独上高楼，望尽天涯路。
   登高望远，瞰察路径，明确目标和方向，了解源码的概貌。
2. 衣带渐宽终不悔，为伊消得人憔悴。
   静态地看代码+动态地执行Debug操作。
3. 众里寻他千百度，蓦然回首，那人却在灯火阑珊处。
   千百度的上下求索，瞬间的顿悟与理解。
> 坚持下去，保持好奇心。

Code Review 代码评审，成功的经验：
1. 领导的支持。
2. 民主的决策。
3. 能用工具完成的，就别再麻烦人了。
4. Check List很有用。
5. 每次评审适量的代码。

Web服务器 = 规范或约定 + 动态内容服务器。本质是为了实现关注点的分离。
- Java: Servlet + Tomcat (HttpRequest, HttpResponse)
- Python: WSGI + WSGI Server (Environment: dit)
定义规范 - WSGI = Web Service Gateway Interface
类或函数，实现相关逻辑 - WSGI Application
动态服务器 - WSGI Server

极限编程是敏捷软件开发领域的一个“奇葩”，它的宗旨就是，如果一个软件开发实践很好，我们就把它做到极致！
遇到问题要深度思考，努力看到本质，这样才能举一反三。

> 例会，例行会议 / 依照惯例开的会议

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
- 自古以来，人与人之间的深仇大恨莫过于杀人父母、挡人财路。
- 工具是没有错的，关键在于使用他的人。
- 现实世界中，软件是需要维护的，社区是需要合作的。

- Joel Spolsky：抽象只能节省你的工作时间，不能节省你的学习时间。
- Lisp大佬Richard P. Gabriel：Worse is better。软件设计有四个目标：简单性，正确性，一致性，完整性。
- Start small. Give it time. Have fun. 从小处着眼，投入时间，享受乐趣。
  瑞典程序员丹尼尔花了28年时间，开发了世界上最流行的软件：cURL。
  丹尼尔多次强调：Have Fun。Linux之父也告诉我们：Just for Fun。是的，一切源于兴趣。
