//
//  SelectViewController.m
//  diplom
//
//  Created by Mac on 25.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SelectViewController.h"

@implementation SelectViewController
@synthesize instrumentSelect;
@synthesize bottomBar;
@synthesize back;
@synthesize exchangeId, instrumentCode;

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
    micex=[MICEX_Loader getEmitentCodes];
    rts=[RTS_Loader getEmitentCodes];
    
    instrumentCombo = [[ComboBox alloc] init];
    [self.view addSubview:instrumentCombo.view];
    instrumentCombo.view.frame = CGRectMake(82, 245, 156, 31);
    [instrumentCombo setComboData:micex:[Settings getInstrumentCode]];
	// Do any additional setup after loading the view, typically from a nib.
    instrumentCode=[micex objectAtIndex:0];
    exchangeId=0;
}

- (void)viewDidUnload
{
    [self setBack:nil];
    [self setBottomBar:nil];
    [self setInstrumentSelect:nil];
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
    if([[segue identifier] isEqualToString:@"toTable"]){
        NSLog(@"Go to table");
        TableViewController* table=(TableViewController*)[segue destinationViewController];
        [table addRow:exchangeId:[instrumentCombo selectedText]];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)exchangeSelected:(id)sender {
    UISegmentedControl* exch=(UISegmentedControl*)sender;
    exchangeId=[exch selectedSegmentIndex];
    if([exch selectedSegmentIndex]==0)
        [instrumentCombo setComboData:micex:[micex objectAtIndex:0]];
    else [instrumentCombo setComboData:rts:[rts objectAtIndex:0]];
}
@end
