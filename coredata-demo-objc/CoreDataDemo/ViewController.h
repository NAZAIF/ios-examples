//
//  ViewController.h
//  CoreDataDemo
//
//  Created by SEBP64 on 22/01/19.
//  Copyright © 2019 Musavir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *versionTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;
- (IBAction)saveAction:(id)sender;
- (IBAction)cancelAction:(id)sender;


@end

