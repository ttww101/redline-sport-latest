#import "RLSSymbolsValueFormatter.h"
#import "RLSDateValueFormatter.h"
#import "RLSSetValueFormatter.h"
#import "RLSUserTuijianNumView.h"
#import "RLSRoundUserView.h"
#import "RLSUserTongjiCollectioncell.h"
@interface RLSUserTongjiCollectioncell ()<ChartViewDelegate>
@property (nonatomic,strong) LineChartView * lineView;
@property (nonatomic,strong) UILabel * markY;
@end
@implementation RLSUserTongjiCollectioncell
- (void)setModel:(RLSUserTongjiModel *)model
{
    _model = model;
    [self.contentView removeAllSubViews];
    CGFloat scaleRoundWidth = 1.0;
    if (isOniPhone4 || isOniPhone5) {
        scaleRoundWidth = 0.9;
    }
    RLSRoundUserView *roundWin = [[RLSRoundUserView alloc] initWithFrame:CGRectMake(15, 10, 100*scaleRoundWidth, 100*scaleRoundWidth)];
    roundWin.backgroundColor = [UIColor clearColor];
    roundWin.scaleRound = [_model.winRate floatValue]/100;
    [self.contentView addSubview:roundWin];
    RLSRoundUserView *roundProfit = [[RLSRoundUserView alloc] initWithFrame:CGRectMake(roundWin.right + 10, 10, 100*scaleRoundWidth, 100*scaleRoundWidth)];
    roundProfit.backgroundColor = [UIColor clearColor];
    roundProfit.scaleRound = [_model.profitRate floatValue]/100;
    [self.contentView addSubview:roundProfit];
    UILabel *labWinNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 27*scaleRoundWidth, 90*scaleRoundWidth, 23)];
    labWinNum.center = CGPointMake(roundWin.center.x, labWinNum.center.y);
    if ([_model.winRate floatValue]>0) {
        labWinNum.textColor = redcolor;
    }else{
        labWinNum.textColor = color99;
    }
    labWinNum.textAlignment = NSTextAlignmentCenter;
    labWinNum.font = font25;
    labWinNum.text = [NSString stringWithFormat:@"%@%%",_model.winRate] ;
    [self.contentView addSubview:labWinNum];
    UILabel *labWinTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 10 + 50*scaleRoundWidth + 5, 90, 20)];
    labWinTitle.center = CGPointMake(roundWin.center.x, labWinTitle.center.y);
    labWinTitle.textColor = color99;
    labWinTitle.textAlignment = NSTextAlignmentCenter;
    labWinTitle.font = font17;
    labWinTitle.text = @"胜率";
    [self.contentView addSubview:labWinTitle];
    UILabel *labProfitNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 27*scaleRoundWidth, 90*scaleRoundWidth, 23)];
    labProfitNum.center = CGPointMake(roundProfit.center.x, labProfitNum.center.y);
    if ([_model.profitRate floatValue]>0) {
        labProfitNum.textColor = redcolor;
    }else{
        labProfitNum.textColor = color99;
    }
    labProfitNum.textAlignment = NSTextAlignmentCenter;
    labProfitNum.font = font25;
    labProfitNum.text =[NSString stringWithFormat:@"%@%%",_model.profitRate] ;
    [self.contentView addSubview:labProfitNum];
    UILabel *labProfitTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 10 + 50*scaleRoundWidth + 5, 90*scaleRoundWidth, 20)];
    labProfitTitle.center = CGPointMake(roundProfit.center.x, labProfitTitle.center.y);
    labProfitTitle.textColor = color99;
    labProfitTitle.textAlignment = NSTextAlignmentCenter;
    labProfitTitle.font = font17;
    labProfitTitle.text = @"盈利率";
    [self.contentView addSubview:labProfitTitle];
    RLSUserTuijianNumView *numV = [[RLSUserTuijianNumView alloc] initWithFrame:CGRectMake(Width - 15 - 100*scaleRoundWidth, 0, 100*scaleRoundWidth, 96)];
    numV.model = _model;
    [self.contentView addSubview:numV];
    UILabel *labProfitLine = [[UILabel alloc] initWithFrame:CGRectMake(15, 120, 100, 35)];
    labProfitLine.text = @"盈利走势";
    labProfitLine.textColor = color66;
    labProfitLine.font = font12;
    [self.contentView addSubview:labProfitLine];
    [self.contentView addSubview:self.lineView];
    if (_model.groupTimeStatis.count>0) {
        [self.lineView clearValues];
        self.lineView.data = [self setData];
    }
}
- (UILabel *)markY{
    if (!_markY) {
        _markY = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 15)];
        _markY.font = font10;
        _markY.adjustsFontSizeToFitWidth = YES;
        _markY.textAlignment = NSTextAlignmentCenter;
        _markY.text =@"";
        _markY.textColor = redcolor;
    }
    return _markY;
}
- (LineChartView *)lineView {
    if (!_lineView) {
        _lineView = [[LineChartView alloc] initWithFrame:CGRectMake(15, 120 + 35, Width - 30, 125)];
        _lineView.delegate = self;
        _lineView.chartDescription.text = @"描述文字";
        _lineView.noDataText = @"暂无数据";
        _lineView.legend.enabled = YES; 
        _lineView.chartDescription.enabled = YES;
        _lineView.scaleXEnabled = YES;
        _lineView.scaleYEnabled = NO;
        _lineView.doubleTapToZoomEnabled = NO;
        _lineView.dragEnabled = YES;
        _lineView.dragDecelerationEnabled = YES;
        _lineView.dragDecelerationFrictionCoef = 0.9;
        ChartMarkerView *markerY = [[ChartMarkerView alloc]init];
        markerY.offset = CGPointMake(-15, -15);
        markerY.chartView = _lineView;
        _lineView.marker = markerY;
        [markerY addSubview:self.markY];
        _lineView.rightAxis.enabled = NO;
        ChartYAxis *leftAxis = _lineView.leftAxis;
        leftAxis.drawZeroLineEnabled = NO;
        leftAxis.labelCount = 5;
        leftAxis.forceLabelsEnabled = NO;
        leftAxis.inverted = NO;
        leftAxis.axisLineColor = [UIColor clearColor];
        leftAxis.valueFormatter = [[RLSSymbolsValueFormatter alloc]init];
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
        leftAxis.labelTextColor = color99;
        leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];
        leftAxis.gridColor = colorEE;
        leftAxis.gridAntialiasEnabled = NO;
        ChartXAxis *xAxis = _lineView.xAxis;
        xAxis.granularityEnabled = NO;
        xAxis.labelPosition= XAxisLabelPositionBottom;
        xAxis.gridColor = [UIColor clearColor];
        xAxis.labelTextColor = color99;
        xAxis.axisLineColor = [UIColor clearColor]; 
        xAxis.granularity = 1;
        _lineView.maxVisibleCount = 999;
        _lineView.chartDescription.text = @"";
        _lineView.legend.enabled = NO;
        [_lineView animateWithXAxisDuration:1.0f];
    }
    return _lineView;
}
- (LineChartData *)setData{
    NSMutableArray *arrValueProfit = [NSMutableArray array];
    NSMutableArray *arrXlabs = [NSMutableArray array];
    for (int i = 0; i<_model.groupTimeStatis.count; i++) {
        RLSTotalrateModel *model = [_model.groupTimeStatis objectAtIndex:i];
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:[model.profitRate doubleValue]];
        [arrValueProfit addObject:entry];
        if (!model.unitstr) {
            model.unitstr = @"";
        }
        [arrXlabs addObject:model.unitstr];
    }
    _lineView.xAxis.valueFormatter = [[RLSDateValueFormatter alloc]initWithArr:arrXlabs];
    LineChartDataSet *set1 = nil;
    if (_lineView.data.dataSetCount > 0) {
        LineChartData *data = (LineChartData *)_lineView.data;
        set1 = (LineChartDataSet *)data.dataSets[0];
        set1.values = arrValueProfit;
        set1.valueFormatter = [[RLSSetValueFormatter alloc]initWithArr:arrValueProfit];
        return data;
    }else{
        set1 = [[LineChartDataSet alloc]initWithValues:arrValueProfit label:nil];
        set1.lineWidth = 2.0/[UIScreen mainScreen].scale;
        set1.drawValuesEnabled = YES;
        if (arrValueProfit.count>0) {
            set1.valueFormatter = [[RLSSetValueFormatter alloc]initWithArr:arrValueProfit];
        }
        set1.valueColors = @[[UIColor brownColor]];
        [set1 setColor:redcolor];
        set1.highlightColor = redcolor;
        set1.highlightEnabled = YES; 
        set1.drawCirclesEnabled = YES;
        set1.drawCircleHoleEnabled = YES;
        set1.circleColors = @[redcolor];
        set1.circleRadius = 2;
        set1.mode = LineChartModeHorizontalBezier;
        NSArray *gradientColors = @[(id)[ChartColorTemplates colorFromString:@"#FFFFFFFF"].CGColor,(id)redcolorAlpha.CGColor];
        CGGradientRef gradientRef = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
        set1.fillAlpha = 1.0f;
        set1.fill = [ChartFill fillWithLinearGradient:gradientRef angle:90.0f];
        CGGradientRelease(gradientRef);
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        LineChartData *data = [[LineChartData alloc]initWithDataSets:dataSets];
        [data setValueFont:font11];
        [data setValueTextColor:[UIColor clearColor]];
        return data;
    }
}
- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight {
    _markY.text = [NSString stringWithFormat:@"%ld%%",(NSInteger)entry.y];
    [_lineView centerViewToAnimatedWithXValue:entry.x yValue:entry.y axis:[_lineView.data getDataSetByIndex:highlight.dataSetIndex].axisDependency duration:1.0];
}
- (void)chartValueNothingSelected:(ChartViewBase * _Nonnull)chartView {
}
@end
