//
//  ViewController.m
//  TodayExtensionSharingDefaults
//
//  Created by Lukas Petr on 25/06/14.
//  Copyright (c) 2014 Lukas Petr. All rights reserved.
//




#import "ViewController.h"
#import "TodayViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (IBAction)setButtonPressed:(id)sender {
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.TodayExtensionSharingDefaults"];
    
    [sharedDefaults setInteger:[self.textField.text integerValue] forKey:@"MyNumberKey"];
    [sharedDefaults synchronize];   // (!!) This is crucial.
}
       
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *gg= [[NSUserDefaults standardUserDefaults]objectForKey:@"local"];
    if ([gg isEqualToString:@"aabb"]) {
         [self performSegueWithIdentifier:@"second" sender:nil];
    }
    
    SecondViewController *sc =  [[SecondViewController alloc] init];
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.TodayExtensionSharingDefaults"];
    NSString *ab= [defaults objectForKey:@"MyPage"];
   
    if ([ab isEqual:@"abc"]) {
        [self performSegueWithIdentifier:@"second" sender:nil];
    }
    NSLog(@"----ab---:%@",ab);
    //[self.navigationController pushViewController:sc animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"second"]) {
        SecondViewController *second=   segue.destinationViewController;
        second.view.backgroundColor=[UIColor yellowColor];
    }
}

@end
