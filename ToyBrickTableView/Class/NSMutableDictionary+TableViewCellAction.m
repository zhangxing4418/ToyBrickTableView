//
//  NSMutableDictionary+TableViewCellAction.m
//  ToyBrickTableView
//
//  Created by mac on 2021/5/6.
//

#import "NSMutableDictionary+TableViewCellAction.h"

@interface Action : NSObject

@property (nonatomic, copy) void (^actionBlock)(void);
@property (nonatomic, copy) void (^actionIndexBlock)(NSInteger index);

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

- (NSMutableDictionary *)addIndexAction:(void (^) (NSInteger index))actionIndexBlock {
    Action *action = [[Action alloc] init];
    action.actionIndexBlock = actionIndexBlock;
    [self setObject:action forKey:@"actionIndexBlock"];
    return self;
}

- (void)executeAction {
    Action *action = [self objectForKey:@"actionBlock"];
    Action *indexAction = [self objectForKey:@"actionIndexBlock"];
    if ([action isKindOfClass:[Action class]] && action.actionBlock) {
        action.actionBlock();
    }
    if ([indexAction isKindOfClass:[Action class]] && indexAction.actionIndexBlock) {
        indexAction.actionIndexBlock([[self objectForKey:@"index"] integerValue]);
    }
}

@end
