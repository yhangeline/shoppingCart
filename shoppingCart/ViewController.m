//
//  ViewController.m
//  shoppingCart
//
//  Created by yh on 15/11/30.
//  Copyright © 2015年 yh. All rights reserved.
//

#import "ViewController.h"
#import "ThrowLineTool.h"

@interface ViewController ()<ThrowLineToolDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIImageView *shopCart;

@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;


@property (strong, nonatomic) UIView *redView;



@end

@implementation ViewController


- (UIView *)redView
{
    if (!_redView) {
        _redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _redView.backgroundColor = [UIColor redColor];
        _redView.center = self.textField.center;
        _redView.layer.cornerRadius = 10;
    }
    return _redView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.textField.userInteractionEnabled = NO;
    
    [ThrowLineTool sharedTool].delegate = self;
    
    self.countLabel.layer.masksToBounds = YES;
    self.countLabel.layer.cornerRadius = 9;
    self.countLabel.hidden = YES;
}

- (IBAction)leftDown:(id)sender
{
    self.textField.text = [NSString stringWithFormat:@"%ld",(self.textField.text.integerValue - 1) > 0 ? (self.textField.text.integerValue - 1) : 0];
    self.countLabel.text = self.textField.text;
    self.countLabel.hidden = self.countLabel.text.integerValue == 0;
    
}

- (IBAction)rightDown:(id)sender
{
    self.textField.text = [NSString stringWithFormat:@"%ld",(self.textField.text.integerValue+1)];
    self.countLabel.text = self.textField.text;
    self.countLabel.hidden = self.countLabel.text.integerValue == 0;
    [self.view addSubview:self.redView];
    [[ThrowLineTool sharedTool] throwObject:self.redView from:self.redView.center to:self.shopCart.center height:-350 duration:0.4];
    
    self.rightBtn.enabled = NO;
}

- (void)animationDidFinish
{
    
     [self.redView removeFromSuperview];
    [UIView animateWithDuration:0.1 animations:^{
        self.shopCart.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.shopCart.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            self.rightBtn.enabled = YES;
            
        }];

    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
