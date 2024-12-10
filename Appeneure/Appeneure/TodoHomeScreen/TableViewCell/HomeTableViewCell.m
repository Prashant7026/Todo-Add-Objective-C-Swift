//
//  HomeTableViewCell.m
//  Appeneure
//
//  Created by Prashant Kumar Soni on 07/12/24.
//

#import "HomeTableViewCell.h"
#import "UIKit/UIKit.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupUI];
}

-(void)setupUI {
    [self setupCntnrView];
    [self addCntnrViewConstraints];
}

-(void) setupCntnrView{
    self.cntnrView = [[UIView alloc] initWithFrame:CGRectZero];
    self.cntnrView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.cntnrView];
}

-(void) addCntnrViewConstraints{
    [NSLayoutConstraint activateConstraints:@[
        [self.cntnrView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
        [self.cntnrView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
        [self.cntnrView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
        [self.cntnrView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor]
    ]];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lblView = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_lblView];
        
        _lblView.translatesAutoresizingMaskIntoConstraints = NO;

        [NSLayoutConstraint activateConstraints:@[
            [_lblView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:10],
            [_lblView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-10],
            [_lblView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:10],
            [_lblView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-10]
        ]];
    }
    return self;
}

@end
