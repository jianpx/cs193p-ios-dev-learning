//
//  AttributedStringViewController.m
//  AttributedStringDemo
//
//  Created by jianpx on 4/2/13.
//  Copyright (c) 2013 PS. All rights reserved.
//

#import "AttributedStringViewController.h"

@interface AttributedStringViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *selectedWordLabel;
@property (weak, nonatomic) IBOutlet UIStepper *selectedWordSteper;

@end

@implementation AttributedStringViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateSelectedWord];
}

- (void)addLabelAttributes: (NSDictionary *)attributes range:(NSRange) range
{
    if (range.location == NSNotFound) return;
    NSMutableAttributedString *attributeString = [self.label.attributedText mutableCopy];
    [attributeString addAttributes:attributes range:range];
    self.label.attributedText = attributeString;
}

- (void)addSelectedWordAttributes: (NSDictionary *)attributes
{
    NSRange range = [[self.label.attributedText string] rangeOfString:[self selectedWord]];
    [self addLabelAttributes:attributes range:range];
}

- (IBAction)changeFont:(UIButton *)sender {
    NSDictionary *attributes = [self.label.attributedText attributesAtIndex:0 effectiveRange:NULL];
    UIFont *existingFont = attributes[NSFontAttributeName];
    CGFloat fontSize = (existingFont) ? existingFont.pointSize : [UIFont systemFontSize];
    UIFont *font = [sender.titleLabel.font fontWithSize:fontSize];
    [self addSelectedWordAttributes:@{NSFontAttributeName : font}];
}

- (IBAction)changeColor:(UIButton *)sender {
    [self addSelectedWordAttributes:@{NSForegroundColorAttributeName : sender.backgroundColor}];
}

- (IBAction)outline:(UIButton *)sender {
    [self addSelectedWordAttributes:@{NSStrokeWidthAttributeName: @5}];
}

- (IBAction)unoutline:(UIButton *)sender {
    [self addSelectedWordAttributes:@{NSStrokeWidthAttributeName: @0}];
}

- (IBAction)underline {
    [self addSelectedWordAttributes:@{ NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
}
- (IBAction)ununderline {
    [self addSelectedWordAttributes:@{ NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone)}];
}

- (NSArray *)wordList
{
    NSArray *words = [[self.label.attributedText string] componentsSeparatedByCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return ([words count]) ? words : @[@""];
}

- (NSString *)selectedWord
{
    return [self wordList][(int)self.selectedWordSteper.value];
}

- (IBAction)updateSelectedWord
{
    self.selectedWordSteper.maximumValue = [[self wordList] count] - 1;
    self.selectedWordLabel.text = [self selectedWord];
}

@end
