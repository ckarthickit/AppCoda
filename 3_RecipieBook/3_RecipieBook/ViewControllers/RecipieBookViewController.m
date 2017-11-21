//
//  ViewController.m
//  3_RecipieBook
//
//  Created by Karthick C on 20/11/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "RecipieBookViewController.h"
#import "RecipieDetailViewController.h"
#import "Recipie.h"
#define GET_RESOURCE(X,Y) [[NSBundle mainBundle] pathForResource:@#X ofType:@#Y]
static const NSString* RECIPIE_NAME_KEY = @"RecipeName";
static const NSString* RECIPIE_THUMBNAIL_KEY = @"RecipieThumbnail";
static const NSString* RECIPIE_PREP_TIME_KEY = @"RecipiePrepTime";
static const NSString* RECIPIE_INGREDIENTS_KEY = @"RecipieIngredients";
@interface RecipieBookViewController (){
    NSMutableArray<Recipie *> *recipies;
    NSArray<Recipie *> *searchRecipieNamesResult;
    NSIndexPath *searchResultSelectedIndexPath;
}
@property (nonatomic,weak) IBOutlet UITableView *tableView;
@end

@implementation RecipieBookViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Recipies.plist loc= %@",GET_RESOURCE(Recipies,plist));
    NSDictionary *recipieBook = [NSDictionary dictionaryWithContentsOfFile:GET_RESOURCE(Recipies,plist)];
    
    if(recipieBook) {
        recipies = [[NSMutableArray alloc] init];
        NSArray *recipieNames = [recipieBook objectForKey:RECIPIE_NAME_KEY];
        NSArray *recipieImages = [recipieBook objectForKey:RECIPIE_THUMBNAIL_KEY];
        NSArray *recipiePrepTimes = [recipieBook objectForKey:RECIPIE_PREP_TIME_KEY];
        NSArray *recipieIngredients = [recipieBook objectForKey:RECIPIE_INGREDIENTS_KEY];
        for(int i=0; i < recipieNames.count; i++) {
            Recipie *recipie =[[Recipie alloc] init];
            recipie.name = recipieNames[i];
            recipie.imageFile = recipieImages[i];
            recipie.prepTime = recipiePrepTimes[i];
            recipie.ingredients = recipieIngredients[i];
            [recipies addObject: recipie];
        }
    }
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
        if(sender == self.searchDisplayController.searchResultsTableView) {
            if(searchResultSelectedIndexPath) {
                recipieDetailCtrlr.recipie = [searchRecipieNamesResult objectAtIndex:searchResultSelectedIndexPath.row];
            }
        }else {
            NSIndexPath *selectedIndex = [self.tableView indexPathForSelectedRow];
            if(selectedIndex) {
                recipieDetailCtrlr.recipie = [recipies objectAtIndex:selectedIndex.row];
            }
        }
    }
}

#pragma mark Recipie-Table DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchRecipieNamesResult count];
    }else {
        return recipies.count;
    }
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
    Recipie *recipie;
    if(tableView == self.searchDisplayController.searchResultsTableView) {
        recipie = [searchRecipieNamesResult objectAtIndex:indexPath.row];
        currentCell.textLabel.text = recipie.name;
        currentCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else {
        recipie = [recipies objectAtIndex:indexPath.row];
        currentCell.textLabel.text = recipie.name;
    }
    return currentCell;
}

#pragma mark Recipie-Table DataDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(tableView == self.searchDisplayController.searchResultsTableView) {
        searchResultSelectedIndexPath = indexPath;
        [self performSegueWithIdentifier:@"showRecipeDetail" sender:tableView];
    }
}

#pragma mark Search-Display Delegate

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterSeachResultsForString:searchString];
    return YES;
}

#pragma mark Search-Filter
-(void) filterSeachResultsForString: (NSString *) searchString {
#if 0
    NSPredicate *searchQuery = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",searchString];
#else
    NSPredicate *searchQuery = [NSPredicate predicateWithFormat:@"name contains[cd] %@",searchString];
#endif
    self->searchRecipieNamesResult = [recipies filteredArrayUsingPredicate:searchQuery];
}

@end
