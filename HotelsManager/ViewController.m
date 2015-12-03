//
//  ViewController.m
//  HotelsManager
//
//  Created by Heidi Yee on 11/30/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import "ViewController.h"
#import "HotelsViewController.h"
#import "DateViewController.h"
#import "AppDelegate.h"
#import "LookUpViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Hotels"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadView {
    [super loadView];
    [self setupCustomLayout];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Guest"];
    
    NSArray *guests = [context executeFetchRequest:request error:nil];
    
    NSLog(@"%li", guests.count);
}

- (void) setupCustomLayout {
    UIButton *browseButton = [[UIButton alloc]init];
    UIButton *bookButton = [[UIButton alloc]init];
    UIButton *lookupBotton = [[UIButton alloc]init];
    
    [browseButton setTitle:@"Browse" forState:UIControlStateNormal];
    [bookButton setTitle:@"Book" forState:UIControlStateNormal];
    [lookupBotton setTitle:@"Look Up" forState:UIControlStateNormal];
    
    [browseButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [bookButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [lookupBotton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [browseButton setBackgroundColor:[UIColor blueColor]];
    [bookButton setBackgroundColor:[UIColor purpleColor]];
    [lookupBotton setBackgroundColor:[UIColor redColor]];
    
    [browseButton addTarget:self action:@selector(browseButtonSelected) forControlEvents:UIControlEventTouchUpInside];
    [bookButton addTarget:self action:@selector(bookButtonSelected) forControlEvents:UIControlEventTouchUpInside];
    [lookupBotton addTarget:self action:@selector(lookupButtonSelected) forControlEvents:UIControlEventTouchUpInside];

    
    float screenHeight = CGRectGetHeight([[UIScreen mainScreen]bounds]) - 64.0;
    float screenHeightByThree = screenHeight/3;
    
    NSLayoutConstraint *browseButtonTopConstraint = [NSLayoutConstraint constraintWithItem:browseButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:64.0];
    NSLayoutConstraint *browseButtonLeadingConstraint = [NSLayoutConstraint constraintWithItem:browseButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    NSLayoutConstraint *browseButtonTrailingConstraint = [NSLayoutConstraint constraintWithItem:browseButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    
    NSLayoutConstraint *bookButtonTopConstraint = [NSLayoutConstraint constraintWithItem:bookButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:browseButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bookButtonLeadingConstraint = [NSLayoutConstraint constraintWithItem:bookButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bookButtonTrailingConstraint = [NSLayoutConstraint constraintWithItem:bookButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    
    NSLayoutConstraint *lookupButtonTopConstraint = [NSLayoutConstraint constraintWithItem:lookupBotton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:bookButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *lookupButtonLeadingConstraint = [NSLayoutConstraint constraintWithItem:lookupBotton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    NSLayoutConstraint *lookupButtonTrailingConstraint = [NSLayoutConstraint constraintWithItem:lookupBotton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    
    
    NSLayoutConstraint *browseButtonHeightConstraint = [NSLayoutConstraint constraintWithItem:browseButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:screenHeightByThree];
    NSLayoutConstraint *bookButtonHeightConstraint = [NSLayoutConstraint constraintWithItem:bookButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:screenHeightByThree];
    NSLayoutConstraint *lookupButtonHeightConstraint = [NSLayoutConstraint constraintWithItem:lookupBotton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:screenHeightByThree];
   
    [self.view addSubview:browseButton];
    [self.view addSubview:bookButton];
    [self.view addSubview:lookupBotton];
    
    browseButtonTopConstraint.active = YES;
    browseButtonLeadingConstraint.active = YES;
    browseButtonTrailingConstraint.active = YES;
    browseButtonHeightConstraint.active = YES;
    
    bookButtonTopConstraint.active = YES;
    bookButtonLeadingConstraint.active = YES;
    bookButtonTrailingConstraint.active = YES;
    bookButtonHeightConstraint.active = YES;
    
    lookupButtonTopConstraint.active = YES;
    lookupButtonLeadingConstraint.active = YES;
    lookupButtonTrailingConstraint.active = YES;
    lookupButtonHeightConstraint.active = YES;
}

- (void)browseButtonSelected {
    [self.navigationController pushViewController:[[HotelsViewController alloc]init] animated:YES];
}

- (void)bookButtonSelected {
    [self.navigationController pushViewController:[[DateViewController alloc]init] animated:YES];
}

- (void)lookupButtonSelected {
    [self.navigationController pushViewController:[[LookUpViewController alloc]init] animated:YES];
}

@end
