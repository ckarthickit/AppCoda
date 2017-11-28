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
    if(self.device) {
        self.name.text = [self.device valueForKey:@"name"];
        self.version.text = [self.device valueForKey:@"version"];
        self.company.text = [self.device valueForKey:@"company"];
    }
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
    if(self.device) {
        [self.device setValue:self.name.text forKey:@"name"];
        [self.device setValue:self.version.text forKey:@"version"];
        [self.device setValue:self.company.text forKey:@"company"];
    }else {
        NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:context];
        [newDevice setValue:self.name.text forKey:@"name"];
        [newDevice setValue:self.version.text forKey:@"version"];
        [newDevice setValue:self.company.text forKey:@"company"];
    }
    NSError *error;
    if([context hasChanges] && ![context save:&error]) {
        NSLog(@"Save Failed: %@", [error debugDescription]);
    }else {
        NSLog(@"Save Success");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
