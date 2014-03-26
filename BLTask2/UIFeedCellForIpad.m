//
//  UIFeedCellForIpad.m
//  BLTask2
//
//  Created by Kamil Zietek on 18.03.2014.
//  Copyright (c) 2014 Kamil Zietek. All rights reserved.
//

#import "UIFeedCellForIpad.h"

@implementation UIFeedCellForIpad

#pragma mark - Other methods

- (void)updateFonts:(NSNotification*)notification
{
	_labelPosition.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
	[_labelPosition invalidateIntrinsicContentSize];
	
	_labelName.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
	[_labelPosition invalidateIntrinsicContentSize];
	
	_labelPosition2.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
	[_labelPosition2 invalidateIntrinsicContentSize];
	
	_labelName2.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
	[_labelPosition2 invalidateIntrinsicContentSize];
}

#pragma mark - Getters and setters

//- (void)setUrlString:(NSString *)urlString
//{
//	if (urlString == nil) {
//		_viewImage.image = nil;
//		_viewImage.alpha = 0;
//		_urlString = nil;
//		return;
//	}
//	
//	_linkCount++;
//	_viewImage.image = nil;
//	_viewImage.alpha = 0;
//	_urlString = [urlString retain];
//	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//		UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_urlString]options:NSDataReadingMappedIfSafe error:nil]];
//		_linkCount--;
//		if (_linkCount == 0) {
//			dispatch_async(dispatch_get_main_queue(), ^{
//				_viewImage.image = img;
////				[UIView animateWithDuration:0.3f animations:^{
//					_viewImage.alpha = 1;
////				}];
//			});
//		}
//	});
//}

//- (void)setUrlString2:(NSString *)urlString
//{
//	if (urlString == nil) {
//		_viewImage2.image = nil;
//		_viewImage2.alpha = 0;
//		_urlString2 = nil;
//		return;
//	}
//	
//	_linkCount2++;
//	_viewImage2.image = nil;
//	_viewImage2.alpha = 0;
//	_urlString2 = [urlString retain];
//	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//		UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_urlString2]options:NSDataReadingMappedIfSafe error:nil]];
//		_linkCount2--;
//		if (_linkCount2 == 0) {
//			dispatch_async(dispatch_get_main_queue(), ^{
//				_viewImage2.image = img;
////				[UIView animateWithDuration:0.3f animations:^{
//					_viewImage2.alpha = 1;
////				}];
//			});
//		}
//	});
//}

#pragma mark - Inherited methods

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		
		/*
		 both sides
		 */
		
		UIView *viewLeft = [[UIView alloc] init];
		UIView *viewRight = [[UIView alloc] init];
		viewLeft.translatesAutoresizingMaskIntoConstraints = NO;
		viewRight.translatesAutoresizingMaskIntoConstraints = NO;
		
		[self addSubview:viewLeft];
		[self addSubview:viewRight];
		
		NSDictionary *dict0 = NSDictionaryOfVariableBindings(viewLeft,viewRight);
		[self addConstraint:[NSLayoutConstraint constraintWithItem:viewLeft attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.5 constant:0]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:viewRight attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.5 constant:0]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[viewLeft][viewRight]|" options:NSLayoutFormatAlignAllCenterY metrics:0 views:dict0]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:viewRight attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:viewLeft attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];

		/*
		 left side
		 */
		
		_linkCount = 0;
        
		_labelPosition = [[UILabel alloc] init];
		_labelPosition.translatesAutoresizingMaskIntoConstraints = NO;
		_labelPosition.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
		_labelPosition.backgroundColor = [UIColor whiteColor];
		[_labelPosition setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
		[viewLeft addSubview:_labelPosition];
		
		_labelName = [[UILabel alloc] init];
		_labelName.translatesAutoresizingMaskIntoConstraints = NO;
		_labelName.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
		_labelName.backgroundColor = [UIColor whiteColor];
		_labelName.numberOfLines = 3;
		_labelName.lineBreakMode = NSLineBreakByTruncatingTail;
		[viewLeft addSubview:_labelName];
		
		_viewImage = [[UIImageView alloc] init];
		_viewImage.translatesAutoresizingMaskIntoConstraints = NO;
		[viewLeft addSubview:_viewImage];
		
		
		NSDictionary *dict = NSDictionaryOfVariableBindings(_labelPosition,_labelName, _viewImage);
		[viewLeft addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_labelPosition]-[_viewImage(50)]-[_labelName]-|" options:NSLayoutFormatAlignAllCenterY metrics:0 views:dict]];
		[viewLeft addConstraint:[NSLayoutConstraint constraintWithItem:_viewImage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:viewLeft attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
		[viewLeft addConstraint:[NSLayoutConstraint constraintWithItem:_viewImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_viewImage attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
		[viewLeft addConstraint:[NSLayoutConstraint constraintWithItem:_labelName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:viewLeft attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
		[viewLeft addConstraint:[NSLayoutConstraint constraintWithItem:_labelName attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:viewLeft attribute:NSLayoutAttributeRight multiplier:1 constant:-10]];
		[viewLeft release];
		
		/*
		 right side
		 */
		
		_linkCount2 = 0;
        
		_labelPosition2 = [[UILabel alloc] init];
		_labelPosition2.translatesAutoresizingMaskIntoConstraints = NO;
		_labelPosition2.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
		_labelPosition2.backgroundColor = [UIColor whiteColor];
		[_labelPosition2 setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
		[viewRight addSubview:_labelPosition2];
		
		_labelName2 = [[UILabel alloc] init];
		_labelName2.translatesAutoresizingMaskIntoConstraints = NO;
		_labelName2.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
		_labelName2.backgroundColor = [UIColor whiteColor];
		_labelName2.numberOfLines = 3;
		_labelName2.lineBreakMode = NSLineBreakByTruncatingTail;
		[viewRight addSubview:_labelName2];
		
		_viewImage2 = [[UIImageView alloc] init];
		_viewImage2.translatesAutoresizingMaskIntoConstraints = NO;
		[viewRight addSubview:_viewImage2];
		
		
		NSDictionary *dict2 = NSDictionaryOfVariableBindings(_labelPosition2,_labelName2, _viewImage2);
		[viewRight addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_labelPosition2]-[_viewImage2(50)]-[_labelName2(>=20)]-|" options:NSLayoutFormatAlignAllCenterY metrics:0 views:dict2]];
		[viewRight addConstraint:[NSLayoutConstraint constraintWithItem:_viewImage2 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:viewRight attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
		[viewRight addConstraint:[NSLayoutConstraint constraintWithItem:_viewImage2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_viewImage2 attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
		[viewRight addConstraint:[NSLayoutConstraint constraintWithItem:_labelName2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:viewRight attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
		[viewRight addConstraint:[NSLayoutConstraint constraintWithItem:_labelName2 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:viewRight attribute:NSLayoutAttributeRight multiplier:1 constant:-10]];
		[viewRight release];
		
		/*
		 other things
		 */
		
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
	
	[_labelPosition2 release];
	[_labelName2 release];
	[_viewImage2 release];
	[_urlString2 release];
}

@end
