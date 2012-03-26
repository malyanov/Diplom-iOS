//
//  ViewController.h
//  diplom
//
//  Created by Mac on 23.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chart.h"
#import "AnalyseChart.h"
#import "Querer.h"
#import "FileParser.h"
#import "Settings.h"
#import "SettingsViewController.h"

@interface MainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *back;
@property (weak, nonatomic) IBOutlet UILabel *clock;
@property (strong) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIView *bottomBar;
@property (weak, nonatomic) IBOutlet UIView *topBar;
@property (weak, nonatomic) IBOutlet UIView *mainChartView;
@property (weak, nonatomic) IBOutlet UIView *analizeChartView;

@property (weak, nonatomic) IBOutlet UIImageView *trend;
@property (weak, nonatomic) IBOutlet UILabel *curValue;
@property (weak, nonatomic) IBOutlet UILabel *changeValue;
@property (weak, nonatomic) IBOutlet UILabel *exchangeName;
@property (weak, nonatomic) IBOutlet UIImageView *exchangeImg;
@property (weak, nonatomic) IBOutlet UILabel *instrumentName;

@property (strong) UIAlertView *progress;
@property (readwrite, copy) HandleBlock updLastQuotHandler;
@property double oldChangeValue;
@property (strong) Chart *chart;
@property (strong) AnalyseChart *analizeGraph;
@property (strong) Querer *querer;

@property (strong) NSMutableArray *quots;
@property (strong) FileParser *parser;
@property (strong) Instrument *curInstrument;
-(void)timerTask:NSTimer;
+(NSString*)getCurrentTimeStr;
-(void)loadChartData;
-(void)setChange:(double)value;
-(void)setInfo:(int)exchangeId:(NSString*)instr;
-(void)showLoading;
-(void)hideLoading;
@end
