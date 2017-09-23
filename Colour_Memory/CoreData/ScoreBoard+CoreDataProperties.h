//
//  ScoreBoard+CoreDataProperties.h
//  Colour_Memory
//
//  Created by akshay bansal on 2/16/17.
//  Copyright © 2017 akshay bansal. All rights reserved.
//

#import "ScoreBoard.h"


NS_ASSUME_NONNULL_BEGIN

@interface ScoreBoard (CoreDataProperties)

+ (NSFetchRequest<ScoreBoard *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *score;

@end

NS_ASSUME_NONNULL_END
