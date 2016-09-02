//
//  ViewController.m
//  iFlyingBird
//
//  Created by Bui Duc Khanh on 9/2/16.
//  Copyright © 2016 Bui Duc Khanh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    UIImageView *bird;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self drawJungle];
    
    [self addBird];
    
    [self flyUpAndDown];
}


// Hàm vẽ khu rừng
- (void) drawJungle{
    UIImageView * bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jungle.jpg"]];
    bg.frame = self.view.frame;
    bg.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.view addSubview:bg];
}


// Bổ sung con chim
- (void) addBird{
    bird = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 110, 68)];
    bird.animationImages = @[ [UIImage imageNamed:@"bird0.png"]
                             ,[UIImage imageNamed:@"bird1.png"]
                             ,[UIImage imageNamed:@"bird2.png"]
                             ,[UIImage imageNamed:@"bird3.png"]
                             ,[UIImage imageNamed:@"bird4.png"]
                             ,[UIImage imageNamed:@"bird5.png"]];
    
    bird.animationRepeatCount = 0;
    bird.animationDuration = 1;
    
    [self.view addSubview:bird];
    
    [bird startAnimating];
}


// Điều hướng chim bay lên và xuống
- (void) flyUpAndDown {
    bird.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:5 animations:^{
        bird.center = CGPointMake(self.view.bounds.size.width, self.view.bounds.size.height);
    } completion:^(BOOL finished) {
        bird.transform = CGAffineTransformConcat(
                                                 CGAffineTransformMakeScale(-1, 1),    // Quay ngược con chim
                                                 CGAffineTransformMakeRotation(M_PI_4));// Chỉnh cho đầu con chim hướng chéo lên
        
        
        [UIView animateWithDuration:5 animations:^{
            bird.center = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            [self flyUpAndDown];
        }];
    }];
}

@end
