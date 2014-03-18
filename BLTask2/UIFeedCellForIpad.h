//
//  UIFeedCellForIpad.h
//  BLTask2
//
//  Created by Kamil Zietek on 18.03.2014.
//  Copyright (c) 2014 Kamil Zietek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFeedCellForIpad : UITableViewCell{
	int _linkCount;
	int _linkCount2;
}

@property(retain,nonatomic) UILabel *labelPosition;
@property(retain,nonatomic) UILabel *labelName;
@property(retain,nonatomic) UIImageView *viewImage;
@property(retain,nonatomic) NSString *urlString;

@property(retain,nonatomic) UILabel *labelPosition2;
@property(retain,nonatomic) UILabel *labelName2;
@property(retain,nonatomic) UIImageView *viewImage2;
@property(retain,nonatomic) NSString *urlString2;

@end
