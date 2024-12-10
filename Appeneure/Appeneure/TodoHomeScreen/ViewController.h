//
//  ViewController.h
//  Appeneure
//
//  Created by Prashant Kumar Soni on 07/12/24.
//

#import <UIKit/UIKit.h>
#import "Appeneure-Swift.h"

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, AppeneureProtocols>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<TodoModel *> *dataArray;
@property (nonatomic, strong) UIView *cntnrView;
@property (nonatomic, strong) UILabel *lblView;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) AddViewController *addController;
@property (nonatomic, strong) TodoDetailViewController *detailController;


@end
