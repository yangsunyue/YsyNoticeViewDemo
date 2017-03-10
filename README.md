# YsyNoticeViewDemo
![没有妹纸你们是不会进来的！](http://upload-images.jianshu.io/upload_images/1830398-844aaf630e895d95.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 今天第一次发文章，才发现写个文章水也很深啊。
- 废话不多说。来说一说YsyNoticeView
- 由于马上项目需要更新，产品大大做了相关原型，于是我这个小小的程序猿开始了各种封装

![QQ点赞已满的提示](http://upload-images.jianshu.io/upload_images/1830398-15e95709ec4c4d79.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 产品中有一个提示跟QQ点赞的提示类似的效果。所以就写了这样一个demo。
- 因为gif制作太麻烦了。所以用的都是截图。哈哈请见谅。下面是demo的部分截图。
![YsyNoticeView](http://upload-images.jianshu.io/upload_images/1830398-6e9e2dff86006dac.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

 
- 使用的话直接调用类方法

```
[YsyNoticeView showInfo:@"网络出错" withStyle:YsyNoticeStyleTop]；
```

- 其中YsyNoticeStyle是选择展示方式，有上中下三种效果。

```
typedef NS_ENUM(NSUInteger, YsyNoticeStyle)
{
    YsyNoticeStyleTop = 0,
    YsyNoticeStyleTableView,
    YsyNoticeStyleBottom
} ;
```

- YsyNoticeStyleTableView，类似汽车之家刷新之后的效果。

![YsyNoticeStyleTableView效果](http://upload-images.jianshu.io/upload_images/1830398-10263f0c69647e0a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- YsyNoticeStyleBottom，在屏幕下方淡出的效果。
![YsyNoticeStyleBottom效果](http://upload-images.jianshu.io/upload_images/1830398-bde16501766fae11.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 如果你的tableView位置不是常规的位置的话 使用下面的代码调用 

```
+(void)showInfo:(NSString *)info withTableView:(UITableView *)tableView;
```

- 例如下图
 
![刷新](http://upload-images.jianshu.io/upload_images/1830398-9617db8c99ba67e8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![刷新结束](http://upload-images.jianshu.io/upload_images/1830398-93618a5e73ad212c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


---

- 实现方法其实很简单 简单解释下YsyNoticeStyleTop代码吧



- 第一步 创建topview 和UIImageView 还有label

```
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, -height, SCREEN_WIDTH, height)];
    topView.userInteractionEnabled = YES;
    topView.backgroundColor = [UIColor whiteColor];
  
    topView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    topView.layer.shadowOpacity = 1;
    topView.layer.shadowRadius = 5;
    topView.layer.shadowOffset = CGSizeMake(3.0, 3.0);
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 64 - 20 - 11 , 20, 20)];
    icon.image = [UIImage imageNamed:@"提示"];
    [topView addSubview:icon];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + 20 + 10, 64 - 20 - 11, SCREEN_WIDTH - 40 - 20, 20)];
    textLabel.text = info;
    textLabel.textColor = [UIColor blackColor];
    textLabel.font = [UIFont boldSystemFontOfSize:14.0];
    [topView addSubview:textLabel];
```

- 第二步 给top添加手势以及使用RAC监听手势。（用于反馈用户上滑）

```
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    
    [[pan rac_gestureSignal] subscribeNext:^(UIPanGestureRecognizer *pan) {
        NSLog(@"%@", pan);
        [UIView animateWithDuration:0.7 animations:^{
            pan.view.frame = CGRectMake(0, -height, SCREEN_WIDTH, height);
        } completion:^(BOOL finished) {
            [pan.view removeFromSuperview];
        }];
        [pan.view removeGestureRecognizer:pan];
    }];
    [topView addGestureRecognizer:pan];
```

- 第三步 将topView直接添加到window上并且添加弹簧动画，然后再1.5秒之后自动上已隐藏

```
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:topView];
    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    [UIView animateWithDuration: 0.7 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.3 options:0 animations:^{
        topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    } completion:^(BOOL finished) {
        if (finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.7 animations:^{
                    topView.frame = CGRectMake(0, -height, SCREEN_WIDTH, height);
                } completion:^(BOOL finished) {
                    [topView removeFromSuperview];
                }];
            });
        }
    }];
}
```

- 这样就完成了。虽然其中还有很多细节可以完善（例如使用单例，防止重复创建 等等 ）。但是暂时可以满足业务需求于是也没多多加雕琢。(*^__^*) 嘻嘻……- 



---

- Git Hub下载地址**[YsyNoticeViewDemo](https://github.com/yangsunyue/YsyNoticeViewDemo)**
