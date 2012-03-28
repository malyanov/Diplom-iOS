//
//  SettingsViewController.h
//  diplom
//
//  Created by Mac on 25.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"
#import "Instrument.h"
#import "Quotation.h"
#import "ComboBox.h"
#import "MICEX_Loader.h"
#import "RTS_Loader.h"

@interface SettingsViewController : UIViewController
{
    ComboBox *instrumentCombo, *analyseCombo;
    NSMutableArray *rts, *micex;
}
@property (weak, nonatomic) IBOutlet UIView *bottomBar;
@property (weak, nonatomic) IBOutlet UIView *back;
@property (weak, nonatomic) IBOutlet UISegmentedControl *exchangeSelect;
@property (weak, nonatomic) IBOutlet UISegmentedControl *chartModeSelect;
@property (weak, nonatomic) IBOutlet UISegmentedControl *periodSelect;
- (IBAction)exchangeSelectionChanged:(id)sender;
-(void)loadSettings;
-(void)saveSettings;
@end
