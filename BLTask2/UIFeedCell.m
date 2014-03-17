//
//  UIFeedCell.m
//  BLTask2
//
//  Created by Kamil Zietek on 17.03.2014.
//  Copyright (c) 2014 Kamil Zietek. All rights reserved.
//

#import "UIFeedCell.h"

@implementation UIFeedCell

- (void)setUrlString:(NSString *)urlString
{
	_viewImage.image = nil;
	_viewImage.alpha = 0;
	_urlString = [urlString retain];
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_urlString]]];
		dispatch_async(dispatch_get_main_queue(), ^{
			_viewImage.image = img;
			[UIView animateWithDuration:0.3f animations:^{
				_viewImage.alpha = 1;
			}];
		});
	});
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _labelPosition = [[UILabel alloc] init];
		_labelPosition.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:_labelPosition];
		
		_labelName = [[UILabel alloc] init];
		_labelName.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:_labelName];
		
		_viewImage = [[UIImageView alloc] init];
		_viewImage.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:_viewImage];
		
		
		NSDictionary *dict = NSDictionaryOfVariableBindings(_labelPosition,_labelName, _viewImage);
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_labelPosition]-[_viewImage(53)]-[_labelName]" options:NSLayoutFormatAlignAllCenterY metrics:0 views:dict]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:_viewImage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:_viewImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_viewImage attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
	[super dealloc];
	
	[_labelPosition release];
	[_labelName release];
	[_viewImage release];
	[_urlString release];
}

@end
