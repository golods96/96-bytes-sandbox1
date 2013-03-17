//
//  READViewController.m
//  readResponse
//
//  Created by Lev on 3/15/13.
//  Copyright (c) 2013 96 Bytes. All rights reserved.
//

#import "READViewController.h"
#import "readView.h"

@interface READViewController ()

@end

@implementation READViewController

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

- (void) loadView{
    [super loadView];
    CGRect frame = CGRectMake(10, 10, 300, 300);
    
    readView*   myView = [[readView alloc ] initWithFrame:frame] ;
    
    myView.clipsToBounds = YES;
    [[self view] addSubview:myView];
    
    UIButton* myButton = [[UIButton alloc] initWithFrame:frame];

    [myButton setTitle:@"unpressed" forState:UIControlStateNormal];
    [myButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [[self view] addSubview:myButton ];
    
}

- (void)buttonClicked:(id)sender
{
    UIButton *clickedButton = (UIButton *)sender;
    [clickedButton setTitle:@"Call HTTPRequest method" forState: UIControlStateNormal];
}

@end
