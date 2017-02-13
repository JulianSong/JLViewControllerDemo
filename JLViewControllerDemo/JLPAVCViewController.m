//
//  DetailViewController.m
//  JLViewControllerDemo
//
//  Created by Julian Song on 17/2/13.
//  Copyright © 2017年 Julian Song. All rights reserved.
//

#import "JLPAVCViewController.h"

@interface JLPAVCViewController ()
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UIButton *fullScreenPresentBtn;
@end

@implementation JLPAVCViewController

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    self.button = [[UIButton alloc] init];
    [self.view addSubview:self.button];
    [self.button addTarget:self action:@selector(showVC) forControlEvents:UIControlEventTouchUpInside];
    self.button.backgroundColor = self.view.tintColor;
    [self.button setTitle:@"Show VC" forState:UIControlStateNormal];
    
    self.fullScreenPresentBtn = [[UIButton alloc] init];
    self.fullScreenPresentBtn.titleLabel.numberOfLines = 0;
    [self.view addSubview:self.fullScreenPresentBtn];
    [self.fullScreenPresentBtn addTarget:self action:@selector(fullScreenPresent) forControlEvents:UIControlEventTouchUpInside];
    self.fullScreenPresentBtn.backgroundColor = self.view.tintColor;
    [self.fullScreenPresentBtn setTitle:@"Full Screen Present" forState:
     UIControlStateNormal];
    [self configureView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.button.frame = CGRectMake(50,114,100,100);
    self.fullScreenPresentBtn.frame = CGRectMake(200,114,100,100);
}

- (void)showVC
{
    UIViewController *pVC = [[UIViewController alloc] init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissVC)];
    [pVC.view addGestureRecognizer:tap];
    pVC.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    pVC.modalPresentationStyle = UIModalPresentationCurrentContext;//Persist self view when present.
    //pVC.modalPresentationStyle = UIModalPresentationCurrentContext;//Remove self view when present.
//    pVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    self.providesPresentationContextTransitionStyle = YES;
//    self.modalTransitionStyle = UIModalPresentationFullScreen;
    self.definesPresentationContext = YES;//Just cover self view.
    [self presentViewController:pVC animated:YES completion:^{
        NSLog(@"done");
    }];
}

- (void)fullScreenPresent
{
    UIViewController *pVC = [[UIViewController alloc] init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissVC)];
    [pVC.view addGestureRecognizer:tap];
    pVC.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    pVC.modalPresentationStyle = UIModalPresentationFormSheet;
    pVC.modalPresentationStyle = UIModalPresentationPageSheet;
    pVC.modalPresentationStyle = UIModalPresentationFormSheet;

    self.definesPresentationContext = YES;//Just cover self view.
    [self presentViewController:pVC animated:YES completion:^{
        NSLog(@"%@",pVC.presentingViewController);
        
        /*a full-screen presentation must be initiated by a full-screen view controller. If the current presenting view controller is not suitable, UIKit walks the view controller hierarchy until it finds one that is. Upon completion of a modal presentation, UIKit updates the presentingViewController and presentedViewController properties of the affected view controllers.*/
    }];
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
