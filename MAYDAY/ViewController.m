//
//  ViewController.m
//  MAYDAY
//
//  Created by zan.zhang on 17/4/28.
//  Copyright © 2017年 zan.zhang. All rights reserved.
//

#import "ViewController.h"
#define ZScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ZScreenHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController ()


@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong)UILabel *mayDay;
@property (nonatomic,strong)CAEmitterLayer *emitter;
@property (nonatomic,strong)UIImageView *image;

@end

@implementation ViewController

-(NSTimer *)timer{
	if (!_timer) {
		_timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeRuns) userInfo:nil repeats:YES];
	}
	return _timer;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
//	_mayDay = [[UILabel alloc]initWithFrame:self.view.bounds];
	
	_mayDay = [[UILabel alloc]initWithFrame:CGRectMake(0, -ZScreenHeight, ZScreenWidth, 30)];
	
	_mayDay.text = @"MAYDAY IS COMING";
	_mayDay.textAlignment = NSTextAlignmentCenter;
	_mayDay.font = [UIFont systemFontOfSize:28 weight:30];
	
	_image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"eat"]];
	[_image setFrame:CGRectMake(0, 64, ZScreenWidth,ZScreenWidth*200/867)];
	
	
	
	[self.view addSubview:_mayDay];
	


	__weak typeof(self )weakself = self;
	
	[UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		
		//		[self.view addSubview:weakself.mayDay];
		
		[weakself.mayDay setCenter:self.view.center];
		
	} completion:^(BOOL finished) {
		weakself.mayDay.text = @"HAPPY MAYDAY!!!";
//		[weakself.mayDay setFrame:CGRectMake(0, 40, ZScreenWidth, 30)];
		[weakself.mayDay removeFromSuperview];
		[weakself.view addSubview:_image];
		/** 创建粒子发射器*/
		self.emitter  = [CAEmitterLayer layer];
		//	self.emitter.frame = self.view.frame;
		[self.view.layer addSublayer:self.emitter];
		
		/** 设置发射粒子位置*/
		
		self.emitter.emitterPosition = CGPointMake(ZScreenWidth/2, 0);
		/** 设置发射源的大小*/
		self.emitter.emitterSize = CGSizeMake(ZScreenWidth, 20);
		/** 渲染模式*/
		self.emitter.renderMode = kCAEmitterLayerAdditive;
		self.emitter.emitterMode = kCAEmitterLayerLine;
		/** 发射源的类型*/
		self.emitter.emitterShape = kCAEmitterLayerLine;
		CAEmitterCell *lip = [CAEmitterCell emitterCell];
		lip.contents = ( id)[UIImage imageNamed:@"lips"].CGImage ;
		lip.birthRate = 3;
		lip.lifetime = 2;
		lip.velocity = -380;
		lip.velocityRange = 100;
		lip.emissionRange = M_PI* 0.25;
		lip.spinRange = M_PI;
		lip.yAcceleration = 75;
		
		
		CAEmitterCell *rose = [CAEmitterCell emitterCell];
		rose.birthRate = 1;
//		rose.emissionRange =  M_PI * 2;
//		rose.yAcceleration = 75;
		rose.contents = (id)[UIImage imageNamed:@"lips"].CGImage;
		rose.lifetime = 0.2;
//		rose.spinRange = M_PI * 2;
		rose.scale = 0.3;
		
		
		CAEmitterCell *happy = [CAEmitterCell emitterCell];
		happy.birthRate = 900;
		happy.velocity = 125;
		happy.emissionRange =  M_PI * 2;
		happy.yAcceleration = 75;
		happy.contents = (id)[UIImage imageNamed:@"flower"].CGImage;
		happy.lifetime = 3;
		happy.spin = M_PI * 2;
		happy.spinRange = M_PI * 2;
		happy.scale = 0.5;
		happy.color = [UIColor orangeColor].CGColor;
		happy.greenRange		= 0.5;		// different colors
		happy.redRange			= 1;
		happy.blueRange		= 1;
		//	cell.alphaSpeed = -0.05;
		self.emitter.emitterCells = @[lip];

		lip.emitterCells = @[rose];
		rose.emitterCells = @[happy];
	}];
//	//加载颗粒状的火花图片
//	CAEmitterLayer *emitterLa = [CAEmitterLayer layer];
//	emitterLa.emitterPosition = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height*(.75));//*(0.75)
//	emitterLa.renderMode = kCAEmitterLayerAdditive;
//	
//	//在爆炸前逐渐隐藏发射颗粒
//	CAEmitterCell *emitterCeRocket = [CAEmitterCell emitterCell];
//	emitterCeRocket.emissionLongitude = -M_PI/2;
//	emitterCeRocket.emissionLatitude = 0;
//	emitterCeRocket.lifetime = 1.6;
//	emitterCeRocket.birthRate = 1;
//	emitterCeRocket.velocity = 400;
//	emitterCeRocket.velocityRange = 100;
//	emitterCeRocket.yAcceleration = 250;
//	emitterCeRocket.emissionRange = M_PI/4;
//	emitterCeRocket.color = CGColorCreateCopy([UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5].CGColor);
//	emitterCeRocket.redRange = 0.5;
//	emitterCeRocket.greenRange = 0.5;
//	emitterCeRocket.blueRange = 0.5;
//	//设置动画效果的路径名称
//	[emitterCeRocket setName:@"rocket"];
//	
//	//添加路径状态
//	CAEmitterCell *emitterCeFly = [CAEmitterCell emitterCell];
//	emitterCeFly.contents = (id)[UIImage imageNamed:@"rose"].CGImage;
//	emitterCeFly.emissionLongitude = (4*M_PI)/2;
//	emitterCeFly.scale = 0.4;
//	emitterCeFly.velocity = 100;
//	emitterCeFly.birthRate = 45;
//	emitterCeFly.lifetime = 1.5;
//	emitterCeFly.yAcceleration = 350;
//	emitterCeFly.emissionRange = M_PI/7;
//	emitterCeFly.alphaSpeed = -0.7;
//	emitterCeFly.scaleSpeed = -0.1;
//	emitterCeFly.scaleRange = 0.1;
//	emitterCeFly.beginTime = 0.01;
//	emitterCeFly.duration = 0.7;
//	
//	//设置爆炸
//	CAEmitterCell *emitterCeFirework = [CAEmitterCell emitterCell];
//	emitterCeFirework.contents = (id)[UIImage imageNamed:@"lips"].CGImage;
//	emitterCeFirework.birthRate = 9999;
//	emitterCeFirework.scale = 0.6;
//	emitterCeFirework.velocity = 130;
//	emitterCeFirework.lifetime = 2;
//	emitterCeFirework.alphaSpeed = -0.2;
//	emitterCeFirework.yAcceleration = 80;
//	emitterCeFirework.beginTime = 1.5;
//	emitterCeFirework.duration = 0.1;
//	emitterCeFirework.emissionRange = 2*M_PI;
//	emitterCeFirework.scaleSpeed = -0.1;
//	emitterCeFirework.spin = 2;
//	//设置爆炸动画名称
//	[emitterCeFirework setName:@"firework"];
//	
//	//添加重复过程
//	CAEmitterCell *emitterCePreSpark = [CAEmitterCell emitterCell];
//	emitterCePreSpark.birthRate = 80;
//	emitterCePreSpark.velocity = emitterCeFirework.velocity*0.7;
//	emitterCePreSpark.lifetime = 1.7;
//	emitterCePreSpark.yAcceleration = emitterCeFirework.yAcceleration*0.85;
//	emitterCePreSpark.beginTime = emitterCeFirework.beginTime-0.2;
//	emitterCePreSpark.emissionRange = emitterCeFirework.emissionRange;
//	emitterCePreSpark.greenSpeed = 100;
//	emitterCePreSpark.blueSpeed = 100;
//	emitterCePreSpark.redSpeed = 100;
//	//设置重复动画名称
//	[emitterCePreSpark setName:@"preSpark"];
//	
//	//烟花最后的闪光
//	CAEmitterCell *emitterCeSparkle = [CAEmitterCell emitterCell];
//	emitterCeSparkle.contents = (id)[UIImage imageNamed:@"rose"].CGImage;
//	emitterCeSparkle.lifetime = 0.05;
//	emitterCeSparkle.yAcceleration = 250;
//	emitterCeSparkle.beginTime = 0.8;
//	emitterCeSparkle.scale = 0.4;
//	emitterCeSparkle.birthRate = 10;
//	
//	emitterCePreSpark.emitterCells = [NSArray arrayWithObjects:emitterCeSparkle, nil];
//	emitterCeRocket.emitterCells = [NSArray arrayWithObjects:emitterCeFly,emitterCeFirework,emitterCePreSpark, nil];
//	emitterLa.emitterCells = [NSArray arrayWithObjects:emitterCeRocket, nil];
//	
//	[self.view.layer addSublayer:emitterLa];
}

-(void)loadView{
	[super loadView];
	
	
	
}

-(void)timeRuns{
	
}
-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];

	
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
