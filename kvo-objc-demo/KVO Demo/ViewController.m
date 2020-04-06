//
//  ViewController.m
//  KVO Demo
//
//  Created by SEBP64 on 21/01/19.
//  Copyright © 2019 Musavir. All rights reserved.
//

#import "ViewController.h"
#import "Children.h"

static void *child1Context = &child1Context;
static void *child2Context = &child2Context;

@interface ViewController ()

@property (nonatomic,strong) Children *child1;
@property (nonatomic,strong) Children *child2;
@property (nonatomic,strong) Children *child3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.child1 = [[Children alloc]init];
    self.child1.name = @"Ramu";
    self.child1.age = 34;
    NSLog(@"%@ - %d",self.child1.name,self.child1.age);
    
    self.child2 = [[Children alloc]init];
    [self.child2 setValue:@"george" forKey:@"name"];
    [self.child2 setValue:[NSNumber numberWithInteger:54] forKey:@"age"];
    
//    NSString *childName = [self.child2 valueForKey:@"name"];
//    NSUInteger childAge = [[self.child2 valueForKey:@"age"]integerValue];
    self.child2.child = [[Children alloc]init];
    [self.child2 setValue:@"Neeraj" forKeyPath:@"child.name"];
    [self.child2 setValue:[NSNumber numberWithInteger:32] forKeyPath:@"child.age"];
    NSLog(@"%@ - %d",self.child2.child.name,self.child2.child.age);
    
    self.child3 = [[Children alloc]init];
    self.child3.child = [[Children alloc]init];
    self.child3.child.child = [[Children alloc]init];
    [self.child3 setValue:@"Bob" forKeyPath:@"child.child.name"];
    [self.child3 setValue:[NSNumber numberWithInteger:75] forKeyPath:@"child.child.age"];
    
    NSLog(@"%@ ~ %d",self.child3.child.child.name,self.child3.child.child.age);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.child1 addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:child1Context];
    [self.child1 addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:child1Context];
    [self.child1 setValue:@"Mikhael" forKey:@"name"];
    [self.child1 setValue:[NSNumber numberWithInteger:23] forKey:@"age"];
    
    [self.child2 addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:child2Context];
    [self.child2 setValue:[NSNumber numberWithInteger:101]forKey:@"age"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (context == child1Context) {
    if ([keyPath isEqualToString:@"name"]) {
        NSLog(@"The name of the first child changed.");
        NSLog(@"%@",change);
    }
    if ([keyPath isEqualToString:@"age"]) {
        NSLog(@"The age of the first child changed.");
        NSLog(@"%@",change);
    } }
    
    if (context == child2Context) {
        if ([keyPath isEqualToString:@"age"]) {
            NSLog(@"The age of second child changed: %@",change);
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.child1 removeObserver:self forKeyPath:@"name"];
    [self.child1 removeObserver:self forKeyPath:@"age"];
    [self.child2 removeObserver:self forKeyPath:@"age"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
