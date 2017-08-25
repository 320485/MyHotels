//
//  HotelViewController.m
//  GetHotels
//
//  Created by admin on 2017/8/23.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "HotelViewController.h"
#import "HotelTableViewCell.h"
@interface HotelViewController ()
@property (weak, nonatomic) IBOutlet UITableView *HotelTableView;
- (IBAction)SelectAdressBtn:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)WeatherBtn:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIDatePicker *DatePicker;
@property (weak, nonatomic) IBOutlet UIToolbar *Toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *CancelAction;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *ConfirmAction;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *CityBtn;


@property (strong, nonatomic) NSArray *HotelArr;
@end

@implementation HotelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self naviConfig];
    // Do any additional setup after loading the view.
    _HotelArr = @[@{@"HotelImage":@"hotels",@"HotelLabel":@"无锡万达喜来登酒店",@"HotelAdressLabel":@"无锡",@"HotelDistanceLabel":@"距离我3.5公里"},@{@"HotelImage":@"hotels",@"HotelLabel":@"无锡万达喜来登酒店",@"HotelAdressLabel":@"无锡",@"HotelDistanceLabel":@"距离我3.5公里"},@{@"HotelImage":@"hotels",@"HotelLabel":@"无锡万达喜来登酒店",@"HotelAdressLabel":@"无锡",@"HotelDistanceLabel":@"距离我3.5公里"}];
    //去掉tableview底部多余的线
    _HotelTableView.tableFooterView = [UIView new ];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)uiLayout{
    
}
-(void)networkRequest{
    
}
//当前页面将要显示的时候，显示导航栏
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)naviConfig {
    //设置导航条标题文字
    self.navigationItem.title = @"GetHotels";
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

#pragma mark - table view
//有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _HotelArr.count;
}

//每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
//细胞长什么样
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HotelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotelCell" forIndexPath:indexPath];
    //根据行号拿到数组中对应的数据
    NSDictionary *dict = _HotelArr[indexPath.section];
    cell.HotelImage.image = [UIImage imageNamed:dict[@"HotelImage"]];
    cell.HotelLabel.text = dict[@"HotelLabel"];
    cell.HotelAdressLabel.text = dict[@"HotelAdressLabel"];
    cell.HotelDistanceLabel.text = dict[@"HotelDistanceLabel"];
    return cell;

}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



- (IBAction)WeatherBtn:(UIButton *)sender forEvent:(UIEvent *)event {
}
@end
