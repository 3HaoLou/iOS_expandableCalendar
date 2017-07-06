# iOS_expandableCalendar
我们是[三号楼](http://3haolou.com/) 专注局部装修100年

简单的一个日历任务预览控件,供大家参考

由于日前,产品小伙伴安利了一发任务清单的App ["滴答清单"](https://www.dida365.com/),所以我们学(cao)习(xi)了一发日历任务控件


![控件简介](https://github.com/3HaoLou/iOS_expandableCalendar/blob/master/github.gif)



目前属于0.0.1版本,思路提供给大家参考,后续会提供出整体控件
大体的结构如下:

## 页面层级
### 使用了多层CollectionView的嵌套实现
> 
第一层:横向滑动的collectionView,通过滑动定位当前月份

> 
第二层:同样是collectionView,当点击某一天时,插入一条CollectionViewCell,充当任务详情页面

具体实现逻辑可以查看源码

### ps
```
使用的第三方控件如下:
1.  SnapKit
2.  AFDateHelper
```
