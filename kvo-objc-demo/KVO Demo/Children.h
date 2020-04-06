//
//  Children.h
//  KVO Demo
//
//  Created by SEBP64 on 21/01/19.
//  Copyright © 2019 Musavir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Children : NSObject

@property(strong,nonatomic) NSString *name;
@property(nonatomic) NSUInteger age;
@property(nonatomic, strong) Children *child;

@end
