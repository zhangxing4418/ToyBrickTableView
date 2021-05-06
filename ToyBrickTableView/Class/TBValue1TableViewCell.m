//
//  TBValue1TableViewCell.m
//  ToyBrickTableView
//
//  Created by mac on 2021/5/6.
//

#import "TBValue1TableViewCell.h"

@implementation TBValue1TableViewCellConfig
@end

@interface TBValue1TableViewCellArguments : NSObject

@property (nonatomic, copy) TBValue1TableViewCellConfig *(^configBlock) (UIImageView *imageView, UILabel *titleLabel, UILabel *subTitleLabel, TBValue1TableViewCellConfig *config);

@end

@implementation TBValue1TableViewCellArguments
@end

@implementation TBValue1TableViewCell

+ (NSString *)reuseIdentifier {
    static NSString *__reuseIdentifier = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __reuseIdentifier = NSStringFromClass([TBValue1TableViewCell class]);
    });
    return __reuseIdentifier;
}

+ (CGFloat)cellRowHeightForDict:(NSMutableDictionary *)dict {
    return [dict tb_floatForKey:@"height"];
}

+ (NSMutableDictionary *)buildCellDictWithConfigBlock:(TBValue1TableViewCellConfig *(^)(UIImageView *, UILabel *, UILabel *, TBValue1TableViewCellConfig *))configBlock {
    NSMutableDictionary *dict = [super buildCellDict:[TBValue1TableViewCell class]];
    if (configBlock) {
        TBValue1TableViewCellArguments *arguments = [[TBValue1TableViewCellArguments alloc] init];
        arguments.configBlock = configBlock;
        [dict tb_setObj:arguments forKey:@"Arguments"];
    }
    [dict tb_setFloat:44 forKey:@"height"];
    return dict;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setBackgroundColor:[UIColor whiteColor]];
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.font = [UIFont systemFontOfSize:13];
        self.detailTextLabel.textColor = [UIColor whiteColor];
        self.detailTextLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

- (void)updateCellWithDict:(NSMutableDictionary *)dict {
    TBValue1TableViewCellArguments *arguments = [dict objectForKey:@"Arguments"];
    if (arguments.configBlock) {
        TBValue1TableViewCellConfig *config = arguments.configBlock(self.imageView, self.textLabel, self.detailTextLabel, [[TBValue1TableViewCellConfig alloc] init]);
        [dict tb_setFloat:config.height forKey:@"height"];
        self.accessoryView = config.accessoryView;
        self.backgroundColor = config.backgroundColor ? config.backgroundColor : [UIColor whiteColor];
        self.contentView.backgroundColor = config.backgroundColor ? config.backgroundColor : [UIColor whiteColor];
    }
}

@end
