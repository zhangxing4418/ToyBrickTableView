//
//  NSMutableDictionary+TableViewCellAction.h
//  ToyBrickTableView
//
//  Created by mac on 2021/5/6.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (TableViewCellAction)

- (NSMutableDictionary *)addAction:(void (^) (void))actionBlock;
- (NSMutableDictionary *)addIndexAction:(void (^) (NSInteger index))actionIndexBlock;
- (void)executeAction;

@end
