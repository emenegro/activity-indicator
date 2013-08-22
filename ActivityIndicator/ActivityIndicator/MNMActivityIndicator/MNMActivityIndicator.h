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

#import <Foundation/Foundation.h>

/**
 * Activity indicator to be put over arbitrary views.
 */
@interface MNMActivityIndicator : UIView

/**
 * Put an activity indicator in the center of the given view, applying the given insets.
 *
 * @param view The view in which the indicator will be put over.
 * @param allowInteraction YES to allow interaction while the indicator is visible.
 * @param indicatorInsets The insets to apply to the indicator from the center of its container.
 */
+ (void)putOverView:(UIView *)view
   allowInteraction:(BOOL)allowInteraction
    indicatorInsets:(UIEdgeInsets)indicatorInsets;

/**
 * Put an activity indicator in the center of the given view disabling interaction.
 *
 * @param view The view in which the indicator will be shown.
 */
+ (void)putOverView:(UIView *)view;

/**
 * Removes the indicator from the given view.
 *
 * @param view The view in which the indicator is being shown.
 */
+ (void)removeFromView:(UIView *)view;

/**
 * Checks if the given view has an activity indicator over it.
 * 
 * @param view The view to check.
 * @return The result of the checking.
 */
+ (BOOL)hasActivityIndicator:(UIView *)view;

/**
 * Shows an activity indicator in the app window.
 */
+ (void)showGlobalActivityIndicator;

/**
 * Removes the activity indicator from the app window.
 */
+ (void)hideGlobalActivityIndicator;

@end
