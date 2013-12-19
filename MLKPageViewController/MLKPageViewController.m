//
//  MLKPageViewController.m
//  MLKPageViewController
//
//  Created by NagaMalleswar on 19/12/13.
//  Copyright (c) 2013 NagaMalleswar. All rights reserved.
//

#import "MLKPageViewController.h"

#define CONTENT_VIEW_HEIGHT     376
#define CONTENT_VIEW_SPACING    10
#define SCROLL_VIEW_PADDING     20

#define FIRST_PAGE              0
#define LAST_PAGE               self.numberOfPages - 1

#define TITLE                   @"MLK Page VC"

@interface MLKPageViewController ()

@property(nonatomic,strong) NSArray *contentVCs;
@property(nonatomic,assign) NSInteger numberOfPages;
@property(nonatomic,assign) BOOL pageControlUsed;

@end

@implementation MLKPageViewController

@synthesize contentVCs;
@synthesize numberOfPages;
@synthesize pageControlUsed;

- (id)initWithContentViewControllers:(NSArray *)aContentVCs
{
    if( self = [super initWithNibName:@"MLKPageView" bundle:nil] )
    {
        self.contentVCs = aContentVCs;
        self.numberOfPages = aContentVCs.count;
    }
    
    return self;
}

#pragma mark -
#pragma mark View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = TITLE;
    
    mlkPageControl.numberOfPages = self.numberOfPages;
    mlkPageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    
    [self setupContentViews];
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if( !pageControlUsed )
    {
        CGFloat pageWidth = contentScrollView.frame.size.width;
        int page = floor((contentScrollView.contentOffset.x - pageWidth / 2 ) / pageWidth) + 1;
        mlkPageControl.currentPage = page;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
    [self changeContentPage:mlkPageControl];
}

#pragma mark -
#pragma mark Methods

- (void)setupContentViews
{
    contentScrollView.contentSize = CGSizeMake(( self.numberOfPages * ([UIScreen mainScreen].bounds.size.width - 2 * SCROLL_VIEW_PADDING) ) + ( self.numberOfPages + 1 ) * CONTENT_VIEW_SPACING, CONTENT_VIEW_HEIGHT) ;
    
    for( int i = 0; i < self.numberOfPages; i++ )
    {
        UIView *contentView = ((UIViewController *)[self.contentVCs objectAtIndex:i]).view;
        contentView.frame = CGRectMake( ((i+1) * CONTENT_VIEW_SPACING) + i * contentView.frame.size.width, SCROLL_VIEW_PADDING, contentView.frame.size.width, contentView.frame.size.height);
        
        [contentScrollView addSubview:contentView];
    }
}

#pragma mark
#pragma mark Actions

- (IBAction)changeContentPage:(id)sender
{
    CGRect pageRect;
    UIView *contentView = ((UIViewController *)[self.contentVCs objectAtIndex:mlkPageControl.currentPage]).view;
    NSInteger currentPage = mlkPageControl.currentPage;
    
    if( mlkPageControl.currentPage == FIRST_PAGE || mlkPageControl.currentPage == LAST_PAGE )
    {
        pageRect = CGRectMake( (currentPage * CONTENT_VIEW_SPACING) + currentPage *  contentView.frame.size.width, contentScrollView.frame.origin.y , contentScrollView.frame.size.width, contentScrollView.frame.size.height);
    }
    else
    {
        pageRect = CGRectMake( (currentPage * CONTENT_VIEW_SPACING) + currentPage *  contentView.frame.size.width - CONTENT_VIEW_SPACING, contentScrollView.frame.origin.y , contentScrollView.frame.size.width, contentScrollView.frame.size.height);
    }
    
    [contentScrollView scrollRectToVisible:pageRect animated:YES];
}

@end
