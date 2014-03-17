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
	_urlString = [urlString retain];
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_urlString]]];
		dispatch_async(dispatch_get_main_queue(), ^{
			_viewImage.image = img;
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
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_labelPosition]-[_viewImage(53)]-[_labelName]" options:NSLayoutFormatAlignAllTop metrics:0 views:dict]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_viewImage(53)]-|" options:0 metrics:0 views:dict]];
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
