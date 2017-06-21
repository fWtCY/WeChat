//
//  ChatInformationViewController.m
//  WeChat
//
//  Created by Fuwentao on 2017/5/6.
//  Copyright © 2017年 Fuwentao. All rights reserved.
//

#import "ChatInformationViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "CustomTextView.h"
#import "EmotionTextAttachment.h"
#import "MessageUser.h"
#import "MessageTableViewCell.h"
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height
#define ScreenWidth   [UIScreen mainScreen].bounds.size.width
static NSString *cellID = @"cellID";

@interface ChatInformationViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextViewDelegate>{
    NSMutableArray *_chatInformationArr;
    UITableView *_chatInformationTableView;
    UIView *_buttonView;
    NSInteger _temp ;
    UIScrollView *_EmtionsScrollView;
    CustomTextView *_textFiled;
    UIPageControl *_pageControl;
    NSMutableArray *_emotionNameArr;
    NSMutableArray *_emotionImageArr;
    UIButton *_emotion;
    NSMutableArray *_data;
    
}


@end

@implementation ChatInformationViewController

- (void)viewDidLoad {
    _temp = 1; //用于决定表情按钮键盘按钮之间的变换
    [self createChatInformationData];
    [self createChatInformationTableView];
    [self createprintView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillShowAction:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillHidenAction:) name:UIKeyboardWillHideNotification object:nil];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//键盘出现触发事件
-(void)keyBoardWillShowAction:(NSNotification *)note{
    
    _buttonView.frame = CGRectMake(0, ScreenHeight-50-255, ScreenWidth, 50);
    _chatInformationTableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-50-255);
    [ _emotion setImage:[UIImage imageNamed:@"chat_bottom_smile_nor"] forState:UIControlStateNormal];
    [ _emotion setImage:[UIImage imageNamed:@"chat_bottom_smile_press"] forState:UIControlStateHighlighted];
    _temp = 1 ;
}
//键盘消失触发时间
-(void)keyBoardWillHidenAction:(NSNotification *)note{
//  _buttonView.frame = CGRectMake(0, ScreenHeight-50, ScreenWidth, 50);
//  _chatInformationTableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-50);
}
//导入聊天记录数据
-(void)createChatInformationData{
    _chatInformationArr = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil]];
    _data = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in _chatInformationArr) {
        MessageUser *messageUser = [[MessageUser alloc]init];
        messageUser.icon = dic[@"icon"];
        messageUser.content = dic[@"content"];
        messageUser.time = dic[@"time"];
        messageUser.selfOrOther = [dic[@"self"] boolValue];
        [_data addObject:messageUser];
    }
}
//创建表情图片名字和图片数组
-(void)createEmtionImageNameArrAndImageArr{
    //用来存储图片和图片名字
    _emotionImageArr = [NSMutableArray array];
    _emotionNameArr = [NSMutableArray array];
    for (int i = 1 ; i <= 85; i++) {
        [_emotionNameArr addObject:[NSString stringWithFormat:@"[/%03d]",i]];
        [_emotionImageArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%03d",i]]];
    }

}
//创建聊天记录表视图
-(void)createChatInformationTableView{
    _chatInformationTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-50) style:UITableViewStylePlain];
    _chatInformationTableView.dataSource = self;
    _chatInformationTableView.delegate = self;
    _chatInformationTableView.bounces = NO;
    _chatInformationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UITapGestureRecognizer *TGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tableviewAction:)];
    [_chatInformationTableView addGestureRecognizer:TGR];
//    _chatInformationTableView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_chatInformationTableView];
}
//单击tableView隐藏键盘和表情键盘
-(void)tableviewAction:(UITableView *)table{
    [_textFiled resignFirstResponder];
    [_EmtionsScrollView removeFromSuperview];
    [_pageControl removeFromSuperview];
    _buttonView.frame = CGRectMake(0, ScreenHeight-50, ScreenWidth, 50);
    _chatInformationTableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-50);

}

//创建下部输入框和表情，语音，更多按钮
-(void)createprintView{
    _buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-50, ScreenWidth, 50)];
    _buttonView.backgroundColor = [UIColor whiteColor];
    _buttonView.userInteractionEnabled = YES;
    //语音按钮
    UIButton *speechSoundButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
    [speechSoundButton setImage:[UIImage imageNamed:@"chat_bottom_voice_press"] forState:UIControlStateNormal];
//    speechSoundButton.layer.cornerRadius = 20;
//    speechSoundButton.layer.borderWidth = 1;
//    speechSoundButton.layer.borderColor = [UIColor grayColor];
    [_buttonView addSubview:speechSoundButton];
    
    //输入框
    _textFiled = [[CustomTextView alloc]initWithFrame:CGRectMake(50, 5, 230, 40)];
//    _textFiled.borderStyle = UITextBorderStyleRoundedRect;
    _textFiled.layer.borderWidth = 1;
    _textFiled.layer.cornerRadius = 5;
    _textFiled.layer.borderColor = [UIColor grayColor].CGColor;
    _textFiled.font = [UIFont systemFontOfSize:20];
    _textFiled.delegate = self;
    [_buttonView addSubview:_textFiled];
    //表情
    _emotion = [[UIButton alloc]initWithFrame:CGRectMake(5+230+50, 5, 40, 40)];
    [_emotion addTarget:self action:@selector(emtionsAction:) forControlEvents:UIControlEventTouchUpInside];
    [ _emotion setImage:[UIImage imageNamed:@"chat_bottom_smile_nor"] forState:UIControlStateNormal];
     [_emotion setImage:[UIImage imageNamed:@"chat_bottom_smile_press"] forState:UIControlStateHighlighted];
    [_buttonView addSubview: _emotion];
    
    //更多
    
    UIButton *moreButton = [[UIButton alloc]initWithFrame:CGRectMake(5+230+50+5+40  , 5, 40, 40)];
    [moreButton setImage:[UIImage imageNamed:@"chat_bottom_up_nor"] forState:UIControlStateNormal];
    [moreButton setImage:[UIImage imageNamed:@"chat_bottom_up_press"] forState:UIControlStateHighlighted];
    [_buttonView addSubview: moreButton];
    
    
    [self.view addSubview:_buttonView];
}
//表情和键盘按钮的响应
-(void)emtionsAction:(UIButton *)button{
        if (_temp == 1) {
        [self createEmtionsView];
        _buttonView.frame = CGRectMake(0, ScreenHeight-50-255, ScreenWidth, 50);
        _chatInformationTableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-50-255);
        [button setImage:[UIImage imageNamed:@"chat_bottom_keyboard_nor"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"chat_bottom_keyboard_press"] forState:UIControlStateHighlighted];
        [_textFiled resignFirstResponder];
        _temp = 0;}
        else{
        [ button setImage:[UIImage imageNamed:@"chat_bottom_smile_nor"] forState:UIControlStateNormal];
        [ button setImage:[UIImage imageNamed:@"chat_bottom_smile_press"] forState:UIControlStateHighlighted];
        [_EmtionsScrollView removeFromSuperview];
        [_textFiled becomeFirstResponder];
        _temp = 1;
    }

}
//创建表情按钮弹出的视图
-(void)createEmtionsView{
    _EmtionsScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, ScreenHeight-255 , ScreenWidth,ScreenHeight-255)];
    _EmtionsScrollView.backgroundColor = [UIColor whiteColor];
    
    _EmtionsScrollView.contentSize = CGSizeMake(4*ScreenWidth,ScreenHeight-255);
    _EmtionsScrollView.userInteractionEnabled = YES;
    _EmtionsScrollView.bounces = NO;
    _EmtionsScrollView.showsHorizontalScrollIndicator = NO;
    _EmtionsScrollView.pagingEnabled = YES;
    _EmtionsScrollView.delegate = self;
    //把生成表情的各种按钮
    NSInteger interval = ScreenWidth/7;
     NSInteger number = 1;
    for (int x = 1; x<=5; x++) {
    for (int y =0; y<4; y++) {
        for ( int z= (x-1)*ScreenWidth; z<x*ScreenWidth-interval&&number<=85; z+=interval) {
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(z+5, y*interval, interval, interval)];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%03ld",number]] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(createEmtionButton:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 1000+number-1;
            number ++;
            [_EmtionsScrollView addSubview:button];
        }
    }
    }
    [self.view addSubview:_EmtionsScrollView];
    [self createEmtionImageNameArrAndImageArr];
    [self createPageControl];
}

//表情按钮的响应插入到TextView
-(void)createEmtionButton:(UIButton *)button{
    EmotionTextAttachment *emtionTextAttachment = [[EmotionTextAttachment alloc]init];
    emtionTextAttachment.image = _emotionImageArr[button.tag-1000];
    emtionTextAttachment.emotionTag = _emotionNameArr[button.tag-1000];
    emtionTextAttachment.emotionSize = CGSizeMake(25,25);
    NSAttributedString *str = [NSAttributedString attributedStringWithAttachment:emtionTextAttachment];
    [_textFiled.textStorage insertAttributedString:str atIndex:_textFiled.selectedRange.location];
    
    _textFiled.selectedRange = NSMakeRange(_textFiled.selectedRange.location+1, 0);
      _textFiled.font = [UIFont systemFontOfSize:20];
    //自动滚动到最后一行
    [_textFiled scrollRectToVisible:CGRectMake(0, _textFiled.contentSize.height-15, _textFiled.contentSize.width, 10) animated:YES];
}
//创建pageControl
-(void)createPageControl{
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,ScreenHeight-59, ScreenWidth, 59)];
    _pageControl.numberOfPages = 4;
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    [_pageControl addTarget:self action:@selector(pageControlAction:) forControlEvents:UIControlEventValueChanged  ];
    [self.view addSubview:_pageControl];
}
//pageCtrol响应
-(void)pageControlAction:(UIPageControl *)pageControl{
     [_EmtionsScrollView scrollRectToVisible:CGRectMake(pageControl.currentPage*ScreenWidth, 0, ScreenWidth,ScreenHeight-255) animated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
     if (cell == nil) {
         cell = [[MessageTableViewCell alloc]initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:cellID];
         
        }
    cell.messageUser = _data[indexPath.row];
    return cell;
 }
//单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageUser *messageUser = _data[indexPath.row];
    return messageUser.fream.size.height+25;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        MessageUser *messageInformation = [[MessageUser alloc]init];
        messageInformation.icon = @"icon01.jpg";
        messageInformation.content = _textFiled.text;
        NSLog(@"123456%@",[[NSAttributedString alloc]initWithAttributedString:_textFiled.attributedText]);
        _textFiled.text = nil;
        messageInformation.time = [NSString stringWithFormat:@"%@",[NSDate date]];
        messageInformation.selfOrOther = YES;
        [_data addObject:messageInformation];
        NSIndexPath *index = [NSIndexPath indexPathForRow:_data.count-1 inSection:0];
        [_chatInformationTableView insertRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationRight];
        [_chatInformationTableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionNone animated:YES];
        return NO;
    }
    return YES;
}
@end
