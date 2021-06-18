//
//  NSMutableDictionary+TBSafe.m
//  ToyBrickTableView
//
//  Created by mac on 2021/5/6.
//

#import "NSMutableDictionary+TBSafe.h"

@implementation NSDictionary (TBSafe)

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

- (NSArray *)tb_arrayForKey:(id)key {
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}

- (NSDictionary *)tb_dictionaryForKey:(id)key {
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

- (BOOL)tb_boolForKey:(id)key {
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value boolValue];
    }
    return NO;
}

- (NSInteger)tb_integerForKey:(id)key {
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return 0;
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

@implementation NSMutableDictionary (TBSafe)

- (void)tb_setObj:(id)i forKey:(NSString *)key {
    if (i != nil) {
        self[key] = i;
    }
}

- (void)tb_setString:(NSString *)i forKey:(NSString *)key {
    [self setValue:i forKey:key];
}

- (void)tb_setBool:(BOOL)i forKey:(NSString *)key {
    self[key] = @(i);
}

- (void)tb_setInteger:(NSInteger)i forKey:(NSString *)key {
    self[key] = @(i);
}

- (void)tb_setFloat:(float)i forKey:(NSString *)key {
    self[key] = @(i);
}

@end
