//
//  ScoreBoard+CoreDataProperties.m
//  Colour_Memory
//
//  Created by akshay bansal on 2/16/17.
//  Copyright © 2017 akshay bansal. All rights reserved.
//

#import "ScoreBoard+CoreDataProperties.h"

@implementation ScoreBoard (CoreDataProperties)

+ (NSFetchRequest<ScoreBoard *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ScoreBoard"];
}

@dynamic name;
@dynamic score;

@end
