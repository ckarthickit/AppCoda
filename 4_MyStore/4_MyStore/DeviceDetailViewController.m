//
//  DeviceDetailViewController.m
//  4_MyStore
//
//  Created by Karthick C on 27/11/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "DeviceDetailViewController.h"
#import "AppDelegate.h"

@interface DeviceDetailViewController ()
@property (nonatomic,weak) IBOutlet UITextField *name;
@property (nonatomic,weak) IBOutlet UITextField *version;
@property (nonatomic,weak) IBOutlet UITextField *company;
@end

@implementation DeviceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectContext *) managedObjectContext {
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    NSPersistentContainer *container = [appDelegate persistentContainer];
    return container.viewContext;
}

#pragma  mark - IBActions

-(IBAction) cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction) save:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:context];
    [newDevice setValue:self.name.text forKey:@"name"];
    [newDevice setValue:self.version.text forKey:@"version"];
    [newDevice setValue:self.company.text forKey:@"company"];
    NSError *error;
    if([context hasChanges] && ![context save:&error]) {
        NSLog(@"Save Failed: %@", [error debugDescription]);
    }else {
        NSLog(@"Save Success");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
