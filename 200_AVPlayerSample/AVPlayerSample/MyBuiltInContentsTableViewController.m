//
//  MyBuiltInContentsTableViewController.m
//  AVPlayerSample
//
//  Created by Karthick C on 11/07/18.
//  Copyright © 2018 Karthick C. All rights reserved.
//

#import "MyBuiltInContentsTableViewController.h"
#import "BuiltInContent.h"
#import "PropertyLists.h"
@interface MyBuiltInContentsTableViewController ()
@property (nonatomic) NSArray<BuiltInContent*> *builtInContents;
@end

@implementation MyBuiltInContentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.builtInContents = [PropertyLists builtInContents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.builtInContents count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"builtInContentCell" forIndexPath:indexPath];
    cell.textLabel.text = self.builtInContents[indexPath.row].contentName;
    cell.detailTextLabel.text = self.builtInContents[indexPath.row].contentURL;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.builtInContentSelectionDelegate != nil) {
        [self.builtInContentSelectionDelegate didSelectBuiltInItem:self.builtInContents[indexPath.row]];
    }
    NSLog(@"selectedIndex = %lu", indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
