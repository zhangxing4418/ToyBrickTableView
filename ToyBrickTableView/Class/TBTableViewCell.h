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

@interface TBTableViewCell : UITableViewCell

+ (NSString *)reuseIdentifier;
+ (CGFloat)cellRowHeight;
+ (CGFloat)cellRowHeightForDict:(NSMutableDictionary *)dict;
+ (CGFloat)cellRowHeightForDict:(NSMutableDictionary *)dict index:(NSInteger)index;
+ (CGFloat)cellRowEstimatedHeight;
+ (CGFloat)cellRowEstimatedHeightForDict:(NSMutableDictionary *)dict;
+ (CGFloat)cellRowEstimatedHeightForDict:(NSMutableDictionary *)dict index:(NSInteger)index;

+ (Class)tableViewCellClassOfDict:(NSMutableDictionary *)dict;
+ (NSMutableDictionary *)buildCellDict:(Class)class;

- (void)updateCellWithDict:(NSMutableDictionary *)dict;
- (void)updateCellWithDict:(NSMutableDictionary *)dict index:(NSInteger)index;

@end
