//
//  HeroTableTableViewController.m
//  HeroTracker
//
//  Created by Steve Graff on 4/21/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "HeroTableTableViewController.h"
#import "HeroDetailViewController.h"
#import "Hero.h"

@interface HeroTableTableViewController ()

// heroes is a mutable array of dictionaries, contains hero name as key, hero object as value
@property NSMutableArray *heroes;


@end

@implementation HeroTableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Set title for Table View Controller
    [self setTitle:@"S.H.I.E.L.D. Hero Tracker"];
    
    // Initialize the heros array as NSMutableArray
    self.heroes = [[NSMutableArray alloc]init];
    
    // Load the heroes into the TableView
    [self loadHeroes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Segues



// Called when executing segue on our View Controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    // Set the segue identifier, HeroDetailSegue
    if ([[segue identifier] isEqualToString:@"HeroCell"])
    {
        // Get an NSIndexPath for the selected cell
        UITableViewCell *selectedCell = (UITableViewCell *)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:selectedCell];
        
        // Use row property of IndexPath above to get associated Hero object from heroes array
        Hero *selectedHero = self.heroes[indexPath.row];
        
        // Send the above Hero object to the Hero detail view controller
        HeroDetailViewController *heroDetailView = [segue destinationViewController];
        [heroDetailView setHero:selectedHero];
        
        // Reset selected hero back to nil
        selectedHero = nil;
        
    }
}



#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"Number of heroes: %ld", self.heroes.count);
    return [self.heroes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"heroCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Hero * aHero = [self.heroes objectAtIndex: indexPath.row];
    cell.textLabel.text = aHero.heroName;
    cell.detailTextLabel.text = aHero.heroRealName;

    
    return cell;
}


/*
     Thoughts on how to perform segue to detail view controller:
 
     Grab current cell and store it in a property
     Call [self performSegueWithIdentifier:@“IdentifierNameHere” sender:self];
     
    In prepareForSegue pass stored property for current cell to destination view controller,
     set property back to nil
 // Reset selected hero back to nil
 // selectedHero = nil;
     Hint - to create segue ctrl-drag from the view controller to the detail view
 
    Agent *anAgent = [self.agents objectAtIndex: indexPath.row];

*/
 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Store selected hero
    Hero *selectedHero = [self.heroes objectAtIndex: indexPath.row];
    
    [self performSegueWithIdentifier:@"HeroDetailSegue" sender:selectedHero];
    
    // [tableView deselectRowAtIndexPath:selectedHero animated:NO];
//    HeroTableTableViewController *heroesController = [[HeroTableTableViewController alloc] initWithStyle:UITableViewStylePlain];
//    heroesController.selectedRegion = [regions objectAtIndex:indexPath.row];
//    [[self navigationController] pushViewController:heroesController animated:YES];
    
    


}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// Load heroes.json file, create dictionary objects and put into array, sort it
-(void)loadHeroes{
    // Create string with filepath to the heroes.json file
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"heroes" ofType:@"json"];
    
    // Load json file into memory as array of dictionaries
    // How to check for errors loading file?
    NSArray *heroes = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingAllowFragments error:nil];
    
    // Iterate over the array and create Hero objects
    for (NSDictionary* aHeroDictionary in heroes) {
        [self.heroes addObject:[Hero heroWithDictionary:aHeroDictionary]];
    }
    
    // Sort the heros array of dictionaries by the key name 'heroName'
    // How to perform case insensitive search?
    [self.heroes sortUsingDescriptors:[NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"heroName" ascending:YES], nil]];
    
    [self.tableView reloadData];
}
    
    
 @end