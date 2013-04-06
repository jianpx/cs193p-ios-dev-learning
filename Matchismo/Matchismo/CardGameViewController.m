//
//  CardGameViewController.m
//  Matchismo
//
//  Created by jianpx on 3/19/13.
//  Copyright (c) 2013 PS. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"


@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic, strong) PlayingCardDeck *playingCardDeck;
@end

@implementation CardGameViewController

+ (NSDictionary *)suitBackgroundColorSettings
{
    UIColor *red = [UIColor redColor];
    UIColor *black = [UIColor colorWithWhite:1.0 alpha:0.2];
    return [NSDictionary dictionaryWithObjectsAndKeys:red,@"♥",red,@"♦",black,@"♠",black,@"♣", nil];
}

- (PlayingCardDeck *)playingCardDeck
{
    if (!_playingCardDeck) {
        _playingCardDeck = [[PlayingCardDeck alloc] init];
    }
    return _playingCardDeck;
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}
- (IBAction)flipCard:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (self.flipCount < self.playingCardDeck.getCards.count) {
        PlayingCard * card = self.playingCardDeck.getCards[self.flipCount];
        [sender setTitle:card.contents forState:UIControlStateNormal];
        self.flipCount ++;
        NSDictionary *suitBackgroundColorSettings = [CardGameViewController suitBackgroundColorSettings];
        self.view.backgroundColor = [suitBackgroundColorSettings objectForKey:card.suit];
    }
    
}

@end
