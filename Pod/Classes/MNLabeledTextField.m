//
//  MNLabeledTextField.m
//  LabelledTextField
//
//  Created by Mateusz Nogaj on 6/6/14.
//  Copyright (c) 2014 Mateusz Nogaj. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MNLabeledTextField.h"

@interface MNLabeledTextField ()

@property (nonatomic, assign) id<UITextFieldDelegate> properDelegate;

@property (nonatomic, strong) UILabel *label;

@end

//#warning different animation styles: fade, slide

@implementation MNLabeledTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUpView];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    self.labelLeftMargin = 5.0f;
    self.labelHeight = 16.0f;

    self.delegate = self;
    self.label = [[UILabel alloc] init];
    self.label.text = self.placeholder;
    self.label.font = [UIFont systemFontOfSize:11.0f];
    self.label.textColor = [UIColor darkTextColor];
    self.label.hidden = YES;
    self.label.alpha = 0.0f;

    self.label.frame = CGRectMake(self.labelLeftMargin,
                                  self.text.length > 0 ? 1.0 : [self topOffset],
                                  self.frame.size.width - self.labelLeftMargin, self.labelHeight);
    [self addSubview:self.label];
//
//    NSLog(@"line height %f", self.font.lineHeight);
//    NSLog(@"label line height %f", self.label.font.lineHeight);
}

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    
//    if ( self != self.delegate ) {
//        self.properDelegate = self.delegate;
//        self.delegate = self;
//    }
//}

- (CGFloat)topOffset {
    return self.label.font.lineHeight;
}

- (void)prepareForInterfaceBuilder {
//#warning Implement
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate {
    if ( delegate == self ) {
        [super setDelegate:delegate];
    } else {
        self.properDelegate = delegate;
    }
}

- (id<UITextFieldDelegate>)delegate {
    return self;
}

- (void)hideLabel {
    CGRect tmp = self.label.frame;
    tmp.origin.y = [self topOffset];
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.label.frame = tmp;
                         self.label.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         self.label.hidden = YES;
                     }];
}

- (void)showLabel {
    CGRect tmp = self.label.frame;
    tmp.origin.y = 1.0f;
    self.label.hidden = NO;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.label.frame = tmp;
                         self.label.alpha = 1.0f;
                     }
                     completion:nil];
}

- (CGRect)customRect:(CGRect)bounds withTopOffset:(CGFloat)topOffset {
    CGFloat width = bounds.size.width - self.labelLeftMargin;
    if ( self.clearButtonMode != UITextFieldViewModeNever ) {
        width -= 20.0f;
    }

    return CGRectMake(self.labelLeftMargin,
                      topOffset,
                      width,
                      bounds.size.height - topOffset);
}

#pragma mark - Overrides

- (CGRect)textRectForBounds:(CGRect)bounds {
//    return [super textRectForBounds:bounds];

    CGRect result = CGRectZero;
    if ( self.text.length > 0 ) {
        result = [self customRect:bounds withTopOffset:[self topOffset]];
    } else {
        result = [super textRectForBounds:bounds];
    }
//    NSLog(@"textRectForBounds %@", NSStringFromCGRect(result));
    return result;
}

//- (CGRect)placeholderRectForBounds:(CGRect)bounds {
//    CGRect result = CGRectZero;
//    if ( self.text.length > 0 ) {
//        result = [self customRect:bounds withTopOffset:[self topOffset]];
//    } else {
//        result = [super placeholderRectForBounds:bounds];//[self customRect:bounds withTopOffset:0.0f];
//    }
//    NSLog(@"placeholder %@", NSStringFromCGRect(result));
//    return result;
//}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

#pragma mark - UITextFieldDelegate <NSObject>

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ( [self.properDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)] ) {
        return [self.properDelegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ( [self.properDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.properDelegate textFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ( [self.properDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        [self.properDelegate textFieldShouldEndEditing:textField];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ( [self.properDelegate respondsToSelector:@selector(textFieldDidEndEditing:)] ) {
        [self.properDelegate textFieldDidEndEditing:textField];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL result = YES;
    if ( [self.properDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)] ) {
        result = [self.properDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    if ( result ) {
        NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ( newText.length > 0 ) {
            [self showLabel];
        } else {
            [self hideLabel];
        }
    }
    return result;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    BOOL result = YES;
    if ( [self.properDelegate respondsToSelector:@selector(textFieldShouldClear:)] ) {
        result = [self.properDelegate textFieldShouldClear:textField];
    }
    if ( result ) {
        [self hideLabel];
    }
    
    return result;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ( [self.properDelegate respondsToSelector:@selector(textFieldShouldReturn:)] ) {
        return [self.properDelegate textFieldShouldReturn:textField];
    }
    return YES;
}

@end
