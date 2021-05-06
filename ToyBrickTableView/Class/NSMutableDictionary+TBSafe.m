//
//  NSMutableDictionary+TBSafe.m
//  ToyBrickTableView
//
//  Created by mac on 2021/5/6.
//

#import "NSMutableDictionary+TBSafe.h"

@implementation NSMutableDictionary (TBSafe)

- (void)tb_setObj:(id)i forKey:(NSString *)key {
    if (i != nil) {
        self[key] = i;
    }
}

- (void)tb_setFloat:(float)i forKey:(NSString *)key {
    self[key] = @(i);
}

- (NSString *)tb_stringForKey:(id)key {
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString *)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    return nil;
}

- (float)tb_floatForKey:(id)key {
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value floatValue];
    }
    return 0;
}

@end
