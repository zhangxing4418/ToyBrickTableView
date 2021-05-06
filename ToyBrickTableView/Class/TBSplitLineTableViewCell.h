//
//  TBSplitLineTableViewCell.h
//  ToyBrickTableView
//
//  Created by mac on 2021/5/6.
//

#import "TBTableViewCell.h"

@interface TBSplitLineTableViewCell : TBTableViewCell

+ (NSString *)reuseIdentifier;
+ (CGFloat)cellRowHeightForDict:(NSMutableDictionary *)dict;
+ (NSMutableDictionary *)buildCellDictWithBackgroundColor:(UIColor *)bgColor height:(CGFloat)height leftEdge:(CGFloat)left rightEdge:(CGFloat)right;

@end
