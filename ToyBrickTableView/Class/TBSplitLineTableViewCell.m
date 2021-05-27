//
//  TBSplitLineTableViewCell.m
//  ToyBrickTableView
//
//  Created by mac on 2021/5/6.
//

#import "TBSplitLineTableViewCell.h"

@interface TBSplitLineTableViewCell ()

@property (nonatomic, strong) UIView *splitLineView;

@end

@implementation TBSplitLineTableViewCell

- (UIView *)splitLineView {
    if (!_splitLineView) {
        _splitLineView = [[UIView alloc] initWithFrame:CGRectZero];
        _splitLineView.backgroundColor = [UIColor clearColor];
    }
    return _splitLineView;
}

+ (NSString *)reuseIdentifier {
    static NSString *__reuseIdentifier = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __reuseIdentifier = NSStringFromClass([TBSplitLineTableViewCell class]);
    });
    return __reuseIdentifier;
}

+ (CGFloat)cellRowHeightForDict:(NSMutableDictionary *)dict {
    return [dict tb_floatForKey:@"height"];
}

+ (NSMutableDictionary *)buildCellDictWithBackgroundColor:(UIColor *)bgColor height:(CGFloat)height leftEdge:(CGFloat)left rightEdge:(CGFloat)right {
    NSMutableDictionary *dict = [super buildCellDict:[TBSplitLineTableViewCell class]];
    [dict tb_setObj:bgColor forKey:@"bgColor"];
    [dict tb_setFloat:height forKey:@"height"];
    [dict tb_setFloat:left forKey:@"leftEdge"];
    [dict tb_setFloat:right forKey:@"rightEdge"];
    return dict;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.splitLineView];
    }
    return self;
}

- (void)updateCellWithDict:(NSMutableDictionary *)dict {
    UIColor *bgColor = [dict objectForKey:@"bgColor"];
    CGFloat height = [dict tb_floatForKey:@"height"];
    CGFloat leftEdge = [dict tb_floatForKey:@"leftEdge"];
    CGFloat rightEdge = [dict tb_floatForKey:@"rightEdge"];
    if ([bgColor isEqual:[UIColor clearColor]]) {
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    self.splitLineView.backgroundColor = bgColor;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.splitLineView.frame = CGRectMake(leftEdge, 0, CGRectGetWidth(self.contentView.frame) - leftEdge - rightEdge, height);
    });
}

@end
