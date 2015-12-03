//
//  BookViewController.m
//  HotelsManager
//
//  Created by Heidi Yee on 12/1/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import "BookViewController.h"
#import "Guest.h"
#import "CoreDataStack.h"

@interface BookViewController ()

@property (strong, nonatomic) UITextField *nameTextField;

@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupReservationLabel];
    [self setupNameTextField];
    [self setupSaveButton];
}

-(void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupReservationLabel {
    UILabel *label = [[UILabel alloc]init];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    NSString *labelString = [NSString stringWithFormat:@"Please fill in your name to reserve the follow room: Room number %@ at Hotel %@, From %@ to %@", self.room.roomNumber, self.room.hotel.name, [NSDateFormatter localizedStringFromDate:self.room.reservation.startDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle] , [NSDateFormatter localizedStringFromDate:self.room.reservation.endDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]];
    label.text = labelString;
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:label];
    
    NSLayoutConstraint *labelLeadingConstraint = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20.0];
    NSLayoutConstraint *labelTrailingConstraint = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20.0];
    NSLayoutConstraint *labelCenterY = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    
    labelLeadingConstraint.active = YES;
    labelTrailingConstraint.active = YES;
    labelCenterY.active = YES;
}

- (void)setupNameTextField {
    self.nameTextField = [[UITextField alloc]init];
    self.nameTextField.placeholder = @"Name here...";
    [self.nameTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:self.nameTextField];
    
    NSLayoutConstraint *nameTextFieldLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.nameTextField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20.0];
    NSLayoutConstraint *nameTextFieldTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.nameTextField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20.0];
    NSLayoutConstraint *nameTextFieldTopConstraint = [NSLayoutConstraint constraintWithItem:self.nameTextField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:100.0];
    
    nameTextFieldLeadingConstraint.active = YES;
    nameTextFieldTopConstraint.active = YES;
    nameTextFieldTrailingConstraint.active = YES;
}

- (void)setupSaveButton {
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonSelected:)]];
}

- (void)saveButtonSelected:(UIBarButtonItem *)sender {
    
    Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:[[CoreDataStack sharedCoreDataStack]managedObjectContext]];
    guest.name = self.nameTextField.text;
    guest.reservation = self.room.reservation;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
