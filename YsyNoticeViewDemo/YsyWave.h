/**
 *  波浪效果View
 */

#import <UIKit/UIKit.h>

typedef void(^YsyWaveBlock)(CGFloat currentY);

@interface YsyWave : UIView
/**
 *  浪弯曲度
 */
@property (nonatomic, assign) CGFloat waveCurvature;
/**
 *  浪速
 */
@property (nonatomic, assign) CGFloat waveSpeed;
/**
 *  浪高
 */
@property (nonatomic, assign) CGFloat waveHeight;
/**
 *  实浪颜色
 */
@property (nonatomic, strong) UIColor *realWaveColor;
/**
 *  遮罩浪颜色
 */
@property (nonatomic, strong) UIColor *maskWaveColor;

@property (nonatomic, copy) YsyWaveBlock waveBlock;

- (void)stopWaveAnimation;

- (void)startWaveAnimation;

@end
