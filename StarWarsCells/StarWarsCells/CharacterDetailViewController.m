//
//  CharacterDetailViewController.m
//  StarWarsCells
//
//  Created by Steve Graff on 5/4/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

/*
 NOTES: Set inputString to an NSString. May be much easier to use NSArray instead.
*/

#import "CharacterDetailViewController.h"

@interface CharacterDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *characterNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *characterDescriptionTextView;
@property (weak, nonatomic) IBOutlet UIImageView *characterImage;

-(void)configureView;

@end

@implementation CharacterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Managing the Character Detail View

-(void)setCharacter:(Character *)newCharacter {
    
    if(_character != newCharacter) {  // _character is equiv to self.character
        _character = newCharacter;  // Use _character here. Using self.character causes problems
        
        // Update the view
        [self configureView];
        
    }
}

-(void)configureView {
    if (self.character) {
        
        // Extract Character name and set detail view title
        self.title = self.character.characterName;
        
        // Set the contents of labels in the Character Detail View
        self.characterNameLabel.text = self.character.characterName;
        self.characterDescriptionTextView.text  = self.character.characterDescription;
        
        // Set the contents of the image in Character Detail View
        self.characterImage.image = [UIImage imageNamed:self.character.characterImageName];
    }
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
