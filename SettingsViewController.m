//
//  SettingsViewController.m
//  diplom
//
//  Created by Mac on 25.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"

@implementation SettingsViewController
@synthesize bottomBar;
@synthesize back;
@synthesize exchangeSelect;
@synthesize chartModeSelect;
@synthesize periodSelect;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad{
    [super viewDidLoad];
    self.back.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.bottomBar.backgroundColor=[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bottombar.png"]];
    NSMutableArray* instrumentsArray = [[NSMutableArray alloc] init];
    [instrumentsArray addObject:@"GAZP"];
    [instrumentsArray addObject:@"MSNG"];
    [instrumentsArray addObject:@"SCOH"];
    [instrumentsArray addObject:@"ARMD"];
    
    instrumentCombo = [[ComboBox alloc] init];
    [instrumentCombo setComboData:instrumentsArray];
    [instrumentCombo setSelectedText:[instrumentsArray objectAtIndex:0]];
    [self.view addSubview:instrumentCombo.view];
    instrumentCombo.view.frame = CGRectMake(90, 110, 149, 31);
    
    NSMutableArray* analyseArray = [[NSMutableArray alloc] init];
    [analyseArray addObject:@"RSI"];
    [analyseArray addObject:@"Stochastic"];
    analyseCombo = [[ComboBox alloc] init];    
    [analyseCombo setComboData:analyseArray];
    [analyseCombo setSelectedText:[analyseArray objectAtIndex:0]];
    [self.view addSubview:analyseCombo.view];
    analyseCombo.view.frame = CGRectMake(89, 356, 149, 31);
    
    [self loadSettings];
}
-(void)loadSettings{
    self.exchangeSelect.selectedSegmentIndex=([Settings getExchangeId]==[Instrument getMICEX])?0:1;
    int mode=0;
    if([Settings getChartMode]==CANDLES)
        mode=1;
    else if([Settings getChartMode]==BARS)
        mode=2;
    self.chartModeSelect.selectedSegmentIndex=mode;
    self.periodSelect.selectedSegmentIndex=([Settings getBidType]==Hour_Bid)?0:1;
}
-(void)saveSettings{
    if(self.exchangeSelect.selectedSegmentIndex==0)
        [Settings setExchangeId:[Instrument getMICEX]];
    else [Settings setExchangeId:[Instrument getRTS]];
    switch (self.chartModeSelect.selectedSegmentIndex) {
        case 0:
            [Settings setChartMode:CURVES];
            break;
        case 1:
            [Settings setChartMode:CANDLES];
            break;
        case 2:
            [Settings setChartMode:BARS];
            break;
        default:
            break;
    }
    if(self.periodSelect.selectedSegmentIndex==0)
        [Settings setBidType:Hour_Bid];
    else [Settings setBidType:Day_Bid];
    [Settings saveSettings];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"fromSettingsWithSave"])
        [self saveSettings];
}
- (void)viewDidUnload{
    [self setBack:nil];
    [self setBottomBar:nil];
    [self setExchangeSelect:nil];
    [self setChartModeSelect:nil];
    [self setPeriodSelect:nil];
    [super viewDidUnload];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated{
	[super viewDidDisappear:animated];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
@end
