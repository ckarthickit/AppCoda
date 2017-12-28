//
//  StoriesMasterViewController.m
//  RSSReader
//
//  Created by Karthick C on 21/12/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "StoriesMasterViewController.h"
#import "StoryItem.h"
static NSString * const APPLE_HOT_NEWS_URL = @"http://images.apple.com/main/rss/hotnews/hotnews.rss";
static NSString * const RSS_TAG = @"rss";
static NSString * const STORY_TAG_ITEM = @"item";
static NSString * const STORY_TAG_ITEM_TITLE = @"title";
static NSString * const STORY_TAG_ITEM_LINK = @"link";
static NSString * const STORY_TAG_ITEM_DESC = @"description";
static NSString * const SEGUE_ID_STORY_DEATIL = @"StoryDetail";
@interface StoriesMasterViewController () <NSXMLParserDelegate>{
    NSXMLParser *_storiesParser;
    NSMutableArray<StoryItem *> *_feeds;
    
    NSString *_currentTag;
    NSMutableString *_currentTitle;
    NSMutableString *_currentLink;
    NSMutableString *_currentDesc;
}
//@property (nonatomic,weak) IBOutlet UITableView *tableView;
@end

@implementation StoriesMasterViewController
//@dynamic tableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    _storiesParser = [[NSXMLParser alloc] initWithContentsOfURL: [[NSURL alloc] initWithString:APPLE_HOT_NEWS_URL]];
    [_storiesParser setDelegate:self];
    [_storiesParser setShouldResolveExternalEntities:NO];
    [_storiesParser parse];
}

#pragma  mark - XML Parser Delegate

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    _currentTag = elementName;
    if([STORY_TAG_ITEM isEqualToString:elementName]) {
        _currentTitle = [[NSMutableString alloc] init];
        _currentLink = [[NSMutableString alloc] init];
        _currentDesc = [[NSMutableString alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if([STORY_TAG_ITEM_TITLE isEqualToString:_currentTag]) {
        [_currentTitle appendString:string];
    }else if([STORY_TAG_ITEM_LINK isEqualToString:_currentTag]) {
        [_currentLink appendString:string];
    }else if([STORY_TAG_ITEM_DESC isEqualToString:_currentTag]) {
        [_currentDesc appendString:string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if([STORY_TAG_ITEM isEqualToString:elementName]) {
        StoryItem *story = [[StoryItem alloc] initWithTitle:[_currentTitle copy] link:[_currentLink copy] description:[_currentDesc copy]];
        if(_feeds == nil) {
            _feeds = [[NSMutableArray alloc] init];
        }
        [_feeds addObject: story];
    }
    _currentTag = nil;
    NSLog(@"%@",[NSThread currentThread]);
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    [self.tableView reloadData];
}

#pragma mark - Table View Adapter
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_feeds count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MasterCell" forIndexPath:indexPath];
    StoryItem *storyItem = [_feeds objectAtIndex:indexPath.row];
    cell.textLabel.text = storyItem.title;
    return cell;
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([SEGUE_ID_STORY_DEATIL isEqualToString:segue.identifier]) {
        UIViewController *dstn =  segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        StoryItem *storyItem = [_feeds objectAtIndex:indexPath.row];
        [dstn setValue:storyItem.link forKey:@"url"];
    }
}
@end
