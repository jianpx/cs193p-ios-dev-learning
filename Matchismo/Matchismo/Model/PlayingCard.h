//
//  PlayingCard.h
//  Matchismo
//
//  Created by jianpx on 3/19/13.
//  Copyright (c) 2013 PS. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
@property (nonatomic, strong) NSString *suit;
@property (nonatomic) NSUInteger rank;
+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
@end
