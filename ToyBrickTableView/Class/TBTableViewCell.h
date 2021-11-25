//
//  TBTableViewCell.h
//  ToyBrickTableView
//
//  Created by mac on 2021/5/6.
//

#import <UIKit/UIKit.h>
#import "NSMutableDictionary+TBSafe.h"
#import "NSArray+TBSafe.h"
#import "NSMutableDictionary+TableViewCellAction.h"
#import <MGSwipeTableCell.h>

@interface TBTableViewCell : MGSwipeTableCell

+ (NSString *)reuseIdentifier;
+ (CGFloat)cellRowHeight;
+ (CGFloat)cellRowHeightForDict:(NSMutableDictionary *)dict;
+ (CGFloat)cellRowEstimatedHeight;
+ (CGFloat)cellRowEstimatedHeightForDict:(NSMutableDictionary *)dict;

+ (Class)tableViewCellClassOfDict:(NSMutableDictionary *)dict;
+ (NSMutableDictionary *)buildCellDict:(Class)class;

- (void)updateCellWithDict:(NSMutableDictionary *)dict;

@end
