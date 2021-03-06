//
//  TBTableViewCell.m
//  ToyBrickTableView
//
//  Created by mac on 2021/5/6.
//

#import "TBTableViewCell.h"

@implementation TBTableViewCell

+ (NSString *)reuseIdentifier {
    static NSString *__reuseIdentifier = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __reuseIdentifier = NSStringFromClass([self class]);
    });
    return __reuseIdentifier;
}

+ (CGFloat)cellRowHeight {
    return 44;
}

+ (CGFloat)cellRowHeightForDict:(NSMutableDictionary *)dict {
    return [self cellRowHeight];
}

+ (CGFloat)cellRowEstimatedHeight {
    return [self cellRowHeight];
}

+ (CGFloat)cellRowEstimatedHeightForDict:(NSMutableDictionary *)dict {
    return [self cellRowEstimatedHeight];
}

+ (NSString *)dictKeyOfClassName {
    return @"className";
}

+ (Class)tableViewCellClassOfDict:(NSMutableDictionary *)dict {
    NSString *className = [dict tb_stringForKey:[self dictKeyOfClassName]];
    if (className && className.length > 0) {
        return NSClassFromString(className);
    }
    return [self class];
}

+ (NSMutableDictionary *)buildCellDict:(Class)cls {
    return [NSMutableDictionary dictionaryWithObject:NSStringFromClass(cls) forKey:[self dictKeyOfClassName]];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)updateCellWithDict:(NSMutableDictionary *)dict {
}

@end
