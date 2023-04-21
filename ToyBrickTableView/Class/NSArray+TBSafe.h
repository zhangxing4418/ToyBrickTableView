//
//  NSArray+TBSafe.h
//  ToyBrickTableView
//
//  Created by mac on 2021/5/6.
//

#import <Foundation/Foundation.h>

@interface NSArray (TBSafe)

- (id)tb_objectWithIndex:(NSUInteger)index;

@end

@interface NSMutableArray (TBCellDataSource)

- (NSInteger)tb_addCellDataSource:(NSMutableDictionary *)dict;

@end
