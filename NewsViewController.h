//
//  NewsViewController.h
//  diplom
//
//  Created by Mac on 16.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"
#import "NewsLoader.h"

@interface NewsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *newsList;
@property (weak, nonatomic) IBOutlet UIButton *refreshBtn;
@property (weak, nonatomic) IBOutlet UILabel *change;
@property (weak, nonatomic) IBOutlet UILabel *exchangeName;
@property (weak, nonatomic) IBOutlet UILabel *instrumentName;
@property (weak, nonatomic) IBOutlet UILabel *curValue;
@property (weak, nonatomic) IBOutlet UIImageView *curDirection;
@property (weak, nonatomic) IBOutlet UIImageView *exchangeImg;
@property (weak, nonatomic) IBOutlet UIView *topBar;
@property (weak, nonatomic) IBOutlet UIView *bottomBar;
@property (strong) UIAlertView *progress;
@property (weak, nonatomic) IBOutlet UIView *back;
-(void)setInfo:(int)exchangeId:(NSString*)instr;
-(void)showLoading;
-(void)hideLoading;
-(void)loadNews;
-(void)refreshClick;
@end
