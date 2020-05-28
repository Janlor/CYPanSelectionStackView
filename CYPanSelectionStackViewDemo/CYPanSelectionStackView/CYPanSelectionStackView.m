//
//  CYPanSelectionStackView.m
//  LingLingBang
//
//  Created by Janlor on 2020/5/28.
//  Copyright © 2020 linglingbang. All rights reserved.
//

#import "CYPanSelectionStackView.h"

@interface CYPanSelectionStackView ()

@property (nonatomic, strong) UISelectionFeedbackGenerator *feedbackGenerator;
@property (nonatomic, strong) UIButton *highlightedButton;

@end

@implementation CYPanSelectionStackView


#pragma mark - Life cycles

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addPanGesture];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addPanGesture];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self addPanGesture];
    }
    return self;
}

- (void)addPanGesture {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self addGestureRecognizer:pan];
}


#pragma mark - Actions

- (void)panAction:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateBegan
        || pan.state == UIGestureRecognizerStateChanged) {
        CGPoint location = [pan locationInView:self];
        
        UIButton *findButton = nil;
        for (UIButton *btn in self.arrangedSubviews) {
            CGPoint btnPoint = [btn convertPoint:location fromView:self];
            BOOL highlighted = [btn pointInside:btnPoint withEvent:nil];
            if (highlighted) {
                btn.highlighted = highlighted;
                findButton = btn;
                break;
            }
        }
        self.highlightedButton = findButton;
        return;
    }
    
    if (pan.state == UIGestureRecognizerStateEnded
        || pan.state == UIGestureRecognizerStateCancelled) {
        for (UIButton *btn in self.arrangedSubviews) {
            if (!btn.highlighted) { continue; }
            [btn sendActionsForControlEvents:UIControlEventTouchUpInside];
            btn.highlighted = NO;
        }
    }
}

- (void)selectionChanged {
    if (@available(iOS 10.0, *)) {
        [self.feedbackGenerator selectionChanged];
    }
}

#pragma mark - Setters

- (void)setHighlightedButton:(UIButton *)highlightedButton {
    BOOL isEqual = [_highlightedButton isEqual:highlightedButton];
    
    if (_highlightedButton
        && highlightedButton
        && !isEqual) {
        [self selectionChanged];
    }
    
    if (!isEqual) {
        _highlightedButton.highlighted = NO;
    }
    
    if (highlightedButton) {
        _highlightedButton = highlightedButton;
    }
}

#pragma mark - Lazy

- (UISelectionFeedbackGenerator *)feedbackGenerator {
    if (!_feedbackGenerator) {
        _feedbackGenerator = [[UISelectionFeedbackGenerator alloc] init];
        [_feedbackGenerator prepare];
    }
    return _feedbackGenerator;
}


#pragma mark - Others

- (void)dealloc {
    _feedbackGenerator = nil;
}

@end
