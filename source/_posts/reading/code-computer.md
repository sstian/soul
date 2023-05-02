---
title: 编码：隐匿在计算机软硬件背后的语言
tags:
  - Book
abbrlink: '1748'
date: 2022-10-30 12:30:00
---

## 编码：隐匿在计算机软硬件背后的语言

**Code: The Hidden Language of Computer Hardware and Software**

[美] Charles Petzold 著，左飞、薛佟佟 译

### 语录

- 所谓经典，就是历尽岁月的洗涤，依然毫不褪色，然其光彩却历久弥新。
- 学习技术发展史的重要意义正在于此：追溯的历史越久远，技术的脉络就变得越清晰。
- 简洁明了是我们人类交流方式的一大特色。
- 一个优秀的汇编程序员所编写的程序比编译器所产生的代码更加有效率。
- 软件之所以被设计出来，其最终目的是《为了扩展人类的智慧》（For the Augmentation of Man’s Intellect）。
- 一个完整的单词由基本的音节（音素 phonemes）组成。

- 物理学家 理查德·费叶曼（Richard Feynman）：从某种程度上看计算机科学像是一种工程，它的工作范畴是利用一些事物去实现其他事物。

### 名词

莫尔斯电码 Morse Code，点 dot，划 dash，嘀 dib，嗒 dab
口头话语 the spoken word / 言辞 speech，书面语言 the written word / 文本 text
原子 atom，中子 neutron，质子 proton，电子 electron，电 electricity，分子 molecules，化合物 compound，混合物 mixture
导体 conductor，绝缘体 insulator，电流 current，串联 series，并联 parallel，电报继电器 Telegraph Relays
交换律 commutative，结合律 associative，分配律 distributive
被减数 minuend，减数 subtrahend，差 difference
上溢 overflow，下溢 underflow
相反数 negation，反码 inverse，补码 complement
分频器 frequency divider
冯·诺依曼瓶颈 von Neumann bottleneck，半导体 semiconductor
计算机程序设计 computer programming / 编写代码 writing code / 编码coding
单芯片微处理器 single-chip microprocessors
母板 motherboard/mainboard，开放体系结构 Open Architecture，封闭体系结构 Closed Architecture
分配块 allocation blocks，目录项 directory entry
复数 complex numbers，实数 real numbers，虚数 imaginary numbers
有理数 rational number，无理数 irrational number
正整数 positive integers，负整数 negative integers，分数 fraction
浮点格式 floating-point notation
汇编器 assembler，解释型 interpreter，编译型 compiler

通用产品代码 UPC = Universal Product Code
读/写存储器 read/write memory / 随机访问存储器 RAM = Random Access Memory / 易失性存储器 volatile
中央处理单元 CPU = Central Processing Unit
算术逻辑单元 ALU = Arithmetic Logic Unit
程序计数器 PC = Program Counter
国际商业机器公司 IBM = International Business Machines Corporation
印刷电路板 PCB = Printed Circuit Board
美国信息交换标准码 ASCII = American Standard Code for Information Interchange
程序状态字 PSW = Program Status Word
ZF = Zero Flag，CF = Carry Flag，PF = Parity Flag，SF = Sign Flag
外围设备互联 PCI = Peripheral Component Interconnect 
直接存储器访问 DMA = Direct Memory Access
静态随机访问存储器 SRAM = Static Random Access Memory，动态访问存储器 DRAM = Dynamic Random Access Memory
阴极射线管 CRT = cathode-ray tube
自由软件基金会 FSF=Free Software Foundation
BASIC = Beginner‘s All-purpose Symbolic Instruction Code
BCPL = Basic Combined Programming Language
面向对象程序设计语言 OOP = Object-Oriented Language
用户界面 UI = User Interface
联合图像专家组 JPEG = Joint Photography Experts Group，移动图像专家组 MPEG = Moving Picture Experts Group
公共网关接口 CGI = Common Gateway Interface

### 1~13

- 优先码 precedence codes / 换档码 shift codes：它们改变着作用域内编码的含义，直到作用域结束。
- 波洛尼厄斯点：经济学在研究消费者进行跨时期的消费行为时，既不向别人借钱、也不借钱给别人的状态。
- 胶片速度：对光的敏感程度。
- 条形码 95位二进制，12个数字：数字系统符 1个数字，制造商编码 5个数字，商品编码 5个数字，模校验字符 1个数字。

- 事实上只要有足够高的电压，任何的物质都是可以导电的。
- 地球是一个巨大的导体，可以把它看做是电子的来源和储藏库。地球之于电子就恰如海洋之于水滴。地球是一个近乎无尽的电子之源，同时也是一个无比庞大的电子池。
- 电报机的发明标志着现代通信的开始。
- 在计算机时代，比特被看做是组成信息块的基本单位。
- 通信理论中，噪声（noise）是指影响通信效果的所有事物。运用“冗余” redundancy抵消噪声的影响。
- 在计算机术语中，开关是一种输入设备（input device），输入是控制电路如何工作的信息。
- 两个二进制数相加的结果是由异或门的输出给出的，而进位位是由与门的输出给出的。
- 晶体管要比继电器计算速度更快、体积更小，而且噪声更弱、耗能也更低，而且更便宜。
- 二进制数的麻烦之处，它们只是一些0和1，本身并没有任何含义。

- 亚里士多德的逻辑学基础是三段论法。
- 规则确实是任何形式数学运算的基础。
- 矛盾律指出事物不可能既是它本身，同时又是它的对立面。

| 罗马数字 | I      | V      | X     | L    | C      | D    | M     |
| -------- | ------ | ------ | ----- | ---- | ------ | ---- | ----- |
| 表示数值 | 1      | 2      | 10    | 50   | 100    | 500  | 1000  |
| 类比     | 一条线 | 一只手 | 两个V |      | centum |      | mille |

布尔代数：
| 集合关系 | 数学符号 | 运算符号 | 逻辑词语 | 逻辑关系 | 电路联结 | 电子器件 |
| -------- | -------- | -------- | -------- | -------- | -------- | -------- |
| 交集     | ∩        | ×        | AND      | 与       | 串联     | 与门     |
| 并集     | ∪        | +        | OR       | 或       | 并联     | 或门     |
| 补集     |          | 1-       | NOT      | 非       | 反相     | 反相器   |

### 14 反馈与触发器

- 振荡器 oscillator：在不需要人干涉的情况下，可以完全自发地工作。
  - 振荡器的一个 循环 cycle/周期 period：振荡器从某个初始状态开始，经过一段时间又回到先前初始状态的这一段间隔一个。
  - 振荡器的频率 frequency：周期的倒数就是。
- 反馈 feedback：系统的输出返回给输入的这种形式。
- 触发器 Flip-Flop：触发器电路可以保持信息，它可以“记住”某些信息。
  - R-S / Reset-Set，复位/置位触发器
- 功能表 function table / 逻辑表 logic table / 真值表 truth table：表达了不同输入组合对应的不同输出结果。

- 电平触发的D型 触发器/锁存器：D（Data）表示数据端输入。
  - 电平触发：当保持位输入为某一特定电平时，触发器才保存数据端的输入值。
  - 1位存储器：表示电路锁存住一位数据并保持它，以便将来使用。
- 边沿触发器：只有当时钟从0跳变到1时，才会引起输出的改变。
  - 边沿触发的D型触发器是由两级R-S触发器连接而成的。
- 区别：
  - 在电平触发器中，当时钟输入为0时，数据端输入的任何改变都不会影响输出
  - 在边沿触发器中，当时钟输入为1时，数据端输入的改变也不会影响输出。只有在时钟输入从0变到1的瞬间，数据端的输入才会影响边沿触发器的输出。

- 8位行波计数器：每一个触发器的输出都是下一个触发器的时钟输入。变化是在触发器中一级一级地顺序传递的，最后一级触发器的变化必定会有一些延迟。
  - 并行 同步计数器：更先进的计数器，所有输出是在同一时刻改变的。

### 16 存储器组织

- RAM阵列的存储容量 = 2 ^ 地址输入端的个数

- 计算机存储单元以**字节 Byte**为单位，数据传输以**每秒多少比特 bps**为单位。
  - 描述在线路中流动的数据时 - 千比特每秒 kbps或兆比特每秒 mbps。
- 为了保证存储的数据不丢失，易失性存储器需要恒定的电流。

- 水平触发 level triggered 锁存器中，为了保存数据必须将时钟输入端首先置1，然后回置为0。当时钟输入端为1时，锁存器的数据输入端可以改变，而这些变化将会影响到数据输出。
- 边沿触发 edge-triggered 锁存器中，在时钟输入从0跳变为1的瞬间保存数据。
- 累加器 accumulator：用来累加多个数的锁存器。

### 17 自动操作

- 进行加法操作的过程：
  - 加载 Load：把一个字节从存储器中传送到累加器中。
  - 相加 Add：把存储器中的一个字节加到累加器的内容中去。
  - 保存 Store：把累加器中的计算结果取出并存放到存储器中。
  - 终止 Halt：令自动加法器停下来。

- 指令码 instruction code / 操作码 operation code：数字代码，指示电路要执行的某种操作。
- 代码（操作码、指令本身）和数据（操作数、代码要处理的数）。
- 取指令 instruction fetch：从存储器中取出指令的过程。
- 执行 execute 指令：机器响应指令码做一系列操作的过程。
- 一个完整的指令周期需要4个时钟周期。
- 计算机 computer 和计算器 calculator 的区别：能否控制重复操作或者循环 looping。

- 机器码 machine codes / 机器语言 machine language：能够被处理器响应的操作码（比如Load指令和Store指令的代码10h和11h）。计算机能够理解和响应机器码。
- 汇编语言 assembly language：全数字的机器语言和指令的文字描述的一种结合体。
  - 参数 argument：位于助记符右侧，是指令的操作对象。
  - 参数由两部分组成，左边的操作数称为目标 destination 操作数，右边的操作数称为源 source 操作数。
  - 方括号[]表明要加载到累加器的不是里面的数值，而是位于存储器该地址的数值。
  - 标号 label 指代存储器中的地址空间。

### 18 从算盘到芯片

- cyberspace 网络空间：数百万台计算机通过因特网相连。
- 硅谷 Silicon Valley：旧金山南部地区。

- 发展阶段：
  - 20世纪50年代中期，开发出磁芯存储器 magnetic core memory
  - 20世纪70年代，贝尔实验室成为计算机操作系统UNIX和编程语言C的诞生地
  - 1947年12月16日，开发出晶体管 transistor
- 摩尔定律：每18个月同一块芯片上集成晶体管数目就会翻一倍。
- NPN晶体管
  - 其三部分分别为集电极 collector、基极 base、发射极 emitter。
  - 在基极施加微小的电压就可以控制非常大的电压从集电极到发射极。如果在基极没有施加电压，那么晶体管将不起作用。
- 继电器、真空管/电子管以及晶体管最初都是为了开发放大器设计的，但是通过相似方式连接可以组成逻辑门，而计算机则是由这些部件构成的。
- 集成电路有几种不同的封装方式，但最为常见的是采用矩形塑料双排直插式 或称为DIP，提供14、16或者40个管脚。
- 超特大规模集成电路 ultra-large-scale integration：超过100,000个逻辑门。

- 制造集成电路的组件：
  - TTL：晶体管-晶体管逻辑 transistor-transistor logic
    - 《TTL数据手册》
    - TTL7400系列
    - 供电电压要求在4.75～5.25V范围内。GND代表接地 ground。在特定电路中使用的所有集成电路都必须有接电源端与接地端。
    - TTL中，当电压介于0～0.8V任一值则可以认为是逻辑“0”，而介于2～5V则可以认为是逻辑“1”。0.8～2V范围的电压输入则应当尽量避免。

  - CMOS：互补金属氧化物半导体 complementary metal-oxide semiconductor
    - 《CMOS数据手册》
    - CMOS家族中4000系列的IC的信息。
    - CMOS供电电压范围在3～18V内的电压均可，非常灵活；需要更少的能量，用电池运行小型CMOS电路可行。
    - 缺点是速度慢。

- 影响一个集成电路性能的最重要因素可以认为是传播时间 propagation time：输入端发生变化引起输出端发生相应变化所需要的时间。
- 计算机处理器迟钝地做着简单的事情——从存储器中取出一个字节放到寄存器中，再将两个字节相加，然后将结果存放回存储器。迅速地完成这些操作是计算机能完成任何实际工作的唯一原因。
- 时钟频率：连接到微处理器并驱动它运行的振荡器的最大频率，超过此时钟频率，微处理器将不能正常工作。
- 1937年图灵在论文里面关于可计算性的一种定义：某种意义上讲，所有的数字计算机都是相同的，如果一台处理器从硬件上无法做到另外一台可以做到的事情，那么它可以通过软件途径做到，最终它们可以完成相同的事情。
- 最大时钟频率 maximum clock speed/主频，是影响处理器速度的决定性因素之一。
- 影响计算机芯片处理速度的三个数值：时钟频率、可寻址空间、一次可处理位数。

### 19 两种典型的微处理器

- 微处理器：诞生于1971年，它将计算机中央处理器的所有构成组件整合在一起，集成在一个硅芯片上。
- Intel 8080是一个8位的微处理器，包括6000个晶体管，运行的时钟频率为2 MHz，寻址空间为64 KB。
- 寄存器和累加器一样，本质上都是锁存器。
- 随机访问存储器 random access memory，RAM：微处理器可以寻址访问的存储器，存放着处理器要执行的机器代码指令。
- 寻址方式：
  - 直接寻址 direct addressing，如：LDA A, [aaaa]
  - 间接寻址 indexed addressing，如：MOV B, ［HL］
  - 立即数寻址 immediate addressing，如：MVI E, 37H

- 堆栈（stack存储器/后进先出存储器 LIFO=last-in-first-out。
  - 从底部到顶部的顺序把数据存入堆栈，并以相反的顺序把数据从堆栈中取出。
  - 堆栈的特点：最先保存到堆栈中的数据最后被取出，而最后保存的数据则被最先取出。
  - 压入（push：将数据存入堆栈的过程。
  - 弹出（pop：从堆栈取出数据的过程。
  - 堆栈指针 SP=Stack Pointer 寄存器，地址递减。堆栈上溢 stack overflow，堆栈下溢 stack underflow

- 子程序是一段频繁使用的完成特定功能的代码。
- 内存映像I/O （memory-mapped I/O）：在某些微处理器中，外围设备实际上占用了一些通常用来寻址存储器的地址。
- 字节序：小端 Little-endian - Intel方式，大端 big-endian - Motorola方式。
- 现代处理器：
  - 流水线技术 pipelining：处理器在执行一条指令的同时读取下一条指令，尽管Jump指令在一定程度上会改变这种流程。提高其运行速度。
  - Cache 高速缓冲存储器：一个设置在处理器内部，访问速度非常快的RAM阵列，用来存放处理器最近要执行的指令。

### 20 ASCII码和字符转换

- 文本字符串 string：对一个句子进行编码后得到的连续字符。
- 编码系统：给每一个字符指派一个唯一的编码。
- 尽管ASCII码从技术的本质上来看是7位编码，但仍以8位的形式存储。

### 21 总线

- 视频适配器 video display adapter / 显卡 video board：可以为视频显示器提供信号的电子元件；独立存在，拥有自己的电路板。
- 像素 picture element：从计算机的角度来说，可以很方便地把视频图像想象成由离散点组成的矩形网格。
- 视频分辨率的最低标准是640×480。多数计算机的显示器的长宽比也是4:3。

- 其实键盘上的每个按键就是一个简单的开关。按键按下，开关就会闭合。
- 扫描码 scan code：键盘硬件提供的代码。当按下键盘上的某个按键时，一小段计算机程序就会计算出这个按键对应的ASCII码（如果有的话。

- 三大总线：地址总线，数据总线，控制总线。可供电。
- 通常情况下，所有读/写内存的操作都是由微处理器来完成的，但采用了DMA后，其他设备可以不通过微处理器而获得总线的控制权，进而直接对内存进行读写。
- 存储体（bank：为了存储完整的字节，而连接在一起的芯片的集合。
- 微处理器是通过从内存中读取一条指令来响应中断的，通常是一条RST指令。这条指令使微处理器跳转到内存中一个特定的区域并执行其中的中断处理程序。

- 磁介质存储器 magnetic storage：声音通过电磁铁和可变长度的金属丝来记录，其中电磁铁是电报机里很常见的部件，它根据声音的高低来磁化金属丝。当磁化的金属丝切割电磁线圈运动的时候，产生的电流强度与其磁化程度有关。不论使用何种磁化介质，记录和读取信息都是利用电磁铁的磁头（head来完成的。
- 磁盘分为软盘（floppy disk和硬盘（hard disk，或fixed disk
  - 柱面
  - 磁道 tracks：磁盘的表面被划分成许多同心圆，每个磁道又被划分成像圆饼切片形状的，
  - 扇区 sectors：每个磁道又被划分成圆饼切片形状。每个扇区可以存放一定数量的字节，通常为512字节。

- 现在流行的硬盘驱动器标准接口有：
  - 小型计算机系统接口 SCSI=Small Computer System Interface
  - 增强的小型设备接口 ESDI=Enhanced Small Device Interface
  - 集成设备电气接口 IDE=Integrated Device Electronics
  - 这些接口都利用直接内存访问技术来使用总线，DMA可以不经过微处理器，实现数据在随机访问存储器和硬盘之间直接传送。传送是以块为单位进行的，每次传输的块大小是磁盘扇区字节数的倍数，通常是512字节。

- **Memory（内存）仅仅表示半导体随机访问存储器；storage（存储器）用来指任何的存储设备，通常包括软盘、硬盘和磁带。**
- 随机访问存储器与磁介质存储器的主要区别：存储的信息是否易失。
  - 随机访问存储器是易失性存储设备，一旦掉电，存储内容将会消失
  - 磁介质存储器是永久性存储设备，像软盘和磁盘，除非故意删除或写覆盖，否则数据将会一直保留不变。
- 随机访问存储器就像办公桌的桌面，上面的任何东西都可以拿来直接使用；而磁介质存储器就像一个文件柜，里面的东西不能直接使用，如果想要使用放在文件柜里的某件东西，你需要站起来，走到文件柜前，查找需要的文件，然后带回桌面。如果桌面太拥挤，没有空间放置需要的文件，还需要把桌面上暂时不用的东西先放回到文件柜中。
- 存储在磁盘上的数据以文件（files）作为实体来存放。存储和检索文件是操作系统（Operating System）负责。

### 22 操作系统

- 按键到显示器的回显 echoing。
- 在键盘处理程序内含有一个命令处理程序 command processor。
- 可编程只读存储器（PROM = Programmable Read-Only Memory）只能编程一次；而可擦除可编程只读存储器（EPROM = Erasable Programmable Read-Only Memory）可重复擦除和写入。

- CP/M（Control Program for Micros）是20世纪70年代中期最重要的8位微处理器操作系统。
- 文件系统是磁盘存储的一种方法，就是把数据组织成文件 file。文件是相关数据的集合，占用磁盘上一个或多个扇区。文件存储在磁盘中不一定要占据连续的扇区空间。
- 只读存储器（ROM = Read-Only Memory）在CP/M计算机中使用得并不多，只需要用它来存放一小段称为引导程序(bootstrap loader)，操作系统的其余部分可以通过这段代码的自举操作被高效地引导。开机启动时，磁盘上最开始的128字节的扇区内容，会首先由引导程序加载到内存并运行，这个扇区包含有特定的代码，可以把CP/M中的其余部分加载到内存中，整个过程称为操作系统的引导（booting）。
- CP/M的三个组成部分：
  - 控制台命令处理程序 CCP = Console Command Processor
  - 基本磁盘操作系统 BDOS = Basic Disk Operating System
  - 基本输入/输出系统 BIOS = Basic Input/Output System
  - 这三个部分只占用了6 KB大小的内存空间。在拥有64 KB内存空间的计算机中，大约58 KB被临时程序区（TPA = Transient Program Area）占用，但是这58 KB空间一开始时是空的。
- 一旦删除文件，此文件的目录项及其所占用的磁盘空间都将被释放。

- 操作系统的功能：
  - 功能1: 如何利用命令和实用程序对文件进行基本操作。
  - 功能2: 如何将程序加载到内存中并运行等。
  - 功能3: 让程序能够方便地访问计算机的硬件。操作系统提供的这种访问操作称为API（Application Programming Interface，应用程序接口）。对于计算机硬件来说，API是一个与设备无关（device-independent）的接口。

- 在MS-DOS中，文件系统是以文件分配表（FAT = File Allocation Table）的形式来组织的。
  - FAT的基本思想是：将磁盘空间分成簇（cluster），——簇的大小由磁盘空间的大小来决定，从512字节到16 K字节不等，每个文件占用若干簇。文件的目录项只记录文件起始（starting）簇的位置，而磁盘上每一簇的下一簇的位置由FAT来记录。
- MS-DOS有两种运行程序：
  - 以COM为扩展名的文件，其大小不能超过64 KB
  - 更大一些的程序，以EXE为文件的扩展名，表明文件本身是可执行的
- 层次文件系统 hierarchical file system：常规的目录称为根目录 root directory / 文件夹 folder，子目录subdirectories是包含在其他目录里的目录。

- UNIX系统
  - 时分复用 time sharing
  - 多任务 multitasking
  - 虚拟内存 virtual memory：在磁盘上划出部分空间用做保存临时文件，程序把暂时不需要用的内存块放到临时文件里，待需要时再把它调入内存。
- GNU意味着：“GNU与UNIX，既要划清界限又相辅相成”。GNU项目的宗旨是：创建一个与UNIX系统兼容，但不受私有权限制的操作系统和开发环境。

### 23 定点数和浮点数

- 超越数 transcendental：不是任何以整数为系数的代数方程的解的数。所有的超越数都是无理数，反之不成立。
- 定点格式 fixed-point format：基于二进制的存储和标记方式，“定点”是指小数点的位置总是在数的某个特定位置。
- 科学计数法的规范化式 normalized of scientific notation：有效数的取值范围是大于或等于1而小于10。
- 在规范化二进制浮点数中，小数点的左边通常只有一个1，除此之外没有其他数字。
- NaN = not a number：用来表示未知的数或非法操作的结果。

### 24 高级语言与低级语言

- 交叉汇编 cross-assembler：利用计算机A的汇编器对运行在计算机B上的程序汇编。
- FORTRAN = FORmula + TRANslation：由IBM在20世纪50年代中期开发的编程语言，主要应用于704系列计算机。科学和工程应用程序开发。
- COBOL语言广泛支持读取记录（record）和生成报表（report）。记录是按照统一方式归类整理的信息的集合。

- 运行时错误 run-time error：程序被执行时才出现的错误。
- 变量名实际上对应内存的一个存储单元，但在程序中是通过名字来访问该存储单元的，而不是直接使用存储单元的地址值。
- **指针本质是数字化描述的内存地址。**
- 编译器读取源文件并生成一个可执行文件；而解释器却采取边读边执行的方式，不会产生新的文件。解释器比编译器的原理简单一些，因此更容易编写，但其运行程序的速度要比后者要慢。

### 25 图形化革命

- 哑终端 dumb terminal：键盘和CRT一起对远程计算机传输来的ASCII码（可能还包括Escape字符序列）做出响应。
- 计算机对键盘的响应速度越快，对视频显示器的更新速度越快，则人机交互就越频繁。
- 日常所用的PC配套的纯平显示器属于光栅（raster）显示器。原理就像电视机，每一幅图像背后都是一行行的光栅线，这些光栅是电子枪（electron gun）发出光束迅速来回移动覆盖整个屏幕而形成的。
- 真实世界出现的几乎所有颜色都是由红、绿、蓝三原色的不同色阶（levels）组合而成。
- 色深 color depth / 色彩分辨率 color resolution：每个像素所赋予的比特数有时也称做。
- 颜色数 = 2 ^ 每个像素所赋予的比特数
- 光笔（light pen）并不发射（emit）光，它所做的是检测（detect）光。
- Macintosh系统软件只支持一种类型的磁盘驱动器、一种视频显示器，以及两种型号的打印机。而IBM PC的图形操作系统开发人员所面对的是许多不同的硬件，操作系统与不同的硬件之间需要同时兼容。
- **对象 object 实际上是代码和数据的组合。**

- 矢量图形（vector graphics）：在算法的帮助下，利用直线、曲线及填充区域生成图形。
  - 应用领域：计算机辅助设计（CAD = Computer-Assisted Drawing），工程和体系结构设计。
  - 矢量图形一般转化为图元文件（metafile）格式以存放到文件中。
- 位图具备色深（颜色分辨率/颜色深度）的概念，色深是指每一个像素被赋予的比特数。位图中每个像素被赋予的比特数相同。
- 电荷耦合器（CCD = charge-coupled device）：一种在光照下会起电的半导体器件。用于把现实世界的图像输入到计算机中，每个像素都需要一个CCD单元来进行采样。

- **振动是声音之源。**
- 1分贝代表着人类所能感知到的声音最小强度变化。
- 脉冲编码调制技术（PCM = Pulse Code Modulation）：CD（Compact Disk）中声音信息采用的编码技术。
- CD可以存储声音、数据。
  - CD-ROM（CD只读存储器）：专门用来存储数据的CD。

- 帧 frame：单个图像。
  - 电影的播放速率为24帧/秒，北美的电视节目为30帧/秒，世界上大部分地方的电视为25帧/秒。
- 动态图像压缩技术基于的是一种客观事实，每一帧继承了前一帧的大部分信息，即存在冗余信息。
- MPEG-2用于高清晰度电视（HDTV = high-definition television）及数字影音光盘（DVD = digital video discs）。
- DVD也叫数字多用光盘（digital versatile discs），其物理大小与CD一样，但是DVD的两面都可以记录数据而且每一面有两层。

- 对声波进行调制（modulate）使其反映两种不同的状态，通过这种方式可以表示出0和1。
- 调制解调器（modem，包括调制和解调）：将比特与声波进行互相转换的设备。
  - 调制解调器以串口（serial）形式工作，因为字节中的单个比特是一个接一个传输的，而不是一拥而上（打印机一般通过并行接口与计算机相连，整个字节由8根线并行传输）。

- 光纤：一种由玻璃或聚合体制造的光导纤维，通过从不同角度对光进行反射达到光传输效果。

![编码](https://cdn.jsdelivr.net/gh/sstian/images/blogimg/编码.png)
