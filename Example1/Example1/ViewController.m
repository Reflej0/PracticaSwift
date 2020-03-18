//
//  ViewController.m
//  Example1
//
//  Created by Juan Tocino on 18/03/2020.
//  Copyright © 2020 Reflejo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)paisAction:(id)sender
{
    [self performSegueWithIdentifier:@"ListaPaises" sender:self];
}
@end
