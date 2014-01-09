//
//  Book.m
//  Shelving
//
//  Created by Erin Green on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Book.h"

@implementation Book
//@synthesize locNumber;
//@synthesize spineColor;
@synthesize locLabel;
@synthesize delegate;
@synthesize spineImageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.spineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, 96.0, 640.0)];
        [self addSubview:self.spineImageView];
        CGRect labelFrame = CGRectMake(4.0, frame.size.height - 144.0
                                       , frame.size.width - 8.0, 128.0);
        locLabel = [[UILabel alloc] initWithFrame:labelFrame];
        locLabel.numberOfLines=6;
        locLabel.font = [UIFont fontWithName:@"Courier" size:18.0];
        [self addSubview:locLabel];
        UIGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        [self addGestureRecognizer:panRecognizer];
        
        storedFrame=self.frame; 
    }
    return self;
}

-(void) setLocNumber:(NSString *)locNumber {
    locLabel.text = locNumber;
    
}
-(NSString *) locNumber{
    return locLabel.text;
}
-(void) setSpineImage:(UIImage *)spineImage {
    self.spineImageView.image = spineImage;
}
-(UIImage *)spineImage {
    return self.spineImageView.image;
}

-(IBAction)handlePanGesture:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        storedFrame=self.frame;
    }
    CGPoint movement = [sender translationInView:self.superview];
    CGRect newFrame = storedFrame;
    newFrame.origin.x += movement.x;
    newFrame.origin.y += movement.y;
    self.frame=newFrame;
    if ([self.delegate respondsToSelector:@selector(book:didMoveToPoint:)]) {
        [self.delegate book:self didMoveToPoint:self.frame.origin];
    }
    if (sender.state == UIGestureRecognizerStateEnded) {
        storedFrame = newFrame;
        if ([self.delegate respondsToSelector:@selector(book:finishedMovingAtPoint:)]) {
            [self.delegate book:self finishedMovingAtPoint:self.frame.origin];
        }
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

