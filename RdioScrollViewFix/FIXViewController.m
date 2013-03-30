//
//  FIXViewController.m
//  RdioScrollViewFix
//
//  Created by Matt on 3/29/13.
//  Copyright (c) 2013 Matt Zanchelli. All rights reserved.
//

#import "FIXViewController.h"

@interface FIXViewController ()

@property CGRect scrollViewBaseRect;
@property BOOL isFirstLoad;

@end

@implementation FIXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	_isFirstLoad = YES;
	
	[_scrollView setDelegate:self];
	
	[_scrollView setBackgroundColor:[UIColor whiteColor]];
	
	[_scrollView setContentSize:CGSizeMake(320, 746)];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ScrollViewExample"]];
	[_scrollView addSubview:imageView];
}

- (void)viewDidLayoutSubviews
{
	// This gets the size of the scroll view at it's original size (first load)
	if ( _isFirstLoad ) {
		_scrollViewBaseRect = _scrollView.frame;
		_isFirstLoad = NO;
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	// The vertical offset of the scroll view
	CGFloat offset = _scrollView.contentOffset.y;
	
	// This can be changed to be the height(s) of some other view(s)
	CGFloat navigationBarHeight = 40;
	CGFloat maxHeight = self.view.frame.size.height - navigationBarHeight;
	
	// Figure out if the frame of the scrollview should change
	BOOL shouldShift = YES;
	if ( _scrollView.frame.origin.y == navigationBarHeight ) {
		shouldShift = ( offset < 0 );
	} else if ( _scrollView.frame.origin.y == _scrollViewBaseRect.origin.y ) {
		shouldShift = ( offset > 0 );
	}
	
	// If it should shift, shift it and keep contentOffset at 0
	if ( shouldShift ) {
		CGRect newFrame = CGRectMake(0,
									 MIN(MAX(_scrollView.frame.origin.y - offset, navigationBarHeight), _scrollViewBaseRect.origin.y),
									 320,
									 MAX(MIN(_scrollView.frame.size.height + offset, maxHeight), _scrollViewBaseRect.size.height));
		
		[_scrollView setFrame:newFrame];
		[_scrollView setContentOffset:(CGPoint){0,0}];
	}
}

@end
