//
//  TBTableView.m
//  ToyBrickTableView
//
//  Created by mac on 2021/5/6.
//

#import "TBTableView.h"
#import <MJRefresh/MJrefresh.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface TBTableView ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation TBTableView

- (void)initialize {
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    /**
     MJRefresh
     */
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self.headerRefreshingBlock) {
            self.headerRefreshingBlock();
        }
    }];
    header.stateLabel.hidden = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = header;
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (self.footerRefreshingBlock) {
            self.footerRefreshingBlock();
        }
    }];
    self.mj_footer = footer;
    [self headerRefreshEnable:NO];
    [self footerRefreshEnable:NO];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialize];
}

/**
 MJRefresh
 */
- (void)headerRefreshEnable:(BOOL)enable {
    self.mj_header.hidden = !enable;
}

- (void)footerRefreshEnable:(BOOL)enable {
    self.mj_footer.hidden = !enable;
}

- (void)beginHeaderRefreshing {
    [self.mj_header beginRefreshing];
}

- (void)endHeaderRefreshing {
    [self.mj_header endRefreshing];
}

- (BOOL)isHeaderRefreshing {
    return [self.mj_header isRefreshing];
}

- (void)beginFooterRefreshing {
    [self.mj_footer beginRefreshing];
}

- (void)endFooterRefreshing {
    [self.mj_footer endRefreshing];
}

- (BOOL)isFooterRefreshing {
    return [self.mj_footer isRefreshing];
}

- (void)noticeFooterNoMoreData {
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)resetFooterNoMoreData {
    [self.mj_footer resetNoMoreData];
}

/**
 EmptyDataSet
 */
- (void)enableEmptyTableView {
    self.emptyDataSetSource = self;
    self.emptyDataSetDelegate = self;
}

#pragma mark - DZNEmptyDataSetSource, DZNEmptyDataSetDelegate
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    switch (self.tableEmptyType) {
        case TableEmptyTypeNone:
            return nil;
            
        case TableEmptyTypeTitle:
            return self.emptyTableAttributedTitle ? self.emptyTableAttributedTitle : [[NSAttributedString alloc] initWithString:self.emptyTableTitle ? self.emptyTableTitle : @"出错误了!" attributes:@{NSForegroundColorAttributeName : [UIColor systemGroupedBackgroundColor], NSFontAttributeName : [UIFont systemFontOfSize:15]}];
            
        case TableEmptyTypeTitleButton:
            return self.emptyTableAttributedTitle ? self.emptyTableAttributedTitle : [[NSAttributedString alloc] initWithString:self.emptyTableTitle ? self.emptyTableTitle : @"出错误了!" attributes:@{NSForegroundColorAttributeName : [UIColor systemGroupedBackgroundColor], NSFontAttributeName : [UIFont systemFontOfSize:15]}];
            
        case TableEmptyTypeImageTitle:
            return self.emptyTableAttributedTitle ? self.emptyTableAttributedTitle : [[NSAttributedString alloc] initWithString:self.emptyTableTitle ? self.emptyTableTitle : @"出错误了!" attributes:@{NSForegroundColorAttributeName : [UIColor systemGroupedBackgroundColor], NSFontAttributeName : [UIFont systemFontOfSize:15]}];
            
        case TableEmptyTypeImageTitleButton:
            return self.emptyTableAttributedTitle ? self.emptyTableAttributedTitle : [[NSAttributedString alloc] initWithString:self.emptyTableTitle ? self.emptyTableTitle : @"出错误了!" attributes:@{NSForegroundColorAttributeName : [UIColor systemGroupedBackgroundColor], NSFontAttributeName : [UIFont systemFontOfSize:15]}];
            
        default:
            return nil;
    }
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    switch (self.tableEmptyType) {
        case TableEmptyTypeNone:
            return nil;
            
        case TableEmptyTypeTitle:
            return nil;
            
        case TableEmptyTypeTitleButton:
            return nil;
            
        case TableEmptyTypeImageTitle:
            return self.emptyTableImage;
            
        case TableEmptyTypeImageTitleButton:
            return self.emptyTableImage;
            
        default:
            return nil;
    }
}

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    switch (self.tableEmptyType) {
        case TableEmptyTypeNone:
            return nil;
            
        case TableEmptyTypeTitle:
            return nil;
            
        case TableEmptyTypeTitleButton:
            return self.emptyTableButtonImage ? self.emptyTableButtonImage : nil;
            
        case TableEmptyTypeImageTitle:
            return nil;
            
        case TableEmptyTypeImageTitleButton:
            return self.emptyTableButtonImage ? self.emptyTableButtonImage : nil;
            
        default:
            return nil;
    }
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return self.verticalOffset;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return self.spaceHeight;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    if (self.emptyTableDidTapButtonBlock) {
        self.emptyTableDidTapButtonBlock(button);
    }
}

@end
