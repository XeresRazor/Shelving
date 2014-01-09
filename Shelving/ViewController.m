//
//  ViewController.m
//  Shelving
//
//  Created by Erin Green on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController
@synthesize currentBookOrderList;
@synthesize currentCorrectOrderList;
@synthesize masterBookList;
@synthesize temporaryBookList;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 1024.0, 748.0)];
    backgroundView.image = [UIImage imageNamed:@"Bookshelf.png"];
    [self.view addSubview:backgroundView];
	//Add a credit label at the top of the screen
	NSString *credits = @"Call numbers gathered from the collection of the Boston Public Library";
	CGSize creditsSize = [credits sizeWithFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
	CGRect creditsRect = CGRectMake(8.0, 0.0, creditsSize.width, creditsSize.height);
	UILabel *creditsLabel = [[UILabel alloc] initWithFrame:creditsRect];
	creditsLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
	creditsLabel.text = credits;
	creditsLabel.backgroundColor = [UIColor clearColor];
	creditsLabel.opaque = NO;
	creditsLabel.textColor = [UIColor blackColor];
	creditsLabel.shadowColor = [UIColor lightGrayColor];
	creditsLabel.shadowOffset = CGSizeMake(0.0, 1.5);
	[self.view addSubview:creditsLabel];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /*CGRect bookFrame = CGRectMake(8.0, 8.0, 96.0, 640.0);
     Book *myBook = [[Book alloc] initWithFrame:bookFrame];
     myBook.spineColor = [UIColor redColor];
     myBook.locNumber = @"LB\n2395\n.C65\n1991";
     [self.view addSubview:myBook];*/
    self.currentBookOrderList = [NSMutableArray arrayWithCapacity:10];
    self.currentCorrectOrderList = [NSMutableArray arrayWithCapacity:10];
    self.temporaryBookList = [NSMutableArray arrayWithCapacity:10];
    //srand(time(NULL));
    [self shuffleBooks];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
        return NO;
    }
    return YES;
}

-(void)book:(Book *)book didMoveToPoint:(CGPoint)point {
    [self.view bringSubviewToFront:book];
    CGFloat currentX = point.x;
    NSInteger currentIndex = MIN(MAX(floor((currentX-8)/100), 0), 9);
    NSLog(@"floating at index %d",currentIndex);
    NSInteger currentSourceIndex = 0;
    for (NSInteger i=0; i<10; i++) {
        if (i == currentIndex) {
            [self.temporaryBookList addObject:book];
            continue;
        }
        if ([self.currentBookOrderList objectAtIndex:currentSourceIndex] == book) {
            currentSourceIndex++;
        }
        Book *thisBook = [self.currentBookOrderList objectAtIndex:currentSourceIndex++];
        [self.temporaryBookList addObject:thisBook];
    }
    [UIView animateWithDuration:0.3 animations:^{
        for (NSInteger i=0; i<10; i++) {
            if ([self.temporaryBookList objectAtIndex:i] != book) {
                Book *thisBook = [self.temporaryBookList objectAtIndex:i];
                CGRect bookFrame = CGRectMake(16.0+(i*100.0), 64.0, 92.0, 640.0);
                thisBook.frame = bookFrame;
                
            }
        }
    }];
    self.temporaryBookList = [NSMutableArray arrayWithCapacity:10];
    
}

-(void)book:(Book *)book finishedMovingAtPoint:(CGPoint)point {
    CGFloat currentX = point.x;
    NSInteger currentIndex = MIN(MAX(floor((currentX-8)/100), 0), 9);
    NSLog(@"floating at index %d",currentIndex);
    NSInteger currentSourceIndex = 0;
    for (NSInteger i=0; i<10; i++) {
        if (i == currentIndex) {
            [self.temporaryBookList addObject:book];
            continue;
        }
        if ([self.currentBookOrderList objectAtIndex:currentSourceIndex] == book) {
            currentSourceIndex++;
        }
        Book *thisBook = [self.currentBookOrderList objectAtIndex:currentSourceIndex++];
        [self.temporaryBookList addObject:thisBook];
    }
    [UIView animateWithDuration:0.3 animations:^{
        for (NSInteger i=0; i<10; i++) {
            
            Book *thisBook = [self.temporaryBookList objectAtIndex:i];
            CGRect bookFrame = CGRectMake(16.0+(i*100.0), 64.0, 92.0, 640.0);
            thisBook.frame = bookFrame;
            
            
        }
    }];
    self.currentBookOrderList = [self.temporaryBookList copy];
    self.temporaryBookList = [NSMutableArray arrayWithCapacity:10];
    BOOL booksMatch = YES;
    for (NSInteger i=0;i<10; i++) {
        Book *movedBook = [currentBookOrderList objectAtIndex:i];
        Book *orderBook = [currentCorrectOrderList objectAtIndex:i];
        if (![movedBook.locNumber isEqualToString:orderBook.locNumber]) {
            booksMatch = NO;
        }
    }
    if (booksMatch) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:@"You put the books in the right order!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    for (UIView * view in self.view.subviews) {
        if ([view isKindOfClass:[Book class]]) {
            [view removeFromSuperview];
        }
    }
    self.currentBookOrderList = [NSMutableArray arrayWithCapacity:10];
    self.currentCorrectOrderList = [NSMutableArray arrayWithCapacity:10];
    self.temporaryBookList = [NSMutableArray arrayWithCapacity:10];
    //srand(time(NULL));
    [self shuffleBooks];

}

-(void)shuffleBooks {
    NSMutableDictionary *shuffleBooks = [NSMutableDictionary dictionaryWithCapacity:10];
    srand(time(NULL));
    while ([shuffleBooks count] <10) {
        NSInteger randomIndex = rand()%95;
		NSString *selectedBook = callNums[randomIndex];
		NSNumber *bookIndexNumber = [NSNumber numberWithInteger:randomIndex];
        [shuffleBooks setObject:selectedBook forKey:bookIndexNumber];
    }
    NSArray *sortedKeys = [[shuffleBooks allKeys] sortedArrayUsingSelector:@selector(compare:)];//[shuffleBooks keysSortedByValueUsingSelector:@selector(compare:)];
    NSLog(@"Sorted keys:\n%@",sortedKeys);
    
    NSMutableArray *temporaryList = [NSMutableArray arrayWithCapacity:10];
    for (NSInteger i=0; i<10; i++) {
        CGRect bookFrame = CGRectMake(16.0+(i*100.0), 64.0, 92.0, 640.0);
        Book *myBook = [[Book alloc] initWithFrame:bookFrame];
        myBook.spineImage = [UIImage imageNamed:coverNames[rand()%3]];
		NSLog(@"Setting book with locNumber:%@", [sortedKeys objectAtIndex:i]);
        myBook.locNumber = [shuffleBooks objectForKey:[sortedKeys objectAtIndex:i]];
        myBook.delegate = self;
        //[self.currentBookOrderList addObject:myBook];
        [temporaryList addObject:myBook];
        [currentCorrectOrderList addObject:myBook];
        //[self.view addSubview:myBook];
    }
    for (NSInteger i = 0; i < 10; i++) {
        Book *thisBook =[temporaryList objectAtIndex:(rand()%[temporaryList count])];
        [temporaryList removeObject:thisBook];
        [currentBookOrderList addObject:thisBook];
        CGRect bookFrame = CGRectMake(16.0+(i*100.0), 64.0, 92.0, 640.0);
        thisBook.frame = bookFrame;
        [self.view addSubview:thisBook];
    }
    
}

@end
