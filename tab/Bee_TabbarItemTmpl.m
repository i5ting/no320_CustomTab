//
//  Bee_TabbarItemTmpl.m
//  SimpleEKDemo
//
//  Created by sang alfred on 5/5/13.
//
//

#import "Bee_TabbarItemTmpl.h"

@implementation Bee_TabbarItemTmpl

#define CUSTOM_TABBAR_ORIGIN_INSETS UIEdgeInsetsMake(1.0,3.0,3.0,3.0)

@synthesize viewframe,bundleName,configArray;

 
@synthesize indicator0;
@synthesize indicator1;
@synthesize indicator2;
@synthesize indicator3;
@synthesize updateLabel0;
@synthesize updateLabel1;
@synthesize updateLabel2;
@synthesize updateLabel3;

@synthesize delegate;


@synthesize highlightView;



- (id)init
{
    self = [super init];
    if (self) {
        
  
    }
    return self;
}


-(void)showTab
{
    __count = [self.configArray count];
    UIEdgeInsets originInsets = CUSTOM_TABBAR_ORIGIN_INSETS;
    
    if (__count==0) {
        return;
    }
    int _width = 320/[self.configArray count];
    
    
    int i = 1;
    
    highlightView = [[UIImageView alloc] init];
    highlightView.frame = CGRectMake(0, 0, 320/__count, 44);
    
    [highlightView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",bundleName,@"tab_light.png"]]];
    
    [self addSubview:highlightView];
    
    for (NSDictionary *d in self.configArray) {
        NSString *defaultImg = [NSString stringWithFormat:@"%@/%@",self.bundleName,(NSString *)[d objectForKey:@"default"]];
        NSString *selectedImg = [NSString stringWithFormat:@"%@/%@",self.bundleName,(NSString *)[d objectForKey:@"selected"]];
        
        UIButton  *_newsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _newsBtn.tag = 10357+i;
        _newsBtn.frame = CGRectMake(_width*(i - 1)-4, 0, _width+6, 46);
        [_newsBtn setImage:[UIImage imageNamed:defaultImg] forState:UIControlStateNormal];
        [_newsBtn setImage:[UIImage imageNamed:selectedImg] forState:UIControlStateSelected];
        [_newsBtn setOpaque:NO];
        _newsBtn.contentEdgeInsets = originInsets;
        
        i++;
        
        [_newsBtn addTarget:self action:@selector(tapOnBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_newsBtn];
        
        if (delegate && [delegate respondsToSelector:@selector(draw_with_dict:in_container:)]) {
            [delegate draw_with_dict:d in_container:self];
        }
    }
}

- (void)selectTabAtCompletion:(int)index{
    for (int i = 0; i < __count; i++) {
        UIButton *_cur_btn = (UIButton *)[self viewWithTag:10358+i];
        if (_cur_btn == nil) {
            return;
        }
        if (i == index) {
            _cur_btn.selected = YES;
            [_cur_btn setBackgroundImage:[UIImage imageNamed:@"CustomTabBar.bundle/bglight.png"] forState:UIControlStateSelected];
        }else{
            _cur_btn.selected = NO;
        }   
    }
}

- (void)selectTabAtIndex:(int)index
{
    for (int i; i < __count; i++) {
        UIButton *_cur_btn = (UIButton *)[self viewWithTag:10358+i];
        if (_cur_btn == nil) {
            return;
        }
        
        if (i != index) {
            _cur_btn.selected = NO;
        }else{
            
        }
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView animateWithDuration:0.2 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        CGRect f = self.highlightView.frame;
        f.origin.x = index * self.highlightView.frame.size.width-1;
        self.highlightView.frame = f;
        
    }completion: ^(BOOL finished){
        [self selectTabAtCompletion:index];
    }];
    
    [UIView commitAnimations];
}

- (void)tapOnBtn:(UIButton *)sender {

    int i = sender.tag - 10358;
    if (delegate && [delegate respondsToSelector:@selector(customTabbar:didSelectTab:)]) {
        NSLog(@"【 tapOnNewsBtn 】 current tag :=%d",i);
        [delegate customTabbar:self didSelectTab:i];
    }
    self.indicator0.hidden = YES;
    self.updateLabel0.hidden = YES;
    
    if (delegate && [delegate respondsToSelector:@selector(tap_on_btn_call_back:)]) {
        [delegate tap_on_btn_call_back:i];
    }
}

//- (void)dealloc {
//    [highlightView release];
//    [indicator0 release];
//    [indicator1 release];
//    [indicator2 release];
//    [indicator3 release];
//    [updateLabel0 release];
//    [updateLabel1 release];
//    [updateLabel2 release];
//    [updateLabel3 release];
//    [super dealloc];
//}

#pragma mark - delay



@end