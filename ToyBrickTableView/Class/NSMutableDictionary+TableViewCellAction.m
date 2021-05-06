//
//  NSMutableDictionary+TableViewCellAction.m
//  ToyBrickTableView
//
//  Created by mac on 2021/5/6.
//

#import "NSMutableDictionary+TableViewCellAction.h"

@interface Action : NSObject

@property (nonatomic, copy) void (^actionBlock)(void);

@end

@implementation Action
@end

@implementation NSMutableDictionary (TableViewCellAction)

- (NSMutableDictionary *)addAction:(void (^) (void))actionBlock {
    Action *action = [[Action alloc] init];
    action.actionBlock = actionBlock;
    [self setObject:action forKey:@"actionBlock"];
    return self;
}

- (void)executeAction {
    Action *action = [self objectForKey:@"actionBlock"];
    if ([action isKindOfClass:[Action class]] && action.actionBlock) {
        action.actionBlock();
    }
}

@end
