//
//  Book.h
//  Shelving
//
//  Created by Erin Green on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BookDelegate;

@interface Book : UIView {
    CGRect storedFrame;
}
@property (retain, nonatomic) NSString *locNumber;
@property (retain, nonatomic) UIImage *spineImage;
@property (retain, nonatomic) UILabel *locLabel;
@property (assign, nonatomic) id<BookDelegate> delegate;
@property (retain, nonatomic) UIImageView *spineImageView;

-(IBAction)handlePanGesture:(UIPanGestureRecognizer *)sender;


@end

@protocol BookDelegate <NSObject>
-(void)book:(Book *)book finishedMovingAtPoint:(CGPoint)point;

-(void)book:(Book *)book didMoveToPoint:(CGPoint)point;

@end
