//
//  AvailabilityViewController.m
//  HotelsManager
//
//  Created by Heidi Yee on 12/1/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import "AvailabilityViewController.h"
#import "Hotel.h"
#import "Room.h"
#import "CoreDataStack.h"
#import "BookViewController.h"


@interface AvailabilityViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation AvailabilityViewController

- (NSArray *)dataSource {
    if (!_dataSource) {
        NSManagedObjectContext *context = [[CoreDataStack sharedCoreDataStack]managedObjectContext];
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
        //request.predicate = [NSPredicate predicateWithFormat:<#(nonnull NSString *), ...#>]
        
        NSError *fetchError;
        //NSArray *results = [context executeFetchRequest:request error:&fetchError];
        
        
        
        _dataSource = [context executeFetchRequest:request error:&fetchError];
        
        if (fetchError) {
            NSLog(@"Error fetching from Core Data.");
        }
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"%@", self.reservationNew.endDate);
    [self setupTableView];
}

-(void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    Room *room = self.dataSource[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Hotel: %@ Room: %i (%i beds, $%0.2f per night)", room.hotel.name, room.roomNumber.intValue, room.beds.intValue, room.priceRate.floatValue];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Room *room = self.dataSource[indexPath.row];
    room.reservation = self.reservationNew;
    BookViewController *bookViewController = [[BookViewController alloc]init];
    bookViewController.room = room;
    
    [self.navigationController pushViewController:bookViewController animated:YES];
}


@end
