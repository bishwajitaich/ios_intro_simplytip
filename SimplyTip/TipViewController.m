//
//  TipViewController.m
//  SimplyTip
//
//  Created by Bishwajit Aich. on 1/16/15.
//  Copyright (c) 2015 Bishwajit Aich. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabelField;
@property (weak, nonatomic) IBOutlet UILabel *totalLabelField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UILabel *billAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIView *hrLabel;

- (IBAction)onTap:(id)sender;
- (void)updateValues;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"SimplyTip";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self updateValues];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    
    float billAmount = [self.billTextField.text floatValue];
    
    NSArray *tip = @[@(0.1), @(0.15), @(0.2)];
    float tipAmount = billAmount * [tip[self.tipControl.selectedSegmentIndex] floatValue];
    
    float totalAmount = billAmount + tipAmount;
    
    self.tipLabelField.text = [formatter stringFromNumber:[NSNumber numberWithFloat:tipAmount]];
    self.totalLabelField.text = [formatter stringFromNumber:[NSNumber numberWithFloat:totalAmount]];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int defaultTipIndex = (int)[defaults integerForKey:@"defaultTip"];
    int defaultThemeIndex = (int) [defaults integerForKey:@"defaultTheme"];
    UIColor *black = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
    UIColor *white = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
    
    
    if (self.tipControl.selectedSegmentIndex != defaultTipIndex) {
        self.tipControl.selectedSegmentIndex = defaultTipIndex;
        [self updateValues];
    }
    
    [self.billTextField becomeFirstResponder];
    
    if (defaultThemeIndex == 1) {
        self.view.backgroundColor = black;
        self.tipControl.tintColor = white;
        self.tipLabelField.textColor = white;
        self.totalLabelField.textColor = white;
        self.billAmountLabel.textColor = white;
        self.tipAmountLabel.textColor = white;
        self.totalLabel.textColor = white;
        self.hrLabel.backgroundColor = white;
    } else {
        self.view.backgroundColor = white;
        self.tipControl.tintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
        self.tipLabelField.textColor = black;
        self.totalLabelField.textColor = black;
        self.billAmountLabel.textColor = black;
        self.tipAmountLabel.textColor = black;
        self.totalLabel.textColor = black;
        self.hrLabel.backgroundColor = black;
    }
}

- (void)saveUserData {
    NSLog(@"saving user data");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.billTextField.text forKey:@"lastSavedBill"];
    [defaults setObject:[NSDate date] forKey:@"lastSavedTime"];
    [defaults synchronize];
}

- (void)loadUserData {
    NSLog(@"loading user data");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *lastSavedTime = [defaults objectForKey:@"lastSavedTime"];
    NSDate * currentTime = [NSDate date];

    if ([currentTime timeIntervalSinceDate:lastSavedTime] > 600) {
        self.billTextField.text = @"";
        [self updateValues];
    }
}
@end
