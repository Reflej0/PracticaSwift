//
//  ListaPaises.h
//  Example1
//
//  Created by Juan Tocino on 18/03/2020.
//  Copyright © 2020 Reflejo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListaPaises : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerPaises;
- (IBAction)verPaisAction:(id)sender;
@end
