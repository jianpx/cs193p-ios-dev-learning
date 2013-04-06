//
//  CardMatchingGame.m
//  Assignment1_Matchismo
//
//  Created by jianpx on 3/26/13.
//  Copyright (c) 2013 PS. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Deck.h"

@interface CardMatchingGame()

@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, readwrite) int score;

@end

@implementation CardMatchingGame

- (NSString *)output
{
    //init as null string
    if (!_output) _output = @"";
    return _output;
}

- (NSMutableArray *)matchCards
{
    if (!_matchCards) _matchCards = [[NSMutableArray alloc] init];
    return _matchCards;
}
//lazy initialization
- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id)initWithCount: (NSUInteger) cardCount
          usingDeck: (Deck *)deck
       matchCardNum:(NSUInteger)matchCardNum
{
    self = [super init];
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                //[self.cards insertObject:card atIndex:i];
                self.cards[i] = card;
            }
        }
        self.matchCardNum = matchCardNum;
    }
    return self;
}

#define MATCH_BONUS 4
#define FLIP_COST 1
#define MISMATCH_PENALTY 2

- (Card *)cardAtIndex: (NSUInteger) index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (NSString *)combineFlipsTip: (NSArray *)cardContents
{
    NSString *tips = @"";
    if (cardContents) {
        tips = [cardContents componentsJoinedByString:@" & "];
    }
    return tips;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card) return;
    if (card.isUnplayable) return;
    NSMutableArray *checkCards = [[NSMutableArray alloc] init];
    if (!card.isFaceup) {
        for (Card *otherCard in self.cards) {
            if (otherCard.isFaceup && !otherCard.isUnplayable && [self.cards indexOfObject:otherCard] != index) {
                [checkCards addObject:otherCard];
                if ([checkCards count] == (self.matchCardNum - 1)) break;
            }
        }
        if ([checkCards count] >= (self.matchCardNum - 1)) {
            NSMutableArray *cardContents = [[NSMutableArray alloc] initWithObjects:card.contents, nil];
            for (Card *checkCard in checkCards) {
                [cardContents addObject:checkCard.contents];
            }
            self.output = [self combineFlipsTip:cardContents];
            
            int matchScore = [card match:checkCards];
            if (matchScore) {
                card.unplayable = YES;
                self.score += matchScore * MATCH_BONUS;
                self.output = [self.output stringByAppendingFormat:@" Match, get Score:%d", matchScore * MATCH_BONUS];
                for (Card *checkCard in checkCards) {
                    checkCard.unplayable = YES;
                }
                NSMutableArray *matchCardIndexes = [[NSMutableArray alloc] init];
                [matchCardIndexes addObject:[NSNumber numberWithUnsignedInt:index]];
                for (Card *checkCard in checkCards) {
                    [matchCardIndexes addObject:[NSNumber numberWithUnsignedInt:[self.cards indexOfObject:checkCard]]];
                }
                [self.matchCards addObject:matchCardIndexes];
                
            } else {
                self.score -= MISMATCH_PENALTY;
                self.output = [self.output stringByAppendingFormat:@" Mismatch, penalty:-%d", MISMATCH_PENALTY];
                for (Card *checkCard in checkCards) {
                    checkCard.faceUp = NO;
                }
            }
        }
        self.score -= FLIP_COST;
    }
    card.faceUp = !card.faceUp;
}

@end
