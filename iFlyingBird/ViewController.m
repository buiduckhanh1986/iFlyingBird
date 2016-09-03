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
    
    CGPoint points[7];
    
    float birdWidth;
    float birdHeight;
    
    int currentPos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Khởi tạo dữ liệu
    birdWidth = 110;
    birdHeight = 68;
    
    float viewPortWidth = self.view.bounds.size.width;
    float viewPortHeight = self.view.bounds.size.height;
    
    points[0] = CGPointMake(birdWidth/2.0, birdHeight/2.0);
    points[1] = CGPointMake(viewPortWidth - birdWidth/2.0, birdHeight/2.0);
    points[2] = CGPointMake(birdWidth/2.0, viewPortHeight/2.0);
    points[3] = CGPointMake(viewPortWidth/2.0, viewPortHeight/2.0);
    points[4] = CGPointMake(viewPortWidth - birdWidth/2.0, viewPortHeight/2.0);
    points[5] = CGPointMake(birdWidth/2.0, viewPortHeight - birdHeight/2.0);
    points[6] = CGPointMake(viewPortWidth - birdWidth/2.0, viewPortHeight - birdHeight/2.0);
    
    currentPos = 3;
    
    // Vẽ rừng
    [self drawJungle];
    
    // Vẽ chim
    [self addBird];
    
    
    // Di chuyển
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
    bird = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, birdWidth, birdHeight)];
    bird.animationImages = @[ [UIImage imageNamed:@"bird0.png"]
                             ,[UIImage imageNamed:@"bird1.png"]
                             ,[UIImage imageNamed:@"bird2.png"]
                             ,[UIImage imageNamed:@"bird3.png"]
                             ,[UIImage imageNamed:@"bird4.png"]
                             ,[UIImage imageNamed:@"bird5.png"]];
    
    bird.animationRepeatCount = 0;
    bird.animationDuration = 1;
    
    bird.center = points[currentPos];
    
    [self.view addSubview:bird];
    
    [bird startAnimating];
}


// Điều hướng chim bay lên và xuống
- (void) flyUpAndDown {
    
    int nextPost = arc4random_uniform(6);
    if (currentPos == nextPost)
        nextPost = nextPost + 1;
    
    float diffX = points[nextPost].x - points[currentPos].x;
    float diffY = points[nextPost].y - points[currentPos].y;
    
    if (diffY > 0) // Di chuyển xuống
    {
        if (diffX > 0) // Chéo xuống
        {
            bird.transform = CGAffineTransformIdentity;
        }
        else if (diffX == 0) // Thẳng đứng xuống
        {
            bird.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        else // Chéo ngược xuống
        {
            bird.transform = CGAffineTransformMakeScale(-1, 1);
        }
    }
    else if (diffY == 0) // Di chuyển ngang
    {
        if (diffX > 0) // Sang phải
        {
            bird.transform = CGAffineTransformMakeRotation(-M_PI_4/2.0);
        }
        else // Sang trái
        {
            bird.transform = CGAffineTransformConcat(
                                                     CGAffineTransformMakeScale(-1, 1),
                                                     CGAffineTransformMakeRotation(M_PI_4/2.0));
        }
    }
    else // Bay lên
    {
        if (diffX > 0) // Chéo lên
        {
            bird.transform = CGAffineTransformMakeRotation(-M_PI_4);
        }
        else if (diffX == 0) // Thẳng đứng lên
        {
            bird.transform = CGAffineTransformMakeRotation(-M_PI_2);
        }
        else // Chéo ngược lên
        {
            bird.transform = CGAffineTransformConcat(
                                                     CGAffineTransformMakeScale(-1, 1),
                                                     CGAffineTransformMakeRotation(M_PI_4));
        }
    }
    
    currentPos = nextPost;
    // Animate
    [UIView animateWithDuration:5 animations:^{
        bird.center = points[currentPos];
    } completion:^(BOOL finished) {
        bird.transform = CGAffineTransformIdentity;
        
        [self flyUpAndDown];
    }];
}

@end
