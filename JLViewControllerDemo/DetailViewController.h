//
//  DetailViewController.h
//  JLViewControllerDemo
//
//  Created by Julian Song on 17/2/13.
//  Copyright © 2017年 Julian Song. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSDate *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

