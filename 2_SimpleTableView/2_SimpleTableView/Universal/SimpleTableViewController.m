//
//  ViewController.m
//  2_SimpleTableView
//
//  Created by Karthick C on 18/11/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "SimpleTableViewController.h"
#import "SimpleTableCell.h"

@interface SimpleTableViewController () {
    NSMutableArray *tableContents;
    NSMutableArray *tablethumbNails;
    NSMutableArray *tableprepTimes;
    NSMutableArray<NSNumber *> *tableselections;
}
@end

@implementation SimpleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
#if 0
    tableContents = [NSMutableArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    thumbNails = [NSMutableArray arrayWithObjects:@"egg_benedict.jpg", @"mushroom_risotto.jpg", @"full_breakfast.jpg", @"hamburger.jpg", @"ham_and_egg_sandwich.jpg", @"creme_brelee.jpg", @"white_chocolate_donut.jpg", @"starbucks_coffee.jpg", @"vegetable_curry.jpg", @"instant_noodle_with_egg.jpg", @"noodle_with_bbq_pork.jpg", @"japanese_noodle_with_pork.jpg", @"green_tea.jpg", @"thai_shrimp_cake.jpg", @"angry_birds_cake.jpg", @"ham_and_cheese_panini.jpg", nil];
    prepTimes = [NSMutableArray arrayWithObjects:@"30 min",@"30 min",@"20 min",@"30 min",@"10 min",@"1 hour",
                 @"2 hours",@"5 mins",@"15 mins",@"5 mins",@"25 mins",@"30 mins",@"5 mins",@"1 hour",@"1 hour",@"2 hours",nil];
#else
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"recipies" ofType:@"plist"];
    NSLog(@"path of plistfile =%@",plistPath);
    NSDictionary *recipiesInfo = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    tableContents = [[recipiesInfo objectForKey:@"name"] mutableCopy];
    tablethumbNails = [[recipiesInfo objectForKey:@"thumbnail"] mutableCopy];
    tableprepTimes = [[recipiesInfo objectForKey:@"prep_time"] mutableCopy];
    tableselections = [[NSMutableArray alloc] init];
    for(int i=0; i < tableContents.count; i++) {
        tableselections[i] = [NSNumber numberWithBool:NO];
    }
#endif
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Delegates

#define DISABLE_CUSTOM_TABLE_VIEW_CELL 0
#pragma mark -UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
#if DISABLE_CUSTOM_TABLE_VIEW_CELL
    return 40;
#else
    return SIMPLE_TABLE_CELL_HEIGHT;
#endif
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //De-Select the Cell and Perform Appropriate action
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UIAlertController *recipieAlert = [UIAlertController alertControllerWithTitle:[tableContents objectAtIndex:indexPath.row]
                                                                          message:[NSString stringWithFormat:@"Can be prepared in %@",[tableprepTimes objectAtIndex:indexPath.row]]
                                                                   preferredStyle:UIAlertControllerStyleAlert];
    __weak UITableViewCell *weakCurrentCell = [tableView cellForRowAtIndexPath:indexPath];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^void(UIAlertAction *action){
                                                       UITableViewCell *currentCell = weakCurrentCell;
                                                       if(tableselections != nil) {
                                                           BOOL currentSelStatus = [tableselections[indexPath.row] boolValue];
                                                           tableselections[indexPath.row] = [NSNumber numberWithBool:!currentSelStatus];
                                                           [self updateCellAccessoryType:currentCell atIndexPath:indexPath];
                                                       }
                                                   }];
    [recipieAlert addAction:action];
    [self presentViewController:recipieAlert animated:YES completion:nil];
}

#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableContents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *simpleTableIdentifier = @"SimpleTableCell";
    UITableViewCell *currentCell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(currentCell == nil) {
        currentCell = [self createNewTableViewCellWithReuseIdentifier:simpleTableIdentifier];
    }
    [self populateCell:currentCell forRowAtIndexPath:indexPath];
    return currentCell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s: commitEditingStyle: %d",__PRETTY_FUNCTION__, (int)editingStyle);
    [tableContents removeObjectAtIndex:indexPath.row];
    [tablethumbNails removeObjectAtIndex:indexPath.row];
    [tableprepTimes removeObjectAtIndex:indexPath.row];
    [tableselections removeObjectAtIndex:indexPath.row];
#if 0
    [tableView reloadData];
#else
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
#endif
}

- (UITableViewCell *) createNewTableViewCellWithReuseIdentifier:(NSString *)simpleTableIdentifier{
#if DISABLE_CUSTOM_TABLE_VIEW_CELL
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
#else
    UINib *simpleTableCellNib = [UINib nibWithNibName:simpleTableIdentifier bundle:nil];
    NSArray *simpleTableCellHierarchy = [simpleTableCellNib instantiateWithOwner:self options:nil];
    return [simpleTableCellHierarchy objectAtIndex:0];
#endif
}

- (void) populateCell:(UITableViewCell *) rowCell forRowAtIndexPath : (NSIndexPath *) indexPath {
    if([rowCell isKindOfClass:[SimpleTableCell class]]) {
        //Custom SimpleTableCell Block -Start
        SimpleTableCell *simpleTableCell = (SimpleTableCell *)rowCell;
        simpleTableCell.nameLabel.text = [tableContents objectAtIndex:indexPath.row];
        simpleTableCell.thumnailImageView.image = [UIImage imageNamed:[tablethumbNails objectAtIndex:indexPath.row]];
        simpleTableCell.prepTimeLabel.text = [tableprepTimes objectAtIndex:indexPath.row];
        //Custom SimpleTableCell Block -End
    }else {
        //Default UITableCellView Block -Start
        rowCell.textLabel.text = [tableContents objectAtIndex:indexPath.row];
        rowCell.imageView.image = [UIImage imageNamed:[tablethumbNails objectAtIndex:indexPath.row]];
        //Default UITableCellView Block -End
    }
    [self updateCellAccessoryType:rowCell atIndexPath:indexPath];
}

- (void) updateCellAccessoryType: (UITableViewCell *) cell atIndexPath: (NSIndexPath *) indexPath {
    if(cell == nil) {
        return;
    }
    if([tableselections[indexPath.row] boolValue] == YES) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}
@end
