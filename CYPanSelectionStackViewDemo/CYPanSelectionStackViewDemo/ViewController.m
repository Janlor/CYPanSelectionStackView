//
//  ViewController.m
//  CYPanSelectionStackViewDemo
//
//  Created by Janlor on 2020/5/28.
//  Copyright © 2020 Janlor. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)buttonClicked:(UIButton *)sender {
    NSString *title = [NSString stringWithFormat:@"点击了%@", sender.titleLabel.text];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

@end
