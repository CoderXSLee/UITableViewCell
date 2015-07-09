//
//  MainViewController.m
//  
//
//  Created by Ariel on 15/7/8.
//
//

#import "MainViewController.h"
#import "MCCommentCell.h"
#import "MCCommnetModel.h"

@interface MainViewController () < UITableViewDelegate,
                                    UITableViewDataSource,
                                    MCCommentDelegate>

@property (nonatomic, strong) UITableView *tableView; // tabelView
@property (nonatomic, strong) UIView *toolBar;        // 底部的toolBar
@property (nonatomic, strong) NSMutableArray *commentData;

@end

NSString *const cellID = @"commnetCell";

@implementation MainViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromSameRGB(241);
    

    [self initLoadData];            // 初始化评论数据
    
    [self initTabelView];           // 初始化tableView
    [self initToolBar];             // 初始化toolBar
    
//    [self initNavigationBar];       // 初始化导航栏
//    [self setAllConstraints];       // 设置所有的约束
}

#pragma mark - privateMethods
#pragma mark 导航栏
- (void)initNavigationBar {
    
}

#pragma mark 初始化 tableView
- (void)initTabelView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, APP_CONTENT_WIDTH, APP_CONTENT_HEIGHT)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[MCCommentCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:_tableView];
}

#pragma mark 初始化
- (void)initToolBar {
    
}

#pragma mark - UITableViewDelegate and UITableViewDataSource
#pragma mark 每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentData.count;
}

#pragma mark 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static MCCommentCell *cell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cell = [self.tableView dequeueReusableCellWithIdentifier:cellID];
    });
    [self configureCell:cell atIndexPath:indexPath];
    return [self calculateHeightForCell:cell];
}

- (CGFloat)calculateHeightForCell:(MCCommentCell *)cell {
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return ceilf(size.height);
}

- (void)configureCell:(MCCommentCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.cellData = self.commentData[indexPath.row];
    cell.delegate = self;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MCCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark 点击展开按钮
- (void)commentOpenButtonClick:(MCCommentCell *)currentCell {
    
    NSIndexPath *indepath = [_tableView indexPathForCell:currentCell];
    MCCommnetModel *model = _commentData[indepath.row];
    model.isOpenAllCommentDetail = !model.isOpenAllCommentDetail;
    [self.tableView reloadRowsAtIndexPaths:@[indepath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark 用户头像的点击事件
- (void)userIconClick:(MCCommentCell *)cell {
    
}

- (void)initLoadData {
    
    MCCommnetModel *model1 = [[MCCommnetModel alloc] init];
    model1.nickName = @"三妓淫领生活";
    model1.pic = @"IMG_0016";
    model1.publishTime = @"2015-06-11";
    model1.content = @"网易河北讯 夜里3:50许，闹铃响了，张女士和丈夫睁眼发现，小偷正趴在卧室的阳台上。震惊之余，丈夫起身追赶，没想到小偷顺势从三楼外墙管道溜下。合肥一名女业主在7月2日家中被盗后，冥冥中感觉贼会再次“光顾”，便在上次失窃的时间定好闹钟。事隔一天后，小偷果然“故地重游”，被女业主恰巧看见。遗憾的是，小偷还是跑掉了。";
    
    MCCommnetModel *model2 = [[MCCommnetModel alloc] init];
    model2.nickName = @"嗯哼~";
    model2.pic = @"2245";
    model2.publishTime = @"2015-06-11";
    model2.content = @"嗯哼~";
    
    MCCommnetModel *model3 = [[MCCommnetModel alloc] init];
    model3.nickName = @"嗯哼哼~~";
    model3.pic = @"1123";
    model3.publishTime = @"2015-06-11";
    model3.content = @"嗯哼哼~~";
    
    MCCommnetModel *model4 = [[MCCommnetModel alloc] init];
    model4.nickName = @"太奇葩!";
    model4.pic = @"4455";
    model4.publishTime = @"2015-06-11";
    model4.content = @"太奇葩!难道剁饺子馅能将阳台掉下楼?原来沈阳市大东区合作街120号的梧桐园小区发生楼体坍塌事故，7楼住户在家客厅好好地剁饺子馅，没想到7楼和6楼阳台整个掉到5楼，直将目击者惊呆了，所幸事发时2阳台上都没人，因此未造成人员伤亡，据悉事发小区有居民看见阳台与楼体之间断裂的部分之后发现楼板里面看不见粗钢筋。经多位该小区居民证实，这几栋回迁楼2002年入住，至今楼龄只有13年。现在该住户已经住到旅店。";
    
    NSArray *array = @[model1, model2, model3, model4];
    _commentData = [NSMutableArray arrayWithArray:array];
}

@end
