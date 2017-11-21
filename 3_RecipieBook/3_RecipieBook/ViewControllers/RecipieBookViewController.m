//
//  ViewController.m
//  3_RecipieBook
//
//  Created by Karthick C on 20/11/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "RecipieBookViewController.h"
#import "RecipieDetailViewController.h"
#define GET_RESOURCE(X,Y) [[NSBundle mainBundle] pathForResource:@#X ofType:@#Y]
const NSString* RECIPIE_NAME_KEY = @"RecipeName";
@interface RecipieBookViewController (){
    NSArray *recipieNames;
}
@property (nonatomic,weak) IBOutlet UITableView *tableView;
@end

@implementation RecipieBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *recipieBook = [NSDictionary dictionaryWithContentsOfFile:GET_RESOURCE(Recipies,plist)];
    if(recipieBook) {
        recipieNames = [recipieBook objectForKey:RECIPIE_NAME_KEY];
    }
    NSLog(@"recipieNames= %@", recipieNames);
    UITableView *tableView = nil;
    for(UIView* view in [self.view subviews]) {
        if([view isKindOfClass:[UITableView class]]) {
            tableView = (UITableView*) view;
        }
    }
    if(tableView) {
        //wire delegate and datasource via code
        tableView.delegate = self;
        tableView.dataSource = self;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Segue Transitions

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Transitioning to %@", [[segue destinationViewController] class]);
    if([segue.identifier isEqualToString: @"showRecipeDetail"]) {
        RecipieDetailViewController *recipieDetailCtrlr = (RecipieDetailViewController *)[segue destinationViewController];
        NSIndexPath *selectedIndex = [self.tableView indexPathForSelectedRow];
        if(selectedIndex) {
            recipieDetailCtrlr.recipieDescription = [recipieNames objectAtIndex:selectedIndex.row];
        }
    }
}

#pragma mark Recipie-Table DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return recipieNames.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Recipies";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* tableCellId = @"RecipieCell";
//    static BOOL isFirst = YES;
//    if(isFirst) {
//        NSLog(@"%s: [%@]", __PRETTY_FUNCTION__, [NSThread callStackSymbols]);
//        isFirst = NO;
//    }
    UITableViewCell *currentCell  = [tableView dequeueReusableCellWithIdentifier:tableCellId];
    if(currentCell == nil) {
        currentCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableCellId];
    }
    currentCell.textLabel.text = [recipieNames objectAtIndex:indexPath.row];
    return currentCell;
}

#pragma mark Recipie-Table DataDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
