//
//  GDFirstViewController.h
//  GeoCocoaExample
//
//  Created by Gautam Dey on 10/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDFirstViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *latitudeTextField;
@property (weak, nonatomic) IBOutlet UITextField *longitudeTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *conversionSelectorSegementedControl;
@property (weak, nonatomic) IBOutlet UILabel *mgrsScaleVaue;
@property (weak, nonatomic) IBOutlet UISlider *mgrsScaleSlider;
@property (weak, nonatomic) IBOutlet UILabel *currentMeterLabel;
@property (weak, nonatomic) IBOutlet UITextField *mgrsTextField;

- (IBAction)getCurrentLocationButtonPressed:(id)sender;
- (IBAction)mgrsScaleSliderDidChange:(id)sender;
- (IBAction)conversionSelectorControlDidChangeValue:(id)sender;


@end
