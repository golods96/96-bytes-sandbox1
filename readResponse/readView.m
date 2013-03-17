//
//  readView.m
//  readResponse
//
//  Created by Lev on 3/16/13.
//  Copyright (c) 2013 96 Bytes. All rights reserved.
//

#import "readView.h"

@implementation readView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
 - (void)drawRect:(CGRect)rect
{
    // Drawing code
    // Get the graphics context and clear it
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect);
    
    //  draw a red rectangle
    CGContextSetRGBFillColor(ctx, 255, 0, 0, 1);
    CGContextFillRect(ctx, CGRectMake(10, 10, 50, 50));
}


@end
