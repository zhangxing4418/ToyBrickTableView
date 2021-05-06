//
//  NSMutableDictionary+TBSafe.h
//  ToyBrickTableView
//
//  Created by mac on 2021/5/6.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (TBSafe)

- (void)tb_setObj:(id)i forKey:(NSString *)key;
- (void)tb_setFloat:(float)i forKey:(NSString *)key;

- (NSString *)tb_stringForKey:(id)key;
- (float)tb_floatForKey:(id)key;

@end
