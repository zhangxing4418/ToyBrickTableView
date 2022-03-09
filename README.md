# ToyBrickTableView
如搭积木般快速搭建自己的TableView

已集成
- [x] 上下拉刷新
- [x] 空白数据集显示
- [x] Cell侧滑
## 如何安装
```objc
pod 'ToyBrickTableView'
```
## 如何使用
* 自定义TableViewCell
```objc
+ (NSString *)reuseIdentifier {
    static NSString *__reuseIdentifier = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __reuseIdentifier = @"tableViewCell复用标志符"
    });
    return __reuseIdentifier;
}
```
```objc
+ (CGFloat)cellRowHeightForDict:(NSMutableDictionary *)dict {
    //设置Cell高度
    return 44;
}
```
```objc
+ (NSMutableDictionary *)buildCellDictWithCustomerModel:(CustomerModel *)model {
    /**
     构建Cell字典
     每次build都会将dict清空
     */
    NSMutableDictionary *dict = [[super class] buildCellDict:[CustomerTableViewCell class]];
    [dict tb_setObj:model forKey:@"model"];
    return dict;
}
```
```objc
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    //初始化Cell, 添加自定义子视图
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.customerView];
        
        //设置Cell侧滑
        self.rightButtons = @[[MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor redColor] callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
          //doSomething
          return YES;
        }], [MGSwipeButton buttonWithTitle:@"更多" backgroundColor:[UIColor lightGrayColor] callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
          //doSomething
          return NO;
        }]];
        self.rightSwipeSettings.transition = MGSwipeTransitionBorder;
    }
    return self;
}
```
```objc
- (void)updateCellWithDict:(NSMutableDictionary *)dict {
    /**
     取字典中的数据用来渲染Cell
     如果需要上一次dict中的数据，可以将数据先保存在类中，再在这里重新将数据写入dict中
     */
    CustomerModel *model = [dict objectForKey:@"model"];
    //doSomething
}
```
* 构建TableView
```objc
- (TBTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TBTableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        /**
         设置上下拉刷新
         */
        [_tableView headerRefreshEnable:YES];
        _tableView.headerRefreshingBlock = ^{
            NSLog(@"下拉刷新");
            //doSomething
        };
//        [_tableView footerRefreshEnable:YES];
        
        /**
         设置空数据集显示
         */
        _tableView.tableEmptyType = TableEmptyTypeImageTitleButton;
        _tableView.emptyTableTitle = @"空表格文案提示!";
        _tableView.emptyTableImage = [UIImage imageNamed:@"ok"];
        _tableView.emptyTableButtonImage = [UIImage imageNamed:@"ok"];
        _tableView.emptyTableDidTapButtonBlock = ^(UIButton *sender) {
            NSLog(@"点击!");
            //doSomething
        };
        [_tableView enableEmptyTableView];
    }
    return _tableView;
}
```
>⚠️ 以下```UITableViewDataSource```、```UITableViewDelegate```两个代理的实现照抄就行🥳
```objc
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *dict = [self.dataSource tb_objectWithIndex:[indexPath row]];
    Class tableViewCellClass = [TBTableViewCell tableViewCellClassOfDict:dict];
    NSString *reuseIdentifier = [tableViewCellClass reuseIdentifier];
    
    TBTableViewCell *tableViewCell = (TBTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (tableViewCell == nil) {
        tableViewCell = [[tableViewCellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        [tableViewCell setBackgroundColor:[UIColor clearColor]];
        [tableViewCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    [tableViewCell updateCellWithDict:dict];
    
    return tableViewCell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *dict = [self.dataSource tb_objectWithIndex:[indexPath row]];
    Class tableViewCellClass = [TBTableViewCell tableViewCellClassOfDict:dict];
    CGFloat height = [tableViewCellClass cellRowHeightForDict:[self.dataSource tb_objectWithIndex:[indexPath row]]];
    return (height == UITableViewAutomaticDimension || height >= 0) ? height : 0;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *dict = [self.dataSource tb_objectWithIndex:[indexPath row]];
    Class tableViewCellClass = [TBTableViewCell tableViewCellClassOfDict:dict];
    CGFloat height = [tableViewCellClass cellRowEstimatedHeightForDict:[self.dataSource tb_objectWithIndex:[indexPath row]]];
    if (@available(iOS 11.0, *)) {
        return (height == UITableViewAutomaticDimension || height >= 0) ? height : 0;
    }else {
        return height <= 1 ? 0 : height;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *dict = [self.dataSource tb_objectWithIndex:[indexPath row]];
    [dict executeAction];
}
```
* TableView数据源构建
```objc
- (void)buildCellDataSource {
    [self.dataSource removeAllObjects];
    
    [self.dataSource tb_addCellDataSource:[[CustomerTableViewCell buildCellDictWithCustomerModel:model] addIndexAction:^(NSInteger index) {
        NSLog(@"点击第%ld行", index);
        //doSomething
    }]];
}
```
