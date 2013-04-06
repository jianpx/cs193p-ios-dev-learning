//
//  CardGameViewController.m
//  Assignment1_Matchismo
//
//  Created by jianpx on 3/25/13.
//  Copyright (c) 2013 PS. All rights reserved.
//

//imported for round the corner of backgroundimage of button
#import <QuartzCore/QuartzCore.h>

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameResultLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameTypeSegControl;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) unsigned flipsCount;

@property (nonatomic, strong) CardMatchingGame *game;
//new added color container
@property (nonatomic, strong) NSMutableArray *matchColors;
@property (nonatomic, strong) NSString *gameResult;
@property (nonatomic, getter = isGameover) BOOL GameOver;

- (IBAction)switchGameType:(UISegmentedControl *)sender;
@end


@implementation CardGameViewController

- (BOOL)isGameOver
{
    return _GameOver;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSInteger clickedSegmentIndex = [self.gameTypeSegControl selectedSegmentIndex];
    if (clickedSegmentIndex >= 0) {
        NSString *type = [self.gameTypeSegControl titleForSegmentAtIndex:clickedSegmentIndex];
        self.gameResult = [NSString stringWithFormat:@"Current GameType:%@", type];
    }
    [self adjustSegControlHeight:self.gameTypeSegControl height:30];
}

- (void)setGameOver:(BOOL)GameOver
{
    _GameOver = GameOver;
    self.gameTypeSegControl.enabled = GameOver;
}

- (void)adjustSegControlHeight:(UISegmentedControl *)segControl height:(NSUInteger) height
{
    CGRect segFrame = [segControl frame];
    segFrame.size.height = height;
    segControl.frame = segFrame;
}

- (void)setGameResult:(NSString *)gameResult
{
    _gameResult = gameResult;
    self.gameResultLabel.text = gameResult;
}

+ (UIImage *)cardBackgroundImage
{
    //if image is png format , ".png" can be omitted.
    return [UIImage imageNamed:@"cardbuttonbg.png"];
}

- (NSMutableArray *)matchColors
{
    if (!_matchColors) {
        _matchColors = [NSMutableArray arrayWithObjects:[UIColor yellowColor], [UIColor greenColor], [UIColor darkGrayColor], [UIColor orangeColor], [UIColor redColor], [UIColor purpleColor], nil];
    }
    return _matchColors;
}

- (UIColor *)getOneMatchColor
{
    UIColor *color = [self.matchColors lastObject];
    if (color) [self.matchColors removeLastObject];
    return color;
}

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCount:self.cardButtons.count
                                              usingDeck:[[PlayingCardDeck alloc] init]
                                           matchCardNum:[self getMatchCardNum]];
    }
    return _game;
}


- (void)setFlipsCount:(unsigned int)flipsCount
{
    _flipsCount = flipsCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", flipsCount];
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    //set cardbutton background image
    //init cardbuttons backgroundimages
    for (UIButton *cardButton in _cardButtons) {
        [cardButton setBackgroundImage:[CardGameViewController cardBackgroundImage] forState:UIControlStateNormal];
        //round the corner of button with a rectangle image.
        //reference:http://stackoverflow.com/questions/5047818/how-to-round-the-corners-of-a-button
        cardButton.layer.cornerRadius = 8.0;
        cardButton.clipsToBounds = YES;
    }
    [self updateUI];
}

- (void)updateScoreLabel: (int) score
{
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", score];
}

- (void)updateMatchCardsColor
{
     NSArray *matchCardIndexes = [self.game.matchCards lastObject];
    if (matchCardIndexes) {
        UIColor *color = [self getOneMatchColor];
        for (NSNumber *matchCardIndex in matchCardIndexes) {
            NSUInteger index = [matchCardIndex integerValue];
            UIButton *matchCardButton = self.cardButtons[index];
            if (color) matchCardButton.backgroundColor = color;
        }
        [self.game.matchCards removeLastObject];
    }
}

- (void)updateUI
{
    for (int i=0; i < self.cardButtons.count; i++) {
        Card *card = [self.game cardAtIndex:i];
        UIButton *cardButton = self.cardButtons[i];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceup;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        //handle flipcard backgroundimage changes;
        UIImage *backgroundImage = (!cardButton.selected) ? [CardGameViewController cardBackgroundImage] : nil;
        [cardButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
        [self updateScoreLabel:self.game.score];
        [self updateMatchCardsColor];
    }
}

- (NSString *)getFlipTip: (Card *)card
{
    NSUInteger index = card.isFaceup ? 0 : 1;
    NSString *s = @[@"Up", @"Down"][index];
    return [NSString stringWithFormat:@"Flips %@ %@", s, card.contents];
}

- (IBAction)flipCard:(UIButton *)sender {
    self.GameOver = NO;
    NSUInteger index = [self.cardButtons indexOfObject:sender];
    [self.game flipCardAtIndex: index];
    self.flipsCount ++;
    Card *card = [self.game cardAtIndex:index];
    NSString *flipTip = [self getFlipTip:card];
    if (self.game.output) {
        self.gameResult = [flipTip stringByAppendingFormat:@" ,%@", self.game.output];
        self.game.output = @"";
    }
    [self updateUI];
}

- (void)resetCardButtons
{
     for (int i=0; i < self.cardButtons.count; i++) {
        Card *card = [self.game cardAtIndex:i];
        UIButton *cardButton = self.cardButtons[i];
        //cardbutton status update
        cardButton.selected = NO;
        cardButton.enabled = YES;
        cardButton.alpha = 1.0;
        //card status update
        card.faceUp = NO;
        card.unplayable = NO;
        UIImage *backgroundImage = (!cardButton.selected) ? [CardGameViewController cardBackgroundImage] : nil;
        [cardButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
        //set backgroundcolor to be original
        cardButton.backgroundColor = nil;
     }
}

- (void)resetGame
{
    self.GameOver = YES;
    self.flipsCount = 0;
    [self updateScoreLabel:0];
    self.game = [[CardMatchingGame alloc] initWithCount:self.cardButtons.count
                                          usingDeck:[[PlayingCardDeck alloc] init]
                                       matchCardNum:[self getMatchCardNum]];
    self.gameResult = @"";
    [self resetCardButtons];
}

//UIAlertView delegate must implement this method
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        //confirm
        case 1:
            [self resetGame];
            break;
        default:
            break;
    }
}

- (IBAction)restartGame:(UIButton *)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Confirm Deal"
                                                     message:@"Deal will clear all score, Sure?"
                                                    delegate:self
                                           cancelButtonTitle:@"Cancle"
                                           otherButtonTitles:@"OK", nil];
    [alertView show];
}

- (NSUInteger)getMatchCardNum
{
    NSInteger clickedSegmentIndex = [self.gameTypeSegControl selectedSegmentIndex];
    switch (clickedSegmentIndex) {
        case -1:
            return 2;
            break;
            
        case 0:
            return 2;
            break;
            
        case 1:
            return 3;
            break;
            
        default:
            return 2;
            break;
    }
}

- (IBAction)switchGameType:(UISegmentedControl *)sender {
    self.game.matchCardNum = [self getMatchCardNum];
    NSInteger clickedSegmentIndex = [self.gameTypeSegControl selectedSegmentIndex];
    NSString *type = [sender titleForSegmentAtIndex:clickedSegmentIndex];
    self.gameResult = [NSString stringWithFormat:@"Current GameType:%@", type];
}

@end