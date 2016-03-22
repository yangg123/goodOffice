/*
 * Copyright (c) 2014, James <jameszjhe@gmail.com> All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of James nor the names of its contributors may
 *       be used to endorse or promote products derived from this software
 *       without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY JAMES "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL JAMES AND CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ZJSwitch.h"

#define ZJSwitchMaxHeight 23.0f
#define ZJSwitchMinHeight 23.0f

#define ZJSwitchMinWidth 51.0f

#define ZJSwitchKnobWidth 21.0f
#define ZJSwitchKnobHeight 18.0f

@interface ZJSwitch ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *onContentView;
@property (nonatomic, strong) UIView *offContentView;
@property (nonatomic, strong) UIView *knobView;

@property (nonatomic, strong) UILabel *onLabel;
@property (nonatomic, strong) UILabel *offLabel;
@property (nonatomic, strong) UIView *borderView;  //边框颜色

- (void)commonInit;

- (CGRect)roundRect:(CGRect)frameOrBounds;

- (void)handleTapTapGestureRecognizerEvent:(UITapGestureRecognizer *)recognizer;

- (void)handlePanGestureRecognizerEvent:(UIPanGestureRecognizer *)recognizer;

- (void)scaleKnodViewFrame:(BOOL)scale;

@end

@implementation ZJSwitch

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[self roundRect:frame]];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:[self roundRect:bounds]];
    
    [self setNeedsLayout];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:[self roundRect:frame]];
    
    [self setNeedsLayout];
}

- (void)setOnText:(NSString *)onText
{
    if (_onText != onText) {
        _onText = onText;
        
        _onLabel.text = onText;
    }
}

- (void)setOffText:(NSString *)offText
{
    if (_offText != offText) {
        _offText = offText;
        
        _offLabel.text = offText;
    }
}

- (void)setOnTintColor:(UIColor *)onTintColor
{
    if (_onTintColor != onTintColor) {
        _onTintColor = onTintColor;
        
        if (_style == ZJSwitchStyleNoBorder) {
            _onContentView.backgroundColor = [UIColor clearColor];
        } else {
            if (_on) {
                _onContentView.backgroundColor = _onTintColor;
            }
        }
    }
}

- (void)setTintColor:(UIColor *)tintColor
{
    if (_tintColor != tintColor) {
        
        _tintColor = tintColor;
        
        if (_style == ZJSwitchStyleNoBorder) {
            _offContentView.backgroundColor = tintColor;
        } else {
            _containerView.backgroundColor = tintColor;
        }
    }
}

- (void)setThumbTintColor:(UIColor *)thumbTintColor
{
    if (_thumbTintColor != thumbTintColor) {
        _thumbTintColor = thumbTintColor;
        
        if (_style == ZJSwitchStyleBorder) {
            _knobView.backgroundColor = _thumbTintColor;
        }
    }
}

- (void)setOnTextColor:(UIColor *)onTextColor
{
    if (_onTextColor != onTextColor) {
        _onTextColor = onTextColor;
        
        if (_style == ZJSwitchStyleNoBorder) {
            _onLabel.textColor = onTextColor;
        }
    }
}

- (void)setOffTextColor:(UIColor *)offTextColor
{
    if (_offTextColor != offTextColor) {
        _offTextColor = offTextColor;
        _offLabel.textColor = _offTextColor; 
        if (_style == ZJSwitchStyleNoBorder) {
            _offLabel.textColor = _offTextColor;
        }
    }
}

- (void)setBorderColor:(UIColor *)borderColor
{
    if (_borderColor != borderColor) {
        _borderColor = borderColor;
    }
    
    if (_style ==ZJSwitchStyleBorder) {
        _borderView.layer.borderColor = _borderColor.CGColor;
    }
}

- (void)setStyle:(ZJSwitchStyle)style
{
    if (_style != style) {
        _style = style;
        
        if (_style == ZJSwitchStyleNoBorder) {
            _onContentView.backgroundColor = [UIColor clearColor];
            _offContentView.backgroundColor = _tintColor;
            
            _borderView.hidden = YES;
            _onLabel.textColor = _onTextColor;
            _offLabel.textColor = _onTextColor;
        } else {
            _onContentView.backgroundColor = _onTintColor;
            _offContentView.backgroundColor = [UIColor clearColor];
            
            _borderView.hidden = NO;
            _onLabel.textColor = _onTextColor;
            _offLabel.textColor = _onTextColor;
        }
        
        _onContentView.backgroundColor = (_style == ZJSwitchStyleNoBorder) ? [UIColor clearColor] : _onTintColor;
        
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.containerView.frame = self.bounds;
    
    CGFloat r = CGRectGetHeight(self.containerView.bounds) / 2.0;
    
    self.containerView.layer.cornerRadius = r;
    self.containerView.layer.masksToBounds = YES;
    
    CGFloat margin_x = (CGRectGetHeight(self.bounds) - ZJSwitchKnobWidth) / 2.0;
    CGFloat margin_y = (CGRectGetHeight(self.bounds) - ZJSwitchKnobHeight) / 2.0;
    
    
    self.borderView.frame = self.bounds;
    self.borderView.layer.borderWidth = 1.0;
    self.borderView.layer.cornerRadius = r;
    self.borderView.layer.masksToBounds = YES;
    
    if (!self.isOn) {
        // frame of off status
        self.onContentView.frame = CGRectMake(-1 * CGRectGetWidth(self.containerView.bounds),
                                              0,
                                              CGRectGetWidth(self.containerView.bounds),
                                              CGRectGetHeight(self.containerView.bounds));
        
        self.offContentView.frame = CGRectMake(0,
                                               0,
                                               CGRectGetWidth(self.containerView.bounds),
                                               CGRectGetHeight(self.containerView.bounds));
        
        self.knobView.frame = CGRectMake(margin_x+1,
                                         margin_y,
                                         ZJSwitchKnobWidth,
                                         ZJSwitchKnobHeight);
    } else {
        // frame of on status
        self.onContentView.frame = CGRectMake(0,
                                              0,
                                              CGRectGetWidth(self.containerView.bounds),
                                              CGRectGetHeight(self.containerView.bounds));
        
        self.offContentView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds),
                                               0,
                                               CGRectGetWidth(self.containerView.bounds),
                                               CGRectGetHeight(self.containerView.bounds));
        
        self.knobView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - margin_x - ZJSwitchKnobWidth,
                                         margin_y,
                                         ZJSwitchKnobWidth,
                                         ZJSwitchKnobHeight);
    }
    
    CGFloat lHeight = 20.0f;
    CGFloat lMargin = r - (sqrtf(powf(r, 2) - powf(lHeight / 2.0, 2))) + margin_x;
    
    self.onLabel.frame = CGRectMake(lMargin,
                                    r - lHeight / 2.0,
                                    CGRectGetWidth(self.onContentView.bounds) - lMargin - ZJSwitchKnobWidth - 2 * margin_x,
                                    lHeight);
    
    self.offLabel.frame = CGRectMake(ZJSwitchKnobWidth + 2 * margin_x,
                                     r - lHeight / 2.0,
                                     CGRectGetWidth(self.onContentView.bounds) - lMargin - ZJSwitchKnobWidth - 2 * margin_x,
                                     lHeight);
}

- (void)setOn:(BOOL)on
{
    [self setOn:on animated:NO];
}

- (void)setOn:(BOOL)on animated:(BOOL)animated
{
    if (_on == on) {
        return;
    }
    
    _on = on;
    
    CGFloat margin_x = (CGRectGetHeight(self.bounds) - ZJSwitchKnobWidth) / 2.0;
    CGFloat margin_y = (CGRectGetHeight(self.bounds) - ZJSwitchKnobHeight) / 2.0;
    
    CGRect onFrame = self.onContentView.frame;
    CGRect offFrame = self.offContentView.frame;
    CGRect knobFrame = self.knobView.frame;
    
    if (!self.isOn) {
        // frame of off status
        self.onContentView.frame = CGRectMake(-1 * CGRectGetWidth(self.containerView.bounds),
                                              0,
                                              CGRectGetWidth(self.containerView.bounds),
                                              CGRectGetHeight(self.containerView.bounds));
        
        self.offContentView.frame = CGRectMake(0,
                                               0,
                                               CGRectGetWidth(self.containerView.bounds),
                                               CGRectGetHeight(self.containerView.bounds));
        
        self.knobView.frame = CGRectMake(margin_x+1,
                                         margin_y,
                                         ZJSwitchKnobWidth,
                                         ZJSwitchKnobHeight);
        
        if (_style == ZJSwitchStyleBorder) {

        }
    } else {
        // frame of on status
        self.onContentView.frame = CGRectMake(0,
                                              0,
                                              CGRectGetWidth(self.containerView.bounds),
                                              CGRectGetHeight(self.containerView.bounds));
        
        self.offContentView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds),
                                               0,
                                               CGRectGetWidth(self.containerView.bounds),
                                               CGRectGetHeight(self.containerView.bounds));
        
        self.knobView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - margin_x - ZJSwitchKnobWidth,
                                         margin_y,
                                         ZJSwitchKnobWidth,
                                         ZJSwitchKnobHeight);
        
        if (_style == ZJSwitchStyleBorder) {
            
        }
    }
    
    if (animated) {
        // on
        CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"bounds"];
        [animation1 setFromValue:[NSValue valueWithCGRect:CGRectMake(0, 0, CGRectGetWidth(onFrame), CGRectGetHeight(onFrame))]];
        [animation1 setToValue:[NSValue valueWithCGRect:CGRectMake(0, 0, CGRectGetWidth(self.onContentView.frame), CGRectGetHeight(self.onContentView.frame))]];
        [animation1 setDuration:0.3];
        [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.onContentView.layer addAnimation:animation1 forKey:NULL];
        
        CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"position"];
        [animation2 setFromValue:[NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(onFrame), CGRectGetMidY(onFrame))]];
        [animation2 setToValue:[NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.onContentView.frame), CGRectGetMidY(self.onContentView.frame))]];
        [animation2 setDuration:0.3];
        [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.onContentView.layer addAnimation:animation2 forKey:NULL];
        
        // off
        CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"bounds"];
        [animation3 setFromValue:[NSValue valueWithCGRect:CGRectMake(0, 0, CGRectGetWidth(offFrame), CGRectGetHeight(offFrame))]];
        [animation3 setToValue:[NSValue valueWithCGRect:CGRectMake(0, 0, CGRectGetWidth(self.offContentView.frame), CGRectGetHeight(self.offContentView.frame))]];
        [animation3 setDuration:0.3];
        [animation3 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.offContentView.layer addAnimation:animation3 forKey:NULL];
        
        CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"position"];
        [animation4 setFromValue:[NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(offFrame), CGRectGetMidY(offFrame))]];
        [animation4 setToValue:[NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.offContentView.frame), CGRectGetMidY(self.offContentView.frame))]];
        [animation4 setDuration:0.3];
        [animation4 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.offContentView.layer addAnimation:animation4 forKey:NULL];
        
        // knob
        CABasicAnimation *animation5 = [CABasicAnimation animationWithKeyPath:@"bounds"];
        [animation5 setFromValue:[NSValue valueWithCGRect:CGRectMake(0, 0, CGRectGetWidth(knobFrame), CGRectGetHeight(knobFrame))]];
        [animation5 setToValue:[NSValue valueWithCGRect:CGRectMake(0, 0, CGRectGetWidth(self.knobView.frame), CGRectGetHeight(self.knobView.frame))]];
        [animation5 setDuration:0.3];
        [animation5 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.knobView.layer addAnimation:animation5 forKey:NULL];
        
        CABasicAnimation *animation6 = [CABasicAnimation animationWithKeyPath:@"position"];
        [animation6 setFromValue:[NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(knobFrame), CGRectGetMidY(knobFrame))]];
        [animation6 setToValue:[NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.knobView.frame), CGRectGetMidY(self.knobView.frame))]];
        [animation6 setDuration:0.3];
        [animation6 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.knobView.layer addAnimation:animation6 forKey:NULL];
    }
}

#pragma mark - Private API

- (void)commonInit
{
    self.backgroundColor = [UIColor clearColor];
    
    _style = ZJSwitchStyleNoBorder;
    
    _onTintColor = [UIColor colorFromHexRGB:@"00bf8f"];
    _tintColor = [UIColor colorFromHexRGB:@"dee6ed"];
    _thumbTintColor = [UIColor colorFromHexRGB:@"feffff"];
    
    _textFont = [UIFont systemFontOfSize:9];
    _onTextColor = [UIColor colorFromHexRGB:@"e9f7f6"];
    _offTextColor = [UIColor colorFromHexRGB:@"3c4856"];
    
    _containerView = [[UIView alloc] initWithFrame:self.bounds];
    _containerView.backgroundColor = [UIColor clearColor];
    [self addSubview:_containerView];
    
    _borderView = [[UIView alloc] initWithFrame:CGRectZero];
    _borderView.userInteractionEnabled = NO;
    _borderView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.2];
    _borderView.hidden = (_style == ZJSwitchStyleNoBorder) ? YES : NO;
    _borderView.layer.borderColor = [UIColor colorFromHexRGB:@"dee6ed"].CGColor;
    [_containerView addSubview:_borderView];
    
    _onContentView = [[UIView alloc] initWithFrame:self.bounds];
    _onContentView.backgroundColor = (_style == ZJSwitchStyleNoBorder) ? [UIColor clearColor] : _onTintColor;
    [_containerView addSubview:_onContentView];
    
    _offContentView = [[UIView alloc] initWithFrame:self.bounds];
    _offContentView.backgroundColor = (_style == ZJSwitchStyleNoBorder) ? _tintColor : [UIColor clearColor];

    [_containerView addSubview:_offContentView];
    
    _onLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _onLabel.backgroundColor = [UIColor clearColor];
    _onLabel.textAlignment = NSTextAlignmentCenter;
    _onLabel.textColor = _onTextColor;
    _onLabel.font = _textFont;
    _onLabel.text = _onText;
    [_onContentView addSubview:_onLabel];
    
    _offLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _offLabel.backgroundColor = [UIColor clearColor];
    _offLabel.textAlignment = NSTextAlignmentCenter;
    _offLabel.textColor = _offTextColor;
    _offLabel.font = _textFont;
    _offLabel.text = _offText;
    [_offContentView addSubview:_offLabel];
    
    _knobView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZJSwitchKnobWidth, ZJSwitchKnobHeight)];
    _knobView.backgroundColor =  [UIColor colorFromHexRGB:@"feffff"];
    _knobView.layer.cornerRadius = ZJSwitchKnobHeight / 2.0;
    [_containerView addSubview:_knobView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handleTapTapGestureRecognizerEvent:)];
    [self addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handlePanGestureRecognizerEvent:)];
    [self addGestureRecognizer:panGesture];
}

- (CGRect)roundRect:(CGRect)frameOrBounds
{
    CGRect newRect = frameOrBounds;
    
    if (newRect.size.height > ZJSwitchMaxHeight) {
        newRect.size.height = ZJSwitchMaxHeight;
    }
    
    if (newRect.size.height < ZJSwitchMinHeight) {
        newRect.size.height = ZJSwitchMinHeight;
    }
    
    if (newRect.size.width < ZJSwitchMinWidth) {
        newRect.size.width = ZJSwitchMinWidth;
    }
    
    return newRect;
}

- (void)handleTapTapGestureRecognizerEvent:(UITapGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self setOn:!self.isOn animated:YES];
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)handlePanGestureRecognizerEvent:(UIPanGestureRecognizer *)recognizer
{
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:{
            [self scaleKnodViewFrame:YES];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed: {
            [self scaleKnodViewFrame:NO];
            break;
        }
        case UIGestureRecognizerStateChanged:{
            break;
        }
        case UIGestureRecognizerStateEnded:
            [self setOn:!self.isOn animated:YES];
            [self sendActionsForControlEvents:UIControlEventValueChanged];
            break;
        case UIGestureRecognizerStatePossible:
            break;
    }
}

- (void)scaleKnodViewFrame:(BOOL)scale
{
    CGFloat margin_x = (CGRectGetHeight(self.bounds) - ZJSwitchKnobWidth) / 2.0;
    CGFloat margin_y = (CGRectGetHeight(self.bounds) - ZJSwitchKnobHeight) / 2.0;
    
    
    CGFloat offset = 6.0f;
    
    CGRect preFrame = self.knobView.frame;
    
    if (self.isOn) {
        self.knobView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - ZJSwitchKnobWidth - margin_x - (scale ? offset : 0),
                                         margin_y,
                                         ZJSwitchKnobWidth + (scale ? offset : 0),
                                         ZJSwitchKnobHeight);
    } else {
        self.knobView.frame = CGRectMake(margin_x,
                                         margin_y,
                                         ZJSwitchKnobWidth + (scale ? offset : 0),
                                         ZJSwitchKnobHeight);
    }
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"bounds"];
    [animation1 setFromValue:[NSValue valueWithCGRect:CGRectMake(0, 0, CGRectGetWidth(preFrame), CGRectGetHeight(preFrame))]];
    [animation1 setToValue:[NSValue valueWithCGRect:CGRectMake(0, 0, CGRectGetWidth(self.knobView.frame), CGRectGetHeight(self.knobView.frame))]];
    [animation1 setDuration:0.3];
    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.knobView.layer addAnimation:animation1 forKey:NULL];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation2 setFromValue:[NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(preFrame), CGRectGetMidY(preFrame))]];
    [animation2 setToValue:[NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.knobView.frame), CGRectGetMidY(self.knobView.frame))]];
    [animation2 setDuration:0.3];
    [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.knobView.layer addAnimation:animation2 forKey:NULL];
}

@end
