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
#import "IndexTableViewCell.h"

@interface ViewController ()

@property (nonatomic, strong) TBTableView *tableView;
@property (nonatomic, assign) NSInteger index;

@end

@implementation ViewController

- (TBTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TBTableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
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
    [self.tableView.dataSources removeAllObjects];
    
    for (int i = 0; i < 15; i++) {
        [self.tableView.dataSources tb_addCellDataSource:[[TBValue1TableViewCell buildCellDictWithConfigBlock:^TBValue1TableViewCellConfig *(UIImageView *imageView, UILabel *titleLabel, UILabel *subTitleLabel, TBValue1TableViewCellConfig *config) {
            titleLabel.text = @"标题";
            subTitleLabel.text = @"详情";
            subTitleLabel.textColor = [UIColor lightGrayColor];
            config.height = 45;
            config.backgroundColor = [UIColor systemRedColor];
            return config;
        }] addAction:^{
            NSLog(@"展示详情");
        }]];
        if (@available(iOS 13.0, *)) {
            [self.tableView.dataSources tb_addCellDataSource:[TBSplitLineTableViewCell buildCellDictWithBackgroundColor:[UIColor systemGroupedBackgroundColor] height:10 leftEdge:15 rightEdge:0]];
        } else {
            [self.tableView.dataSources tb_addCellDataSource:[TBSplitLineTableViewCell buildCellDictWithBackgroundColor:[UIColor groupTableViewBackgroundColor] height:10 leftEdge:15 rightEdge:0]];
        }
        [self.tableView.dataSources tb_addCellDataSource:[[IndexTableViewCell buildCellDict] addIndexAction:^(NSInteger index) {
            NSLog(@"%ld", index);
        }]];
    }
    self.index = [self.tableView.dataSources tb_addCellDataSource:[[TBValue1TableViewCell buildCellDictWithIndexConfigBlock:^TBValue1TableViewCellConfig *(UIImageView *imageView, UILabel *titleLabel, UILabel *subTitleLabel, TBValue1TableViewCellConfig *config, NSInteger index) {
        titleLabel.text = [NSString stringWithFormat:@"第%ld项", index];
        subTitleLabel.text = @"详情";
        subTitleLabel.textColor = [UIColor lightGrayColor];
        config.height = 45;
        config.backgroundColor = [UIColor systemBlueColor];
        return config;
    }] addAction:^{
        NSLog(@"%ld", self.index);
    }]];
}

@end
