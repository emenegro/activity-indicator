MNMActivityIndicator
==========

Implementation of an activity indicator that can be put over a given view.

## Installation

- Add `QuartzCore` framework to your project.
- Copy the entire folder `MNMActivityIndicator` into your project.

## Usage

There are some utility selectors to put an indicator over another view, but the main one to use is

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