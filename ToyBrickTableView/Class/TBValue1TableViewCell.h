//
//  TBValue1TableViewCell.h
//  ToyBrickTableView
//
//  Created by mac on 2021/5/6.
//

#import "TBTableViewCell.h"

@interface TBValue1TableViewCellConfig : NSObject

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) UIView *accessoryView;
@property (nonatomic, strong) UIColor *backgroundColor;

@end

@interface TBValue1TableViewCell : TBTableViewCell

+ (NSString *)reuseIdentifier;
+ (CGFloat)cellRowHeightForDict:(NSMutableDictionary *)dict;
+ (NSMutableDictionary *)buildCellDictWithConfigBlock:(TBValue1TableViewCellConfig *(^)(UIImageView *imageView, UILabel *titleLabel, UILabel *subTitleLabel, TBValue1TableViewCellConfig *config))configBlock;
- (void)updateCellWithDict:(NSMutableDictionary *)dict;

@end
