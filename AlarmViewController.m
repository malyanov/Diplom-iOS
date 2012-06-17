//
//  AlarmViewController.m
//  diplom
//
//  Created by Mac on 26.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AlarmViewController.h"

@implementation AlarmViewController
@synthesize slider;
@synthesize stepper;
@synthesize back;
@synthesize bottomBar;
@synthesize topBar;
@synthesize direction;
@synthesize curValue;
@synthesize exchangeImage;
@synthesize exchangeName;
@synthesize instrumentName;
@synthesize changeValue;
@synthesize valueField;

double startValue;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.back.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.bottomBar.backgroundColor=[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bottombar.png"]];
    self.topBar.backgroundColor=[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"topbar.png"]];
    valueField.text=[NSString stringWithFormat:@"%.3f", 0.1];
    startValue=0.1;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setBack:nil];
    [self setBottomBar:nil];
    [self setTopBar:nil];
    [self setDirection:nil];
    [self setCurValue:nil];
    [self setExchangeImage:nil];
    [self setExchangeName:nil];
    [self setInstrumentName:nil];
    [self setChangeValue:nil];
    [self setValueField:nil];
    [self setSlider:nil];
    [self setStepper:nil];
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
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"toAlertsList"]){
        AlertsListViewController *alertsList=(AlertsListViewController*)[segue destinationViewController];
        double value=[valueField.text doubleValue];
        [alertsList addAlert:value:[Settings getInstrumentCode]];
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)sliderValueChanged:(id)sender {
    double val=round(slider.value);
    stepper.value=val;
    valueField.text=[NSString stringWithFormat:@"%.3f", startValue+val*(startValue/100.0)];
}

- (IBAction)stepperChanged:(id)sender {
    double val=stepper.value;    
    slider.value=val;
    valueField.text=[NSString stringWithFormat:@"%.3f", startValue+val*(startValue/100.0)];
}
@end