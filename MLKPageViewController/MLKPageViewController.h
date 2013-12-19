//
//  MLKPageViewController.h
//  MLKPageViewController
//
//  Created by NagaMalleswar on 19/12/13.
//  Copyright (c) 2013 NagaMalleswar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLKPageViewController : UIViewController
{
    IBOutlet UIScrollView *contentScrollView;
    IBOutlet UIPageControl *mlkPageControl;
}

- (id)initWithContentViewControllers:(NSArray *)contentVCs;

@end
