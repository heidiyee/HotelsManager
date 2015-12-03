//
//  LookUpViewController.m
//  HotelsManager
//
//  Created by Heidi Yee on 12/2/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import "LookUpViewController.h"
#import "CoreDataStack.h"

@interface LookUpViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation LookUpViewController

- (NSArray *)dataSource {
    if (!_dataSource) {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        NSManagedObjectContext *context = delegate.managedObjectContext;
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
        
        NSError *fetchError;
        
        _dataSource = [context executeFetchRequest:request error:&fetchError];
        
        if (fetchError) {
            NSLog(@"Error fetching from Core Data.");
        }
    }
    return _dataSource;
}


-(void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    NSLayoutConstraint *tableViewTopConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *tableViewLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    NSLayoutConstraint *tableViewTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    NSLayoutConstraint *tableViewBottomConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    [self.view addSubview:self.tableView];
    
    tableViewBottomConstraint.active = YES;
    tableViewLeadingConstraint.active = YES;
    tableViewTrailingConstraint.active = YES;
    tableViewTopConstraint.active = YES;
}



@end
