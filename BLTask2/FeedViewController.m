//
//  FeedViewController.m
//  BLTask2
//
//  Created by Kamil Zietek on 17.03.2014.
//  Copyright (c) 2014 Kamil Zietek. All rights reserved.
//

#import "FeedViewController.h"
#import "UIFeedCell.h"

@interface FeedViewController () {
	NSMutableArray *_apps;
	NSMutableArray *_appsFiltered;
}

@end

@implementation FeedViewController

#pragma mark - JSON handling

- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error] retain];
	NSArray *entry = json[@"feed"][@"entry"];
	
	for (NSDictionary *d in entry) {
		_apps[[entry indexOfObject:d]] = @{
				  @"name":[d[@"im:name"][@"label"] copy],
				  @"image":[d[@"im:image"][0][@"label"]copy]
				  };
	}
	[self.tableView reloadData];
	[self.refreshControl endRefreshing];
}

- (void)refreshTable
{
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [[NSData dataWithContentsOfURL:
						 [NSURL URLWithString:@"https://itunes.apple.com/us/rss/toppaidapplications/limit=100/json"]] retain];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
		[data release];
    });
}

#pragma mark - Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [_appsFiltered removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[c] '%@'",searchText];
    _appsFiltered = [NSMutableArray arrayWithArray:[_apps filteredArrayUsingPredicate:predicate]];
	[predicate release];
	NSLog(@"%@",_appsFiltered);
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString scope:nil];
//     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:nil];
//     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

#pragma mark - Inherited methods

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _apps = [[NSMutableArray alloc] initWithCapacity:100];
		_appsFiltered = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	self.title = @"Top 100";
	[self.tableView registerClass:[UIFeedCell class] forCellReuseIdentifier:@"Cell"];
	
	UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
	self.refreshControl = refreshControl;
	[refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
	[refreshControl release];
	
	UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,70,320,44)];
	[self.tableView setTableHeaderView:searchBar];
	UISearchDisplayController *searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
	searchDisplayController.delegate = self;
	[searchBar release];
	
	[self refreshTable];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	UIView *searchBar = self.tableView.tableHeaderView;
	CGRect newBounds = self.tableView.bounds;
    newBounds.origin.y = newBounds.origin.y + searchBar.bounds.size.height;
    self.tableView.bounds = newBounds;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
	[super dealloc];
	[_apps release];
	[_appsFiltered release];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	int count = _apps.count;
	if (tableView == self.searchDisplayController.searchResultsTableView) {
		count = _appsFiltered.count;
	}
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 53 + 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UIFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	
	if (tableView == self.searchDisplayController.searchResultsTableView) {
		cell.labelPosition.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
		cell.labelName.text = _appsFiltered[indexPath.row][@"name"];
		cell.urlString = _appsFiltered[indexPath.row][@"image"];
	}
	else {
		cell.labelPosition.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
		cell.labelName.text = _apps[indexPath.row][@"name"];
		cell.urlString = _apps[indexPath.row][@"image"];
	}
	
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
