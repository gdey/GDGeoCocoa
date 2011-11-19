//
//  GDFirstViewController.m
//  GeoCocoaExample
//
//  Created by Gautam Dey on 10/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GDFirstViewController.h"
#import <math.h>

@implementation GDFirstViewController {
    
}


@synthesize latitudeTextField;
@synthesize longitudeTextField;
@synthesize conversionSelectorSegementedControl;
@synthesize mgrsScaleVaue;
@synthesize mgrsScaleSlider;
@synthesize currentMeterLabel;
@synthesize mgrsTextField;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setLatitudeTextField:nil];
    [self setLongitudeTextField:nil];
    [self setConversionSelectorSegementedControl:nil];
    [self setMgrsScaleVaue:nil];
    [self setMgrsScaleSlider:nil];
    [self setCurrentMeterLabel:nil];
    [self setMgrsTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - helpers

- (void) toggleInputViews {
    
    if ([[self conversionSelectorSegementedControl] selectedSegmentIndex] == 0) {
        [[self mgrsTextField] setEnabled:NO];
        [[self latitudeTextField] setEnabled:YES];
        [[self longitudeTextField] setEnabled:YES];
    } else {
        [[self mgrsTextField] setEnabled:YES];
        [[self latitudeTextField] setEnabled:NO];
        [[self longitudeTextField] setEnabled:NO];        
    }
    
}

#pragma mark - IB Actions


- (IBAction)getCurrentLocationButtonPressed:(id)sender {
}

- (IBAction)mgrsScaleSliderDidChange:(id)sender {
    
    UISlider *slider = (UISlider *)sender;
    [[self currentMeterLabel] setText:[NSString stringWithFormat:@" %u meter(s)", (int)floorf([slider value]) + 1]];
}

- (IBAction)conversionSelectorControlDidChangeValue:(id)sender {
    
    [self toggleInputViews];
    
}

- (IBAction)selectorValueChanged:(id)sender {
}
@end
