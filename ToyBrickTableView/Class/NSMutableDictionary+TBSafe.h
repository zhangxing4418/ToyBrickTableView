//
//  NSMutableDictionary+TBSafe.h
//  ToyBrickTableView
//
//  Created by mac on 2021/5/6.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (TBSafe)

- (NSArray *)tb_arrayForKey:(id)key;
- (NSDictionary *)tb_dictionaryForKey:(id)key;
- (NSString *)tb_stringForKey:(id)key;
- (BOOL)tb_boolForKey:(id)key;
- (NSInteger)tb_integerForKey:(id)key;
- (float)tb_floatForKey:(id)key;

@end

@interface NSMutableDictionary (TBSafe)

- (void)tb_setObj:(id)i forKey:(NSString *)key;
- (void)tb_setString:(NSString *)i forKey:(NSString *)key;
- (void)tb_setBool:(BOOL)i forKey:(NSString *)key;
- (void)tb_setInteger:(NSInteger)i forKey:(NSString *)key;
- (void)tb_setFloat:(float)i forKey:(NSString *)key;

@end
