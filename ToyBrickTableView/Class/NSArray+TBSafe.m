//
//  NSArray+TBSafe.m
//  ToyBrickTableView
//
//  Created by mac on 2021/5/6.
//

#import "NSArray+TBSafe.h"

@implementation NSArray (TBSafe)

- (id)tb_objectWithIndex:(NSUInteger)index {
    if (index < self.count) {
        return self[index];
    }else {
        return nil;
    }
}

@end

@implementation NSMutableArray (TBCellDataSource)

- (NSInteger)tb_addCellDataSource:(NSMutableDictionary *)dict {
    if (dict != nil) {
        [self addObject:dict];
        [dict setObject:@(self.count - 1) forKey:@"index"];
        return self.count - 1;
    }
    return -1;
}

@end
