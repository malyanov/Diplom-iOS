//
//  ViewController.h
//  diplom
//
//  Created by Mac on 23.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *back;
@property (weak, nonatomic) IBOutlet UILabel *clock;
@property (strong) NSTimer *timer;
-(void)timerTask:NSTimer;
@property (weak, nonatomic) IBOutlet UIView *bottomBar;
@property (weak, nonatomic) IBOutlet UIView *topBar;
@property (strong, nonatomic) IBOutlet UIView *mainChart;
+(NSString*)getCurrentTimeStr;
@end
