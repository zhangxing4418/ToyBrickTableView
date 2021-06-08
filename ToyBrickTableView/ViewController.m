//
//  ViewController.m
//  ToyBrickTableView
//
//  Created by mac on 2021/5/6.
//

#import "ViewController.h"
#import "TBTableView.h"
#import "TBTableViewCell.h"
#import "TBValue1TableViewCell.h"
#import "TBSplitLineTableViewCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) TBTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

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
         MJRefresh
         */
        [_tableView headerRefreshEnable:YES];
        __block ViewController *weakSelf = self;
        _tableView.headerRefreshingBlock = ^{
            NSLog(@"下拉刷新");
            [weakSelf.tableView endHeaderRefreshing];
        };
//        [_tableView footerRefreshEnable:YES];
        
        /**
         EmptyDataSet
         */
        self.tableView.tableEmptyType = TableEmptyTypeImageTitleButton;
        self.tableView.emptyTableTitle = @"空表格文案提示!";
        self.tableView.emptyTableImage = [UIImage imageNamed:@"ok"];
        self.tableView.emptyTableButtonImage = [UIImage imageNamed:@"ok"];
        self.tableView.emptyTableDidTapButtonBlock = ^(UIButton *sender) {
            NSLog(@"点击确定!");
        };
        [self.tableView enableEmptyTableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self buildCellDataSource];
}

- (void)buildCellDataSource {
    [self.dataSource removeAllObjects];
    
    for (int i = 0; i < 5; i++) {
        [self.dataSource addObject:[[TBValue1TableViewCell buildCellDictWithConfigBlock:^TBValue1TableViewCellConfig *(UIImageView *imageView, UILabel *titleLabel, UILabel *subTitleLabel, TBValue1TableViewCellConfig *config) {
            titleLabel.text = @"第一项";
            subTitleLabel.text = @"详情";
            subTitleLabel.textColor = [UIColor lightGrayColor];
            config.height = 45;
            config.backgroundColor = [UIColor systemRedColor];
            return config;
        }] addAction:^{
            NSLog(@"这是第一项");
        }]];
        if (@available(iOS 13.0, *)) {
            [self.dataSource addObject:[TBSplitLineTableViewCell buildCellDictWithBackgroundColor:[UIColor systemGroupedBackgroundColor] height:10 leftEdge:15 rightEdge:0]];
        } else {
            [self.dataSource addObject:[TBSplitLineTableViewCell buildCellDictWithBackgroundColor:[UIColor groupTableViewBackgroundColor] height:10 leftEdge:15 rightEdge:0]];
        }
    }
}

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

@end
