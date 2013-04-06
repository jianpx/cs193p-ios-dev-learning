//
//  Deck.h
//  Matchismo
//
//  Created by jianpx on 3/19/13.
//  Copyright (c) 2013 PS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
- (void)addCard: (Card *)card atTop:(BOOL) atTop;
- (Card *) drawRandomCard;
- (NSMutableArray *) getCards;
@end
