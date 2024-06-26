---
title: 计算机/程序 是怎样跑起来的
categories: Technology
tags:
  - Book
  - Computer
  - Program
abbrlink: 7bf1
date: 2024-03-23 17:29:13
---

矢泽久雄, 日本YAZAWA股份有限公司董事长兼总经理。

## 计算机是怎样跑起来的

**How Computer Works**

### 1~2 计算机
计算机的三大原则：
1.计算机是执行输入、运算、输出的机器
2.程序是指令和数据的集合
3.计算机的处理方式有时与人们的思维习惯不同

### 3 汇编
程序的作用是驱动硬件工作。

计算机的硬件有三个基本要素，CPU、内存、I/O。
时钟信号的频率，就是由时钟发生器发送给CPU的电信号的频率。

机器语言就是处理器可以直接理解（与生俱来就能理解）的编程语言。机器语言有时也叫作原生代码(Native Code)。

汇编语言的语法，即把“标签”、“操作码（指令）”、“操作数（指令的对象）”并排写在一行上。
使用汇编语言编程时，因为要事无巨细地列出计算机的行为，所以程序会变得冗长繁复。

### 4 程序流程
程序是流动着的。

程序的流程只有顺序执行、条件分支和循环这三种：
顺序执行是最基本的程序流程，这是因为CPU中的PC寄存器的值会自动更新。
条件分支和循环，
  在高级语言中用程序块表示，
  在机器语言和汇编语言中用跳转指令表示，
  在硬件上是通过把PC寄存器的值设为要跳转到的目的地的内存地址来实现。

条件分支本身也是通过跳转指令实现的。
根据比较操作的结果，跳转到之前处理过的步骤就是循环；跳转到之后尚未处理的步骤就是条件分支。

结构化程序设计就是“为了把程序编写得具备结构性，仅使用顺序执行、条件分支和循环表示程序的流程即可，而不再使用跳转指令”。
程序的流程是由程序块表示的，而不是用GoTo语句等跳转指令实现的。

算法(Algorithm)，就是解决既定问题的步骤。
思考算法时的要点是要分两步走，先从整体上考虑程序的粗略流程，再考虑程序各个部分细节的流程。

中断处理是指计算机使程序的流程突然跳转到程序中的特定地方（中断处理例程 Routine / 中断处理程序 Handler）。
这种跳转是通过CPU所具备的硬件功能实现的。

事件驱动：用户的操作等产生事件后，由事件决定程序的流程。
状态转化图：表示事件驱动；有多个状态，反映了由于某种原因从某个状态转化到另一个状态的流程。

电阻颜色代码的谐音助记口诀：

| 数字 | 颜色 | 谐音助记口诀   |
| ---- | ---- | -------------- |
| 0    | 黑   | 黑灵(零)芝     |
| 1    | 棕   | 粽(棕)子叶     |
| 2    | 红   | 红孩儿(二)     |
| 3    | 橙   | 三乘(橙)轿     |
| 4    | 黄   | 黄丝(四)带     |
| 5    | 绿   | 五缕(绿)须     |
| 6    | 蓝   | 蓝琉(六)璃     |
| 7    | 紫   | 钟子(紫)期(七) |
| 8    | 灰   | 灰八哥         |
| 9    | 白   | 摆(白)酒(九)宴 |

### 5 算法
“哨兵”：一种含有特殊值的数据，可用于标识数据的结尾等。
算法的定义：被明确定义的有限个规则的集合，用于根据有限的步骤解决问题。

算法中解决问题的步骤是明确且有限的。
计算机不靠直觉而是机械地解决问题。

主要的典型算法：

| 名称             | 用途           |
| ---------------- | -------------- |
| 辗转相除法       | 求解最大公约数 |
| 埃拉托斯特尼筛法 | 判定素数       |
| 顺序查找         | 检索数据       |
| 二分查找         | 检索数据       |
| 哈希查找         | 检索数据       |
| 冒泡排序         | 数据排序       |
| 快速排序         | 数据排序       |

### 6 数据结构
算法（处理问题的步骤）和数据结构（作为处理对象的数据的排列方式）。

只要灵活地去运用典型算法和数据结构，就能创造出出色的原创作品，而能够创造出原创作品的程序员才是真正的技术者。

### 7 面向对象编程
面向对象编程就是通过把组件拼装到一起进行编程的方法。
面向对象编程的程序设计方法：将关注点置于对象(Object)本身，对象的构成要素包含对象的行为及操作，以此为基础进行编程。
所使用的主要编程技巧有继承、封装、多态三种。

面向对象编程的关键在于能否灵活地运用类。
用“函数”表示指令，用“变量”表示数据。对于C语言或是BASIC的程序员而言，程序就是函数和数据的集合。

所谓企业级的程序，指的是对可维护性有较高要求的程序。可维护性体现在当程序投入使用后对已有功能的修改和新功能的扩充上。

消息传递：程序可以通过由一个对象去调用另一个对象所拥有的函数这种方式运行起来。
面向对象语言中的消息传递，指的就是调用某个对象所拥有的函数。

使用类的程序员可以通过三种方法使用类：
1.仅调用类所持有的个别成员（函数和变量）;
2.在类的定义中包含其他的类（这种方法被称作组合）;
3.通过继承已存在的类定义出新的类。

Java和.NET其实是位于操作系统（Windows或Linux等）之上，旨在通过隐藏操作系统的复杂性从而提升开发效率的程序集（框架）。
框架由两部分构成，一部分是负责安全执行程序的“执行引擎”，另一部分是作为程序组件集合的“类库”。

UML中规定的九种图：

| 名称                         | 主要用途                               |
| ---------------------------- | -------------------------------------- |
| 用例图 Use Case Diagram      | 表示用户使用程序的方式                 |
| 类图 Class Diagram           | 表示类以及多个类之间的关系             |
| 对象图 Object Diagram        | 表示对象                               |
| 时序图 Sequence Diagram      | 从时间上关注并表示多个对象间的交互     |
| 协作图 Collaboration Diagram | 从合作关系上关注并表示多个对象间的交互 |
| 状态图 State Diagram         | 表示对象状态的变化                     |
| 活动图 Activity Diagram      | 表示处理的流程等                       |
| 组件图 Component Diagram     | 表示文件以及多个文件之间的关系         |
| 配置图 Deployment Diagram    | 表示计算机或程序的部署配置方法         |

### 8 数据库
数据库系统的构成要素：数据文件，DBMS，应用程序。

记录（行/元组Tuple）：录入到表中的每一行数据。
字段（列/属性Attribute）：构成一条记录中的各个数据项所在的列。
外键用于设定表和表之间的关系(Relationship)。
索引是提升数据检索速度的机制。

索引仅仅是提升数据检索和排序速度的内部机制。一旦在字段上设置了索引，DBMS就会自动为这个字段创建索引表。
一旦设置了索引，每次向表中插入数据时，DBMS都必须更新索引表。
提升数据检索和排序速度的代价，就是插入或更新数据速度的降低。因此，只有对那些要频繁地进行检索和排序的字段，才需要设置索引。

连接表(Link Table)：当出现多对多关系时，可以在这两张表之间再加入一张表，把多对多关系分解成两个一对多关系。
规范化，就是将一张大表分割成多张小表，然后再在小表之间建立关系，以此来达到整理数据库结构的目的。
在设计系统时，优先设计数据库，再设计用户界面。

使用数据对象向DBMS发送SQL语句。
ADO = ActiveX Data Object ActiveX数据对象
ADO是以下几个类的统称：
  用于建立和DBMS连接的Connection类
  向DBMS发送SQL语句的Command类
  存储DBMS返回结果的Recordset类等

事务由若干条SQL语句构成，表示对数据库一系列相关操作的集合。
1.BEGIN TRANSACTION（开启事务）语句，用于通知DBMS开启事务；
2.COMMIT（提交事务）语句，用于通知DBMS提交事务；
3.ROLL BACK（事务回滚）语句，用于在事务进行中发生问题时，把数据库中的数据恢复到事务开始前的状态。

### 9 TCP/IP网络
协议(Protocol)：对信息发送方式的规定或约束。为了交换信息，必须在发送者和接收者之间事先确定发送方式。

CSMA/CD = Carrier Sense Multiple Access with Collision Detection 带冲突检测的载波监听多路访问
载波监听(Carrier Sense)，指的是这套机制会去监听(Sense)表示网络是否正在使用的电信号(Carrier)。
多路复用(Multiple Access)指的是多个(Multiple)设备可以同时访问(Access)传输介质。
带冲突检测(with Collision Detection)则表示这套机制会去检测(Detection)因同一时刻的传输而导致的电信号冲突(Collision)。
MAC = Media Access Control

通常把IP地址中表示分组（即LAN）的部分称作“网络地址”、表示各台计算机（即主机）的部分称为“主机地址”。
子网掩码 Subnet Mask：
子网掩码的作用是标识出在32比特的IP地址中，从哪一位到哪一位是网络地址，从哪一位到哪一位是主机地址。
子网掩码中，值为1的那些位对应着IP地址中的网络地址，后面值为0的那些位则对应着主机地址。

DHCP = Dynamic Host Configuration Protocol 动态主机设置协议
DHCP服务器上记录着可以被分配到LAN内计算机的IP地址范围和子网掩码的值。作为DHCP客户端的计算机在启动时，就可以从中知道哪些IP地址还没有分配给其他计算机。
“默认网关”的配置项。通常会把路由器的IP地址设置在这里。也就是说路由器就是从LAN通往互联网世界的入口(Gateway)。路由器的IP地址也可以从DHCP服务器获取。

路由器，是决定数据传输路径的设备。
路由器的工作原理就是查看附加到数据上的IP地址中的网络地址部分，只要发现这个数据不是发送给LAN内计算机的，就把它发送到LAN外，即互联网的世界中。
```cmd
# 列出路由表
route print

# 查看路由器的路由过程
# tracert 主机名 
tracert www.grapecity.com
```
路由表由5列构成：
  Network Destination、Netmask、Gateway、Interface 这四列记录着数据发送的目的地和路由器的IP地址等信息。
  Metric这一列记录着路径的权重，这个值由某种算法决定，比如数据传输过程中经过的路由器的数量。
路由(Routing)：数据经过路由器转发的过程。

DNS服务器可以把主机名解析成IP地址。
DNS服务器通常被部署在各个LAN中，里面记录着FQDN和IP地址的对应关系表。
FQDN = Fully Qualified Domain Name 完整限定域名：由主机名和域名组合起来形成的名字。
```cmd
# 查看域名对应的 IP 地址
nslookup
```

ARP = Address Resolution Protocol 地址解析协议：IP地址到MAC地址的转换。
```cmd
# 输出ARP的缓存表
arp -a
```

IP协议用于指定数据发送目的地的IP地址以及通过路由器转发数据。
TCP协议则用于通过数据发送者和接收者相互回应对方发来的确认信号，可靠地传输数据。

实现了TCP/IP网络的程序的层级：
（数据经过实现了各层协议的软件或硬件，一层一层地传递下去）
用户
应用程序（Web或电子邮件）
实现了TCP协议的程序
实现了IP协议的程序
设备驱动程序
网卡
网线

### 10 加密数据
XOR运算 = eXclusive OR 逻辑异或运算。异或运算，翻转加密，再翻转解密。

密钥每增长一位，破解所花费的时间就会翻10倍。

印章或签字有两层约束。其一是发送者承认文件的内容是完整有效的；其二是文件确实是由发送者本人发送的。
合理的密钥应该满足如下条件：长短适中、可以反复使用、可以通过某种通信手段交给接收者，并且通信双方以外的其他人难以用它来解密。

创建公钥和私钥的步骤：
```
[创建公钥的步骤]
(1) 选取两个素数a、b
    例如a=17、b=19
(2) 求出c=a×b
    c=17x19=323
(3) 求出d=(a-1)x(b-1)
    d=(17-1)x(19-1)=288
(4) 选取与d没有公约数的e
    e=11
(5) 把c和e这两个数值组成的数对儿作为公钥
    c=323、e=11

[创建私钥的步骤]
(1) 求出f，使其满足(fxe)÷d余1
    例加f=131
(2) 把c和f这两个數值组成的数对儿作为私钥
    c=323、f=131
```

### 11 XML
标记语言，就是可以用标签为数据赋予意义的语言。
元语言：用于定义新语言的语言。通过使用XML可以定义出各种各样的新语言。
> 元注解，用于定义新注解的注解。
> 元编程，用于创建新程序的程序。
> 元数据，用于描述新数据的数据。
> 元，原本，根源……

|      | HTML                                     | XML                                       |
| ---- | ---------------------------------------- | ----------------------------------------- |
| 全称 | Hypertext Markup Language 超文本标记语言 | Extensible Markup Language 可扩展标记语言 |
| 定义 | 用于编写网页的固定的标记语言             | 用于定义任意标记语言的元语言              |
| 使用 | 只能使用定义的若干种标签                 | 不限定标签种类，可任意创建标签            |
| 用途 | 仅限于信息的可视化，用于展现网页         | 在互联网上交换信息                        |
| 概述 | 给人看的                                 | 给计算机看的                              |

命名空间，通常是一个能代表企业或个人的字符串，用于修饰限定标签的名字。
XML命名空间(Namespace in XML)，旨在防止同形异义带来的混乱。
在XML文档中，通过把“xmlns="命名空间的名字"”作为标签的一个属性记述，就可以为标签设定命名空间。
xmlns = XML NameSpace（命名空间），通常用全世界唯一的标识符作为命名空间的名称。
<cat xmlns="http://www.grapecity.com/yazawa">小玉</cat>

XML中的主要约束：

| 约束                                                         | 示例                                    |
| ------------------------------------------------------------ | --------------------------------------- |
| XML文档的开头要写有XML声明，表明使用的XML版本和宇符编码      | `<?xml version="1.0" encoding="UTF-8"?>`  |
| 信息要用开始标签`<标签名>`和结束标签`</标签名>`括起来        | `<cat>小玉</cat>`                         |
| 标签名不能以数字开头，中间也不能含有空格                     | `不能用<5cat>或<my cat>作标签名`          |
| 半角空格、换行符、制表符(TAB)都会被视为空白字符，在文档中可以任意地换行或缩进书写 |                                         |
| 没有内容的元素，可以写成`<标签名></标签名>`或`<标签名/>`     | `<cat></cat>等价于<cat/>`                 |
| 标签名区分大小写                                             | `<cat>、<Cat>、<CAT>`互不相同             |
| 标签中可以嵌套标签以表示层级结构，但是不能交叉嵌套           |                                         |
| 在XML声明的后面，必须有且只有一个“根元素”，该标签包舍了所有其他的标签 | `<pet>…其它的标签…</pet>`                 |
| 在开始标签中，可以以`属性名="属性值"`形式加入任意的属性      | `<cat type="三色猫">小玉</cat>`           |
| 特殊符号要转义：`< => &lt; > => &gt; & => &amp; ' => &apos; " => &quot;` | `<cat>小玉&amp;小老虎</cat>`              |
| `<![CDATA[...]]>`，可以直接使用特殊符号和大量输入              | `<cat><![CDATA[小玉&小老虎&咪咪]]></cat>` |
| 注释的写法：`<!- ... ->`                                     | `<!-- 注释 -->`                           |

DTD = Document Type Definition 文档类型描述
格式良好的XML文档(Well-formed XML Document)：遵循XML约束、正确标记了的文档。也就是能通过XML解析器的解析。
有效的XML文档(Valid XML document)：在XML文档中写有DTD信息。

完整的XML文档包括三个部分：
- XML声明：写在XML文档开头的、形如<? xml version="1.0" encoding="UTF-8"? >的部分。
- DTD：作用是定义XML实例的结构，可以省略。
- XML实例：文档中通过标签被标记的部分。
```xml
<!-- XML声明 -->
<?xml version="1.0" encoding="UTF-8"?>

<!-- DTD -->
<!DOCTYPE mydata [
  <!ELEMENT mydata (company+)>
  <!ELEMENT company (name, address, employee)>
  <!ELEMENT name (#PCDATA)>
  <!ELEMENT address (#PCDATA)>
  <!ELEMENT employee (#PCDATA)>
]>

<!-- XML实例 -->
<mydata>
  <company>
    <name>小明</name>
    <address>中国</address>
    <employee>1000</employee>
  </company>
  <company>
    <name>小红</name>
    <address>地球</address>
    <employee>2000</employee>
  </company>
</mydata>
```

用XML定义的标记语言示例：

| 名称   | 全称                                                         | 用途                      | 有关的企业或组织   |
| ------ | ------------------------------------------------------------ | ------------------------- | ------------------ |
| XSL    | eXtensible Stylesheet Language 可扩展样式语言                | 为XML中的信息提供显示格式 | W3C                |
| MathML | Mathematical Markup Language  数学标记语言                   | 描述数学算式              | W3G                |
| SMIL   | Synchronized Multimedia Integration Language 同步多媒体集成语言 | 把多媒体数据嵌入到网页中  | W3G                |
| MML    | Medical Markup Language 医疗标记语言                         | 描述电子病历              | 电子病历研究会     |
| SVG    | Scalable Vector Graphics 可缩放矢量图形                      | 用向量表示国形数据        | W3C                |
| Jepax  |                                                              | 表示电子书                | 日本电子出版协会等 |
| WL     |                                                              | 表示移动终端上的内容      | WAP Forum          |
| CHTML  | Compact HyperText Markup Language 压缩式超文本标记语言       | 表示手机上的内容          | Accos等6家公司     |
| XHTML  | eXtensible HyperText Markup Language 可扩展超文本标记语言    | 用XML定义HTML4.0          | W3C                |
| SOAP   | Simple Object Access Protocol 简单对象访问协议               | 实现分布式计算            | W3C                |

SGML = Standard Generalized Markup Language 标准通用标记语言

分布式计算，就是把程序分散部署在用网络连接起来的多台计算机上，使这些计算机相互协作，充分发挥计算机整体的计算能力。

### 12 SE 系统工程师
IT = Information Technology 信息技术

SE = System Engineer 系统工程师：负责监管计算机系统的构建。
是自始至终参与系统开发过程的工程师，而不是只负责编程的程序员。
要具备的能力分为两类：
- 技术能力(Technical Skill)，是指灵活运用硬件、软件、网络、数据库等技术的能力。
- 沟通能力(Communication Skill)，是指和他人交换信息的能力，要求的是双向的信息交换能力。

客户最关心的是使用计算机解决眼前的问题，而并不是引进什么样的计算机系统。
倾听客户的难处，给出解决对策即IT解决方案，这才是SE的职责。
> 面向对象 -> 换位思考，站在客户或对方的角度看问题。

需要的技能：

| 职业   | 工作内容                                                     | 所需技能                                                 |
| ------ | ------------------------------------------------------------ | -------------------------------------------------------- |
| SE     | 调查、分析客户的业务内容，计算机系统的基本设计，确定计算机系统的规格，估算开发费用和开发周期，项目管理，软件开发管理，计算机系统的维护管理 | 倾听需求，书写策划率，硬件，软件，网络，数据库，管理能力 |
| 程序员 | 制作软件（编程）                                             | 编程语言，算法和数据结构，关于开发工具和程序组件的知识   |

系统是由多个要素相互发生关联、结合而成的带有一定功能的整体。
计算机系统是将各种各样的硬件和软件组合起来构建而成的系统。

所谓设计，就是拆解。
无论任何事都需要规范，即便未能按其实践，规范的存在也算是一种参考。
只有以易于维护为标准把业务拆解成对象的做法，才是具有专家风范的面向对象法。

瀑布模型各个阶段的文档：

| 阶段       | 文档                               |
| ---------- | ---------------------------------- |
| 需求分析   | 系统策划文档、系统功能需求规格文档 |
| 外部设计   | 外部设计文档                       |
| 内部设计   | 内部设计文档                       |
| 程序设计   | 程序设计文档                       |
| 编码实现   | 模块设计文档、测试计划文档         |
| 测试       | 测试报告                           |
| 部署、维护 | 部署手册、维护手册                 |

部署指的是将计算机系统引进（安装）到客户的环境中，让客户使用。
维护指的是定期检查计算机系统是否能正常工作，根据需要进行文件备份或根据应用场景的变化对系统进行部分改造。

具有代表性的程序设计方法：

| 设计方法       | 拆解时所关注的事物           |
| -------------- | ---------------------------- |
| 通用功能分割法 | 在整个计算机系统中通用的功能 |
| STS法          | 数据流（输入、变换、输出）   |
| TR法           | 事务（数据的处理单位）       |
| Jackson法      | 输入数据和输出数据           |
| Warnier法      | 输入数据                     |
| 面向对象法     | 构成计算机系统的事务（对象） |

将计算机系统的构成要素设成多机备份，可以出乎意料地大幅度提升设备利用率。
`设备利用率 = 正常运转的时间 / (正常运转的时间 + 出现故障处于维修状态的时间)`

专家也好普通人也罢，只有为社会做出了贡献才能有成就感，才会觉得工作有意义。

> 点评：浅显易懂，适合新手入门。

