//
//  ViewController.m
//  FontDemo
//
//  Created by shenzhenshihua on 2017/6/15.
//  Copyright © 2017年 shenzhenshihua. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>
#import "Store.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *myText;
@property (weak, nonatomic) IBOutlet UIButton *gasper;
@property (weak, nonatomic) IBOutlet UIButton *mfzhihei;
@property (weak, nonatomic) IBOutlet UIButton *mfjinhei;
@property (weak, nonatomic) IBOutlet UIButton *mftongxin;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
    
    
    [self initView];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)initData {
    NSMutableDictionary * dataDcit = [Store readWithPathString:@"dataBase"];
    if (!dataDcit) {
        dataDcit = [[NSMutableDictionary alloc] init];
        NSArray * nameArr = @[@"gasper",@"mfzhihei",@"mfjinhei",@"mftongxin"];
        NSArray * pathArr = @[@"http://olxnvuztq.bkt.clouddn.com/Gaspar%20Regular.otf",@"http://olxnvuztq.bkt.clouddn.com/MFZhiHei_Noncommercial-Regular.ttf",@"http://olxnvuztq.bkt.clouddn.com/MFJinHei_Noncommercial-Regular.ttf",@"http://olxnvuztq.bkt.clouddn.com/MFTongXin_Noncommercial-Regular.ttf"];
        for (NSInteger i = 0; i < nameArr.count; i++) {
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
            [dic setObject:nameArr[i] forKey:@"name"];
            [dic setObject:pathArr[i] forKey:@"pathUrl"];
            [dic setObject:@"" forKey:@"pathLocation"];
            [dataDcit setObject:dic forKey:nameArr[i]];
        }
        BOOL isok = [Store writeID:dataDcit pathString:@"dataBase"];
        if (isok) {
            NSLog(@"写入成功");
        } else {
            NSLog(@"写入失败");
        }
    }

}


- (void)initView {
    NSMutableDictionary * dataDcit = [Store readWithPathString:@"dataBase"];
    if (dataDcit) {
        NSArray * nameArr = @[@"gasper",@"mfzhihei",@"mfjinhei",@"mftongxin"];
        for (NSInteger i = 0; i < nameArr.count; i++) {
            NSDictionary * dic = dataDcit[nameArr[i]];
            if (dic) {
                NSString * path = [dic objectForKey:@"pathLocation"];
                UIButton * btn = [self.view viewWithTag:1000 + i];
                if (path.length) {
                    [btn setTitle:@"下载完成" forState:UIControlStateNormal];
                }else{
                    [btn setTitle:@"还未下载" forState:UIControlStateNormal];
                }
            }
        }
    }

}


//下载所需要的字体；
- (void)downloadfountwithName:(NSString *)name {
    NSMutableDictionary * dataBase = [Store readWithPathString:@"dataBase"];
    NSMutableDictionary * dic = [dataBase objectForKey:name];
    NSURL * URL = [NSURL URLWithString:dic[@"pathUrl"]];
    
    NSInteger tag = -1;
    NSArray * nameArr = @[@"gasper",@"mfzhihei",@"mfjinhei",@"mftongxin"];
    for (NSInteger i = 0; i < nameArr.count; i++) {
        if ([name isEqualToString:nameArr[i]]) {
            tag = i;
            break;
        }
    }

    
    NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDownloadTask * task = [session downloadTaskWithURL:URL completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        }else{
            
            NSString * lastPath = [[response.URL.absoluteString componentsSeparatedByString:@"/"] lastObject];
            NSString * path1 = [Store returnThePath:lastPath];

            NSURL * mylocation = [NSURL fileURLWithPath:path1];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSError * error;
           BOOL isok111 =  [fileManager copyItemAtURL:location toURL:mylocation error:&error];
            if (!error && isok111) {
                if ([[NSFileManager defaultManager]fileExistsAtPath:mylocation.path]) {
                    NSLog(@"有东西呀");
                }
                NSMutableDictionary * dataBase = [Store readWithPathString:@"dataBase"];
                NSMutableDictionary * dic = [dataBase objectForKey:name];
                [dic setObject:lastPath forKey:@"pathLocation"];
                BOOL isok =  [Store writeID:dataBase pathString:@"dataBase"];
                NSLog(@"好了吗%d--%@",isok,dataBase);
                
            }
           
            dispatch_async(dispatch_get_main_queue(), ^{
                UIButton * btn = [self.view viewWithTag:tag + 1000];
                [btn setTitle:@"下载完成" forState:UIControlStateNormal];
            });


        }
        
    }];
    [task resume];


}
-(UIFont*)customFontWithPath:(NSURL *)path size:(CGFloat)size {
    
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)path);
    CGFontRef fontRef = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CTFontManagerRegisterGraphicsFont(fontRef, NULL);
    NSString *fontName = CFBridgingRelease(CGFontCopyPostScriptName(fontRef));
    UIFont *font = [UIFont fontWithName:fontName size:size];
    CGFontRelease(fontRef);
    return font;

}

- (IBAction)btnAction:(UIButton *)sender {
    
    NSInteger tag = sender.tag - 1000;
    NSMutableDictionary * dataDict = [Store readWithPathString:@"dataBase"];
    NSArray * nameArr = @[@"gasper",@"mfzhihei",@"mfjinhei",@"mftongxin"];

    if (![sender.titleLabel.text isEqualToString:@"下载中.."]) {
        if (dataDict) {
            NSMutableDictionary * dic = [dataDict objectForKey:nameArr[tag]];
            if ([dic[@"pathLocation"] length]) {
                NSString * path = [Store returnThePath:dic[@"pathLocation"]];
                //已经完成了
                [self.myText setFont:[self customFontWithPath:[NSURL fileURLWithPath:path] size:17]];
            }else{
            //还未下载
                [sender setTitle:@"下载中.." forState:UIControlStateNormal];
                [self downloadfountwithName:nameArr[tag]];
            
            }
            
        }

    }
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
