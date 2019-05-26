#import "RLSDCScrollVIew.h"
#import "RLSFenxiHeaderView.h"
#import "PictureModel.h"
#import "RLSFenxiPageVC.h"
#import "RLSBifenDTTable.h"
#import "RLSNewQingbaoTableView.h"
#import "RLSInfoListModel.h"
#import "RLSTuijianDatingTableView.h"
#import "RLSTitleIndexView.h"
#import "RLSLivingModel.h"
#import "RLSTimeModel.h"
#import "RLSNewTuijianHtml.h"
#import "RLSZhiboTableView.h"
#import "RLSJiBenWebView.h"
#import "RLSRelRecNewVC.h"
#import "RLSToAnalystsVC.h"
#import "RLSFenXiHeaderBottomView.h"
#import "SRWebSocket.h"
#import "RLSRecommendedWebView.h"
#import "ArchiveFile.h"
#import "RLSToolWebViewController.h"
#import "RLSAnalysisWebview.h"
#import "RLSShowActivityView.h"
#import "RLSRecommendedWKWeb.h"

#import <NELivePlayerFramework/NELivePlayerFramework.h>
#import "NELivePlayerControlView.h"
#import <Photos/Photos.h>

#import "VideoLoading.h"


@interface RLSFenxiPageVC ()<UIScrollViewDelegate,NewQingbaoTableViewDelegate,TuijianDatingTableViewDelegate,ViewPagerDelegate,TitleIndexViewDelegate,FenxiHeaderViewDelegate,UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate,SRWebSocketDelegate, NELivePlayerControlViewProtocol, UIGestureRecognizerDelegate>

@property (nonatomic, strong) RLSBifenDTTable *tableView;
@property (nonatomic, strong) RLSTitleIndexView *titleView;
@property (nonatomic, strong) RLSDCScrollVIew *scrollMainView;
@property (nonatomic, strong) NSMutableArray *arrTableViews;
@property (nonatomic, strong) RLSFenXiHeaderBottomView        *hederBottomView;
@property (nonatomic, assign) BOOL hideHeaderView;
@property (nonatomic, strong) RLSFenxiHeaderView *headerView;
@property (nonatomic, strong) RLSNewQingbaoTableView *NewQBTableView;
@property (nonatomic, strong) RLSTuijianDatingTableView *tuiJianTable;
@property (nonatomic, strong) RLSJiBenWebView *webView;
@property (nonatomic, strong) RLSRecommendedWKWeb *webViewZhiShu;
@property (nonatomic, strong) RLSRecommendedWKWeb *recommendWeb;
@property (nonatomic , strong) RLSAnalysisWebview *analysisWeb; 
@property (nonatomic, strong) RLSRecommendedWKWeb *webZhiBo;
@property (nonatomic, assign) NSInteger typeNum;
@property (nonatomic, assign) CGFloat   temHeight;
@property (nonatomic, strong) UIButton *btnFabu;
@property (nonatomic, strong) UIButton *btnFabuJingcai;
@property (nonatomic, strong) UIButton *btnFabuTuijian;
@property (nonatomic, assign) NSInteger isShareQB;
@property (nonatomic, assign)BOOL mainTableCanscroll;
@property (nonatomic, strong) RLSNavView *nav;
@property (nonatomic, strong) UIView *viewT;
@property (nonatomic, strong) UILabel *labVS;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic,strong)SRWebSocket *webSocket;
@property (nonatomic , strong) UIImageView *liveQuizImageView;
@property (nonatomic , copy) NSDictionary *activityDic;
@property (nonatomic, assign) BOOL isBack;
@property (nonatomic , strong) RLSShowActivityView *animationActivityView;


@property (nonatomic, strong) UIView *playerContainerView; // 视频播放容器
@property (nonatomic, strong) NELivePlayerController *player; //播放器sdk
@property (nonatomic, strong) NELivePlayerControlView *controlView; //播放器控制视图
//外挂字幕处理缓存
@property (nonatomic, strong) NSMutableArray *subtitleIdArray;
@property (nonatomic, strong) NSMutableDictionary *subtitleDic;
@property (nonatomic, strong) NSMutableArray *exSubtitleIdArray;
@property (nonatomic, strong) NSMutableDictionary *exSubtitleDic;
@property (nonatomic , strong) dispatch_source_t timerSource;
@property (nonatomic , copy) NSString *videoSingal;

@property (nonatomic , strong) VideoLoading *videoLoadingView;



@end

@implementation RLSFenxiPageVC

#pragma mark - System Method

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.player.playbackState == NELPMoviePlaybackStatePlaying ) {
        [self doDestroyPlayer];
    }
    self.isBack = YES;
}


-(BOOL)shouldAutorotate{        //必须关闭旋转屏幕
    return NO;      //默认YES
}


#pragma mark - FenxiHeaderViewDelegate

- (void)tapPlayVideoAction:(NSString *)signal {
    _videoSingal = signal;
    [self.view addSubview:self.playerContainerView];
    [self initializationPlayer];
    [self doInitPlayerNotication];
    
}

#pragma mark - 播放器通知事件

- (void)NELivePlayerDidPreparedToPlay:(NSNotification*)notification {
    // 调用prepareToPlay之后
    //获取视频信息，主要是为了告诉界面的可视范围，方便字幕显示


    NELPVideoInfo info;
    memset(&info, 0, sizeof(NELPVideoInfo));
    [_player getVideoInfo:&info];
    _controlView.videoResolution = CGSizeMake(info.width, info.height);
    
    [self syncUIStatus];
    [_player play]; //开始播放
    
    //开
    [_player setRealTimeListenerWithIntervalMS:500 callback:^(NSTimeInterval realTime) {
        NSLog(@"当前时间戳：[%f]", realTime);
    }];
    
    //关
    [_player setRealTimeListenerWithIntervalMS:500 callback:nil];
}

- (void)NELivePlayerPlaybackStateChanged:(NSNotification*)notification {
    // 播放状态发生改变时发出
}

- (void)NeLivePlayerloadStateChanged:(NSNotification*)notification {
   
    // 加载状态发生改变时
    
    NELPMovieLoadState nelpLoadState = _player.loadState;
    
    if (nelpLoadState == NELPMovieLoadStatePlaythroughOK)
    {
        NSLog(@"finish buffering");
        _controlView.isBuffing = NO;
    }
    else if (nelpLoadState == NELPMovieLoadStateStalled)
    {
        NSLog(@"begin buffering");
        _controlView.isBuffing = YES;
    }
}

- (void)NELivePlayerPlayBackFinished:(NSNotification*)notification {
    // 播放完成时发送
    
    UIAlertController *alertController = NULL;
    UIAlertAction *action = NULL;
    __weak typeof(self) weakSelf = self;
    switch ([[[notification userInfo] valueForKey:NELivePlayerPlaybackDidFinishReasonUserInfoKey] intValue])
    {
        case NELPMovieFinishReasonPlaybackEnded: {
            alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"直播结束" preferredStyle:UIAlertControllerStyleAlert];
            action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                [weakSelf doDestroyPlayer];
                [self.playerContainerView removeFromSuperview];
                self.playerContainerView = nil;
            }];
            [alertController addAction:action];
            [weakSelf presentViewController:alertController animated:YES completion:nil];
        }
            break;
        
        case NELPMovieFinishReasonPlaybackError: {
            alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"加载失败" preferredStyle:UIAlertControllerStyleAlert];
            action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                [weakSelf doDestroyPlayer];
                [self.playerContainerView removeFromSuperview];
                self.playerContainerView = nil;
            }];
            [alertController addAction:action];
            [weakSelf presentViewController:alertController animated:YES completion:nil];
        }
             break;
           
        case NELPMovieFinishReasonUserExited: {
            
        }
            break;
            
        default: {
            
        }
            break;
    }
}

- (void)NELivePlayerFirstVideoDisplayed:(NSNotification*)notification {
   // 第一帧视频显示时发出
    if (_videoLoadingView) {
        [_videoLoadingView dismiss];
        _videoLoadingView = nil;
    }
}

- (void)NELivePlayerFirstAudioDisplayed:(NSNotification*)notification {
    //  第一帧音频播放时发出
}

- (void)NELivePlayerVideoParseError:(NSNotification*)notification {
    NSLog(@"[NELivePlayer Demo] 收到 NELivePlayerVideoParseError 通知");
}

- (void)NELivePlayerSeekComplete:(NSNotification*)notification {
   // seek完成时发出，仅用于点播
    [self cleanSubtitls];
}

- (void)NELivePlayerReleaseSuccess:(NSNotification*)notification {
   // NELivePlayerReleaseSueecssNotification
}

#pragma mark - 控制页面的事件

- (void)controlViewOnClickQuit:(NELivePlayerControlView *)controlView {
    NSLog(@"[NELivePlayer Demo] 点击退出");
    
    if (self.playerContainerView.width > self.headerView.width) {
        CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
        [UIView animateWithDuration:duration animations:^{
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
            self.view.transform = CGAffineTransformIdentity;
            self.view.frame = CGRectMake(0, 0, Width, Height);
            self.playerContainerView.frame = self.headerView.frame;
            self.player.view.frame = self.playerContainerView.bounds;
            self.controlView.frame = self.playerContainerView.bounds;
        }];
        
        return;
    }
    
    [self doDestroyPlayer];
    
    // 释放timer
    if (_timerSource != nil) {
        dispatch_source_cancel(_timerSource);
        _timerSource = nil;
    }
    
    [self.navigationController popViewControllerAnimated:true];
}

- (void)controlViewOnClickPlay:(NELivePlayerControlView *)controlView isPlay:(BOOL)isPlay {
    NSLog(@"[NELivePlayer Demo] 点击播放，当前状态: [%@]", (isPlay ? @"播放" : @"暂停"));
    if (isPlay) {
        [self.player play];
    } else {
        [self.player pause];
    }
}

- (void)controlViewOnClickSeek:(NELivePlayerControlView *)controlView dstTime:(NSTimeInterval)dstTime {
    NSLog(@"[NELivePlayer Demo] 执行seek，目标时间: [%f]", dstTime);
    self.player.currentPlaybackTime = dstTime;
}

- (void)controlViewOnClickMute:(NELivePlayerControlView *)controlView isMute:(BOOL)isMute{
    NSLog(@"[NELivePlayer Demo] 点击静音，当前状态: [%@]", (isMute ? @"静音开" : @"静音关"));
    [self.player setMute:isMute];
}

- (void)controlViewOnClickSnap:(NELivePlayerControlView *)controlView{
    
    NSLog(@"[NELivePlayer Demo] 点击屏幕截图");
    
    UIImage *snapImage = [self.player getSnapshot];

    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:snapImage];
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {

        if(success){
            [SVProgressHUD showSuccessWithStatus:@"图片保存成功"];
        }else{
            [SVProgressHUD showSuccessWithStatus:@"图片保存失败"];
        }
        
    }];
}

- (void)controlViewOnClickScale:(NELivePlayerControlView *)controlView isFill:(BOOL)isFill {
    NSLog(@"[NELivePlayer Demo] 点击屏幕缩放，当前状态: [%@]", (isFill ? @"全屏" : @"适应"));
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [UIView animateWithDuration:duration animations:^{
        [[UIApplication sharedApplication] setStatusBarOrientation:isFill ? UIInterfaceOrientationLandscapeRight : UIInterfaceOrientationPortrait];
        
        self.view.transform = isFill ? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformIdentity;
        if (isFill) {
             self.view.frame = CGRectMake(0, 0, Height, Width);
            self.playerContainerView.frame = self.view.bounds;
        } else {
             self.view.frame = CGRectMake(0, 0, Width, Height);
            self.playerContainerView.frame = self.headerView.frame;
        }
        self.player.view.frame = self.playerContainerView.bounds;
        self.controlView.frame = self.playerContainerView.bounds;
    }];
}

#pragma mark  播放器SDK功能

- (void)initializationPlayer {
    
    _videoLoadingView = [[VideoLoading alloc]initWithFrame:self.controlView.bounds];
    [self.playerContainerView addSubview:_videoLoadingView];
    [_videoLoadingView startAnimation];
    
    
    
    [NELivePlayerController setLogLevel:NELP_LOG_VERBOSE];
    NSError *error = nil;
    NSURL *url = [NSURL URLWithString:_videoSingal];
    self.player = [[NELivePlayerController alloc]initWithContentURL:url error:&error];
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.player.view.frame = self.playerContainerView.bounds;
    [self.playerContainerView addSubview:self.player.view];
    
    self.view.autoresizesSubviews = true;
    [self.player setBufferStrategy:NELPFluent]; // 直播低延时模式
    [self.player setShouldAutoplay:YES]; // 设置prepareToPlay完成后是否自动播放
    [self.player setHardwareDecoder:true]; // 设置解码模式，是否开启硬件解码
    [self.player setPauseInBackground:NO]; // 设置切入后台时的状态，暂停还是继续播放
    [self.player setPlaybackTimeout:15 *1000]; // 设置拉流超时时间
    [self.player setScalingMode:NELPMovieScalingModeNone]; // 设置画面显示模式，默认原始大小
    [self.player setScalingMode:NELPMovieScalingModeAspectFill];
    [self.player prepareToPlay];
    
    [self.playerContainerView addSubview:self.controlView];
}

- (void)doInitPlayerNotication {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerDidPreparedToPlay:)
                                                 name:NELivePlayerDidPreparedToPlayNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerPlaybackStateChanged:)
                                                 name:NELivePlayerPlaybackStateChangedNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NeLivePlayerloadStateChanged:)
                                                 name:NELivePlayerLoadStateChangedNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerPlayBackFinished:)
                                                 name:NELivePlayerPlaybackFinishedNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerFirstVideoDisplayed:)
                                                 name:NELivePlayerFirstVideoDisplayedNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerFirstAudioDisplayed:)
                                                 name:NELivePlayerFirstAudioDisplayedNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerReleaseSuccess:)
                                                 name:NELivePlayerReleaseSueecssNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerVideoParseError:)
                                                 name:NELivePlayerVideoParseErrorNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerSeekComplete:)
                                                 name:NELivePlayerMoviePlayerSeekCompletedNotification
                                               object:_player];
}

- (void)syncUIStatus
{
    _controlView.isPlaying = NO;
    
    __block NSTimeInterval mDuration = 0;
    __block bool getDurFlag = false;
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t syncUIQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timerSource = CreateDispatchSyncUITimerN(1.0, syncUIQueue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (!getDurFlag) {
                mDuration = [weakSelf.player duration];
                if (mDuration > 0) {
                    getDurFlag = true;
                }
            }
            
            weakSelf.controlView.isAllowSeek = (mDuration > 0);
            weakSelf.controlView.duration = mDuration;
            weakSelf.controlView.currentPos = [weakSelf.player currentPlaybackTime];
            weakSelf.controlView.isPlaying = ([weakSelf.player playbackState] == NELPMoviePlaybackStatePlaying);
        });
    });
}

- (void)doDestroyPlayer {
    [self.player shutdown]; // 退出播放并释放相关资源
    [self.player.view removeFromSuperview];
    self.player = nil;
}

- (void)cleanSubtitls { //seek完成后，或者切换完字幕，需要清空
    [_exSubtitleDic removeAllObjects];
    [_exSubtitleIdArray removeAllObjects];
    [_subtitleDic removeAllObjects];
    [_subtitleIdArray removeAllObjects];
    
    //更新UI
    _controlView.subtitle_ex = @"";
    _controlView.subtitle = @"";
}

#pragma mark - Tools

dispatch_source_t CreateDispatchSyncUITimerN(double interval, dispatch_queue_t queue, dispatch_block_t block)
{
    //创建Timer
    dispatch_source_t timer  = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);//queue是一个专门执行timer回调的GCD队列
    if (timer) {
        //使用dispatch_source_set_timer函数设置timer参数
        dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval*NSEC_PER_SEC), interval*NSEC_PER_SEC, (1ull * NSEC_PER_SEC)/10);
        //设置回调
        dispatch_source_set_event_handler(timer, block);
        //dispatch_source默认是Suspended状态，通过dispatch_resume函数开始它
        dispatch_resume(timer);
    }
    
    return timer;
}

#pragma mark - Lazy Load

- (UIView *)playerContainerView {
    if (_playerContainerView == nil) {
        _playerContainerView = [[UIView alloc]initWithFrame:self.headerView.frame];

        _playerContainerView.backgroundColor = [UIColor whiteColor];
    }
    return _playerContainerView;
}

- (NELivePlayerControlView *)controlView {
    if (_controlView == nil) {
        _controlView = [[NELivePlayerControlView alloc] initWithFrame:_playerContainerView.bounds];
        _controlView.delegate = self;
    }
    return _controlView;
}

#pragma mark - ************  以下高人所写  ************

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _mainTableCanscroll = YES;
    [[UINavigationBar appearance]setTranslucent:NO];
    [[UITabBar appearance]setTranslucent:NO];
    if (!self.currentIndex) {
        self.currentIndex = 0;
    }
    self.view .backgroundColor = [UIColor whiteColor];
    _isShareQB = 0;
    _typeNum = 1;
    [self.scrollMainView setContentOffset:CGPointMake(self.currentIndex * Width,0) animated:NO];
    [self.titleView updateSelectedIndex:self.currentIndex];
    self.headerView.imageRight.hidden = YES;
    _nav.btnRight.hidden = YES;
    [self.view addSubview:self.tableView];
    [self setNavView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateHeaderData:) name:@"NSNotificationupdateHeaderData" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTableViewFrame) name:@"changeTableViewFrame" object:nil];
    if (self.model.matchstate ==0) {
        _btnFabuTuijian = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnFabuTuijian.frame = CGRectMake(Width - 40 - 34, Height - 35 - 40 , 70, 70);
        [_btnFabuTuijian setBackgroundImage:[UIImage imageNamed:@"fabunewtuijian"] forState:UIControlStateNormal];
        [_btnFabuTuijian setBackgroundImage:[UIImage imageNamed:@"fabunewtuijian"] forState:UIControlStateHighlighted];
        [_btnFabuTuijian addTarget:self action:@selector(btnFabuCilick:) forControlEvents:UIControlEventTouchUpInside];
        _btnFabuTuijian.tag = 2;
        _btnFabu = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnFabu.frame = CGRectMake(Width - 40 - 34, Height - 35 - 40 , 40, 40);
        _btnFabuJingcai.center = _btnFabu.center;
        _btnFabuTuijian.center = _btnFabu.center;
        [_btnFabu setBackgroundImage:[UIImage imageNamed:@"addJingcai"] forState:UIControlStateNormal];
        [_btnFabu setBackgroundImage:[UIImage imageNamed:@"addJingcaiS"] forState:UIControlStateSelected];
        [_btnFabu addTarget:self action:@selector(btnFabuCilick:) forControlEvents:UIControlEventTouchUpInside];
        _btnFabu.hidden = YES;
        _btnFabu.tag = 1;
    }
    [self.view addSubview:self.liveQuizImageView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    if (_model.matchstate>0) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerChange) userInfo:nil repeats:YES];
    }else if(_model.matchstate == 0){
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    }else{
    }
    if (self.isBack) {
        [self.analysisWeb reloadData];
        [self.recommendWeb reloadData];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self loadLiveData];
    });
    
    if (_playerContainerView) {
        [self initializationPlayer];
        [self doInitPlayerNotication];
    }
    
    [self lodaDataAnalysisQB];
    [self lodaDataTiDian];
   
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_timer invalidate];
    _timer = nil;
    self.webSocket.delegate = nil;
    [self.webSocket close];
    self.webSocket = nil;
}
- (void)timerRun
{
    NSDate *matchDate = [RLSMethods getDateFromString:_model.matchtime byformat:dateStyleFormatter];
    NSTimeInterval timerInt = [matchDate timeIntervalSince1970];
    NSTimeInterval timeNow = [[NSDate date] timeIntervalSince1970];
    NSInteger timeout= timerInt - timeNow;
        if (timeout>0) {
        NSString *str_hour = [NSString stringWithFormat:@"%ld",timeout/3600];
            if (str_hour.length<=2) {
                str_hour =[NSString stringWithFormat:@"%02ld",timeout/3600];
            }
        NSString *str_minute = [NSString stringWithFormat:@"%02ld",(timeout%3600)/60];
        NSString *str_second = [NSString stringWithFormat:@"%02ld",timeout%60];
        NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
            if ([str_hour integerValue]>24) {
                format_time = @"VS";
                [_timer invalidate];
            }
        [_headerView changeCountTimeWithTime:format_time];
        }else{
            [_timer invalidate];
            [_headerView changeCountTimeWithTime:@"VS"];
            _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerChange) userInfo:nil repeats:YES];
        }
}
- (void)timerChange
{
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:nil PathUrlL:[NSString stringWithFormat:@"%@%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_change] Start:^(id requestOrignal) {
        [_timer setFireDate:[NSDate distantFuture]];
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        NSArray *arrLiving = [RLSLivingModel arrayOfEntitiesFromArray:responseOrignal];
        for (int i = 0; i<arrLiving.count; i++) {
            RLSLivingModel *living = [arrLiving objectAtIndex:i];
            if (living.sid == _model.mid) {
                _model.matchstate = living.code;
                _model.homescore = living.hsc;
                _model.guestscore = living.gsc;
                _model.matchtime2 = living.htime;
                [_headerView updateScroeWithmodel:_model];
                if (_model.matchstate == -1 || _model.matchstate>0) {
                    _labVS.text = [NSString stringWithFormat:@"%ld:%ld", _model.homescore,_model.guestscore];
                }else{
                    _labVS.text = @"vs";
                }
                if (_model.matchstate <0) {
                    [_timer invalidate];
                }
                break;
            }
        }
        [self performSelector:@selector(startTime) withObject:nil afterDelay:5];
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        NSLog(@"%@",responseOrignal);
        [self performSelector:@selector(startTime) withObject:nil afterDelay:5];
    }];
}
- (void)startTime
{
    [_timer setFireDate:[NSDate distantPast]];
}
#pragma mark -- setnavView
- (void)setNavView
{
    _nav = [[RLSNavView alloc] init];
    _nav.delegate = self;
    [_nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [_nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
       _nav.bgView.alpha = 0;
    _nav.backgroundColor = [UIColor clearColor];
    _viewT = [[UIView alloc] initWithFrame:_nav.labTitle.frame];
    _viewT.alpha = 0;
    [_nav addSubview:_viewT];
    _labVS = [[UILabel alloc] init];
    _labVS.textColor = [UIColor whiteColor];
    _labVS.font = font16;
    if (_model.matchstate == -1 || _model.matchstate>0) {
        _labVS.text = [NSString stringWithFormat:@"%ld:%ld", _model.homescore,_model.guestscore];
    }else{
        _labVS.text = @"vs";
    }
    [_viewT addSubview:_labVS];
    [_labVS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_viewT.mas_centerY);
        make.centerX.equalTo(_viewT.mas_centerX);
    }];
    UILabel *labHome = [[UILabel alloc] init];
    labHome.textColor = [UIColor whiteColor];
    labHome.font = font16;
    labHome.text = _model.hometeam;
    labHome.textAlignment = NSTextAlignmentRight;
    [_viewT addSubview:labHome];
    [labHome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_viewT.mas_centerY);
        make.right.equalTo(_labVS.mas_left).offset(-10);
        make.width.mas_equalTo(125*Scale_Ratio_width);
    }];
    UILabel *labGuest = [[UILabel alloc] init];
    labGuest.textColor = [UIColor whiteColor];
    labGuest.font = font16;
    labGuest.text = _model.guestteam;
    [_viewT addSubview:labGuest];
    [labGuest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_viewT.mas_centerY);
        make.left.equalTo(_labVS.mas_right).offset(10);
        make.width.mas_equalTo(125*Scale_Ratio_width);
    }];
    [self.view addSubview:_nav];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
        [self rightBtnClick];
    }
}
- (void)changeTableViewFrame
{
    self.mainTableCanscroll = YES;
    self.analysisWeb.cellCanScroll = NO;
    self.webViewZhiShu.cellCanScroll = NO;
    self.webZhiBo.cellCanScroll = NO;
    self.NewQBTableView.cellCanScroll = NO;
    self.recommendWeb.cellCanScroll = NO;
}
- (void)updateHeaderData:(NSNotification *)notific
{
    NSArray *arrfenxiHeader = [notific.userInfo objectForKey:@"NSNotificationupdateHeaderData"];
    for (int i = 0; i<arrfenxiHeader.count; i++) {
        RLSLiveScoreModel *liveModel = [arrfenxiHeader objectAtIndex:i];
        if (liveModel.mid == _headerView.model.mid) {
            _headerView.model = liveModel;
            break;
        }
    }
}
#pragma mark -- UITableViewDataSource
- (RLSBifenDTTable *)tableView
{
    if (!_tableView) {
        _tableView = [[RLSBifenDTTable alloc] initWithFrame:CGRectMake(0, 0, Width, Height) style:UITableViewStylePlain];
        _tableView.tag = 10;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.delegate =self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [(self.model.weather) isEqualToString:@""]? 164 : 190;
    }
    return Height - 44 - APPDELEGATE.customTabbar.height_myNavigationBar;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 44;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return self.titleView;
    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        while ([cell.contentView.subviews lastObject]!= nil) {
            [[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    if (indexPath.section == 0) {
        [cell.contentView addSubview:self.headerView];
    }else{
        [cell.contentView addSubview:self.scrollMainView];
    }
    return cell;
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (RLSFenxiHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[RLSFenxiHeaderView alloc] initWithFrame:CGRectMake(0, 0, Width, [(self.model.weather) isEqualToString:@""]? 164 : 190)]; 
        _headerView.model = self.model;
        _headerView.delegate = self;
    }
    return _headerView;
}
- (UIView *)hederBottomView {
    if (!_hederBottomView) {
        _hederBottomView = [[RLSFenXiHeaderBottomView alloc] initWithFrame:CGRectMake(0, _headerView.bottom, Width, 40)];
        _hederBottomView.backgroundColor = redcolor;
    }
    return _hederBottomView;
}
- (void)backClick:(NSInteger)btnTag
{
    if (btnTag == 1) {
            [self.navigationController  popViewControllerAnimated:YES];
    }else{
        [self rightBtnClick];
    }
}
- (void)rightBtnClick
{
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObjectsFromArray:_NewQBTableView.arrhomeInfo];
    [arr addObjectsFromArray:_NewQBTableView.arrneutralInfo];
    [arr addObjectsFromArray:_NewQBTableView.arrawayInfo];
    if (arr.count>0) {}
}
- (RLSDCScrollVIew *)scrollMainView
{
    if (!_scrollMainView) {
        _scrollMainView = [[RLSDCScrollVIew alloc] initWithFrame:CGRectMake(0, 0, Width, Height - 44 - APPDELEGATE.customTabbar.height_myNavigationBar)];;
        _scrollMainView.tag = 11;
        _scrollMainView.pagingEnabled = YES;
        _scrollMainView.delegate = self;
        _scrollMainView.bounces = NO;
        _scrollMainView.contentSize = CGSizeMake(Width*5, 0);
        _arrTableViews = [NSMutableArray array];
        [self.scrollMainView addSubview:self.analysisWeb];
        [self.scrollMainView addSubview:self.webViewZhiShu];
        [_scrollMainView addSubview:self.NewQBTableView];
        [_scrollMainView addSubview:self.recommendWeb];
        [_scrollMainView addSubview:self.webZhiBo];
//        [self.webZhiBo addSegMent];
    }
    return _scrollMainView;
}
- (void)btnFabuCilick:(UIButton *)btn
{
    switch (btn.tag) {
        case 1:
        {
            if (btn.selected == YES) {
                _btnFabu.selected = NO;
                [UIView animateWithDuration:0.5 animations:^{
                    _btnFabuTuijian.frame = CGRectMake(Width - 40 - 34, Height - 35 - 40 , 70, 70);
                    _btnFabuJingcai.frame = CGRectMake(Width - 40 - 34, Height - 35 - 40 , 30, 30);
                    _btnFabuJingcai.center = _btnFabu.center;
                    _btnFabuTuijian.center = _btnFabu.center;
                } completion:^(BOOL finished) {
                }];
            }else{
                _btnFabu.selected = YES;
                [UIView animateWithDuration:0.5 animations:^{
                    _btnFabuTuijian.frame = CGRectMake(Width - 34 - 40 - 26 - 40, Height - 29 - 40, 70, 70);
                    _btnFabuJingcai.frame = CGRectMake(Width - 70 - 40, Height - 35 - 40 - 13 - 40, 40, 40);
                } completion:^(BOOL finished) {
                }];
            }
        }
            break;
        case 2:
        {
            [UIView animateWithDuration:0.5 animations:^{
                _btnFabuTuijian.frame = CGRectMake(Width - 40 - 34, Height - 35 - 40 , 70, 70);
                _btnFabuJingcai.frame = CGRectMake(Width - 40 - 34, Height - 35 - 40 , 30, 30);
                _btnFabuJingcai.center = _btnFabu.center;
                _btnFabuTuijian.center = _btnFabu.center;
            } completion:^(BOOL finished) {
            }];
            _btnFabu.selected = NO;
            if (![RLSMethods login]) {
                [RLSMethods toLogin];
                return;
            }
            [[RLSDependetNetMethods sharedInstance] loadUserInfocompletion:^(RLSUserModel *userback) {
                [self toapplyAnalasis];
            } errorMessage:^(NSString *msg) {
                [self toapplyAnalasis];
            }];
        }
            break;
        case 3:
        {
            _btnFabu.selected = NO;
            [UIView animateWithDuration:0.5 animations:^{
                _btnFabuTuijian.frame = CGRectMake(Width - 40 - 34, Height - 35 - 40 , 70, 70);
                _btnFabuJingcai.frame = CGRectMake(Width - 40 - 34, Height - 35 - 40 , 30, 30);
                _btnFabuJingcai.center = _btnFabu.center;
                _btnFabuTuijian.center = _btnFabu.center;
            } completion:^(BOOL finished) {
            }];
            if (![RLSMethods login]) {
                [RLSMethods toLogin];
                return;
            }
            RLSDan_StringMatchsModel *remodel = [RLSDan_StringMatchsModel entityFromDictionary:[NSDictionary dictionary]];
            remodel.sid = _model.mid;
            remodel.hometeam = _model.hometeam;
            remodel.guestteam = _model.guestteam;
        }
            break;
        default:
            break;
    }
}
- (void)toapplyAnalasis
{
    RLSUserModel *user = [RLSMethods getUserModel];
    if (user.analyst == 1) {
        if (user.reachLimit == YES) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"周一~周五每天不超过5个方案，周六~周日每天不超过10个方案"];
            return;
        }
        RLSDan_StringMatchsModel *remodel = [RLSDan_StringMatchsModel entityFromDictionary:[NSDictionary dictionary]];
        remodel.sid = _model.mid;
        remodel.hometeam = _model.hometeam;
        remodel.guestteam = _model.guestteam;
        RLSRelRecNewVC *relVC = [[RLSRelRecNewVC alloc] init];
        relVC.model = remodel;
        relVC.hidesBottomBarWhenPushed = YES;
        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
        [parameter setObject:@(_model.mid) forKey:@"ScheduleID"];
        [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_SingalRecommendMatch] Start:^(id requestOrignal) {
        } End:^(id responseOrignal) {
        } Success:^(id responseResult, id responseOrignal) {
             NSLog(@"fatuijian判断=%@",responseOrignal);
            if ([[responseOrignal objectForKey:@"code"] integerValue]==200) {
                NSDictionary*data=[responseOrignal objectForKey:@"data"];
                NSDictionary*instantOdds=data[@"instantOdds"];
                NSArray*rq=instantOdds[@"rq"];
                NSArray*spf=instantOdds[@"spf"];
                NSArray*dx=instantOdds[@"dx"];
                if (rq.count == 0 && dx.count == 0 &&spf.count == 0) {
                    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"暂无数据，无法发推荐！"];
                    return;
                }
                [APPDELEGATE.customTabbar pushToViewController:relVC animated:YES];
            }
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            return ;
        }];
        return;
}
    NSString *strTitle = @"您尚未认证分析师";
    NSString *str_content = @"申请分析师";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:strTitle];
    [hogan addAttribute:NSFontAttributeName value:font16 range:NSMakeRange(0, [[hogan string] length])];
    [hogan addAttribute:NSForegroundColorAttributeName value:color33 range:NSMakeRange(0, [[hogan string] length])];
    [alertController setValue:hogan forKey:@"attributedTitle"];
    UIAlertAction *alertOne = [UIAlertAction actionWithTitle:str_content style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        RLSToAnalystsVC *analysts = [[RLSToAnalystsVC alloc] init];
        analysts.hidesBottomBarWhenPushed = YES;
        analysts.type = user.analyst;
        analysts.model = user;
        [APPDELEGATE.customTabbar pushToViewController:analysts animated:YES];
    }];
    [alertOne setValue:redcolor forKey:@"_titleTextColor"];
    UIAlertAction *alertTwo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertTwo setValue:color33 forKey:@"_titleTextColor"];
    [alertController addAction:alertTwo];
    [alertController addAction:alertOne];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (RLSNewQingbaoTableView *)NewQBTableView
{
    if (!_NewQBTableView) {
        _NewQBTableView = [[RLSNewQingbaoTableView alloc] initWithFrame:CGRectMake(Width*2, 0, Width, _scrollMainView.height) style:UITableViewStylePlain];
        _NewQBTableView.tag = 32;
        _NewQBTableView.delegateNewQB = self;
        _NewQBTableView.backgroundColor = colorTableViewBackgroundColor;
        _NewQBTableView.matchID = self.model.mid;
    }
    return _NewQBTableView;
}
- (void)headerRefreshNewQB
{
    [self lodaDataAnalysisQB];
}
- (RLSTuijianDatingTableView *)tuiJianTable
{
    if (!_tuiJianTable) {
        _tuiJianTable = [[RLSTuijianDatingTableView alloc] initWithFrame:CGRectMake(Width*3, 0, Width, _scrollMainView.height) style:UITableViewStylePlain];
        _tuiJianTable.tag = 33;
        _tuiJianTable.type = typeTuijianCellFenxi;
        _tuiJianTable.hideFooter = YES;
        _tuiJianTable.model = self.model;
        _tuiJianTable.delegateTuijianDatingTableView = self;
        _tuiJianTable.backgroundColor = colorTableViewBackgroundColor;
    }
    return _tuiJianTable;
}

- (RLSRecommendedWKWeb *)recommendWeb {
    if (_recommendWeb == nil) {
        _recommendWeb = [[RLSRecommendedWKWeb alloc]initWithFrame:CGRectMake(Width*3, 0, Width, _scrollMainView.height)];
        RLSWebModel *model = [[RLSWebModel alloc]init];
        model.webUrl = [NSString stringWithFormat:@"https://tok-fungame.github.io/tuijian-list.html?sid=%zi",_model.mid];
        _recommendWeb.model = model;
        _recommendWeb.tag = 33;
    }
    return _recommendWeb;
}

- (RLSJiBenWebView *)webView{
    if (!_webView) {
        _webView = [[RLSJiBenWebView alloc] initWithFrame:CGRectMake(0, 0, Width, _scrollMainView.height)];
        _webView.model = self.model;
        _webView.backgroundColor = colorTableViewBackgroundColor;
        _webView.scrollView.tag = 30;
    }
    return _webView;
}
- (RLSAnalysisWebview *)analysisWeb {
    if (_analysisWeb == nil) {
        _analysisWeb = [[RLSAnalysisWebview alloc]initWithFrame:CGRectMake(0, 0, Width, _scrollMainView.height)];
        RLSWebModel *model = [[RLSWebModel alloc]init];
        model.webUrl = [NSString stringWithFormat:@"%@/%@/fenxi2/#/?id=%zi", APPDELEGATE.url_ip,H5_Host,_model.mid];
        _analysisWeb.model = model;
        _analysisWeb.tag = 30;
    }
    return _analysisWeb;
}

- (RLSRecommendedWKWeb *)webViewZhiShu {
    if (_webViewZhiShu == nil) {
        _webViewZhiShu = [[RLSRecommendedWKWeb alloc]initWithFrame:CGRectMake(Width, 0, Width, _scrollMainView.height)];
        RLSWebModel *model = [[RLSWebModel alloc]init];
        model.webUrl = [NSString stringWithFormat:@"%@/%@/fenxi2/#/peilv/?id=%zi", APPDELEGATE.url_ip,H5_Host,_model.mid];
        _webViewZhiShu.model = model;
        _webViewZhiShu.tag = 31;
    }
    return _webViewZhiShu;
}

- (RLSRecommendedWKWeb *)webZhiBo {
    if (_webZhiBo == nil) {
        _webZhiBo = [[RLSRecommendedWKWeb alloc]initWithFrame:CGRectMake(Width*4, 0, Width, _scrollMainView.height)];
        RLSWebModel *model = [[RLSWebModel alloc]init];
        model.webUrl = [NSString stringWithFormat:@"%@/%@/fenxi2/#/zhibo/?id=%zi", APPDELEGATE.url_ip,H5_Host,_model.mid];
        _webZhiBo.model = model;
        _webZhiBo.tag = 34;
    }
    return _webZhiBo;
}

- (RLSTitleIndexView *)titleView
{
    if (!_titleView) {
        _titleView = [[RLSTitleIndexView alloc] initWithFrame:CGRectMake(0, self.headerView.bottom, Width, 44)];
        _titleView.backgroundColor = [UIColor whiteColor];
        _titleView.bottomLineColor = colorDD;
        _titleView.arrData = @[@"分析",@"指数",@"情报",@"推荐",@"直播"];
        _titleView.delegate =self;
    }
    return _titleView;
}
#pragma mark -- TitlePagerViewDelegate
- (void)didSelectedAtIndex:(NSInteger)index;
{
    self.currentIndex = index;
    [self.titleView updateSelectedIndex:index];
    [self.scrollMainView setContentOffset:CGPointMake(_currentIndex * Width,0) animated:NO];
    _tableView.scrollEnabled = YES;
    if (index == 0) {
        [MobClick event:@"bsfx" label:@""];
    } else if (index == 1) {
        [MobClick event:@"bszs" label:@""];
    } else if (index == 2) {
        [MobClick event:@"bsqb" label:@""];
    } else if (index == 3) {
        [MobClick event:@"bstj" label:@""];
    } else if (index == 4) {
        [MobClick event:@"bszb" label:@""];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView    
{
    if (scrollView.tag == 11) {
        _tableView.scrollEnabled = YES;
        NSInteger index = (NSInteger)(scrollView.contentOffset.x/Width);
        NSLog(@"%ld",(long)index);
        [self.titleView updateSelectedIndex:index];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_btnFabu.selected == YES) {
        _btnFabu.selected = NO;
        [UIView animateWithDuration:0.5 animations:^{
            _btnFabuTuijian.frame = CGRectMake(Width - 40 - 34, Height - 35 - 40 , 70, 70);
            _btnFabuJingcai.frame = CGRectMake(Width - 40 - 34, Height - 35 - 40 , 30, 30);
            _btnFabuJingcai.center = _btnFabu.center;
            _btnFabuTuijian.center = _btnFabu.center;
        } completion:^(BOOL finished) {
        }];
    }
    if (scrollView.tag ==10) {
        if (scrollView.contentOffset.y<0) {
            scrollView.contentOffset = CGPointMake(0, 0);
            return;
        }
        CGFloat bottomCellOffset = [_tableView rectForSection:1].origin.y - 64;
        if (scrollView.contentOffset.y >= bottomCellOffset) {
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
            if (self.mainTableCanscroll) {
                self.mainTableCanscroll = NO;
                self.analysisWeb.cellCanScroll = YES;
                self.webViewZhiShu.cellCanScroll = YES;
                self.webZhiBo.cellCanScroll = YES;
                self.NewQBTableView.cellCanScroll = YES;
                self.recommendWeb.cellCanScroll = YES;
            }
        }else{
            if (!self.mainTableCanscroll) {
                scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
            }
        }
        self.tableView.showsVerticalScrollIndicator = self.mainTableCanscroll?YES:NO;
        _nav.bgView.alpha = scrollView.contentOffset.y*1.5/100 >1 ? 1:scrollView.contentOffset.y*1.5/100;
        _viewT.alpha = scrollView.contentOffset.y*1.5/100 >1 ? 1:scrollView.contentOffset.y*1.5/100;
    }else if (scrollView.tag == 11){
        CGFloat contentOffsetX = scrollView.contentOffset.x;
        NSInteger num = contentOffsetX / Width;
        _currentIndex = num;
        if (_currentIndex == 2) {
            if (_isShareQB > 0) {
                self.headerView.imageRight.hidden = NO;
                _nav.btnRight.hidden = NO;
            }else{
                self.headerView.imageRight.hidden = YES;
                _nav.btnRight.hidden = YES;
            }
        }else{
            self.headerView.imageRight.hidden = YES;
            _nav.btnRight.hidden = YES;
        }
        _tableView.scrollEnabled = NO;
    }else if(scrollView.tag >= 30){
    }else{
    }
}
- (void)setsubvewCanscroll
{
}
- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
}
#pragma mark ----- 请求提点的数据
- (void)lodaDataTiDian {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [dict setObject:@(self.model.mid) forKey:@"scheduleId"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:dict PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_tidian] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
                NSLog(@"提点%@",responseOrignal);
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _NewQBTableView.jiDianArr = [[NSMutableArray alloc] initWithArray:[RLSTimeModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
            [self.NewQBTableView reloadData];
        }else{
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
    }];
}
#pragma mark ----- 请求情报的数据
- (void)lodaDataAnalysisQB {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [dict setObject:@(self.model.mid) forKey:@"matchId"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:dict PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_infolistOneSchedule] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _NewQBTableView.arrhomeInfo = [[NSArray alloc] initWithArray:[RLSInfoListModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"homeInfo"]]];
            _NewQBTableView.arrawayInfo = [[NSArray alloc] initWithArray:[RLSInfoListModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"awayInfo"]]];
            _NewQBTableView.arrneutralInfo = [[NSArray alloc] initWithArray:[RLSInfoListModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"neutralInfo"]]];
            _isShareQB = _NewQBTableView.arrhomeInfo.count + _NewQBTableView.arrawayInfo.count + _NewQBTableView.arrneutralInfo.count;
            if (_isShareQB > 0 && self.currentIndex == 2) {
                self.headerView.imageRight.hidden = NO;
                _nav.btnRight.hidden = NO;
            }else{
                self.headerView.imageRight.hidden = YES;
                _nav.btnRight.hidden = YES;
            }
            if (_NewQBTableView.arrawayInfo.count>0 ||  _NewQBTableView.arrneutralInfo.count>0 ||_NewQBTableView.arrhomeInfo.count>0 ) {
            }
            
            _NewQBTableView.feeDic = [[responseOrignal objectForKey:@"data"] objectForKey:@"fee"];
            _NewQBTableView.defaultTitle = @"暂无情报，你要做头条吗";
            _NewQBTableView.defaultPage =defaultPageThird;
            [_NewQBTableView reloadData];
            [_NewQBTableView.mj_header endRefreshing];
        }else{
            _NewQBTableView.defaultPage = defaultPageForth;
            _NewQBTableView.defaultTitle =  default_loadFailure;
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        _NewQBTableView.defaultPage = defaultPageForth;
        _NewQBTableView.defaultTitle =  default_loadFailure;
    }];
}
#pragma mark -- 发不，先上传图片
- (void)uploadImageWithImageArr:(NSArray *)arrImage completion:(void(^)(BOOL finished,NSArray*arrUrl)) completion
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:@(3) forKey:@"flag"];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_ZiXunUrl] ArrayFile:arrImage Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            NSArray *arr = [responseOrignal objectForKey:@"data"];
            NSMutableArray *arrPic = [NSMutableArray array];
            for (int i = 0; i < arr.count; i ++) {
                PictureModel *photoModel = [[PictureModel alloc] init];
                photoModel.imgthumburl = responseOrignal[@"data"][i][@"thumb"];
                photoModel.imageurl = responseOrignal[@"data"][i][@"image"];
                [arrPic addObject:photoModel];
            }
            completion(YES,arrPic);
        }else{
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
            completion(NO,[NSArray array]);
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        completion(NO,[NSArray array]);
    }];
}
#pragma mark - ------
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    [recognizer.view.superview bringSubviewToFront:recognizer.view];
    CGPoint center = recognizer.view.center;
    CGFloat cornerRadius = recognizer.view.frame.size.width / 2;
    CGPoint translation = [recognizer translationInView:self.view];
    CGFloat centerY = center.y + translation.y;
    CGFloat centerX = center.x + translation.x;
    if (centerY > self.view.height - self.navigationController.tabBarController.tabBar.height -  recognizer.view.frame.size.width / 2) {
        centerY = self.view.height - self.navigationController.tabBarController.tabBar.height -  recognizer.view.frame.size.width / 2;
    }
    if (centerY < cornerRadius) {
        centerY = cornerRadius;
    }
    if (centerX < cornerRadius) {
        centerX = cornerRadius;
    }
    if (centerX > Width  - cornerRadius) {
        centerX = Width  - cornerRadius;
    }
    recognizer.view.center = CGPointMake(centerX, centerY);
    [recognizer setTranslation:CGPointZero inView:self.view];
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (centerX > recognizer.view.superview.width / 2) {
            centerX = recognizer.view.superview.width - cornerRadius - 5;
        } else {
            centerX = cornerRadius + 5;
        }
        CGPoint centerPoint = CGPointMake(centerX, centerY);
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            recognizer.view.center = centerPoint;
        } completion:^(BOOL finished) {
        }];
    }
}
- (void)loadLiveData {
    NSMutableArray *activityArray = [ArchiveFile getDataWithPath:Activity_Path];
    if (activityArray.count > 0) {
        for (NSDictionary *dic in activityArray) {
            if (dic[@"matchDetail"]) {
                NSDictionary *itemDic = dic[@"matchDetail"];
                self.activityDic = itemDic;
                [self.liveQuizImageView sd_setImageWithURL:[NSURL URLWithString:itemDic[@"icon"]]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.liveQuizImageView.hidden = false;
                });
                break;
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (self.model.matchstate ==0) {
                        self.liveQuizImageView.hidden = false;
                        self.liveQuizImageView.image = [UIImage imageNamed:@"fabunewtuijian"];
                    } else {
                        self.liveQuizImageView.hidden = YES;
                    }
                });
            }
        }
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.model.matchstate ==0) {
                self.liveQuizImageView.hidden = false;
                self.liveQuizImageView.image = [UIImage imageNamed:@"fabunewtuijian"];
            } else {
                self.liveQuizImageView.hidden = YES;
            }
        });
    }
}
#pragma mark - Events
- (void)liveQuziAction:(UITapGestureRecognizer *)tap {
    if (self.activityDic) {
        Class targetCalss = NSClassFromString(self.activityDic[@"n"]);
        RLSToolWebViewController *target =[[targetCalss alloc] init];
        RLSWebModel *model = [[RLSWebModel alloc]init];
        NSDictionary *pDic = self.activityDic[@"v"];
        model.title = PARAM_IS_NIL_ERROR(pDic[@"title"]);
        model.webUrl = PARAM_IS_NIL_ERROR(pDic[@"url"]);
        model.hideNavigationBar = pDic[@"nav_hidden"];
        model.parameter = pDic[@"nav"];
        target.model = model;
        [self.navigationController pushViewController:target animated:YES];
        [MobClick event:@"bsxqjc" label:@""];
    } else {
        if (![RLSMethods login]) {
            [RLSMethods toLogin];
            return;
        }
        [self toapplyAnalasis];
    }
}
#pragma mark - Lazy Load
- (UIImageView *)liveQuizImageView {
    if (_liveQuizImageView == nil) {
        _liveQuizImageView = [UIImageView new];
        _liveQuizImageView.frame = CGRectMake(Width - 80, 4 * (Height / 5), 70, 70);
        _liveQuizImageView.contentMode = UIViewContentModeScaleAspectFill;
        _liveQuizImageView.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(liveQuziAction:)];
        [_liveQuizImageView addGestureRecognizer:tap];
        _liveQuizImageView.userInteractionEnabled = YES;
        _liveQuizImageView.hidden = YES;
        UIPanGestureRecognizer *panTouch = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        [_liveQuizImageView addGestureRecognizer:panTouch];
    }
    return _liveQuizImageView;
}
- (RLSShowActivityView *)animationActivityView {
    if (_animationActivityView == nil) {
        _animationActivityView = [[RLSShowActivityView alloc]initWithFrame:CGRectMake(80, 4 * (Height / 5), 80, 80)];
    }
    return _animationActivityView;
}
@end
