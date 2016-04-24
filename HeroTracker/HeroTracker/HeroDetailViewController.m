//
//  HeroDetailViewController.m
//  HeroTracker
//
//  Created by Steve Graff on 4/21/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "HeroDetailViewController.h"

@interface HeroDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *heroNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *heroRealNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *heroPowersLabel;


// What is this? What does it do?
- (void)configureView;


@end

@implementation HeroDetailViewController

#pragma mark - Managing the Hero Detail View

- (void)setHero:(Hero *)newHero {
    if (_hero != newHero) {  // _hero is equivalent to self.hero
        _hero = newHero;  // Use _hero. Using self.hero will cause infinite loop
        
        // Update the view
        [self configureView];
    }
}

- (void)configureView {
    if (self.hero) {
        self.title = [NSString stringWithFormat:@"Hero %@", [self.hero.heroName componentsSeparatedByString:@" "][1]];
        
        // Set contents of labels in the Hero Detail View
        self.heroNameLabel.text = self.hero.heroName;
        self.heroRealNameLabel.text = self.hero.heroRealName;
        self.heroPowersLabel.text = self.hero.heroPowers;
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureView];
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
