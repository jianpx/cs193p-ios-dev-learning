//
//  CardMatchingGame.h
//  Assignment1_Matchismo
//
//  Created by jianpx on 3/26/13.
//  Copyright (c) 2013 PS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly) int score;
@property (nonatomic, strong) NSMutableArray *matchCards;

@property (nonatomic) NSUInteger matchCardNum;
@property (nonatomic, strong) NSString *output;

- (Card *) cardAtIndex: (NSUInteger) index;
- (void) flipCardAtIndex: (NSUInteger) index;
- (id) initWithCount: (NSUInteger) cardCount
           usingDeck: (Deck *) deck
        matchCardNum: (NSUInteger) matchCardNum;
@end
