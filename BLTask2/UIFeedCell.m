//
//  UIFeedCell.m
//  BLTask2
//
//  Created by Kamil Zietek on 17.03.2014.
//  Copyright (c) 2014 Kamil Zietek. All rights reserved.
//

#import "UIFeedCell.h"



@implementation UIFeedCell

#pragma mark - Other methods

- (void)updateFonts:(NSNotification*)notification
{	
	_labelPosition.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
	[_labelPosition invalidateIntrinsicContentSize];
	
	_labelName.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
	[_labelPosition invalidateIntrinsicContentSize];
}

#pragma mark - Getters and setters

- (void)setUrlString:(NSString *)urlString
{
	_linkCount++;
	_viewImage.image = nil;
	_viewImage.alpha = 0;
	_urlString = [urlString retain];
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_urlString]options:NSDataReadingMappedIfSafe error:nil]];
		_linkCount--;
		if (_linkCount == 0) {
			dispatch_async(dispatch_get_main_queue(), ^{
				_viewImage.image = img;
				[UIView animateWithDuration:0.3f animations:^{
					_viewImage.alpha = 1;
				}];
			});
		}
	});
}

#pragma mark - Inherited methods

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		_linkCount = 0;
		
        _labelPosition = [[UILabel alloc] init];
		_labelPosition.translatesAutoresizingMaskIntoConstraints = NO;
		_labelPosition.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
		[self addSubview:_labelPosition];
		
		_labelName = [[UILabel alloc] init];
		_labelName.translatesAutoresizingMaskIntoConstraints = NO;
		_labelName.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
		_labelName.numberOfLines = 3;
		_labelName.lineBreakMode = NSLineBreakByTruncatingTail;
		[self addSubview:_labelName];
		
		_viewImage = [[UIImageView alloc] init];
		_viewImage.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:_viewImage];
		
		
		NSDictionary *dict = NSDictionaryOfVariableBindings(_labelPosition,_labelName, _viewImage);
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_labelPosition]-[_viewImage(53)]-[_labelName(>=20)]-|" options:NSLayoutFormatAlignAllCenterY metrics:0 views:dict]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:_viewImage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:_viewImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_viewImage attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:_labelName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:_labelName attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-10]];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateFonts:) name:UIContentSizeCategoryDidChangeNotification object:nil];
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
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	[_labelPosition release];
	[_labelName release];
	[_viewImage release];
	[_urlString release];
}

@end
