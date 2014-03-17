//
//  UIFeedCell.h
//  BLTask2
//
//  Created by Kamil Zietek on 17.03.2014.
//  Copyright (c) 2014 Kamil Zietek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFeedCell : UITableViewCell

@property(retain,nonatomic) UILabel *labelPosition;
@property(retain,nonatomic) UILabel *labelName;
@property(retain,nonatomic) UIImageView *viewImage;
@property(retain,nonatomic) NSString *urlString;

@end
