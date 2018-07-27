//
//  UINavigationBar+Custom.m
//  ZSNavigationBar
//
//  Created by zakariyyasv on 2018/7/27.
//  Copyright © 2018年 Lingyue. All rights reserved.
//

#import "UINavigationBar+Custom.h"
#import <objc/runtime.h>

typedef void(^ExecutorBlock)(void);

@interface DeallocExecutor : NSObject

@property (nonatomic, copy) ExecutorBlock executor;

@end

@implementation DeallocExecutor

- (instancetype)initWithExecutor:(ExecutorBlock)executor {
  
  if (self = [super init]) {
    self.executor = executor;
  }

  return self;
}

- (void)dealloc {
  self.executor();
}

@end

@implementation UINavigationBar (Custom)

static char overlayKey;
static char barBackgroundViewKey;
static char deallocExecutorKey;

#pragma mark - Runtime Properties
- (UIView *)overlay {
  return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay {
  objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)barBackgroundView {
  return objc_getAssociatedObject(self, &barBackgroundViewKey);
}

- (void)setBarBackgroundView:(UIView *)backgroundView {
  objc_setAssociatedObject(self, &barBackgroundViewKey, backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DeallocExecutor *)deallocExecutor {
  return objc_getAssociatedObject(self, &deallocExecutorKey);
}

- (void)setDeallocExecutor:(DeallocExecutor *)executor {
  objc_setAssociatedObject(self, &deallocExecutorKey, executor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Public Methods
- (void)zs_setBackgroundColor:(UIColor *)backgroundColor {

  if (!self.overlay) {

    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.overlay = [UIView new];
    self.overlay.userInteractionEnabled = NO;
    [[self.subviews firstObject] insertSubview:self.overlay atIndex:0];

  }
  
  if (!self.barBackgroundView) {

    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      if ([obj isMemberOfClass:NSClassFromString(@"_UIBarBackground")]) {
        self.barBackgroundView = obj;
      }
    }];
    
    if (self.barBackgroundView) {
      [self.barBackgroundView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
      
      __weak __typeof(&*self) weakSelf = self;
      self.deallocExecutor = [[DeallocExecutor alloc] initWithExecutor:^{
        [weakSelf.barBackgroundView removeObserver:weakSelf forKeyPath:@"frame"];
      }];
    }
  }
  
  dispatch_async(dispatch_get_main_queue(), ^{
    self.overlay.backgroundColor = backgroundColor;
  });
  
}

- (void)zs_setTranslationY:(CGFloat)translationY {
  self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)zs_reset {

  dispatch_async(dispatch_get_main_queue(), ^{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
  });
  
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {

  if (object == self.barBackgroundView && [keyPath isEqualToString:@"frame"]) {
    CGRect newFrame = [change[NSKeyValueChangeNewKey] rect];

    if (self.overlay) {

      dispatch_async(dispatch_get_main_queue(), ^{
        self.overlay.frame = CGRectMake(0, 0, newFrame.size.width, newFrame.size.height);
      });

    }
  } else {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  }

}

@end


