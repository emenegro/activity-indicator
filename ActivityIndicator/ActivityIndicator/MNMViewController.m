//
//  MNMViewController.m
//  ActivityIndicator
//
//  Created by Mario Negro on 20/08/13.
//  Copyright (c) 2013 Mario Negro. All rights reserved.
//

#import "MNMViewController.h"
#import "MNMActivityIndicator.h"

@interface MNMViewController ()

@property (nonatomic, readwrite, weak) IBOutlet UILabel *label1; // With insets.
@property (nonatomic, readwrite, weak) IBOutlet UILabel *label2; // In the middle.
@property (nonatomic, readwrite, weak) IBOutlet UILabel *label3; // Scroll.
@property (nonatomic, readwrite, weak) IBOutlet UILabel *label4; // Window.
@property (nonatomic, readwrite, weak) IBOutlet UIScrollView *scrollView; // Window.

- (IBAction)viewTapped:(UITapGestureRecognizer*)recognizer;

@end

@implementation MNMViewController

- (IBAction)viewTapped:(UITapGestureRecognizer*)recognizer {
    
    UIView *view = [recognizer view];
    if (view == _label3) {        
        view = _scrollView;
    }
    
    if ([MNMActivityIndicator hasActivityIndicator:view]) {
        
        [MNMActivityIndicator removeFromView:view];
        
    } else {
        
        if (view == _scrollView) {
            
            [MNMActivityIndicator putOverView:view
                             allowInteraction:YES
                              indicatorInsets:UIEdgeInsetsZero];
        
        } else if (view == _label4) {
            
            [MNMActivityIndicator showGlobalActivityIndicator];
            
            double delayInSeconds = 3.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                
                [MNMActivityIndicator hideGlobalActivityIndicator];
            });
            
        } else {
        
            UIEdgeInsets insets = (view == _label1
                                   ? UIEdgeInsetsMake(0.0f, round(CGRectGetWidth([view bounds]) / 3.0f), 0.0f, 0.0f)
                                   : UIEdgeInsetsZero);
            
            [MNMActivityIndicator putOverView:view
                             allowInteraction:NO
                              indicatorInsets:insets];
        }
    }
}

@end
