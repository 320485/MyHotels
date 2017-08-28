//
//  SiginInViewController.m
//  GetHotels
//
//  Created by admin on 2017/8/26.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "SiginInViewController.h"

@interface SiginInViewController ()<UITextFieldDelegate>
@property (strong,nonatomic)UIActivityIndicatorView *avi;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *siginInBtn;
- (IBAction)siginInAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@end

@implementation SiginInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self naviConfig];
    [self uiLayout];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)uiLayout{
    _headImageView.layer.borderColor=[UIColor blueColor].CGColor;
    
}

- (void)naviConfig {
    //设置导航条标题文字
    self.navigationItem.title = @"注册会员";
    //设置导航条颜色（风格颜色）
    self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
    //设置导航条标题颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    //设置导航条是否隐藏.
    self.navigationController.navigationBar.hidden = NO;
    //设置导航条上按钮的风格颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //设置是否需要毛玻璃效果
    self.navigationController.navigationBar.translucent = YES;
}

//自定的返回按钮的事件
- (void)leftButtonAction: (UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _phoneTextField || textField == _pwdTextField || textField == _confirmPwdTextField) {
        if (_phoneTextField.text.length != 0 && _pwdTextField.text.length != 0 && _confirmPwdTextField.text.length != 0) {
           _siginInBtn.enabled =YES;
        }
    }
}
//按键盘的return收回按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _phoneTextField || textField == _pwdTextField || textField == _confirmPwdTextField) {
        [textField resignFirstResponder];
    }
    return YES;
}

//让根视图结束编辑状态，到达收起键盘的目的
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)siginInAction:(UIButton *)sender forEvent:(UIEvent *)event {
    if ([_pwdTextField.text isEqualToString:_confirmPwdTextField.text]) {
        [self signUpRequest];
    }else{
        [Utilities popUpAlertViewWithMsg:@"密码输入不一致，请重新输入" andTitle:@"提示" onView:self onCompletion:^{
            _pwdTextField.text = @"";
            _confirmPwdTextField.text = @"";
        }];
    }
}

-(void)signUpRequest{
    _avi=[Utilities getCoverOnView:self.view];
    NSDictionary *para=@{@"tel":_phoneTextField.text,@"pwd":_pwdTextField.text};
    [RequestAPI requestURL:@"/register" withParameters:para andHeader:nil byMethod:kPost andSerializer:kForm success:^(id responseObject) {
        [_avi stopAnimating];
        NSLog(@"%@",responseObject);
        if([responseObject[@"result"] integerValue] == 1){
            [Utilities popUpAlertViewWithMsg:@"注册成功" andTitle:nil onView:self onCompletion:^{
                [self performSegueWithIdentifier:@"signUpToLogin" sender:self];
            }];
        }else{
            //业务逻辑失败的情况下
            NSString *errorMsg = [ErrorHandler getProperErrorString:[responseObject[@"result"] integerValue]];
            [Utilities popUpAlertViewWithMsg:errorMsg andTitle:nil onView:self onCompletion:nil];
        }
        
        
    } failure:^(NSInteger statusCode, NSError *error) {
        [_avi stopAnimating];
        NSLog(@"%ld",(long)statusCode);
        [Utilities popUpAlertViewWithMsg:@"请保持网络参数" andTitle:nil onView:self onCompletion:nil];
        
    }];
}









@end
