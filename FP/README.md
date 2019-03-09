# FP (Functional Programming)

reference: https://llh911001.gitbooks.io/mostly-adequate-guide-chinese/content/ch4.html#%E4%B8%8D%E4%BB%85%E4%BB%85%E6%98%AF%E5%8F%8C%E5%85%B3%E8%AF%AD%E5%92%96%E5%96%B1

## 一等公民函数

函数可以作为变量一般处理

```javascript
var example = function(callback) {
  return ajaxCall(function(json){
    return callback(json);
  });
}
```

改为

```javascript
var example = ajaxCall;
```



## 纯函数  

- 同样的输入给出同样的输出, 没有牵扯外部的变量
- 没有副作用(调用接口, 数据库, 文件系统, 各种IO操作...)


## curry化

- 最后一个参数通常是可以被操作的
```javascript
var add = function(a) {
  return function(b) {
    return a + b;
  }
}
```
- 是一个预加载的功能, 可以返回一个记住左右参数的函数, 有个缓存的作用
