---
title: Spring WebFlux Sharing
categories: Technology
tags:
  - Spring Framework
  - WebFlux
abbrlink: 608f
date: 2021-06-11 03:20:53
---
# Spring WebFlux

## Feature

Spring 5+ / Spring Boot 2.0+ 新的Web开发技术栈

| Web Framework  | Container | Server | Programming | Network IO |
| -------------- | --------- | ------ | ----------- | ---------- |
| Spring MVC     | Servlet   | Tomcat | 命令式编程  | 同步阻塞式 |
| Spring WebFlux | Reactor   | Netty  | 响应式编程  | 异步非阻塞 |

WebFlux 优势：

- 非阻塞式：在有限资源下，提高系统吞吐量和伸缩性，**支持高并发**
- 函数式编程：实现路由请求
- 响应式编程：Reactor = Java 8 Stream + Java 9 Reactive Stream

应用扩展：

- 垂直扩展：异步方式
- 水平扩展：增加结点，需要更多资源

![Spring-Boot-Reactor](https://cdn.jsdelivr.net/gh/sstian/images/blogimg/Spring-Boot-Reactor.png)

![spring-mvc-and-webflux-venn](https://cdn.jsdelivr.net/gh/sstian/images/blogimg/spring-mvc-and-webflux-venn.png)

## Knowledges

### 网络IO

同步/异步：针对调用者

> 调用者发送请求，等对方回应才去做别的事情（同步）；不等对方回应就去做别的事情（异步）

阻塞/非阻塞：针对被调用者

> 被调用者接收请求后，做完任务后才反馈（阻塞）；及时反馈再去做任务（非阻塞）

![Socket-IO-5](https://cdn.jsdelivr.net/gh/sstian/images/blogimg/Socket-IO-5.png)

###  命令式编程

关注计算机执行的步骤

```java
// Imperative programming
Integer[] nums = {10, 20, 7, 30};
Integer min = Integer.MAX_VALUE;
for (Integer integer : nums) {
    if (integer < min) {
        min = integer;
    }
}
System.out.println("min value is " + min);
// min value is 7
```

### 函数式编程

#### Lamda表达式

闭包，返回实现了指定接口的对象实例，允许把函数作为一个方法的参数

不关心接口名字和抽象方法名字，只关心输入输出

`(parameters) -> expression` or`(parameters) -> { statements; }`

```java
// 不需要参数，返回值 5
() -> 5  
    
// 接收一个参数(数字类型)，返回其2倍的值  
x -> 2 * x  
  
// 接受2个参数(数字)，并返回它们的差值  
(x, y) -> x – y  
```

#### 函数式接口

有且仅有一个抽象方法，可以有多个非抽象方法的接口

```java
// 1. 自定义
@FunctionalInterface
interface GreetingInterface
{
    // 接口的抽象方法
    void sayMessage(String message);

    // 接口 默认方法，解决接口的修改与现有的实现不兼容的问题
	default void greet(){
        System.out.println("Wonderful!");
    }
}

// 2. 使用Lambda表达式表示接口的一个实现（JAVA 8 之前使用用匿名类实现）
GreetingInterface greetingInterface = 
    message -> System.out.println("Hello " + message);

greetingInterface.sayMessage("World");
greetingInterface.greet();
// Hello World
// Wonderful!

// 3. 使用 java.util.function
Function<Integer, Integer> function = x -> x * 2;
System.out.println(function.apply(5));
// 10
```

| 接口                | 输入参数 | 返回类型 | 说明                         |
| ------------------- | -------- | -------- | ---------------------------- |
| Predicate<T>        | T        | boolean  | 断言                         |
| Supplier<T>         | /        | T        | 提供数据                     |
| Consumer<T>         | T        | /        | 消费数据                     |
| Function<T, R>      | T        | R        | 输入T输出R                   |
| UnaryOperator<T>    | T        | T        | 一元函数（输入输出类型相同） |
| BiFunction<T, U, R> | (T, U)   | R        | 输入两个，输出一个           |
| BinaryOperator<T>   | (T, T)   | T        | 二元函数（输入输出类型相同） |

#### 方法引用

通过方法的名字去指向一个方法

`Class::method` or `instance::method`

```java
/* 自定义类 */
package com.snow.webflux.function;

public class Cat {

    private String name = "Totoro";

    public Cat() {
    }

    public Cat(String name) {
        this.name = name;
    }

    public static void bark(Cat cat) {
        System.out.println(cat + " meow");
    }

    // 默认会把当前实例传到非静态方法，参数名为this,位置在第一个
    public int eat(int num) {
        System.out.println("eat " + num + " fish");
        return num;
    }

    @Override
    public String toString() {
        return this.name;
    }
}
```

```java
/* Method Reference */
// 1. 方法引用
// Consumer<String> consumer = s -> System.out.println(s);
Consumer<String> consumer = System.out::println;
consumer.accept("Apple");
// Apple

// 2. 静态方法引用
Consumer<Cat> staticConsumer = Cat::bark;
Cat cat = new Cat();
staticConsumer.accept(cat);
// Totoro meow

// 3.1. 非静态方法引用，使用对象实例
// Function<Integer, Integer> function = cat::eat;
UnaryOperator<Integer> function = cat::eat;
function.apply(2);
// eat 2 fish

// 3.2. 非静态方法引用，使用类名
BiFunction<Cat, Integer, Integer> eatFunction = Cat::eat;
eatFunction.apply(cat, 3);
// eat 3 fish

// 4.1 构造函数的方法引用
Supplier<Cat> supplier = Cat::new;
System.out.println("another cat: " + supplier.get());
// another cat: Totoro

// 4.2 带参数的构造函数的方法引用
Function<String, Cat> catFunction = Cat::new;
System.out.println("new cat: " + catFunction.apply("Black Cat"));
// new cat: Black Cat
```

#### Stream - Java 8

高级的迭代器，不是数据结构；以一种声明的方式高效地处理数据；来自数据源的元素队列并支持聚合操作。

1. 基本特征：

- **数据源**：流的来源，可以是集合，数组，I/O channel， 产生器generator 等。

- **元素**：特定类型的对象，形成一个队列；不存储元素，而是按需计算。

- **聚合操作**：数据处理，中间操作、终止操作等。

- 内部迭代：通过访问者模式（Visitor）实现，关注数据，可以并行

  > 外部迭代：先前遍历集合，通过Iterator或For-Each的串行方式定义循环，显示地在集合外部进行迭代。

2. Steam类型：

- **stream()** / sequential() - 创建串行流

- **parallelStream()** - 创建并行流；方便并行操作，不需要用户管理多线程

  > 并行流使用线程池：ForkJoinPool.commonPool
  >
  > 默认线程数：当前机器的CPU个数
  >
  > 修改线程数：`System.setProperty("java.util.concurrent.ForkJoinPool.common.parallelism", "8")`

3. Stream使用：

- 创建stream

| 类型      | 相关方法                               |
| --------- | -------------------------------------- |
| 数组      | Arrays.stream()                        |
| 集合      | Collection.stream/parallelStream       |
| 数字Steam | IntStream/LongStream.range/rangeClosed |
|           | Random.ints/longs/doubles              |
| 自己创建  | Stream.generate/iterate()              |

- 中间操作：返回Stream的操作
  - 无状态操作：当前操作跟其它元素的前后没有依赖关系；一般输入为一个元素。
  - 有状态操作：结果需要依赖于其它元素；一般输入为两个元素。

| 中间操作   | 相关方法               | 说明                |
| ---------- | ---------------------- | ------------------- |
| 无状态操作 | map/mapToXxx           | 用于转换元素        |
|            | flatMap / flatMapToXxx | 用于操作元素        |
|            | filter                 | 元素过滤            |
|            | peek                   | 元素遍历，用于debug |
|            | unordered              | 元素无序            |
| 有状态操作 | distinct               | 元素去重            |
|            | sorted                 | 元素排序            |
|            | limit / skip           | 限流 / 跳过指定元素 |

- 终止操作
  - 非短路操作：
  - 短路操作：不需要所有结果计算完就可以结束流的操作。


| 终止操作   | 相关方法                        |                            |
| ---------- | ------------------------------- | -------------------------- |
| 非短路操作 | forEach / forEachOrdered        | 遍历，并行流遍历时保证顺序 |
|            | collect / toArray               | 收集                       |
|            | reduce                          | 减少                       |
|            | min / max / count               | 最小 / 最大 / 元素个数     |
| 短路操作   | findFirst / findAny             | 找到第一个 / 找到任意一个  |
|            | allMatch / anyMatch / noneMatch | 匹配                       |

4. 运行机制：

   链式调用，Head->nextStage

```java
List<String> strings = Arrays.asList("apple", "", "banana", "orange", "", "peach");
List<String> filtered = strings
        .stream()
        .filter(s -> !s.isEmpty())
        .collect(Collectors.toList());
System.out.println("filter list: " + filtered);
// filter list: [apple, banana, orange, peach]
```

#### Reactive Stream - Java 9

基于发布/订阅的数据处理

背压 Back Press：发布者（主动）与订阅者（被动）之间的互动，可以调节数据流量，防止压垮订阅者。

| 发布者     | 订阅者   | 数据 | 背压                               |
| ---------- | -------- | ---- | ---------------------------------- |
| 自来水公司 | 家庭用户 | 水   | 水龙头：需要 - 打开，不需要 - 关闭 |

![Flow](https://cdn.jsdelivr.net/gh/sstian/images/blogimg/Flow.png)

```java
import java.util.concurrent.SubmissionPublisher;
import java.util.concurrent.Flow.Subscriber;

// 1. 定义发布者，发布数据类型为Integer
SubmissionPublisher<Integer> publisher = new SubmissionPublisher<>();

// 2. 定义订阅者
Subscriber<Integer> subscriber = new Subscriber<Integer>() {
    private Subscription subscription;

    @Override
    public void onSubscribe(Subscription subscription) {
        // 保存订阅关系
        this.subscription = subscription;
        // 请求一个数据
        this.subscription.request(1);
    }

    @Override
    public void onNext(Integer item) {
        // 接受到数据，处理
        System.out.println("receive data: " + item);
        // 处理完再请求一个数据
        this.subscription.request(1);
        // // 或者不再接受
        // this.subscription.cancel();
    }

    @Override
    public void onError(Throwable throwable) {
        // 出现异常，可以不接受数据
        throwable.printStackTrace();
        this.subscription.cancel();
    }

    @Override
    public void onComplete() {
        // 数据处理完（发布者关闭）
        System.out.println("done");
    }
};

// 3. 发布者与订阅者建立订阅关系（神鬼契约）
publisher.subscribe(subscriber);

// 4. 生产数据，发布者发布
for (int index = 100; index <= 110; index++) {
    // submit 是个阻塞函数，当订阅者缓冲池满了(256)，发布者会停止发布，直到订阅者消费了数据
    publisher.submit(index);
}

// 5. 结束，发布者关闭
publisher.close();

// 主线程延迟停止，防止数据没有消费就退出
try {
    Thread.currentThread().join(1000);
} catch (InterruptedException e) {
    e.printStackTrace();
}
// receive data: 100
// receive data: 101
// receive data: 102
// receive data: 103
// receive data: 104
// receive data: 105
// receive data: 106
// receive data: 107
// receive data: 108
// receive data: 109
// receive data: 110
// done
```

## Principle

### 响应式编程

#### Rector

一种面向数据流和变化传播的编程范式

==Reactor = Java 8 stream + Java 9 Reactive stream (Java.Util.concurrent.Flow)==

#### 数据信号

- 元素值

- 完成信号：数据流结束

- 错误信号：终止数据流，传递错误信息给订阅者

#### 数据流的发布者

- **Mono**：返回0-1个元素

![mono](https://cdn.jsdelivr.net/gh/sstian/images/blogimg/mono.png)

- **Flux**：返回0-N个元素

![flux](https://cdn.jsdelivr.net/gh/sstian/images/blogimg/flux.png)

#### 操作符

- map

`public final <V> Flux<V> map(Function<? super T,? extends V> mapper)`

![mapForFlux](https://cdn.jsdelivr.net/gh/sstian/images/blogimg/mapForFlux.png)

- flatmap

`public final <R> Flux<R> flatMap(Function<? super T,? extends Publisher<? extends R>> mapper)`

> Transform the elements emitted by this [`Flux`](https://projectreactor.io/docs/core/release/api/reactor/core/publisher/Flux.html) asynchronously into Publishers, then flatten these inner publishers into a single [`Flux`](https://projectreactor.io/docs/core/release/api/reactor/core/publisher/Flux.html) through merging, which allow them to interleave.

![flatMapForFlux](https://cdn.jsdelivr.net/gh/sstian/images/blogimg/flatMapForFlux.png)

- zip

`public static <I,O> Flux<O> zip(Function<? super Object[],? extends O> combinator,int prefetch,  Publisher<? extends I>... sources)`

> Zip multiple sources together, that is to say wait for all the sources to emit one element and combine these elements once into an output value (constructed by the provided combinator). The operator will continue doing so until any of the sources completes. Errors will immediately be forwarded. This "Step-Merge" processing is especially useful in Scatter-Gather scenarios.

![zipIterableSourcesForFlux](https://cdn.jsdelivr.net/gh/sstian/images/blogimg/zipIterableSourcesForFlux.png)

- zipwith

`public final <T2> Flux<Tuple2<T,T2>> zipWith(Publisher<? extends T2> source2)`

> Zip this [`Flux`](https://projectreactor.io/docs/core/release/api/reactor/core/publisher/Flux.html) with another [`Publisher`](https://www.reactive-streams.org/reactive-streams-1.0.3-javadoc/org/reactivestreams/Publisher.html?is-external=true) source, that is to say wait for both to emit one element and combine these elements once into a [`Tuple2`](https://projectreactor.io/docs/core/release/api/reactor/util/function/Tuple2.html). The operator will continue doing so until any of the sources completes. Errors will immediately be forwarded. This "Step-Merge" processing is especially useful in Scatter-Gather scenarios.

![zipWithOtherForFlux](https://cdn.jsdelivr.net/gh/sstian/images/blogimg/zipWithOtherForFlux.png)

- subscribeOn

`public final Flux<T> subscribeOn(Scheduler scheduler)`

> Run subscribe, onSubscribe and request on a specified [`Scheduler`](https://projectreactor.io/docs/core/release/api/reactor/core/scheduler/Scheduler.html)'s [`Scheduler.Worker`](https://projectreactor.io/docs/core/release/api/reactor/core/scheduler/Scheduler.Worker.html). As such, placing this operator anywhere in the chain will also impact the execution context of onNext/onError/onComplete signals from the beginning of the chain up to the next occurrence of a [`publishOn`](https://projectreactor.io/docs/core/release/api/reactor/core/publisher/Flux.html#publishOn-reactor.core.scheduler.Scheduler-).

![subscribeOnForFlux](https://cdn.jsdelivr.net/gh/sstian/images/blogimg/subscribeOnForFlux.png)

- subscribe

`public final Disposable subscribe(Consumer<? super T> consumer)`

> Subscribe a [`Consumer`](https://docs.oracle.com/javase/8/docs/api/java/util/function/Consumer.html?is-external=true) to this [`Flux`](https://projectreactor.io/docs/core/release/api/reactor/core/publisher/Flux.html) that will consume all the elements in the sequence. It will request an unbounded demand (`Long.MAX_VALUE`).

![subscribeWithOnNextForFlux](https://cdn.jsdelivr.net/gh/sstian/images/blogimg/subscribeWithOnNextForFlux.png)

- more ......

### 实现方式

![SpringWebFlux](https://cdn.jsdelivr.net/gh/sstian/images/blogimg/SpringWebFlux.png)

## Examples

### Import Dependency

- Gradle

```groovy
implementation group: 'org.springframework.boot', name: 'spring-boot-starter-webflux', version: '2.4.1'
```

- Maven

```groovy
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-webflux</artifactId>
</dependency>
```

### Create

```java
// just create
Flux.just(1, 2, 3).subscribe(System.out::print);
Mono.just(1).subscribe(System.out::print);

// from array
Integer[] array = {10, 20, 30};
Flux.fromArray(array);

// from iterable
List<Integer> list = Arrays.asList(100, 200, 300);
Flux.fromIterable(list);

// form stream
Stream<Integer> stream = list.stream();
Flux.fromStream(stream);
```

### Operate

```java
Mono<String> mono = Mono.just("123.com");
String[] receivers = {"tom@", "null", "jerry"};
Flux.fromArray(receivers)
        .filter(receiver -> !receiver.equals("null"))
        .flatMap(receiver -> receiver.contains("@") 
                ? Mono.just(receiver) : Mono.just(receiver + "@"))
        .collectList()
        .zipWith(mono)
        .map(tupe2 -> {
            List<String> receiverList = tupe2.getT1();
            String com = tupe2.getT2();
            receiverList = receiverList
                    .stream()
                    .map(recv -> recv + com)
                    .collect(Collectors.toList());
            return receiverList;
        }).subscribe(System.out::println);
// [tom@123.com, jerry@123.com]
```

### Exception Handling

对于Flux或Mono，所有的异常都是一个终止操作。

如果对异常进行了处理，则oneError信号将转换为新序列的开始，并替换掉之前上游产生的序列。

```java
// 常规 try-catch
try {
    Stream.of(1, 2, 0)
            .map(i -> "100 / " + i + " = " + (100 / i))
            .forEach(System.out::println);
} catch (Exception e){
    System.err.println("Error: " + e);
}
```

```java
// 1. Static Fallback Value
// 在遇到异常的时候会fallback到一个静态的默认值
// 1.1 当Publish时，指定异常处理模式
Flux<?> flux= Flux.just(1, 2, 0)
        .map(i -> "100 / " + i + " = " + (100 / i))
        .onErrorReturn("Divided by zero :(");
flux.subscribe(System.out::println);

// 1.2 当subscribe时，指定异常处理模式
Flux<?> flux1= Flux.just(1, 2, 0)
        .map(i -> "100 / " + i + " = " + (100 / i));
flux1.subscribe(System.out::println,
        error -> System.err.println("Error: " + error));
```

```java
// 2. Fallback Method
// 在捕获异常之后可以调用其它的方法
Flux<?> flux2 = Flux.just(1, 2, 0)
        .map(i -> "100 / " + i + " = " + (100 / i))
        .onErrorResume(e -> System.out::println);
flux2.subscribe(System.out::println);
```

```java
// 3. Dynamic Fallback Value
// 根据抛出的异常进行判断，通过定位不同的Error从而Fallback不同的值
Flux<?> flux3 = Flux.just(1, 2, 0)
        .map(i -> "100 / " + i + " = " + (100 / i))
        .onErrorResume(error -> Mono.just(
                MyWrapper.fromError(error)));
flux3.subscribe(System.out::println);
```

```java
// 4. Catch and Rethrow
// 4.1 在onErrorResume中使用Flux.error构建一个新的Flux
Flux<?> flux41 = Flux.just(1, 2, 0)
        .map(i -> "100 / " + i + " = " + (100 / i))
        .onErrorResume(error -> Flux.error(
                new RuntimeException("Oops, ArithmeticException!", error)));
flux41.subscribe(System.out::println);

// 4.2 直接在onErrorMap中进行处理
Flux<?> flux42 = Flux.just(1, 2, 0)
        .map(i -> "100 / " + i + " = " + (100 / i))
        .onErrorMap(error -> 
                    new RuntimeException("Oops, ArithmeticException!", error));

flux42.subscribe(System.out::println);
```

```java
// 5. Log or React on the Side
// 记录异常信息，而不破坏原来的结构
Flux<?> flux5 = Flux.just(1, 2, 0)
        .map(i -> "100 / " + i + " = " + (100 / i))
        .doOnError(error -> System.out.println("We got the error: "+ error));
flux5.subscribe(System.out::println);
```

### Web Request

WebClient 

Spring WebFlux 提供的非阻塞的基于响应式编程的进行HTTP请求的客户端工具

```java
package com.snow.webflux.function;

import io.netty.channel.ChannelOption;
import io.netty.handler.ssl.SslContext;
import io.netty.handler.ssl.SslContextBuilder;
import io.netty.handler.ssl.util.InsecureTrustManagerFactory;
import io.netty.handler.timeout.ReadTimeoutHandler;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.client.reactive.ClientHttpConnector;
import org.springframework.http.client.reactive.ReactorClientHttpConnector;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.netty.http.client.HttpClient;

import javax.net.ssl.SSLException;
import java.util.concurrent.TimeUnit;


@Slf4j
@Configuration
public class WebClientConfig {

    private String assembleBaseUrl = "http://localhost:8080";
    private int assembleConnectionTimeout = 3000;
    private int assembleReadTimeout = 30000;

    @Bean
    public WebClient assembleBaseWebClient() {
        try {
            SslContext sslContext = SslContextBuilder
                .forClient()
                .trustManager(InsecureTrustManagerFactory.INSTANCE)
                .build();
            HttpClient httpClient = HttpClient
                .create()
                .option(ChannelOption.CONNECT_TIMEOUT_MILLIS,
                        assembleConnectionTimeout)
                .doOnConnected(connection -> connection.addHandlerLast(
                                   new ReadTimeoutHandler(assembleReadTimeout, 
                                                   TimeUnit.MILLISECONDS)))
                    .secure(sslContextSpec -> sslContextSpec.sslContext(sslContext));
            ClientHttpConnector connector = 
                new ReactorClientHttpConnector(httpClient);
            return WebClient.builder()
                    .baseUrl(this.assembleBaseUrl)
                    .defaultHeader(HttpHeaders.CONTENT_TYPE, 
                                   MediaType.APPLICATION_JSON_VALUE)
                    .clientConnector(connector)
                    .build();
        } catch (SSLException e) {
            log.error("Caught exception in creating Assemble WebClient bean.", e);
            return null;
        }
    }
}

```

```java
package com.snow.webflux.function;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.time.Duration;

@Slf4j
@Service
public class AssembleService {

    private WebClient assembleBaseWebClient;

    @Autowired
    public AssembleService(WebClient assembleBaseWebClient) {
        this.assembleBaseWebClient = assembleBaseWebClient;
    }

    public Mono<String> createAssembleApplication(final String id) {
        return this.assembleBaseWebClient
            .get()
            .uri(String.format("/create/%s"), id)
            .retrieve()
            .bodyToMono(String.class)
            .filter(rawResult -> {
                    JSONObject jsonObject = JSON.parseObject(rawResult);
                    String status = jsonObject.getString("status");
                    return status.equalsIgnoreCase("DONE");
                })
            .repeatWhenEmpty(repeat -> repeat
                             .zipWith(Flux.range(1, 10), (e, idx) -> idx)
                             .flatMap(time -> {
                    log.info("creating application, please waite a moment...");
                    return Mono.delay(Duration.ofSeconds(time * 5));
                }))
            .onErrorResume(throwable -> Mono.just(
                String.format("error: %s", throwable.getMessage())));
    }
}
```

### Application

spring-boot-gradle-webflux

## References

- [Web on Reactive Stack](https://docs.spring.io/spring-framework/docs/current/reference/html/web-reactive.html)
- [Reactor Exception handling](https://www.cnblogs.com/flydean/p/13967746.html)
- [Socket IO 5](https://blog.csdn.net/u010313909/article/details/80764954)
- [reactor-core 3.4.6](https://projectreactor.io/docs/core/release/api/overview-summary.html)
