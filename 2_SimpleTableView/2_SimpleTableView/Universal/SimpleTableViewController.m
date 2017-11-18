//
//  ViewController.m
//  2_SimpleTableView
//
//  Created by Karthick C on 18/11/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "SimpleTableViewController.h"

@interface SimpleTableViewController () {
    NSArray *tableContents;
}
@end

@implementation SimpleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    tableContents = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableContents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *simpleTableIdentifier = @"My-Breakfast-Items";
    UITableViewCell *currentCell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(currentCell == nil) {
        currentCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    currentCell.textLabel.text = [tableContents objectAtIndex:indexPath.row];
    currentCell.imageView.image = [UIImage imageNamed:@"creme_brelee.jpg"];
    return currentCell;
}


@end
