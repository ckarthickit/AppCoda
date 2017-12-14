//
//  RecipieCollectionViewController.m
//  5_RecipieCollection
//
//  Created by Karthick C on 30/11/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "RecipieCollectionViewController.h"
#import "Recipie.h"

@interface RecipieCollectionViewController () <UICollectionViewDelegate,UICollectionViewDataSource> {
    NSArray <NSArray *>*recipieSections;
}
@end

@implementation RecipieCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.collectionView.backgroundColor = [UIColor blackColor];
    NSString *recipiePlistPath = [[NSBundle mainBundle] pathForResource:@"Recipies" ofType:@"plist"];
    NSLog(@"recipiePlist_path : %@",recipiePlistPath);
    NSDictionary *recipiesInfo = [NSDictionary dictionaryWithContentsOfFile:recipiePlistPath];
    NSArray *recipieNames = [recipiesInfo objectForKey:@"RecipeName"];
    NSArray *recipieThumbnails = [recipiesInfo objectForKey:@"RecipieThumbnail"];
    NSMutableArray <Recipie *> *section1, *section2;
    for(int i=0; i < recipieNames.count; i++) {
        if(i < recipieNames.count/2) {
            if(section1 == nil) {
                section1 = [NSMutableArray array];
            }
            [section1 addObject:[[Recipie alloc] initWithName:[recipieNames objectAtIndex:i] thumbnail:[recipieThumbnails objectAtIndex:i]]];
        }else {
            if(section2 == nil) {
                section2 = [NSMutableArray array];
            }
            [section2 addObject:[[Recipie alloc] initWithName:[recipieNames objectAtIndex:i] thumbnail:[recipieThumbnails objectAtIndex:i]]];
        }
    }
    recipieSections = [NSArray arrayWithObjects:section1, section2, nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Data Source

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [recipieSections count];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return recipieSections[section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecipieCell" forIndexPath:indexPath];
    //cell.contentView.backgroundColor = [UIColor yellowColor];
    UIImageView *cellImage = (UIImageView *) [cell viewWithTag:100];
    Recipie *recipie = recipieSections[indexPath.section][indexPath.row];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:recipie.thumbnail ofType:@""];
    NSLog(@"imagePath = %@", imagePath);
    cellImage.image = [UIImage imageWithContentsOfFile: imagePath];
    UIImageView *photoFrame = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo-frame"]];
    [photoFrame setContentMode:UIViewContentModeScaleToFill];
    cell.backgroundView = photoFrame;
    return cell;
}

#define LEFT_RIGHT_INSET 5.0f
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat picDimension = self.view.frame.size.width / 4.0f;
    return CGSizeMake(picDimension - (2*LEFT_RIGHT_INSET), picDimension);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //CGFloat leftRightInset = self.view.frame.size.width / 14.0f;
    UIEdgeInsets inset = {
        .left = LEFT_RIGHT_INSET,
        .right = LEFT_RIGHT_INSET,
        .top =0,
        .bottom =0
    };
    //return UIEdgeInsetsMake(0, 0, 0, 0);
    return inset;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 10.f);
}

@end



