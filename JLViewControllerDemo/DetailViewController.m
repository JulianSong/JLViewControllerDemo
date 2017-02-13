//
//  DetailViewController.m
//  JLViewControllerDemo
//
//  Created by Julian Song on 17/2/13.
//  Copyright © 2017年 Julian Song. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property(nonatomic,strong)UIButton *button;
@end

@implementation DetailViewController

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.button = [[UIButton alloc] init];
    [self.view addSubview:self.button];
    [self.button addTarget:self action:@selector(showVC) forControlEvents:UIControlEventTouchUpInside];
    self.button.backgroundColor = self.view.tintColor;
    [self.button setTitle:@"Show VC" forState:UIControlStateNormal];
    [self configureView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.button.frame = CGRectMake(100,100,100,100);
}

- (void)showVC
{
    UIViewController *pVC = [[UIViewController alloc] init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissVC)];
    [pVC.view addGestureRecognizer:tap];
    pVC.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    pVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;//Persist self view when present.
    //pVC.modalPresentationStyle = UIModalPresentationCurrentContext;//Remove self view when present.
    pVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    self.providesPresentationContextTransitionStyle = YES;
//    self.definesPresentationContext = YES;//Just cover self view.
    [self presentViewController:pVC animated:YES completion:nil];
}

- (void)dismissVC
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(NSDate *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}


@end
