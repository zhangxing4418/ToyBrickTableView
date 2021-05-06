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
