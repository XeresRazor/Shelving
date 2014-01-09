//
//  ViewController.h
//  Shelving
//
//  Created by Erin Green on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface ViewController : UIViewController <BookDelegate, UIAlertViewDelegate>
@property (retain, nonatomic) NSMutableArray *currentBookOrderList;
@property (retain, nonatomic) NSMutableArray *currentCorrectOrderList;
@property (retain, nonatomic) NSArray *masterBookList;
@property (retain, nonatomic) NSMutableArray *temporaryBookList;
-(void)shuffleBooks;

@end


static NSString * callNums[] = {
    @"AM\n101\n.B85\n1989",
    @"AM\n101\n.B851\n1971",
    @"B\n2063\n.H5\n1912",
    @"DA\n783.4\n.B34\n1988",
    @"DA\n910\n.B375\n2010",
    @"DA\n933\n.E54\n1984",
    @"DC\n36.9\n.A76\n2011",
    @"DC\n148\n.P67\n2006",
    @"DC\n148\n.P67\n2010",
    @"DD\n89\n.H3513\n1968",
    @"DG\n311\n.G5\n2005",
    @"DG\n675.6\n.M45\n1996",
    @"DT\n143\n.B43\n2005",
    @"DT\n148\n.C3513\n2002",
    @"DT\n148\n.R3913\n2000",
    @"E\n468\n.S795\n2000",
    @"F\n73.5\n.C758\n1996",
    @"F\n74\n.S1\nS64\n2010",
    @"F\n144\n.A8\n J65\n2010",
    @"F\n746.3\n.P48\n2009",
    @"F\n2546\n.A439\n2006",
    @"GV\n875\n.B62\nR43\n2005",
    @"HJ\n1199\n.F55\nK58\n1991",
    @"KF\n5630\n.I33",
    @"ML\n410\n.R12\nS33\n2008",
    @"NB\n92\n.B7\n1953",
    @"ND\n237\n.S3\nA4\n1998",
    @"ND\n237\n.S3\nA4\n1998\nc.2",
    @"ND\n237\n.S3\nA4\n1999",
    @"ND\n1329\n.T54\nF74\n1995",
    @"NK\n7346\n.A1\nD44\n1998",
    @"PN\n1992.77\n.T67\nI45\n2010",
    @"PN\n1993.5\n.F7\nN48\n2007",
    @"PN\n1999\n.W27\nS37\n2002",
    @"PN\n6231\n.A77\nA93\n2004",
    @"PN\n6727\n.M55\nA2\n2006",
    @"PN\n6727\n.V38\nS68\n1998",
    @"PN\n6728\n.B36\nM547\n2005",
    @"PQ\n4563\n.A25\n1926",
    @"PQ\n4564\n.C53",
    @"PQ\n4564\n.W33\n2004",
    @"PR\n2246\n.C37\n1996",
    @"PR\n2248\n.J59\n1983",
    @"PR\n2248\n.W28\n1987",
    @"PR\n4034\n.N7\n2008",
    @"PR\n4034\n.P7\n2009",
    @"PR\n4172\n.W7\n2001",
    @"PR\n4300\n1972",
    @"PR\n4331\n.D24\n1963",
    @"PR\n4331\n.L69\n1986",
    @"PR\n4338\n.B46\n1987",
    @"PR\n6039\n.O32\nH63\n2007",
    @"PS\n3525\n.I972\nO737\n2002",
    @"PS\n3527\n.I865\nZ5",
    @"PS\n3527\n.I865\nZ522\n1978",
    @"PS\n3527\n.I865\nZ913\n1984",
    @"PS\n3545\n.I342\nZ894\n2009",
    @"PS\n3555\n.D38\nS44\n2005",
    @"PS\n3557\n.A3519\nA84\n2001",
    @"PS\n3561\n.P96\nG65\n1995",
    @"PS\n3562\n.A316\nI58\n1999",
    @"PS\n3562\n.A316\nN36\n2004",
    @"PS\n3562\n.A316\nU53\n2008",
    @"PS\n3569\n.T3868\nC79\n2002",
    @"PS\n3570\n.U76\nA95\n2010",
    @"PS\n3619\n.E424\nL55\n2004",
    @"PT\n2583\n.W9\nS313\n1996",
    @"PZ\n7\n.O135",
    @"QA\n76.2\n.J63\nI83\n2011",
    @"QA\n76.64\n.D38\n2002",
    @"QA\n76.64\n.K63\n2004",
    @"QA\n76.64\n.P57\n1991",
    @"QC\n84\n.B78\n1985",
    @"QH\n75\n.G636\n2009",
    @"QH\n86\n.R39\n2002",
    @"QL\n737\n.C214\nM338\n1988",
    @"QL\n737\n.C214\nR88\n1998",
    @"QL\n737\n.P96\nG65\n1995",
	@"QL\n737\n.C23\nM87\n2006",
    @"QL\n737\n.P98\nS34\n2003",
    @"R\n131\n.D83\n1999",
    @"R\n131\n.H56\n1988",
    @"R\n133.5\n.W66\n2006",
    @"RC\n275\n.M85\n2010",
    @"TX\n715\n.W55\n1997",
    @"TX\n833.5\n.C63\n2003",
    @"Z\n110\n.C7\nR57\n1983",
    @"Z\n663.35\n.L55",
    @"Z\n678.9\n.S35",
    @"Z\n721\n.F75\n2003",
    @"Z\n721\n.R24\n1998",
    @"Z\n921\n.B8703",
    @"Z\n3291\n.U51",
    @"Z\n6660.8\n.S34\n1986",
    @"Z\n8802\n.I33\n1978",
    
    
};

static NSString *coverNames[] = {
    @"BlueCover.png",
    @"GreenCover.png",
    @"RedCover.png",
};