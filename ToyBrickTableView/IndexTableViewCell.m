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

+ (CGFloat)cellRowHeightForDict:(NSMutableDictionary *)dict index:(NSInteger)index {
    [super cellRowHeightForDict:dict index:index];
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
    }
    return self;
}

- (void)updateCellWithDict:(NSMutableDictionary *)dict {
    self.label.text = [NSString stringWithFormat:@"第%ld行", index + 1];
}

- (void)updateCellWithDict:(NSMutableDictionary *)dict index:(NSInteger)index {
    /**
     如果需要上一次dict中的数据，可以将数据先保存在类中，再在这里重新将数据写入dict中
     */
    [super updateCellWithDict:dict index:index];
    self.label.text = [NSString stringWithFormat:@"第%ld行", index + 1];
}

- (void)autoLayoutSubviews {
    self.label.frame = CGRectMake(50, 0, 100, 50);
}

@end

