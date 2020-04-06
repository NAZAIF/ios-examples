//
//  ViewController.m
//  CoreDataDemo
//
//  Created by SEBP64 on 22/01/19.
//  Copyright © 2019 Musavir. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface ViewController () {
    AppDelegate *appDelegate;
}

@end

@implementation ViewController

//- (NSManagedObjectContext *)managedObjectContext {
//    NSManagedObjectContext *context = nil;
////    AppDelegate *appDelegate;
////    NSManagedObjectContext *context = nil;
//    id delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
////    id delegate = [[UIApplication sharedApplication] delegate];
//    if ([delegate performSelector:@selector(persistentContainer)]) {
//        context = elegate.persistentContainer.viewContext;
//    }
//    return context;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)saveAction:(id)sender {
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [[appDelegate persistentContainer]viewContext];
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:context];
    [newDevice setValue:self.nameTextField.text forKey:@"name"];
    [newDevice setValue:self.versionTextField.text forKey:@"version"];
    [newDevice setValue:self.companyTextField.text forKey:@"company"];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Cant save! %@ %@",error,[error localizedDescription]);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)cancelAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
