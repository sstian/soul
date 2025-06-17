---
title: 深入浅出Node.js
categories: Technology
tags:
  - Book
  - Nodejs
abbrlink: '9578'
date: 2024-11-16 21:56:08
---

## 《深入浅出Node.js》
[中] 朴灵

### Node简介
#### Node的起源
设计高性能，Web服务器的几个要点：事件驱动、非阻塞I/O。
考虑到高性能、符合事件驱动、没有历史包袱这３个主要原因，JavaScript成为了Node的实现语言。

#### Node的特点
- 异步I/O
异步调用中对于结果值的捕获是符合“Don’t call me, I will call you”的原则，这也是注重结果，不关心过程的一种表现。
事件的编程方式具有轻量级、松耦合、只关注事务点等优势，但是在多个异步任务的场景下，事件与事件之间各自独立，如何协作是一个问题。
- 单线程
单线程的最大好处是不用像多线程编程那样处处在意状态的同步问题，这里没有死锁的存在，也没有线程上下文交换所带来的性能上的开销。
- 跨平台
兼容Windows和*nix平台主要得益于Node在架构层面的改动，它在操作系统与Node上层模块系统之间构建了一层平台层架构，即libuv。目前，libuv已经成为许多系统实现跨平台的基础组件。

单线程的弱点具体有以下3方面：
- 无法利用多核CPU。
- 错误会引起整个应用退出，应用的健壮性值得考验。
- 大量计算占用CPU导致无法继续调用异步I/O。

#### Node的应用场景
CPU密集不可怕，如何合理调度是诀窍。
Node高效利用并行I/O的过程，也是高效使用数据库的过程。

### 模块机制
编译和执行是引入文件模块的最后一个阶段。定位到具体的文件后，Node会新建一个模块对象，然后根据路径载入并编译。
对于不同的文件扩展名，其载入方法也有所不同： 
- .js文件。通过fs模块同步读取文件后编译执行。
- .node文件。这是用C/C++编写的扩展文件，通过dlopen()方法加载最后编译生成的文件。
- .json文件。通过fs模块同步读取文件后，用JSON.parse()解析返回结果。
- 其余扩展名文件。它们都被当做.js文件载入。每一个编译成功的模块都会将其文件路径作为索引缓存在Module._cache对象上，以提高二次引入的性能。

CommonJS模块规范也允许在标识符中不包含文件扩展名，这种情况下，Node会按.js、.json、.node的次序补足扩展名，依次尝试。在尝试的过程中，需要调用fs模块同步阻塞式地判断文件是否存在。

#### 模块实现
在Node中引入模块，需要经历3个步骤：路径分析，文件定位，编译执行。

在Node中，模块分为两类：一类是Node提供的模块，称为核心模块；另一类是用户编写的模块，称为文件模块。
依赖层级关系，即文件模块可能会依赖核心模块，核心模块可能会依赖内建模块。
`文件模块 <-- 核心模块 (JavaScript) <-- 内建模块 (C/C++)`
C++模块主内完成核心，JavaScript主外实现封装的模式是Node能够提高性能的常见方式。
require()方法通过解析标识符、路径分析、文件定位，然后加载执行即可。

os原生模块的引入流程：
```
require("os")
NativeModule.require("os")
process.binding("os")
get_buildin_module("node_os")
NODE_MODULE(node_os, reg_func)
```

require()引入.node文件的过程：
```
JavaScript - require("./hello.node")
原生模块 - process.dlopen("./hello.node", exports)
libuv - uv_dlopen()/uv_dlsym()
  - *nix - dlopen()/dlsym()
  - Windows - LoadLibraryExW()/GetProcAddress()
```

V8引擎C++库。V8是Node自身的动力来源之一。它自身由C++写成，可以实现JavaScript与C++的互相调用。
libuv库。它是Node自身的动力来源之二。Node能够实现跨平台的一个诀窍就是它的libuv库，这个库是跨平台的一层封装，通过它去调用一些底层操作，比自己在各个平台下编写实现要高效得多。libuv封装的功能包括事件循环、文件操作等。

Node自身的源码就是通过GYP编译的。为此，Nathan Rajlich基于GYP为Node提供了一个专有的扩展构建工具node-gyp，这个工具通过 `npm install -g node-gyp` 这个命令即可安装。
GYP = Generate Your Projects
它的好处在于，可以帮助你生成各个平台下的项目文件，比如Windows下的Visual Studio解决方案文件（.sln）、Mac下的XCode项目配置文件以及Scons工具。在这个基础上，再动用各自平台下的编译器编译项目。

GYP项目生成工具：
其中*nix下通过g++/gcc等编译器编译为动态链接共享对象文件（.so），在Windows下则需要通过Visual C++的编译器编译为动态链接库文件（.dll）
C/C++模块通过预先编译为.node文件，然后调用process.dlopen()方法加载执行。
CPAN社区对它的原始定义如下：“Kwalitee”is something that looks like quality, sounds like quality, but is not quite quality.
总体而言，符合Kwalitee的模块要满足的条件：具备良好的测试，具备良好的文档（README、API），具备良好的测试覆盖率，具备良好的编码规范。

#### CommonJS包规范

```
|----- 浏览器 ------ ||------- CommonJS --------|
 BOM DOM  ECMAScript   FS TCP Stream Buffer ...
|- W3C -|| ------------ Node ------------------|
```

CommonJS包规范是理论，NPM是其中的一种实践。NPM之于Node，相当于gem之于Ruby，pear之于PHP。对于Node而言，NPM帮助完成了第三方模块的发布、安装和依赖等。

包描述文件用于表达非代码相关的信息，它是一个JSON格式的文件——package.json，位于包的根目录下，是包的重要组成部分。

包描述文件规范：
- 必需字段：
  - name。包名。规范定义它需要由小写的字母和数字组成，可以包含.、_和-，但不允许出现空格。包名必须是唯一的，以免对外公布时产生重名冲突的误解。除此之外，NPM还建议不要在包名中附带上node或js来重复标识它是JavaScript或Node模块。
  - description。包简介。
  - version。版本号。一个语义化的版本号，这在http://semver.org/上有详细定义，通常为major.minor.revision格式。该版本号十分重要，常常用于一些版本控制的场合。
  - keywords。关键词数组，NPM中主要用来做分类搜索。一个好的关键词数组有利于用户快速找到你编写的包。
  - maintainers。包维护者列表。每个维护者由name、email和web这3个属性组成。NPM通过该属性进行权限认证。示例：
    ```json
    "maintainers": [
      {
        "name": "Jackson Tian",
        "email": "shyvo1987@gmail.com",
        "web": "http://html5ify.com"
      }
    ]
    ```
  - contributors。贡献者列表。在开源社区中，为开源项目提供代码是经常出现的事情，如果名字能出现在知名项目的contributors列表中，是一件比较有荣誉感的事。列表中的第一个贡献应当是包的作者本人。它的格式与维护者列表相同。
  - bugs。一个可以反馈bug的网页地址或邮件地址。
  - licenses。当前包所使用的许可证列表，表示这个包可以在哪些许可证下使用。格式：
    ```json
    "licenses": [{ "type": "GPLv2", "url": "http://www.example.com/licenses/gpl.html" }]
    ```
  - repositories。托管源代码的位置列表，表明可以通过哪些方式和地址访问包的源代码。
  - dependencies。使用当前包所需要依赖的包列表。这个属性十分重要，NPM会通过这个属性帮助自动加载依赖的包。
- 可选字段： 
  - author。包作者。
  - bin。一些包作者希望包可以作为命令行工具使用。配置好bin字段后，通过npm install package_name -g命令可以将脚本添加到执行路径中，之后可以在命令行中直接执行。通过-g命令安装的模块包称为全局模式。
  - main。模块引入方法require()在引入包时，会优先检查这个字段，并将其作为包中其余模块的入口。如果不存在这个字段，require()方法会查找包目录下的index.js、index.node、index.json文件作为默认入口。
  - devDependencies。一些模块只在开发时需要依赖。配置这个属性，可以提示包的后续开发者安装依赖包。
  - homepage。当前包的网站地址。
  - os。操作系统支持列表。这些操作系统的取值包括aix、freebsd、linux、macos、solaris、vxworks、windows。如果设置了列表为空，则不对操作系统做任何假设。
  - cpu。CPU架构的支持列表，有效的架构名称有arm、mips、ppc、sparc、x86和x86_64。同os一样，如果列表为空，则不对CPU架构做任何假设。
  - engine。支持的JavaScript引擎列表，有效的引擎取值包括ejs、flusspferd、gpsee、jsc、spidermonkey、narwhal、node和v8。builtin。标志当前包是否是内建在底层系统的标准组件。
  - directories。包目录说明。
  - implements。实现规范的列表。标志当前包实现了CommonJS的哪些规范。
  - scripts。脚本说明对象。它主要被包管理器用来安装、编译、测试和卸载包。示例：
    ```json
    "scripts": {
      "install": "install.js",
      "uninstall": "uninstall.js",
      "build": "build.js",
      "doc": "make-doc.js",
      "test": "test.js"
    }
    ```

CommonJS的包规范的定义其实也十分简单，它由包结构和包描述文件两个部分组成，前者用于组织包中的各种文件，后者则用于描述包的相关信息，以供外部读取分析。
包结构包实际上是一个存档文件，即一个目录直接打包为.zip或tar.gz格式的文件，安装后解压还原为目录。完全符合CommonJS规范的包目录应该包含如下这些文件：
- package.json：包描述文件。
- bin：用于存放可执行二进制文件的目录。
- lib：用于存放JavaScript代码的目录。
- doc：用于存放文档的目录。
- test：用于存放单元测试用例的代码。

#### 多种模块
兼容多种模块规范为了让同一个模块可以运行在前后端，在写作过程中需要考虑兼容前端也实现了模块规范的环境。为了保持前后端的一致性，类库开发者需要将类库代码包装在一个闭包内。

示例：将hello()方法定义到不同的运行环境中，它能够兼容Node、AMD、CMD以及常见的浏览器环境中。
```js
(function (name, definition) {
  // 检测上下文环境是否为AMD或CMD  
  var hasDefine = typeof define === 'function',
  // 检查上下文环境是否为Node   
  var hasExports = typeof module !== 'undefined' && module.exports;
  if (hasDefine) {
    // AMD环境或CMD环境    
    define(definition);
  } else if (hasExports) {
    // 定义为普通Node模块    
    module.exports = definition();
  } else {
    // 将模块的执行结果挂在window变量中，在浏览器中this指向window对象  
    this[name] = definition();
  }
})('hello', function () { var hello = function () { }; return hello; }); 
```

CMD规范：
CMD规范由国内的玉伯提出，与AMD规范的主要区别在于模块定义和依赖引入的部分。
- 模块定义
CMD模块更接近于Node对CommonJS规范的定义：
`define(factory);`
AMD需要在声明模块的时候指定所有的依赖，通过形参传递依赖到模块内容中：
`define(['dep1', 'dep2'], function (dep1, dep2) { return function () { }; });`
- 依赖引入
CMD支持动态引入，示例：`define(function (require, exports, module) { /*...*/ });`
require、exports和module通过形参传递给模块，在需要依赖模块时，随时调用require()引入即可。

AMD规范：
AMD规范是CommonJS模块规范的一个延伸，它的模块定义：`define(id?, dependencies?, factory);`
它的模块id和依赖是可选的，与Node模块相似的地方在于factory的内容就是实际代码的内容。
定义一个简单的模块：
`define(function () { var exports = {}; exports.sayHello = function () { alert('Hello from module: ' + module.id); }; return exports; });`
不同之处在于AMD模块需要用define来明确定义一个模块，而在Node实现中是隐式包装的，它们的目的是进行作用域隔离，仅在需要的时候被引入，避免掉过去那种通过全局变量或者全局命名空间的方式，以免变量污染和不小心被修改。
另一个区别则是内容需要通过返回的方式实现导出。

AMD规范最终在前端应用场景中胜出。它的全称是Asynchronous Module Definition，即异步模块定义，详见https://github.com/amdjs/amdjs-api/wiki/AMD。

### 异步I/0

#### 异步I/O现状
Node的方案：
- 利用单线程，远离多线程死锁、状态同步等问题；
- 利用异步I/O，让单线程远离阻塞，以更好地使用CPU。

多线程的代价在于创建线程和执行期线程上下文切换的开销较大。

I/O是昂贵的，分布式I/O是更昂贵的。只有后端能够快速响应资源，才能让前端的体验变好。

通过让部分线程进行阻塞I/O或者非阻塞I/O加轮询技术来完成数据获取，让一个线程进行计算处理，通过线程之间的通信将I/O得到的数据进行传递，这就轻松实现了异步I/O（尽管它是模拟的）。

AIO是原生提供的一种异步I/O方式，通过信号或回调来传递数据的。但不幸的是，只有Linux下有，而且它还有缺陷——AIO仅支持内核I/O中的O_DIRECT方式读取，导致无法利用系统缓存。

#### Node的异步I/O
在进程启动时，Node便会创建一个类似于while(true)的循环，每执行一次循环体的过程我们称为Tick。
一个主线程与多个IO线程
Node是单线程的，这里的单线程仅仅只是JavaScript执行在单线程中罢了。在Node中，无论是*nix还是Windows平台，内部完成I/O任务的另有线程池。
事实上，在Node中，除了JavaScript是单线程外，Node自身其实是多线程的，只是I/O线程使用的CPU较少。另一个需要重视的观点则是，除了用户代码无法并行执行外，所有的I/O（磁盘I/O和网络I/O等）则是可以并行起来的。

Windows下的IOCP，它在某种程度上提供了理想的异步I/O：调用异步方法，等待I/O完成之后的通知，执行回调，用户无须考虑轮询。但是它的内部其实仍然是线程池原理，不同之处在于这些线程池由系统内核接手管理。
Windows下主要通过IOCP来向系统内核发送I/O调用和从内核获取已完成的I/O操作，配以事件循环，以此完成异步I/O的过程。
在Linux下通过epoll实现这个过程。
FreeBSD下通过kqueue实现。
Solaris下通过Event ports实现。
不同的是线程池在Windows下由内核（IOCP）直接提供，*nix系列下由libuv自行实现。

事件循环、观察者、请求对象、I/O线程池这四者共同构成了Node异步I/O模型的基本要素。
完成整个异步I/O环节的有事件循环、观察者和请求对象等。
从JavaScript发起调用到内核执行完I/O操作的过渡过程中，存在一种中间产物，它叫做请求对象。

#### 事件驱动
在Node中，事件主要来源于网络请求、文件I/O等，这些事件对应的观察者有文件I/O观察者、网络I/O观察者等。
观察者将事件进行了分类。
事件循环是一个典型的生产者/消费者模型。
异步I/O、网络请求等则是事件的生产者，源源不断为Node提供不同类型的事件，这些事件被传递到对应的观察者那里，事件循环则从观察者那里取出事件并处理。在Windows下，这个循环基于IOCP创建，而在*nix下则基于多线程创建。

与I/O无关的异步API，它们分别是setTimeout()、setInterval()、setImmediate()和process.nextTick()。
process.nextTick()中的回调函数执行的优先级要高于setImmediate()。这里的原因在于事件循环对观察者的检查是有先后顺序的，process.nextTick()属于idle观察者，setImmediate()属于check观察者。在每一个轮循环检查中，idle观察者先于I/O观察者，I/O观察者先于check观察者。

异步I/O实现，其主旨是使I/O操作与CPU操作分离。
**事件驱动的实质，即通过主循环加事件触发的方式来运行程序。**

事件循环是异步实现的核心，它与浏览器中的执行模型基本保持了一致。
V8和异步I/O在性能上带来的提升，前后端JavaScript编程风格一致，是Node能够迅速成功并流行起来的主要原因。

### 异步编程
#### 函数式编程
```js
var toString = Object.prototype.toString;
var isString = function (obj) { return toString.call(obj) == '[object String]'; };
var isFunction = function (obj) { return toString.call(obj) == '[object Function]'; };
```

通过指定部分参数来产生一个新的定制函数的形式就是偏函数。
偏函数用法是指创建一个调用另外一个部分（参数或变量已经预置的函数）的函数的用法。

事件的处理方式正是基于高阶函数的特性来完成的。
高阶函数则是可以把函数作为参数，或是将函数作为返回值的函数，

单一线程上执行的代码，这在浏览器中指的是JavaScript执行线程与UI渲染共用的一个线程；在Node中，只是没有UI渲染的部分，模型基本相同。
这个利用事件循环的经典调度方式在很多地方都存在应用，最典型的是UI编程，如iOS应用开发等。
Node带来的最大特性莫过于基于事件驱动的非阻塞I/O模型，这是它的灵魂所在。

#### 异步编程解决方案
异步方法任务化。

Pyramid of Doom 恶魔金字塔

中间件通过队列形成一个处理流中间件机制使得在处理网络请求时，可以像面向切面编程一样进行过滤、验证、日志等功能，而不与具体业务逻辑产生关联，以致产生耦合。
尾触发与Next除了事件和Promise外，还有一类方法是需要手工调用才能持续执行后续调用的，常见的关键词是next。事实上，尾触发目前应用最多的地方是Connect的中间件。

异步编程的主要解决方案有3种：
- 事件发布/订阅模式
- Promise/Deferred模式
- 流程控制库

事件发布/订阅模式 或 事件监听器模式是一种广泛用于异步编程的模式，是回调函数的事件化。
在事件订阅/发布模式中，通常也有一个once()方法，通过它添加的侦听器只能执行一次，在执行之后就会将它与事件的关联移除。这个特性常常可以帮助过滤一些

重复性的事件响应。
用于检测次数的变量叫做哨兵变量。

所谓雪崩问题，就是在高访问量、大并发量的情况下缓存失效的情景，此时大量的请求同时涌入数据库中，数据库无法同时承受如此大的查询请求，进而往前影响到网站整体的响应速度。

（http://nodejs.org/docs/latest/api/events.html）是发布/订阅模式的一个简单实现，Node中部分模块都继承自它，这个模块比前端浏览器中的大量DOM事件简单，不存在事件冒泡，也不存在preventDefault()、stopPropagation()和stopImmediatePropagation()等控制事件传递的方法。
它具有addListener/on()、once()、removeListener()、removeAllListeners()和emit()等基本的事件监听模式的方法实现。
示例：
```javascript
// 订阅
emitter.on("event1", function (message) { console.log(message); });
// 发布
emitter.emit('event1', "I am message!");
```

**Promise的秘诀其实在于对队列的操作。**

### 内存控制
迈进服务器端编程的领域，内存控制正是在海量请求和长时间运行的前提下进行探讨的。在服务器端，资源向来就寸土寸金，要为海量用户服务，就得使一切资源都要高效循环利用。

通过在Node启动时使用--prof参数，可以得到V8执行时的性能分析数据，其中包含了垃圾回收执行时占用的时间。
查看垃圾回收日志的方式主要是在启动时添加--trace_gc参数。

#### V8的垃圾回收机制
延迟清理（lazy sweeping）
增量式整理（incremental compaction）
增量标记（incremental marking）

Mark-Sweep是标记清除，它分为标记和清除两个阶段。
Mark-Compact是标记整理。
Scavenge中只复制活着的对象，而Mark-Sweep只清理死亡对象。

3种垃圾回收算法的简单对比：

| 回收算法     | Mark-Sweep   | Mark-Compact | Scavenge           |
| ------------ | ------------ | ------------ | ------------------ |
| 速度         | 中等         | 最慢         | 最快               |
| 空间开销     | 少（有碎片） | 少（无碎片） | 双倍空间（无碎片） |
| 是否移动对象 | 否           | 是           | 是                 |

在V8中，主要将内存分为新生代和老生代两代。新生代中的对象为存活时间较短的对象，老生代中的对象为存活时间较长或常驻内存的对象。
V8在老生代中主要采用了Mark-Sweep和Mark-Compact相结合的方式进行垃圾回收。
在分代的基础上，新生代中的对象主要通过Scavenge算法进行垃圾回收。在Scavenge的具体实现中，主要采用了Cheney算法，

对象从新生代中移动到老生代中的过程称为晋升。
对象晋升的条件主要有两个，一个是对象是否经历过Scavenge回收，一个是To空间的内存占用比超过限制。

在64位系统下只能使用约1.4 GB内存和在32位系统下只能使用约0.7 GB内存。
--max-old-space-size命令行参数可以用于设置老生代内存空间的最大值，
--max-new-space-size命令行参数则用于设置新生代内存空间的大小的。

V8的垃圾回收策略主要基于分代式垃圾回收机制。

在正常的JavaScript执行中，无法立即回收的内存有闭包和全局变量引用这两种情况。
在JavaScript中，实现外部作用域访问内部作用域中变量的方法叫做闭包（closure）。这得益于高阶函数的特性：函数可以作为参数或者返回值。
在JavaScript中能形成作用域的有函数调用、with以及全局作用域。

Node的内存构成主要由通过V8进行分配的部分和Node自行分配的部分。受V8的垃圾回收限制的主要是V8的堆内存。

### Buffer
#### Buffer 的结构
Buffer对象不同于其他对象，它不经过V8的内存分配机制，所以也不会有堆内存的大小限制。
不是通过V8分配的内存称为堆外内存。

`new Buffer(size);`
Node以8 KB为界限来区分Buffer是大对象还是小对象：`Buffer.poolSize = 8 * 1024;`
这个8 KB的值也就是每个slab的大小值，在JavaScript层面，以它作为单位单元进行内存的分配。


为了高效地使用申请来的内存，Node采用了slab分配机制。
slab是一种动态内存管理机制，最早诞生于SunOS操作系统（Solaris）中，目前在一些*nix操作系统中有广泛的应用，如FreeBSD和Linux。
简单而言，slab就是一块申请好的固定大小的内存区域。slab具有如下3种状态：
- full：完全分配状态。
- partial：部分分配状态。
- empty：没有被分配状态。

#### Buffer的拼接
Buffer是二进制数据，字符串与Buffer之间存在编码关系。

```js
// Buffer.concat()方法封装了从小Buffer对象向大Buffer对象的复制过程
Buffer.concat = function (list, length) {
  if (!Array.isArray(list)) {
    throw new Error('Usage: Buffer.concat(list, [length])');
  }
  if (list.length === 0) {
    return new Buffer(0);
  } else if (list.length === 1) {
    return list[0];
  } if (typeof length !== 'number') {
    length = 0;
    for (var i = 0; i < list.length; i++) {
      var buf = list[i];
      length += buf.length;
    }
  }
  var buffer = new Buffer(length);
  var pos = 0;
  for (var i = 0; i < list.length; i++) {
    var buf = list[i];
    buf.copy(buffer, pos);
    pos += buf.length;
  }
  return buffer;
};

// 正确的Buffer拼接方法
var chunks = [];
var size = 0;
res.on('data', function (chunk) {
  chunks.push(chunk); size += chunk.length;
});
res.on('end', function () {
  var buf = Buffer.concat(chunks, size);
  var str = iconv.decode(buf, 'utf8');
  console.log(str);
});
var fs = require('fs');
var rs = fs.createReadStream('test.md');
```

#### Buffer的性能
os模块中的totalmem()和freemem()这两个方法用于查看操作系统的内存使用情况，它们分别返回系统的总内存和闲置内存，以字节为单位。

查看进程的内存占用调用process.memoryUsage()可以看到Node进程的内存占用情况，示例：
`$ node> process.memoryUsage(){ rss: 13852672,  heapTotal: 6131200,  heapUsed: 2757120 }`
rss是resident set size的缩写，即进程的常驻内存部分。进程的内存总共有几部分，一部分是rss，其余部分在交换区（swap）或者文件系统（filesystem）中。
heapTotal和heapUsed对应的是V8的堆内存信息。heapTotal是堆中总共申请的内存量，heapUsed表示目前堆中使用中的内存量。
这3个值的单位都是字节。

如何使用大量缓存，目前比较好的解决方案是采用进程外的缓存，进程自身不存储状态。
外部的缓存软件有着良好的缓存过期淘汰策略以及自有的内存管理，不影响Node进程的性能。
在Node中主要可以解决两个问题：1. 将缓存转移到外部，减少常驻内存的对象的数量，让垃圾回收更高效。2. 进程之间可以共享缓存。
目前，市面上较好的缓存有Redis和Memcached。

造成内存泄漏的原因有如下几个：
- 缓存
- 队列消费不及时
- 作用域未释放

现在已经有许多工具用于定位Node应用的内存泄漏，下面是一些常见的工具：
- v8-profiler。由Danny Coates提供，它可以用于对V8堆内存抓取快照和对CPU进行分析，但该项目已经有3年没有维护了。
- node-heapdump。这是Node核心贡献者之一Ben Noordhuis编写的模块，它允许对V8堆内存抓取快照，用于事后分析。
- node-mtrace。由Jimb Esser提供，它使用了GCC的mtrace工具来分析堆的使用。
- dtrace。在Joyent的SmartOS系统上，有完善的dtrace工具用来分析内存泄漏。
- node-memwatch。来自Mozilla的Lloyd Hilaiel贡献的模块，采用WTFPL许可发布。

Node提供了stream模块用于处理大文件。
stream模块是Node的原生模块，直接引用即可。stream继承自EventEmitter，具备基本的自定义事件功能，同时抽象出标准的事件和方法。它分可读和可写两种。
Node中的大多数模块都有stream的应用，比如fs的createReadStream()和createWriteStream()方法可以分别用于创建文件的可读流和可写流，process模块中的stdin和stdout则分别是可读流和可写流的示例。

真正的内存是在Node的C++层面提供的，JavaScript层面只是使用它。
当进行小而频繁的Buffer操作时，采用slab的机制进行预先申请和事后分配，使得JavaScript到操作系统之间不必有过多的内存申请方面的系统调用。
对于大块的Buffer而言，则直接使用C++层面提供的内存，而无需细腻的分配操作。

### 网络编程
Node提供了net、dgram、http、https这4个模块，分别用于处理TCP、UDP、HTTP、HTTPS，适用于服务器端和客户端。

#### 构建TCP服务
TCP服务的事件分为服务器事件和连接事件。
服务器事件对于通过net.createServer()创建的服务器而言，它是一个EventEmitter实例。
它的自定义事件有如下几种：
- listening：在调用server.listen()绑定端口或者Domain Socket后触发，简洁写法为server.listen(port,listeningListener)，通过listen()方法的第二个参数传入。
- connection：每个客户端套接字连接到服务器端时触发，简洁写法为通过net.createServer()，最后一个参数传递。
- close：当服务器关闭时触发，在调用server.close()后，服务器将停止接受新的套接字连接，但保持当前存在的连接，等待所有连接都断开后，会触发该事件。
- error：当服务器发生异常时，将会触发该事件。比如侦听一个使用中的端口，将会触发一个异常，如果不侦听error事件，服务器将会抛出异常。连接事件服务器可以同时与多个客户端保持连接，对于每个连接而言是典型的可写可读Stream对象。

Stream对象可以用于服务器端和客户端之间的通信，既可以通过data事件从一端读取另一端发来的数据，也可以通过write()方法从一端向另一端发送数据。
它具有如下自定义事件：
- data：当一端调用write()发送数据时，另一端会触发data事件，事件传递的数据即是write()发送的数据。
- end：当连接中的任意一端发送了FIN数据时，将会触发该事件。
- connect：该事件用于客户端，当套接字与服务器端连接成功时会被触发。
- drain：当任意一端调用write()发送数据时，当前这端会触发该事件。
- error：当异常发生时，触发该事件。
- close：当套接字完全关闭时，触发该事件。
- timeout：当一定时间后连接不再活跃时，该事件将会被触发，通知用户当前该连接已经被闲置了。

由于TCP套接字是可写可读的Stream对象，可以利用pipe()方法巧妙地实现管道操作。
示例：实现一个echo服务器。
```js
var net = require('net');

var server = net.createServer(function (socket) {
  socket.write('Echo server\r\n');
  socket.pipe(socket);
});
server.listen(1337, '127.0.0.1');
```

TCP针对网络中的小数据包有一定的优化策略：Nagle算法。

对于Domain Socket，在填写选项时，填写path即可：`var client = net.connect({path: '/tmp/echo.sock'});`
也可以对Domain Socket进行监听：`server.listen('/tmp/echo.sock');`

```js
// 通过net模块自行构造客户端进行会话
var net = require('net');

var client = net.connect({ port: 8124 }, function () { //'connect' listener  
  console.log('client connected');
  client.write('world!\r\n');
});
client.on('data', function (data) {
  console.log(data.toString());
  client.end();
});
client.on('end', function () {
  console.log('client disconnected');
});


// 创建一个TCP服务器端来接受网络请求
var net = require('net');

var server = net.createServer(function (socket) {
  // 新的连接  
  socket.on('data', function (data) {
    socket.write("你好");
  });
  socket.on('end', function () {
    console.log('连接断开');
  });
  socket.write("欢迎光临《深入浅出Node.js》示例：\n");
});
server.listen(8124, function () {
  console.log('server bound');
});

//通过net.createServer(listener)即可创建一个TCP服务器，listener是连接事件connection的侦听器，也可以采用如下的方式进行侦听：
// var server = net.createServer();
// server.on('connection', function (socket) {
//   // 新的连接});
//   server.listen(8124);
// })
```

#### 构建UDP服务
UDP套接字事件UDP套接字相对TCP套接字使用起来更简单，它只是一个EventEmitter的实例，而非Stream的实例。
它具备如下自定义事件：
- message：当UDP套接字侦听网卡端口后，接收到消息时触发该事件，触发携带的数据为消息Buffer对象和一个远程地址信息。
- listening：当UDP套接字开始侦听时触发该事件。
- close：调用close()方法时触发该事件，并不再触发message事件。如需再次触发message事件，重新绑定即可。
- error：当异常发生时触发该事件，如果不侦听，异常将直接抛出，使进程退出。

```js
// 创建UDP服务器端
var dgram = require("dgram");

var server = dgram.createSocket("udp4");
server.on("message", function (msg, rinfo) {
  console.log("server got: " + msg + " from " + rinfo.address + ":" + rinfo.port);
});
server.on("listening", function () {
  var address = server.address();
  console.log("server listening " + address.address + ":" + address.port);
});
// 若想让UDP套接字接收网络消息，只要调用dgram.bind(port, [address])方法对网卡和端口进行绑定即可。
// 该套接字将接收所有网卡上41234端口上的消息。在绑定完成后，将触发listening事件
server.bind(41234);


// 创建UDP客户端
var dgram = require('dgram');

var message = new Buffer("深入浅出Node.js");
var client = dgram.createSocket("udp4");
client.send(message, 0, message.length, 41234, "localhost", function (err, bytes) {
  client.close();
});
```

#### 构建HTTP服务
HTTP客户端事件与服务器端对应的，HTTP客户端也有相应的事件：
- response：与服务器端的request事件对应的客户端在请求发出后得到服务器端响应时，会触发该事件。
- socket：当底层连接池中建立的连接分配给当前请求对象时，触发该事件。
- connect：当客户端向服务器端发起CONNECT请求时，如果服务器端响应了200状态码，客户端将会触发该事件。
- upgrade：客户端向服务器端发起Upgrade请求时，如果服务器端响应了101 Switching Protocols状态，客户端将会触发该事件。
- continue：客户端向服务器端发起Expect: 100-continue头信息，以试图发送较大数据量，如果服务器端响应100 Continue状态，客户端将触发该事件。

http模块提供了一个底层API：`http.request(options, connect)`，用于构造HTTP客户端：
```js
var options = { hostname: '127.0.0.1', port: 1334, path: '/', method: 'GET' };
var req = http.request(options, function (res) {
  console.log('STATUS: ' + res.statusCode);
  console.log('HEADERS: ' + JSON.stringify(res.headers));
  res.setEncoding('utf8');
  res.on('data', function (chunk) {
    console.log(chunk);
  });
});
req.end();
```

HTTP服务的事件如同TCP服务一样，HTTP服务器也抽象了一些事件，以供应用层使用，同样典型的是，服务器也是一个EventEmitter实例。 
- connection事件：在开始HTTP请求和响应前，客户端与服务器端需要建立底层的TCP连接，这个连接可能因为开启了keep-alive，可以在多次请求响应之间使用；当这个连接建立时，服务器触发一次connection事件。
- request事件：建立TCP连接后，http模块底层将在数据流中抽象出HTTP请求和HTTP响应，当请求数据发送到服务器端，在解析出HTTP请求头后，将会触发该事件；在res.end()后，TCP连接可能将用于下一次请求响应。
- close事件：与TCP服务器的行为一致，调用server.close()方法停止接受新的连接，当已有的连接都断开时，触发该事件；可以给server.close()传递一个回调函数来快速注册该事件。
- checkContinue事件：某些客户端在发送较大的数据时，并不会将数据直接发送，而是先发送一个头部带Expect: 100-continue的请求到服务器，服务器将会触发checkContinue事件；如果没有为服务器监听这个事件，服务器将会自动响应客户端100 Continue的状态码，表示接受数据上传；如果不接受数据的较多时，响应客户端400 Bad Request拒绝客户端继续发送数据即可。需要注意的是，当该事件发生时不会触发request事件，两个事件之间互斥。当客户端收到100 Continue后重新发起请求时，才会触发request事件。
- connect事件：当客户端发起CONNECT请求时触发，而发起CONNECT请求通常在HTTP代理时出现；如果不监听该事件，发起该请求的连接将会关闭。
- upgrade事件：当客户端要求升级连接的协议时，需要和服务器端协商，客户端会在请求头中带上Upgrade字段，服务器端会在接收到这样的请求时触发该事件。这在后文的WebSocket部分有详细流程的介绍。如果不监听该事件，发起该请求的连接将会关闭。
- clientError事件：连接的客户端触发error事件时，这个错误会传递到服务器端，此时触发该事件。

创建HTTP服务器端：
```js
var http = require('http');

http.createServer(function (req, res) {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('Hello World\n');
}).listen(1337, '127.0.0.1');
console.log('Server running at http://127.0.0.1:1337/');
```

**Ajax的实质就是一个异步的网络HTTP请求。**

HTTP服务与TCP服务模型有区别的地方在于：
- 在开启keepalive后，一个TCP会话可以用于多次请求和响应。
- TCP服务以connection为单位进行服务，HTTP服务以request为单位进行服务。
http模块即是将connection到request的过程进行了封装。

从协议的角度来说，现在的应用，如浏览器，其实是一个HTTP的代理。

#### 构建WebSocket服务
社区的ws模块封装了WebSocket的底层实现。socket.io即是在它的基础上构建实现的。

WebSocket握手客户端建立连接时，通过HTTP发起请求报文，如下所示：
```http
GET /chat HTTP/1.1
Host: server.example.com
Upgrade: websocket
Connection: Upgrade
Sec-WebSocket-Key: dGhlIHNhbXBsZSBub25jZQ==
Sec-WebSocket-Protocol: chat, superchat
Sec-WebSocket-Version: 13
```

服务器端在处理完请求后，响应如下报文：
```http
HTTP/1.1 101 Switching Protocols
Upgrade: websocket
Connection: Upgrade
Sec-WebSocket-Accept: s3pPLMBiTxaQ9kYGzzhZRbK+xOo=
Sec-WebSocket-Protocol: chat
```

WebSocket协议主要分为两个部分：握手和数据传输。
WebSocket更接近与传输层协议，它并没有在HTTP的基础上模拟服务器端的推送，而是在TCP上定义独立的协议。让人迷惑的部分在于WebSocket的握手部分是由HTTP完成的。

WebSocket与传统HTTP有如下好处：
- 客户端与服务器端只建立一个TCP连接，可以使用更少的连接。
- WebSocket服务器端可以推送数据到客户端，这远比HTTP请求响应模式更灵活、更高效。
- 有更轻量级的协议头，减少数据传送量。

#### 构建HTTPS服务

创建HTTPS客户端，与HTTP的客户端相差不大，除了指定证书相关的参数外：
```js
var https = require('https');
var fs = require('fs');

var options = {
  hostname: 'localhost',
  port: 8000,
  path: '/',
  method: 'GET',
  key: fs.readFileSync('./keys/client.key'),
  cert: fs.readFileSync('./keys/client.crt'),
  ca: [fs.readFileSync('./keys/ca.crt')]
};
options.agent = new https.Agent(options);
var req = https.request(options, function (res) {
  res.setEncoding('utf-8');
  res.on('data', function (d) {
    console.log(d);
  });
});
req.end();
req.on('error', function (e) {
  console.log(e);
});
```

执行上面的操作：$ node client.js helloworld
如果不设置ca选项，将会得到如下异常：[Error: UNABLE_TO_VERIFY_LEAF_SIGNATURE]
解决该异常的方案是添加选项属性 `rejectUnauthorized: false`，它的效果与curl工具加-k一样，都会在数据传输过程中会加密，但是无法保证服务器端的证书不是伪造的。

由于是自签名的证书，curl工具无法验证服务器端证书是否正确。要解决上面的问题有两种方式：
- 一种是加-k选项，让curl工具忽略掉证书的验证，这样的结果是数据依然会通过公钥加密传输，但是无法保证对方是可靠的，会存在中间人攻击的潜在风险。
`$ curl -k https://localhost:8000/helloworld`
- 另一种解决的方式是给curl设置--cacert选项，告知CA证书使之完成对服务器证书的验证。
`$ curl --cacert keys/ca.crt https://localhost:8000/helloworld`

创建HTTPS服务器端，只比HTTP服务多一个选项配置，其余地方几乎相同：
```js
var https = require('https');
var fs = require('fs');

var options = {
  key: fs.readFileSync('./keys/server.key'),
  cert: fs.readFileSync('./keys/server.crt')
};
https.createServer(options, function (req, res) {
  res.writeHead(200);
  res.end("hello world\n");
}).listen(8000);
```

#### 构建TLS服务
TLS的服务器端和客户端仅仅只在证书的配置上有差别，其余部分基本相同。

创建TLS服务器端：
```js
var tls = require('tls');
var fs = require('fs');

var options = {
  key: fs.readFileSync('./keys/server.key'),
  cert: fs.readFileSync('./keys/server.crt'),
  requestCert: true,
  ca: [fs.readFileSync('./keys/ca.crt')]
};
var server = tls.createServer(options, function (stream) {
  console.log('server connected', stream.authorized ? 'authorized' : 'unauthorized');
  stream.write("welcome!\n");
  stream.setEncoding('utf8');
  stream.pipe(stream);
});
server.listen(8000, function () {
  console.log('server bound');
});

```
启动上述服务后，通过下面的命令可以测试证书是否正常：
`$ openssl s_client -connect 127.0.0.1:8000`

证书：
- 自签名证书。就是自己扮演CA机构，给自己的服务器端颁发签名证书。
以下为生成私钥、生成CSR文件、通过私钥自签名生成证书的过程：
`$ openssl genrsa -out ca.key 1024$ openssl req -new -key ca.key -out ca.csr$ openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt`
- 第三方 CA（Certificate Authority，数字证书认证中心）。
CA的作用是为站点颁发证书，且这个证书中具有CA通过自己的公钥和私钥实现的签名。
为了得到签名证书，服务器端需要通过自己的私钥生成CSR（Certificate Signing Request，证书签名请求）文件。CA机构将通过这个文件颁发属于该服务器端的签名证书，只要通过CA机构就能验证证书是否合法。

Node在底层采用的是openssl实现TLS/SSL的，为此要可以通过openssl为为服务端和客户端生成公钥和私钥：
```bash
// 生成服务器端私钥
$ openssl genrsa -out server.key 1024
// 生成客户端私钥
$ openssl genrsa -out client.key 1024

// 上述命令生成了两个1024位长的RSA私钥文件，可以通过它继续生成公钥
$ openssl rsa -in server.key -pubout -out server.pem
$ openssl rsa -in client.key -pubout -out client.pem
```

Node在网络安全上提供了3个模块，分别为crypto、tls、https。
- crypto主要用于加密解密，SHA1、MD5等加密算法都在其中有体现。
- 真正用于网络的是另外两个模块，tls模块提供了与net模块类似的功能，区别在于它建立在TLS/SSL加密的TCP连接上。
- https模块，它完全与http模块接口一致，区别也仅在于它建立于安全的连接之上。

### 多进程架构

4种创建进程方法的差别：

| 类型       | 回调/异常 | 进程类型 | 执行类型       | 可设置超时 |
| ---------- | --------- | -------- | -------------- | ---------- |
| spawn()    | ×         | 任意     | 命令           | ×          |
| exec()     | √         | 任意     | 命令           | √          |
| execFile() | √         | 任意     | 可执行文件     | √          |
| fork()     | ×         | Node     | JavaScript文件 | ×          |

这里的可执行文件是指可以直接直行的文件。
通过execFile()运行的JavaScript文件，首行内容必须添加如下代码：
`#!/usr/bin/env node`

> 点评：深入浅出，理论与实践相结合，值得一读。
对于开发者来说，原理性的东西看得再多，仍旧停留在“知道”的层面，宛若空中楼阁，轻飘飘的；而“多说无益，直接上代码”，会让人有一种醍醐灌顶、恍然大悟、不过如此的感觉，因为触及到了底层运作机制，很有实感，理解了，通了，谓之“精通”。
