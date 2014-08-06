//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by Omer Wazir on 8/3/14.
//  Copyright (c) 2014 Omer Wazir. All rights reserved.
//

#import "BNRHypnosisView.h"

@implementation BNRHypnosisView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // All BNRHypnosisViews will start with a clear background color
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    CGRect bounds = self.bounds;
    CGRect hypnotoadBounds = CGRectMake(bounds.origin.x + bounds.size.width / 4.0,
                                        bounds.origin.y + bounds.size.height / 4.0,
                                        bounds.size.width / 1.58,
                                        bounds.size.height / 2.0);
    
    UIImage *hypnotoad = [UIImage imageNamed:@"Hypnotoad.png"];
    
    //figure out the center of the bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    //the largest circle will circumscribe the view
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    

    for(float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20){
        
        //Need to move where drawing starts so that the circles aren't joined together
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        
        [path addArcWithCenter:center
                        radius:currentRadius
                    startAngle:0.0
                      endAngle:M_PI * 2.0
                     clockwise:YES];
    }
    
    //Set line width to 10 points
    path.lineWidth = 10;
    
    //Configure the drawing color to light gray
    [[UIColor lightGrayColor] setStroke];
    
    //Now draw the line
    [path stroke];
    

    
    //get the current graphics context
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    //save the context before applying a clipping path to it
    CGContextSaveGState(currentContext);
    
    //All the work in making a clipping path
    CGPoint startPoint = CGPointMake(bounds.origin.x + bounds.size.width / 2.0, bounds.origin.y + bounds.size.height * 0.20);
    CGPoint endPoint = CGPointMake(bounds.origin.x + bounds.size.width, bounds.origin.y + bounds.size.height * 0.85);
    
    CGFloat angle = M_PI/4; // 45 degrees in radians
    // v1 = vector from startPoint to endPoint:
    CGPoint v1 = CGPointMake(endPoint.x - startPoint.x, endPoint.y - startPoint.y);
    // v2 = v1 rotated by 60 degrees:
    CGPoint v2 = CGPointMake(cosf(angle) * v1.x - sinf(angle) * v1.y,
                             sinf(angle) * v1.x + cosf(angle) * v1.y);
    // thirdPoint = startPoint + v2:
    CGPoint thirdPoint = CGPointMake(startPoint.x + v2.x, startPoint.y + v2.y);
    
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    [path addLineToPoint:thirdPoint];
    
    //now apply the clipping path
    [path addClip];
    
    //apply the gradient which is applied just within the clipping path
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = { 1.0, 0.0, 0.0, 1.0, //some how this starts as red
        1.0,1.0,0.0,1.0}; // and this ends as yellow?
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2);
    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0);
    
    //Need to release what we created since own them
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    
    //restore state so a gradient and clipping aren't applied
    CGContextRestoreGState(currentContext);
    
    //save the context before applying a shadow to it
    CGContextSaveGState(currentContext);
    
    //set a shadow to the graphic context -- I have no clue how this will look
    CGContextSetShadow(currentContext, CGSizeMake(4, 8), 2.5);
    
    //Add hypnotoad
    [hypnotoad drawInRect:hypnotoadBounds];
    
    //restore the context so new drawings don't have a shadow applied to them.
    CGContextRestoreGState(currentContext);
    
    
}


@end
