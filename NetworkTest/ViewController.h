//
//  ViewController.h
//  NetworkTest
//
//  Created by Weverton Peron on 02/03/16.
//  Copyright © 2016 WStorm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaPlayer/MediaPlayer.h"

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIButton *downloadBtn;
@property (nonatomic, weak) IBOutlet UIButton *playBtn;
@property (nonatomic, weak) IBOutlet UIView *movieView;
@property (nonatomic, weak) IBOutlet UITextField *urlTextField;

@property (nonatomic) MPMoviePlayerController *moviePlayer;

- (IBAction)playMovie:(id)sender;

- (IBAction)downloadFile:(id)sender;

@end

