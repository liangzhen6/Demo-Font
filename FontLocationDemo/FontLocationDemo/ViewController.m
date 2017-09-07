//
//  ViewController.m
//  FontLocationDemo
//
//  Created by shenzhenshihua on 2017/9/7.
//  Copyright © 2017年 shenzhenshihua. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *myText;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testFontName];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)testFontName {
    for (NSString *familyName in [UIFont familyNames]) {
        NSLog(@"familyName：%@", familyName);
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            NSLog(@"fontName:%@", fontName);
        }
    }
}
- (IBAction)btnAction:(UIButton *)sender {
    NSArray * fonts = @[@"MFJinHei_Noncommercial-Regular",@"MFTongXin_Noncommercial-Regular",@"MFZhiHei_Noncommercial-Regular",@"Gaspar"];
    [self.myText setFont:[UIFont fontWithName:fonts[sender.tag - 1000] size:17]];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
