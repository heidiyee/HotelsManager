//
//  DateViewController.m
//  HotelsManager
//
//  Created by Heidi Yee on 12/1/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import "DateViewController.h"

@interface DateViewController ()

@property (strong, nonatomic) UIDatePicker *startDatePicker;
@property (strong, nonatomic) UIDatePicker *endDatePicker;
@property (strong, nonatomic) NSLocale *locale;
@property (strong, nonatomic) NSDate *date;

@end

@implementation DateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locale = [NSLocale currentLocale];
    self.date = [NSDate date];
    [self setupDatePicker];
    [self setupDoneButton];
}

-(void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupDoneButton {
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonSelected)]];
}

- (void)setupDatePicker {
    self.startDatePicker = [[UIDatePicker alloc]init];
    self.startDatePicker.datePickerMode = UIDatePickerModeDate;
    self.startDatePicker.locale = self.locale;
    self.startDatePicker.minimumDate = self.date;
    [self.startDatePicker setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.endDatePicker = [[UIDatePicker alloc]init];
    self.endDatePicker.datePickerMode = UIDatePickerModeDate;
    self.endDatePicker.locale = self.locale;
    self.endDatePicker.minimumDate = self.date;
    [self.endDatePicker setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *startPickerTopConstraint = [NSLayoutConstraint constraintWithItem:self.startDatePicker attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:64.0];
    NSLayoutConstraint *startPickerLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.startDatePicker attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    NSLayoutConstraint *startPickerTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.startDatePicker attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    NSLayoutConstraint *startPickerHeightConstraint = [NSLayoutConstraint constraintWithItem:self.startDatePicker attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:200.0];
    
    NSLayoutConstraint *endPickerTopConstraint = [NSLayoutConstraint constraintWithItem:self.endDatePicker attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.startDatePicker attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.0];
    NSLayoutConstraint *endPickerLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.endDatePicker attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    NSLayoutConstraint *endPickerTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.endDatePicker attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    NSLayoutConstraint *endPickerHeightConstraint = [NSLayoutConstraint constraintWithItem:self.endDatePicker attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:200.0];
    
    [self.view addSubview:self.startDatePicker];
    [self.view addSubview:self.endDatePicker];
    
    startPickerHeightConstraint.active = YES;
    startPickerLeadingConstraint.active = YES;
    startPickerTopConstraint.active = YES;
    startPickerTrailingConstraint.active = YES;
    
    endPickerHeightConstraint.active = YES;
    endPickerLeadingConstraint.active = YES;
    endPickerTopConstraint.active = YES;
    endPickerTrailingConstraint.active = YES;
}

- (void)doneButtonSelected {
    [self.date descriptionWithLocale:self.locale];
    NSDate *startDate = [self.startDatePicker date];
    NSDate *endDate = self.endDatePicker.date;
    
    if ([startDate timeIntervalSinceDate:endDate] > 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Nope" message:@"Please choose an end date that is after your start date" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.endDatePicker.date = self.startDatePicker.date;
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil]; return;
    }
    
    
}

@end
