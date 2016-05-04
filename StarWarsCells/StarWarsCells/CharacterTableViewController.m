//
//  CharacterTableViewController.m
//  StarWarsCells
//
//  Created by Steve Graff on 5/4/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "CharacterTableViewController.h"
#import "CharacterDetailViewController.h"
#import "Character.h"

@interface CharacterTableViewController ()

// characters is a mutable array of dictionaries
@property NSMutableArray *characters;



@end

@implementation CharacterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the title for the Table View Controller
    [self setTitle:@"Force Awakens Characters"];
    
    // Initialize the characters array
    self.characters = [[NSMutableArray alloc]init];
    
    // Load the characters into the TableView
    [self loadCharacters];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Segues

// Call when executing segue on our View Controller
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Set the segue identifier, characterDetailSegue
    if ( [[segue identifier] isEqualToString:@"characterDetailSegue"]) {
        // Get index path to selected row
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        // Use row property from indexPath to get Character from array
        Character *selectedCharacter = [self.characters objectAtIndex:indexPath.row];
        
        CharacterDetailViewController *myDetailViewController = [segue destinationViewController];
        
        myDetailViewController.character = selectedCharacter;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSLog(@"Number of characters: %ld", self.characters.count);
    return [self.characters count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CharacterCell" forIndexPath:indexPath];
    
    // Create a Character object
    Character *aCharacter = [self.characters objectAtIndex:indexPath.row];
    
    // Set label text for the character
    cell.textLabel.text = aCharacter.characterName;
    cell.detailTextLabel.text = aCharacter.characterDescription;
    
    // Set image for the character
    cell.imageView.layer.cornerRadius = 10;
    cell.imageView.clipsToBounds = YES;
    
    cell.imageView.layer.borderWidth=4;
    cell.imageView.layer.borderColor=[[UIColor blackColor]CGColor];
    
    cell.imageView.image = [UIImage imageNamed:aCharacter.characterImageName];
    
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Store selected character
    Character *selectedCharacter = [self.characters objectAtIndex: indexPath.row];
    
    [self performSegueWithIdentifier:@"characterDetailSegue" sender:selectedCharacter];
    
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


-(void)loadCharacters {
    // Create string with filepath to the Characters.json file
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ForceAwakensCharacters" ofType:@"json"];
    
    // Load json file into memory as array of dictionaries
    // How to check for errors loading file?
    NSArray *characters = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingAllowFragments error:nil];
    
    // Iterate over the array and create Hero objects
    for (NSDictionary* aCharacterDictionary in characters) {
        [self.characters addObject:[Character characterWithDictionary:aCharacterDictionary]];
    }
    
    // Sort the characters array of dictionaries by the key name 'characterName'
    [self.characters sortUsingDescriptors:[NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"characterName" ascending:YES], nil]];
    
    [self.tableView reloadData];
    
    
    
}

@end
