//
//  IndexTableViewCell.m
//  ToyBrickTableView
//
//  Created by mac on 2021/6/17.
//

#import "IndexTableViewCell.h"

@interface IndexTableViewCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation IndexTableViewCell

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textColor = [UIColor blackColor];
        _label.font = [UIFont systemFontOfSize:15];
    }
    return _label;
}

+ (NSString *)reuseIdentifier {
    static NSString *__reuseIdentifier = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __reuseIdentifier = NSStringFromClass([IndexTableViewCell class]);
    });
    return __reuseIdentifier;
}

+ (CGFloat)cellRowHeightForDict:(NSMutableDictionary *)dict {
    return 50;
}

+ (NSMutableDictionary *)buildCellDict {
    /**
     每次build都会将dict清空
     */
    NSMutableDictionary *dict = [[super class] buildCellDict:[IndexTableViewCell class]];
    
    return dict;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.label];
        [self autoLayoutSubviews];
        [self configSwipe];
    }
    return self;
}

- (void)updateCellWithDict:(NSMutableDictionary *)dict {
    self.label.text = [NSString stringWithFormat:@"第%ld行", [dict tb_integerForKey:@"index"] + 1];
}

- (void)configSwipe {
    self.rightButtons = @[[MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor redColor] callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
        NSLog(@"删除");
        return YES;
    }], [MGSwipeButton buttonWithTitle:@"更多" backgroundColor:[UIColor lightGrayColor] callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
        NSLog(@"更多");
        return NO;
    }]];
    self.rightSwipeSettings.transition = MGSwipeTransitionBorder;
}

- (void)autoLayoutSubviews {
    self.label.frame = CGRectMake(50, 0, 100, 50);
}

@end

