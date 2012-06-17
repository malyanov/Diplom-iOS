//
//  ViewController.m
//  diplom
//
//  Created by Mac on 23.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "Chart.h"

@implementation MainViewController
@synthesize bottomBar = _bottomBar;
@synthesize topBar = _topBar;
@synthesize mainChartView = _mainChart;
@synthesize analizeChartView;
@synthesize trend;
@synthesize curValue;
@synthesize changeValue;
@synthesize exchangeName;
@synthesize exchangeImg;
@synthesize instrumentName;
@synthesize back=_back;
@synthesize clock=_clock;
@synthesize timer=_timer;

@synthesize chart, analizeGraph, quots, querer, oldChangeValue, parser, curInstrument, progress, updLastQuotHandler;

static const int SETTINGS_ACTIVITY_CODE=1;

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad{
    [super viewDidLoad]; 
    //debug
    [Settings clearSettings];
    //
    if(![Settings loadSettings])//first app start        
        [Settings saveSettings];
    self.back.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    [self.clock setText:[MainViewController getCurrentTimeStr]];
    self.timer=[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timerTask:) userInfo:nil repeats:YES];
    self.clock.backgroundColor=[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"time.png"]];
    self.bottomBar.backgroundColor=[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bottombar.png"]];
    self.topBar.backgroundColor=[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"topbar.png"]];
    self.parser=[FileParser newFileParser];
   
    self.querer=[Querer newQuerer];
    [self setInfo:[Settings getExchangeId]:[Settings getInstrumentCode]];
    [self setChangeValue:0];
    [self loadChartData];
    
    self.analizeGraph=[AnalyseChart newAnalyseChart:CGRectMake(0, 0, 320, 113)];
    self.chart=[Chart newChart:self.analizeGraph:false:CGRectMake(0, 0, 320, 175)];
    [self.mainChartView addSubview:chart];
    [self.analizeChartView addSubview:analizeGraph];
    analizeGraph.mode=[Settings getAnalyseMode];
    __unsafe_unretained MainViewController *vc = self;
    self.updLastQuotHandler=^(Instrument *instr){
        double value=[instr value];
        [vc.chart updateLastValue:value];
        [vc setChange:value];
    };
}

-(void)timerTask:(NSTimer*) theTimer{    
    [self.clock setText:[MainViewController getCurrentTimeStr]];    
}
+(NSString*)getCurrentTimeStr{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setTimeStyle:NSDateFormatterShortStyle];
    [format setTimeZone:[NSTimeZone localTimeZone]];
    NSString *result=[format stringFromDate:[NSDate date]];
    return result;
}
- (void)viewDidUnload{
    [self setBack:nil];
    [self setBottomBar:nil];
    [self setTopBar:nil];
    [self setMainChartView:nil];
    [self setAnalizeChartView:nil];
    [self setTrend:nil];
    [self setCurValue:nil];
    [self setChangeValue:nil];
    [self setExchangeName:nil];
    [self setInstrumentName:nil];
    [self setExchangeImg:nil];
    [querer stopTimer];
    [super viewDidUnload];
}
//------------------------------------Chart Data Functions-----------------------------------------
-(void)loadChartData{
    [self showLoading];
    int monthsNum=1;
    if([Settings getBidType]==Day_Bid)
        monthsNum=3;
    NSDate *start=[NSDate dateWithTimeIntervalSinceNow:-monthsNum*30*3600*24];
    void (^handler)(Quotation*)=^(Quotation *quot){
        quots=[parser readFile];
        [quots addObject:quot];
        [chart init:quots];
        if(curInstrument!=nil)
            [querer removeTask:curInstrument];
        curInstrument=[Instrument newInstrument:[Settings getExchangeId]:[Settings getBoardCode]:[Settings getInstrumentCode]:@"":0];
        [querer addTask:curInstrument:self.updLastQuotHandler];
        [self hideLoading];  
    };       
    if([Settings getExchangeId]==[Instrument getRTS])        
         [RTS_Loader getDataForChart:[Settings getInstrumentCode]:start:[Settings getBidType]:handler]; 
    else if([Settings getExchangeId]==[Instrument getMICEX])    
         [MICEX_Loader getDataForChart:[Settings getInstrumentCode]:start:[Settings getBidType]:handler];
}
//----------------------------------------------------------------------------------------------------
-(void)setChange:(double)value{    
    if(oldChangeValue<value){
        trend.image = [UIImage imageNamed:@"up.png"];
        curValue.backgroundColor=[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
    }
    else if(oldChangeValue>value){
        trend.image = [UIImage imageNamed:@"down.png"];
        curValue.backgroundColor=[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];        
    }
    curValue.text=[NSString stringWithFormat:@"%.2lf",value];
    double changeVal=0;
    if(oldChangeValue>0)
        changeVal=(value-oldChangeValue)/oldChangeValue*100.0;
    changeValue.text=[NSString stringWithFormat: @"%.2lf%", changeVal];
    if(changeVal>=0)
        changeValue.backgroundColor=[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
    else changeValue.backgroundColor=[UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:0.0];
    oldChangeValue=value;
}
-(void)setInfo:(int)exchangeId:(NSString*)instr{
    instrumentName.text=instr;
    if(exchangeId==[Instrument getRTS]){
        exchangeName.text=@"RTS";
        exchangeImg.image=[UIImage imageNamed:@"rts.png"];        
    }
    else{
        exchangeName.text=@"MICEX";
        exchangeImg.image=[UIImage imageNamed:@"micex.png"];
    }
}
-(void)showLoading{ 
    progress = [[UIAlertView alloc] initWithTitle:@"Идет загрузка" message:@"Пожалуйства, подождите..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [progress show];    
    if(progress != nil) {
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];        
        indicator.center = CGPointMake(progress.bounds.size.width/2, progress.bounds.size.height-45);
        [indicator startAnimating];
        [progress addSubview:indicator];
    }
}
//----------------------------------Transitions Processing-------------------------------
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"Segue: %@",[segue identifier]);
    if([[segue identifier] isEqualToString:@"toSettings"]){
        NSLog(@"Go to settings");
        //SettingsViewController* settings=(SettingsViewController*)[segue destinationViewController];
        
    }
}
-(void)hideLoading{
    [progress dismissWithClickedButtonIndex:0 animated:YES];
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
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
@end
