//
//  DeviceViewController.m
//  4_MyStore
//
//  Created by Karthick C on 27/11/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "DeviceViewController.h"
#import "DeviceDetailViewController.h"
#import "AppDelegate.h"

@interface DeviceViewController ()
@property (nonatomic,strong) NSMutableArray <NSManagedObject *> *devices;
@end

@implementation DeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Device"];
#if 0
    [fetchRequest setReturnsObjectsAsFaults:NO];
#endif
    NSError *error;
    self.devices = [[context executeFetchRequest:fetchRequest error:&error] mutableCopy];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma CoreData

- (NSManagedObjectContext *) managedObjectContext {
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    NSPersistentContainer *container = [appDelegate persistentContainer];
    return container.viewContext;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.devices.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeviceCell" forIndexPath:indexPath];
    NSManagedObject *device = [self.devices objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",[device valueForKey:@"name"],[device valueForKey:@"version"]];
    cell.detailTextLabel.text = [device valueForKey:@"company"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteDeviceForIndexPath:indexPath];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    
    }   
}

- (void) deleteDeviceForIndexPath: (NSIndexPath *)indexPath {
    [[self managedObjectContext] deleteObject:[self.devices objectAtIndex:indexPath.row]];
    NSError *error;
    if(![[self managedObjectContext] save:&error]){
        NSLog(@"Delete Failed : %@", [error debugDescription]);
    }else {
        NSLog(@"Delete Success");
    }
    [self.devices removeObjectAtIndex:indexPath.row];
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"DeviceUpdate"]){
        DeviceDetailViewController *detailViewController = (DeviceDetailViewController *)segue.destinationViewController;
        NSIndexPath *selectedIndexPath =[self.tableView indexPathForSelectedRow];
        [self.tableView deselectRowAtIndexPath:selectedIndexPath animated:NO];
        detailViewController.device = [self.devices objectAtIndex:selectedIndexPath.row];
    }
}


@end
