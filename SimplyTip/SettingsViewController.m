//
//  SettingsViewController.m
//  SimplyTip
//
//  Created by Bishwajit Aich. on 1/16/15.
//  Copyright (c) 2015 Bishwajit Aich. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultThemeControl;
- (IBAction)setDefaults:(id)sender;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int defaultTipIndex = (int)[defaults integerForKey:@"defaultTip"];
    int defaultThemeIndex = (int)[defaults integerForKey:@"defaultTheme"];
    self.defaultTipControl.selectedSegmentIndex = defaultTipIndex;
    self.defaultThemeControl.selectedSegmentIndex = defaultThemeIndex;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)setDefaults:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:self.defaultTipControl.selectedSegmentIndex forKey:@"defaultTip"];
    [defaults setInteger:self.defaultThemeControl.selectedSegmentIndex forKey:@"defaultTheme"];
    [defaults synchronize];
}
@end
