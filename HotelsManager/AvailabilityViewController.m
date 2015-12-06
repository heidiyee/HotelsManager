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


@interface AvailabilityViewController () <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) UITableView *tableView;
//@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsVC;

@end

@implementation AvailabilityViewController

- (NSFetchedResultsController *)fetchedResultsVC {
    if (!_fetchedResultsVC) {
        NSManagedObjectContext *context = [[CoreDataStack sharedCoreDataStack]managedObjectContext];
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
        request.predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", self.reservationNew.startDate, self.reservationNew.endDate];
        
        NSArray *allReservation = [[NSArray alloc]init];
        NSError *fetchError;
        allReservation = [context executeFetchRequest:request error:&fetchError];
        
        if (fetchError) {
            NSLog(@"Error fetching from Core Data.");
        }
        
        NSMutableArray *results = [[NSMutableArray alloc]init];
        for (Reservation *reservation in allReservation) {
            if (reservation.room) {
                [results addObject:reservation.room];
            }
        }
        
        NSFetchRequest *checkRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
        checkRequest.predicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", results];
        checkRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"hotel.name" ascending:YES]];
        
        _fetchedResultsVC = [[NSFetchedResultsController alloc]initWithFetchRequest:checkRequest managedObjectContext:context sectionNameKeyPath:@"hotel.name" cacheName:nil];
        _fetchedResultsVC.delegate = self;
        
        [_fetchedResultsVC performFetch:&fetchError];
        
        
        if (fetchError) {
            NSLog(@"Error fetching from Core Data.");
        }
    }
    return _fetchedResultsVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.fetchedResultsVC.sections > 0) {
        return self.fetchedResultsVC.sections.count;
    }
    return 0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.fetchedResultsVC.sections > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsVC sections] objectAtIndex:section];
        return [sectionInfo name];
    }
    return @"Hotel";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[self.fetchedResultsVC sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsVC sections] objectAtIndex:section];
        return [sectionInfo numberOfObjects];
    } else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    Room *room = [self.fetchedResultsVC objectAtIndexPath:indexPath];

    cell.textLabel.text = [NSString stringWithFormat:@"Room: %i (%i beds, $%0.2f per night)", room.roomNumber.intValue, room.beds.intValue, room.priceRate.floatValue];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Room *room = [self.fetchedResultsVC objectAtIndexPath:indexPath];
    room.reservation = self.reservationNew;
    self.reservationNew.room = room;
    BookViewController *bookViewController = [[BookViewController alloc]init];
    bookViewController.room = room;
    
    [self.navigationController pushViewController:bookViewController animated:YES];
}


@end
