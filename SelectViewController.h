//
//  SelectViewController.h
//  diplom
//
//  Created by Mac on 25.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComboBox.h"
#import "MICEX_Loader.h"
#import "RTS_Loader.h"
#import "TableViewController.h"

@interface SelectViewController : UIViewController
{
    ComboBox *instrumentCombo;
    NSMutableArray *rts, *micex;
}
@property int exchangeId;
@property (strong) NSString* instrumentCode;
@property (weak, nonatomic) IBOutlet UIView *bottomBar;
@property (weak, nonatomic) IBOutlet UIView *back;
- (IBAction)exchangeSelected:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *instrumentSelect;

@end
