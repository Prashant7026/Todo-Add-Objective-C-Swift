//
//  ViewController.m
//  Appeneure
//
//  Created by Prashant Kumar Soni on 07/12/24.
//

#import "ViewController.h"
#import "UIKit/UIKit.h"
#import "HomeTableViewCell.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.title = @"Todo App";
    NSDictionary *attributes = @{
        NSForegroundColorAttributeName: [UIColor systemYellowColor],
        NSFontAttributeName: [UIFont fontWithName:@"Chalkduster" size:25]
    };
    self.navigationController.navigationBar.titleTextAttributes = attributes;
}

- (void)viewWillAppear:(BOOL)animated{
    if (_dataArray.count > 0) {
        [self setupUI];
    } else {
        [self setupCntnrView];
        [self addCntnrViewConstraints];
        [self showNoDataMessage];
        [self addNoDataMessageConstraints];
        [self setupBtnView];
        [self addBtnViewConstraints];
    }
}

-(void) showNoDataMessage {
    self.lblView = [[UILabel alloc] init];
    self.lblView.translatesAutoresizingMaskIntoConstraints = NO;
    self.lblView.text = @"No Data Added Yet!";
    self.lblView.font = [UIFont systemFontOfSize:20.0];
    self.lblView.textColor = [UIColor grayColor];
    self.lblView.textAlignment = NSTextAlignmentCenter;
    [self.cntnrView addSubview:self.lblView];
}

-(void) addNoDataMessageConstraints {
    [NSLayoutConstraint activateConstraints:@[
        [self.lblView.centerXAnchor constraintEqualToAnchor:self.cntnrView.centerXAnchor],
        [self.lblView.centerYAnchor constraintEqualToAnchor:self.cntnrView.centerYAnchor]
    ]];
}

-(void)setupUI {
    [self registerCell];
    
    [self setupCntnrView];
    [self addCntnrViewConstraints];
    
    [self setupTableView];
    [self addTableViewConstraints];
    
    [self setupBtnView];
    [self addBtnViewConstraints];
}

-(void) registerCell{
    [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"HomeTableViewCell"];
}

-(void) setupCntnrView{
    self.cntnrView = [[UIView alloc] initWithFrame:CGRectZero];
    self.cntnrView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.cntnrView];
}

-(void) addCntnrViewConstraints{
    [NSLayoutConstraint activateConstraints:@[
        [self.cntnrView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.cntnrView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [self.cntnrView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.cntnrView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor]
    ]];
}

-(void) setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.cntnrView addSubview:self.tableView];
}

-(void) addTableViewConstraints{
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.topAnchor constraintEqualToAnchor:self.cntnrView.topAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.cntnrView.bottomAnchor],
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.cntnrView.leadingAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.cntnrView.trailingAnchor]
    ]];
}

-(void) setupBtnView{
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cntnrView addSubview:self.addBtn];
    self.addBtn.translatesAutoresizingMaskIntoConstraints = NO;
    UIImage *buttonImage = [[UIImage systemImageNamed:@"plus"] imageWithRenderingMode: UIImageRenderingModeAlwaysTemplate];
    [self.addBtn setImage:buttonImage forState:UIControlStateNormal];

    self.addBtn.backgroundColor = UIColor.systemBlueColor;
    self.addBtn.tintColor = UIColor.whiteColor;
    self.addBtn.layer.cornerRadius = 30.0;
    [self.addBtn addTarget:self action:@selector(addBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) addBtnViewConstraints{
    [NSLayoutConstraint activateConstraints:@[
        [self.addBtn.heightAnchor constraintEqualToConstant: 60.0],
        [self.addBtn.widthAnchor constraintEqualToConstant: 60.0],
        [self.addBtn.bottomAnchor constraintEqualToAnchor:self.cntnrView.bottomAnchor constant: -50.0],
        [self.addBtn.trailingAnchor constraintEqualToAnchor:self.cntnrView.trailingAnchor constant: -30.0]
    ]];
}

- (void)addBtnTapped:(UIButton *)sender {
    self.addController = [[AddViewController alloc] init];
    self.addController.delegate = self;
    [self.navigationController pushViewController:_addController animated:true];
}

// MARK: Add Todo Item
- (void)AddTodo:(TodoModel *)todoData {
    if (!todoData) {
        NSLog(@"todoData is nil!");
        return;
    }
    
    if (!self.dataArray) {
        self.dataArray = [NSMutableArray new];
    }
    
    NSMutableArray *mutableArray = [self.dataArray mutableCopy];
    
    [mutableArray addObject:todoData];
    
    self.dataArray = [mutableArray copy];
    
    NSLog(@"dataArray count: %lu", (unsigned long)self.dataArray.count);
    [self.tableView reloadData];
}

// MARK: Table View Configure
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell"];
    
    if (!cell) {
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeTableViewCell"];
    }
    TodoModel *todo = self.dataArray[indexPath.row];
    NSLog(@"todo title: %@", todo.title);
    cell.lblView.text = todo.title;
    NSLog(@"Label text: %@", cell.lblView.text);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.detailController = [[TodoDetailViewController alloc] init];
    self.detailController.detailData = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:self.detailController animated:true];
}

@end
