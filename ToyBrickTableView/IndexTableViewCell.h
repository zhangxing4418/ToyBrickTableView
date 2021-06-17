//
//  IndexTableViewCell.h
//  ToyBrickTableView
//
//  Created by mac on 2021/6/17.
//

#import "TBTableViewCell.h"

@interface IndexTableViewCell : TBTableViewCell

+ (NSString *)reuseIdentifier;
+ (CGFloat)cellRowHeightForDict:(NSMutableDictionary *)dict index:(NSInteger)index;
+ (NSMutableDictionary *)buildCellDict;
- (void)updateCellWithDict:(NSMutableDictionary *)dict index:(NSInteger)index;

@end
