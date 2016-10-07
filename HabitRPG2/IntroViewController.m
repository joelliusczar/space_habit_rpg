//
//  IntroViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/29/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "IntroViewController.h"
#import "CoreDataStackController.h"
#import "Settings.h"
#import "StoryConstants.h"

@interface IntroViewController ()
@property (nonatomic,weak) CoreDataStackController *dataController;
@property (nonatomic,weak) Settings *userSettings;
@property (nonatomic,weak) UITextView *introMessage;
@property (nonatomic,weak) UILabel *headline;
@property (nonatomic,assign) BOOL isThreadAllowed;
@end

@implementation IntroViewController

@synthesize introMessage = _introMessage;
-(UITextView *)introMessage{
    if(_introMessage == nil){
        _introMessage = [self.view viewWithTag:2];
    }
    return _introMessage;
}

@synthesize headline = _headline;
-(UILabel *)headline{
    if(_headline == nil){
        _headline = [self.view viewWithTag:1];
    }
    return _headline;
}


-(id)initWithDataController:(CoreDataStackController *)dataController AndSettings:(Settings *)userSettings{
    if(self = [self initWithNibName:@"IntroViewController" bundle:nil]){
        self.dataController = dataController;
        self.userSettings = userSettings;
        self.isThreadAllowed = YES;
    }
    return self;
}


-(void)viewDidLoad {
    [super viewDidLoad];
    self.headline.text = @"";
    self.introMessage.text = @"";
    NSString *headlineText = @"Welcome to Space Habit Frontier";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [self autoTypeoutTitle:headlineText characterDelay:.01];
        [self autoTypeIntro:INTRO characterDelay:.01];
    });
    
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)autoTypeoutTitle:(NSString *)title characterDelay:(NSTimeInterval)delay{
    
    for(int i = 0;i<title.length&&self.isThreadAllowed;i++){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.headline setText:[NSString stringWithFormat:@"%@%C",self.headline.text,[title characterAtIndex:i]]];
        });
        
        [NSThread sleepForTimeInterval:delay];
    }
}


-(void)autoTypeIntro:(NSString *)text characterDelay:(NSTimeInterval)delay{
    for(int i = 0;i<text.length&&self.isThreadAllowed;i++){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.introMessage setText:[NSString stringWithFormat:@"%@%C",self.introMessage.text,[text characterAtIndex:i]]];
        });
        
        [NSThread sleepForTimeInterval:delay];
    }
}



@end
