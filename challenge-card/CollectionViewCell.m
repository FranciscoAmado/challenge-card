//
//  CollectionViewCell.m
//  challenge-card
//
//  Created by franciscoamado on 11/03/16.
//  Copyright © 2016 franciscoamado. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelLeadingConstraint;
@property (weak, nonatomic) IBOutlet UIView *fadeView;
@property (assign, nonatomic) CGFloat labelPadding;

@end

@implementation CollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.labelPadding = self.labelLeadingConstraint.constant;
    self.inputType = CollectionViewCellInputTypeNumber;
    self.cardFacingView = CardFacingViewFront;
}

- (void)cancelNumberPad
{
    [self.textField resignFirstResponder];
    self.textField.text = @"";
}

- (void)doneWithNumberPad
{
    NSString *numberFromTheKeyboard = self.textField.text;
    [self.textField resignFirstResponder];
}

- (void)setIsFinalItem:(BOOL)isFinalItem
{
    _isFinalItem = isFinalItem;
    self.isFinalItem ? [self.textField setReturnKeyType:UIReturnKeyDone] : [self.textField setReturnKeyType:UIReturnKeyGo];
}

- (void)setInputType:(CollectionViewCellInputType)inputType
{
    if (inputType == CollectionViewCellInputTypeNumber || inputType == CollectionViewCellInputTypeDate) {
        [self.textField setKeyboardType:UIKeyboardTypeNumberPad];

        // Add toolbar for number input
        UIToolbar *numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
        numberToolbar.barStyle = UIBarStyleDefault;
        numberToolbar.items = @[
            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                         target:nil
                                                         action:nil],
            [[UIBarButtonItem alloc]initWithTitle:self.isFinalItem ? @"Done" : @"Next" style:UIBarButtonItemStyleDone
                                           target:self
                                           action:@selector(textFieldShouldReturn:)]];
        [numberToolbar sizeToFit];
        self.textField.inputAccessoryView = numberToolbar;
    }
    else {
        [self.textField setKeyboardType:UIKeyboardTypeDefault];
        self.textField.inputAccessoryView = nil;
    }
}

- (void)setCaptionText:(NSString *)captionText
{
    _captionText = captionText;
    [self.titleLabel setText:captionText];
}

- (void)setPlaceholderText:(NSString *)placeholderText
{
    _placeholderText = placeholderText;
    [self.textField setPlaceholder:placeholderText];
}

- (void)focusOn
{
    [self.textField becomeFirstResponder];
}

- (CGSize)sizeForConstrainedSize:(CGSize)constrainedSize
{
    CGSize labelSize = [self.titleLabel sizeThatFits:constrainedSize];
    return CGSizeMake(labelSize.width + 2 * self.labelPadding, labelSize.height);
}

#pragma MARK UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.fadeView setAlpha:0.0f];

    id <CollectionViewCellDelegate> strongDelegate = self.delegate;

    if ([strongDelegate respondsToSelector:@selector(didStartEditingCellWithTag:)]) {
        [strongDelegate didStartEditingCellWithTag:self.tag];
    }

    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidEndEditing");

    [self.fadeView setAlpha:0.5f];

    id <CollectionViewCellDelegate> strongDelegate = self.delegate;

//    if ([strongDelegate respondsToSelector:@selector(didEndEditingCellWithTag:)]) {
//        [strongDelegate didEndEditingCellWithTag:self.tag];
//    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textFieldShouldReturn");

    [self.fadeView setAlpha:0.5f];
    id <CollectionViewCellDelegate> strongDelegate = self.delegate;

    if ([strongDelegate respondsToSelector:@selector(didReturnEditingCellWithTag:)]) {
        [strongDelegate didReturnEditingCellWithTag:self.tag];
    }

    return YES;
}

@end