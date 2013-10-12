//
//  ViewController.m
//  GameViewImage
//
//  Created by iOS17 on 10/9/13.
//  Copyright (c) 2013 VT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIStoryboard *storyboard;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionStartGame:(id)sender {
    
    GameViewController  *game = [storyboard instantiateViewControllerWithIdentifier:@"gameViewController"];
    [self presentViewController:game animated:YES completion:nil];

}
- (IBAction)actionSetting:(id)sender {
    
    
    SettingViewController *setting = [storyboard instantiateViewControllerWithIdentifier:@"settingViewController"];
    [self presentViewController:setting animated:YES completion:nil];
}
@end
