//
//  HelloWorldViewController.m
//  HelloWorld
//
//  Created by jianpx on 3/7/13.
//  Copyright (c) 2013 PS. All rights reserved.
//

#import "HelloWorldViewController.h"

@interface HelloWorldViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UITextField *textField;


- (IBAction)changeGreeting:(id)sender;

@end

@implementation HelloWorldViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeGreeting:(id)sender {
    self.userName = self.textField.text;
    NSString *name = self.userName;
    if ([name length] == 0) {
        name = @"Default World!";
    }
    NSString *greeting = [[NSString alloc] initWithFormat:@"Hello, %@!", name];
    self.label.text = greeting;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.textField) {
        [textField resignFirstResponder];
    }
    return YES;
}
@end
