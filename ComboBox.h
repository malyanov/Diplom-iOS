//
//  ComboBox.h
//
//  Created by Dor Alon on 12/17/11.
//  http://doralon.net

#import <UIKit/UIKit.h>

@interface ComboBox : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>
{
    UIPickerView* pickerView;
    IBOutlet UITextField* textField;
    NSMutableArray *dataArray;
    NSString* selectedText;
}

-(void) setComboData:(NSMutableArray*) data:(NSString*)selectedValue;
@property (retain, nonatomic) NSString* selectedText; //the UITextField text
@end
