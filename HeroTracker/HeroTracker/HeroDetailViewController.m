//
//  HeroDetailViewController.m
//  HeroTracker
//
//  Created by Steve Graff on 4/21/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "HeroDetailViewController.h"

#import "CBPDefines.h"  // Contains Marvel API keys
#import "MDAMarvelAPIClient.h" // Allows us to set API keys

#import "NSURLSessionDataTask+MarvelDeveloperAPI.h" // Provides new methods to get Marvel data

#import "MDASearchParameters.h"  //
#import "MDACharacterDataContainer.h"  // Container for returned Marvel character


@interface HeroDetailViewController()

@property (weak, nonatomic) IBOutlet UILabel *heroNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *heroRealNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *heroPowersLabel;

@property MDAComic *comic;
@property MDADataContainer *dataContainer;

- (void)configureView;


@end



@implementation HeroDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
    
}



#pragma mark - Managing the Hero Detail View

- (void)setHero:(Hero *)newHero {
    if (_hero != newHero) {  // _hero is equivalent to self.hero
        _hero = newHero;  // Use _hero. Using self.hero will cause infinite loop
        
        // Update the view
        // [self configureView];
    }
}

- (void)configureView {
    if (self.hero) {
        
        // Extract Hero name and set detail view title
        self.title = [NSString stringWithFormat:@"%@", [self.hero.heroName componentsSeparatedByString:@" "][0]];
        
        // Set contents of labels in the Hero Detail View
        self.heroNameLabel.text = self.hero.heroName;
        self.heroRealNameLabel.text = self.hero.heroRealName;
        self.heroPowersLabel.text = self.hero.heroPowers;
        
        
        // New code from 5/11 using Marvel API
        // This should go into configureView
        
        if (self.hero) {
            self.heroPowersLabel.text = [self.hero description];
            
            if (!self.dataContainer) {
                [self lookUpHero];
            } else {
                self.heroPowersLabel.text = [self.dataContainer.results description];
            }
        }
    }
}


- (void)lookUpHero {
    __block typeof(self) blockSelf = self;
    
    NSInteger comicID = 48564;
    
    [[MDAMarvelAPIClient sharedClient] publicKey:CBPMarvelAPIPublicKey privateKey:CBPMarvelAPIPrivateKey];
    
    MDASearchParameters *search = [[MDASearchParameters alloc]init];
    search.nameStartsWith = @"black";
    
    [NSURLSessionDataTask fetchCharactersWithSearch:search withBlock:^(MDACharacterDataContainer *data, NSError *error) {
        
        blockSelf.dataContainer = data; // save the returned data
        
        NSLog(@"%@", [data.results description]);  // prints the returned data
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [blockSelf configureView];
        });
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
