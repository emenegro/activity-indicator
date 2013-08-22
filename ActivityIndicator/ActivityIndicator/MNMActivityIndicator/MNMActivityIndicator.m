/*
 * Copyright (c) 20/08/2013 Mario Negro (@emenegro)
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "MNMActivityIndicator.h" 
#import <QuartzCore/QuartzCore.h>

static CGFloat const kMNMActivityIndicatorFadeDuration = 0.3f;
static CGFloat const kMNMActivityIndicatorRotationDuration = 1.0f;

@interface MNMActivityIndicator()

/**
 * Returns the indicagor view for the given view.
 * 
 * @param view The view to search in.
 * @return The indicator view, or nil if no indicator.
 */
+ (UIView *)indicatorForView:(UIView *)view;

@end

@implementation MNMActivityIndicator

+ (void)putOverView:(UIView *)view
   allowInteraction:(BOOL)allowInteraction
    indicatorInsets:(UIEdgeInsets)indicatorInsets {
 
    if (view) {
                
        [MNMActivityIndicator removeFromView:view];
        
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectZero];
        [containerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin];
        [containerView setBackgroundColor:[UIColor clearColor]];
        [containerView setTag:[view hash]];
        [containerView setUserInteractionEnabled:!allowInteraction];
        
        if ([view isKindOfClass:[UIScrollView class]]) { // This avoids problems with autolayout because of the auto content size of the scrolls.
        
            [containerView setFrame:[view frame]];
            [[view superview] addSubview:containerView];
            
        } else {
            
            [containerView setFrame:[view bounds]];
            [view addSubview:containerView];
        }
        
        UIImageView *indicatorView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"indicator"]];
        [indicatorView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [indicatorView setAlpha:0.0f];
        [containerView addSubview:indicatorView];
        [containerView addConstraint:[NSLayoutConstraint constraintWithItem:indicatorView
                                                                  attribute:NSLayoutAttributeCenterX
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:containerView
                                                                  attribute:NSLayoutAttributeCenterX
                                                                 multiplier:1.0f
                                                                   constant:indicatorInsets.left - indicatorInsets.right]];        
        [containerView addConstraint:[NSLayoutConstraint constraintWithItem:indicatorView
                                                                  attribute:NSLayoutAttributeCenterY
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:containerView
                                                                  attribute:NSLayoutAttributeCenterY
                                                                 multiplier:1.0f
                                                                   constant:indicatorInsets.top - indicatorInsets.bottom]];
        
        // Indicator animation (rotating 360º clockwise).
        
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        [rotationAnimation setFromValue:@0];
        [rotationAnimation setToValue:@((360 * M_PI) / 180)];
        [rotationAnimation setDuration:kMNMActivityIndicatorRotationDuration];
        [rotationAnimation setRepeatCount:HUGE_VALF];
        [[indicatorView layer] addAnimation:rotationAnimation forKey:@"rotation"];
        
        [UIView animateWithDuration:kMNMActivityIndicatorFadeDuration animations:^{
            
            [indicatorView setAlpha:1.0f];
        }];
    }
}

+ (void)putOverView:(UIView *)view {
    
    [MNMActivityIndicator putOverView:view
                      allowInteraction:NO
                       indicatorInsets:UIEdgeInsetsZero];
}

+ (void)removeFromView:(UIView *)view {
    
    UIView *indicatorView = [self indicatorForView:view];
    
    [UIView animateWithDuration:kMNMActivityIndicatorFadeDuration animations:^{
        
        [indicatorView setAlpha:0.0f];
        
    } completion:^(BOOL finished) {
        
        [indicatorView removeFromSuperview];
    }];
}

+ (BOOL)hasActivityIndicator:(UIView *)view {
    
    return [MNMActivityIndicator indicatorForView:view] != nil;
}

+ (void)showGlobalActivityIndicator {

    [MNMActivityIndicator putOverView:[[UIApplication sharedApplication] keyWindow]];
}

+ (void)hideGlobalActivityIndicator {
    
    [MNMActivityIndicator removeFromView:[[UIApplication sharedApplication] keyWindow]];
}

#pragma mark - Utils

+ (UIView *)indicatorForView:(UIView *)view {
    
    UIView *indicatorView = nil;
    
    if ([view isKindOfClass:[UIScrollView class]]) {
        
        indicatorView = [[view superview] viewWithTag:[view hash]];
        
    } else {
        
        indicatorView = [view viewWithTag:[view hash]];
    }
    
    return indicatorView;
}

@end
