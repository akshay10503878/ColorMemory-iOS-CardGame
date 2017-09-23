//
//  HighScoreViewController.m
//  Colour_Memory
//
//  Created by akshay bansal on 2/16/17.
//  Copyright © 2017 akshay bansal. All rights reserved.
//

#import "HighScoreViewController.h"
#import "HighScoreTableViewCell.h"
#import "ScoreBoard+CoreDataProperties.h"
#import "AppDelegate.h"

@interface HighScoreViewController ()

@end

@implementation HighScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.highScoreData=[[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context = delegate.persistentContainer.viewContext;
    return context;
}

- (IBAction)BackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    
    }];
}

-(void)viewDidAppear:(BOOL)animated{

    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ScoreBoard"];
    
    NSSortDescriptor *sdic=[NSSortDescriptor sortDescriptorWithKey:@"score"
                                                         ascending:YES];
    fetchRequest.sortDescriptors=[NSArray arrayWithObject:sdic];
   
    
    self.highScoreData = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.HightScoreTableView reloadData];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

      return self.highScoreData.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HighScoreTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"HighScoreCell"];
    if (cell==NULL) {
        cell=[[HighScoreTableViewCell alloc] init];
    }
    
    ScoreBoard *data=[self.highScoreData objectAtIndex:indexPath.row];

    cell.name.text=data.name;
    cell.rank.text=@"1";
    cell.score.text=data.score;
    cell.rank.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
    return cell;

}
@end
