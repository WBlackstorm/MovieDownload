//
//  ViewController.m
//  NetworkTest
//
//  Created by Weverton Peron on 02/03/16.
//  Copyright © 2016 WStorm. All rights reserved.
//

#import "ViewController.h"
#import "AFURLSessionManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

-(IBAction)playMovie:(id)sender {
    
    // TODO - Colocar o nome do arquivo parametrizado
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Video/big_buck_bunny_240p_1mb.mp4"];
    
    NSString *filepath;
    
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        filepath = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"];
    } else {
        
        filepath = [[documentsDirectoryURL URLByAppendingPathComponent:path] absoluteString];
    }
    
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:filepath]];
    self.moviePlayer.controlStyle =  MPMovieControlStyleEmbedded;
    self.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    self.moviePlayer.view.frame = self.movieView.frame;
    
    [self.view addSubview:self.moviePlayer.view];
    
    [self.moviePlayer prepareToPlay];
    [self.moviePlayer play];
    
}

-(IBAction)downloadFile:(id)sender {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Video/small.mp4"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:documentsDirectory]) {
     
        NSLog(@"Arquivo já existe");
        
        return;
    
    } else {
        
        NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Video"];
        
        // Se o diretório existe, deleta
        if ([[NSFileManager defaultManager] fileExistsAtPath:path])
        {
            [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        }
        
    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:_urlTextField.text];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Video"];
        
        if (![[NSFileManager defaultManager] createDirectoryAtPath:path
                                       withIntermediateDirectories:NO
                                                        attributes:nil
                                                             error:nil]) {
            
            NSLog(@"Error creating directory");
            
        }
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        NSString *filepath = [NSString stringWithFormat:@"Video/%@", [response suggestedFilename]];
        
        return [documentsDirectoryURL URLByAppendingPathComponent:filepath];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
       
        NSLog(@"File saved in: %@",filePath.absoluteString);
    
    }];
    
    [downloadTask resume];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
