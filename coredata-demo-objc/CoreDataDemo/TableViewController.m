//
//  TableViewController.m
//  CoreDataDemo
//
//  Created by SEBP64 on 22/01/19.
//  Copyright © 2019 Musavir. All rights reserved.
//

#import "TableViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface TableViewController () {
    AppDelegate *appDelegate;
    NSArray *results;
    
}

@property (strong) NSMutableArray *devices;
@end



@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSManagedObjectContext *context = [[appDelegate persistentContainer]viewContext];
//    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:context];
//    [newDevice setValue:@"iphone" forKey:@"name"];
//    [newDevice setValue:@"6s" forKey:@"version"];
//    [newDevice setValue:@"apple" forKey:@"company"];
//
//    NSError *error = nil;
//    if (![context save:&error]) {
//        NSLog(@"Cant save! %@ %@",error,[error localizedDescription]);
//    }
    
    
    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Device"];
//    self.devices = [[context executeRequest:fetchRequest error:nil]mutableCopy];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [[appDelegate persistentContainer]viewContext];
    NSFetchRequest *requestExamLocation = [NSFetchRequest fetchRequestWithEntityName:@"Device"];
    self.devices = [[context executeFetchRequest:requestExamLocation error:nil]mutableCopy];
    
    NSLog(@"%@",results);
    [self.tableView reloadData];
}

//- (NSManagedObjectContext *)managedObjectContext {
//    NSManagedObjectContext *context = nil;
////    AppDelegate *appDelegate = nil;
//   id delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
////    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//    if ([delegate performSelector:@selector(persistentContainer)]) {
//        context = [[delegate persistentContainer]viewContext];
//    }
//    return context;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.devices.count ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
//    NSManagedObject *device = [results objectAtIndex:indexPath.row];
    NSString *name = [self.devices[indexPath.row] valueForKey:@"name"];
    NSString *version = [self.devices[indexPath.row] valueForKey:@"version"];
    NSString *company = [self.devices[indexPath.row] valueForKey:@"company"];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@",name,version]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@",company]];
    // Configure the cell...
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//     Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [[appDelegate persistentContainer]viewContext];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [context deleteObject:[self.devices objectAtIndex:indexPath.row]];
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Save: %@ %@",error,[error localizedDescription]);
            return;
        }
        [self.devices removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
   }// else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"UpdateDevice"]) {
        <#statements#>
    }
}


@end
