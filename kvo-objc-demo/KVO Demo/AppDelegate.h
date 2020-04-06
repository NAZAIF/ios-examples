//
//  AppDelegate.h
//  KVO Demo
//
//  Created by SEBP64 on 21/01/19.
//  Copyright © 2019 Musavir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

