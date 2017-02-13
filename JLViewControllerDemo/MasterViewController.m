//
//  MasterViewController.m
//  JLViewControllerDemo
//
//  Created by Julian Song on 17/2/13.
//  Copyright © 2017年 Julian Song. All rights reserved.
//

#import "MasterViewController.h"
#import "JLPAVCViewController.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@property NSDictionary *viewControllers;
@end

@implementation MasterViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.cornerRadius = 4;
    self.view.layer.shadowOpacity = 0.5;
    self.objects = [[NSMutableArray alloc] init];
    [self.objects addObject:@"Presenting a View Controller"];
    self.viewControllers = @{@"Presenting a View Controller":@"JLPAVCViewController",
                             };
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}


- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = self.objects[indexPath.row];
    NSString *clsName = [self.viewControllers objectForKey:key];
    Class class = NSClassFromString(clsName);
    UIViewController *vc = [[class alloc] init];
    [vc setTitle:key];
    
    if (self.splitViewController.collapsed) {
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        UINavigationController *nav = self.splitViewController.viewControllers.lastObject;
        [nav setViewControllers:@[vc]];
        [self.splitViewController showDetailViewController:nav sender:self];
        vc.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        vc.navigationItem.leftItemsSupplementBackButton = YES;
    }
}
@end
