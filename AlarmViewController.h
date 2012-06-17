//
//  AlarmViewController.h
//  diplom
//
//  Created by Mac on 26.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"
#import "AlertsListViewController.h"

@interface AlarmViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *back;
@property (weak, nonatomic) IBOutlet UIView *bottomBar;
@property (weak, nonatomic) IBOutlet UIView *topBar;
@property (weak, nonatomic) IBOutlet UIImageView *direction;
@property (weak, nonatomic) IBOutlet UILabel *curValue;
@property (weak, nonatomic) IBOutlet UIImageView *exchangeImage;
@property (weak, nonatomic) IBOutlet UILabel *exchangeName;
@property (weak, nonatomic) IBOutlet UILabel *instrumentName;
@property (weak, nonatomic) IBOutlet UILabel *changeValue;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)stepperChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;

@end
