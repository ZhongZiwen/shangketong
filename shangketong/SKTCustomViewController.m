//
//  SKTCustomViewController.m
//  shangketong
//
//  Created by sungoin-zbs on 16/2/18.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTCustomViewController.h"
#import <UIImageView+WebCache.h>
#import "SKTPhoto.h"
#import "SKTPhotoBrowser.h"

@interface SKTCustomViewController ()

@property (copy, nonatomic) NSArray *imagesArray;
@property (copy, nonatomic) NSMutableArray *photoItemsArray;
@end

@implementation SKTCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *dict0 = @{@"url" : @"http://skt.sunke.com//user/resource/img.do?u=LzE3NjcxNy8yMDE2LTAyLTAyLzZmODY5OTA5MzAwYzRmNmZiMWU2NzBiM2FiYTBmZjRkLmpwZw==",
                            @"minUrl" : @"http://skt.sunke.com//user/resource/img.do?u=LzE3NjcxNy8yMDE2LTAyLTAyLzZmODY5OTA5MzAwYzRmNmZiMWU2NzBiM2FiYTBmZjRkLmpwZw==&zoom=min"};
    NSDictionary *dict1 = @{@"url" : @"http://skt.sunke.com//user/resource/img.do?u=LzE3NjcxNy8yMDE2LTAyLTAyLzI3MjhjZWY1MDkxZjRkZmU4ZjVjZDBmOTMwZmY3MDkzLmpwZw==",
                            @"minUrl" : @"http://skt.sunke.com//user/resource/img.do?u=LzE3NjcxNy8yMDE2LTAyLTAyLzI3MjhjZWY1MDkxZjRkZmU4ZjVjZDBmOTMwZmY3MDkzLmpwZw==&zoom=min"};
    NSDictionary *dict2 = @{@"url" : @"http://skt.sunke.com//user/resource/img.do?u=LzE3NjcxNy8yMDE2LTAyLTAyL2M4NDNhMTE3NThhMzRlMThhMjZjMmFiOWVhZDhiYjZiLmpwZw==",
                            @"minUrl" : @"http://skt.sunke.com//user/resource/img.do?u=LzE3NjcxNy8yMDE2LTAyLTAyL2M4NDNhMTE3NThhMzRlMThhMjZjMmFiOWVhZDhiYjZiLmpwZw==&zoom=min"};
    NSDictionary *dict3 = @{@"url" : @"http://skt.sunke.com//user/resource/img.do?u=LzE3NjcxNy8yMDE2LTAyLTAyLzc1NDM0YTM3MjY2ODQwN2Y5MTNhODFkNGE0YjJiZTM1LmpwZw==",
                            @"minUrl" : @"http://skt.sunke.com//user/resource/img.do?u=LzE3NjcxNy8yMDE2LTAyLTAyLzc1NDM0YTM3MjY2ODQwN2Y5MTNhODFkNGE0YjJiZTM1LmpwZw==&zoom=min"};
    NSDictionary *dict4 = @{@"url" : @"http://skt.sunke.com//user/resource/img.do?u=LzE3NjcxNy8yMDE2LTAyLTAyL2Q3MzA4NmU1NTgzZjRlMGI4NDZjMjNhYzdmNzM5OGFhLmpwZw==",
                            @"minUrl" : @"http://skt.sunke.com//user/resource/img.do?u=LzE3NjcxNy8yMDE2LTAyLTAyL2Q3MzA4NmU1NTgzZjRlMGI4NDZjMjNhYzdmNzM5OGFhLmpwZw==&zoom=min"};
    
    _imagesArray = @[dict0, dict1, dict2, dict3, dict4];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < _imagesArray.count; i ++) {
        NSDictionary *tempDict = _imagesArray[i];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(15 + (80 + 10) * (i % 3), 84 + (80 + 10) * (i / 3), 80, 80);
        imageView.tag = i;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.userInteractionEnabled = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:tempDict[@"minUrl"]]];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [imageView addGestureRecognizer:tap];
        [self.view addSubview:imageView];
        
        SKTPhoto *photoItem = [[SKTPhoto alloc] init];
        photoItem.url = tempDict[@"url"];
        photoItem.minUrl = tempDict[@"minUrl"];
        photoItem.srcImageView = imageView;
        [tempArray addObject:photoItem];
    }
    _photoItemsArray = tempArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event response
- (void)tapGesture:(UITapGestureRecognizer *)tap {
    UIImageView *imageView = (UIImageView *)tap.view;
    
    SKTPhoto *selectedPhoto = [[SKTPhoto alloc] init];
    selectedPhoto.srcImageView = imageView;
    [[SKTPhotoBrowser sharedInstance] showWithPhotoItems:_photoItemsArray selectedItem:selectedPhoto];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
