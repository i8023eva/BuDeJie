//
//  EVATapPictureViewController.m
//  BuDeJie
//
//  Created by 李元华 on 2019/2/25.
//  Copyright © 2019年 李元华. All rights reserved.
//

#import "EVATapPictureViewController.h"
#import "EVAEssenceModel.h"
#import <Photos/Photos.h>

#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "FLAnimatedImageView+EVA.h"

@interface EVATapPictureViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *imageView;

- (PHAssetCollection *)createdCollection;
- (PHFetchResult<PHAsset *> *)createdAsset;

@end

@implementation EVATapPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
//    scrollView.frame = self.view.bounds;  //还是xib中的样式
//    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    scrollView.frame = [UIScreen mainScreen].bounds;
    scrollView.backgroundColor = [UIColor greenColor];
    [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)]];
    [self.view insertSubview:scrollView atIndex:0];
    self.scrollView = scrollView;
    
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.image1] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) return;
        self.saveBtn.enabled = YES;
    }];
    imageView.eva_width = eva_screenW;
    imageView.eva_height = imageView.eva_width / self.model.width * self.model.height;
    imageView.eva_x = 0;
    if (imageView.eva_height > eva_screenH) {
        imageView.eva_y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.eva_height);
    } else {
        imageView.eva_centerY = eva_screenH * 0.5;
    }
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    
    //缩放
    CGFloat maxScale = self.model.width / imageView.eva_width;
    if (maxScale > 1) {
        scrollView.maximumZoomScale = maxScale;
        scrollView.delegate = self;
    }
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        // <NSThread: 0x600003651480>{number = 4, name = (null)}
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusDenied) { //拒绝
                if (oldStatus != PHAuthorizationStatusNotDetermined) {//第一次没有做出选择不提示
                    [SVProgressHUD showInfoWithStatus:@"提示开启权限"];
                }
            } else if (status == PHAuthorizationStatusAuthorized) { //ok
                [self asset2Collection];
            } else if (status == PHAuthorizationStatusRestricted) { //无法访问
                [SVProgressHUD showErrorWithStatus:@"系统错误"];
            }
        });
    }];
}

/**
 * @brief 第一次安装权限申请时后面提示失败
 *
 */
- (void) asset2Collection {
    PHFetchResult<PHAsset *> *asset = self.createdAsset;
    if (asset == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片失败"];
        return;
    }
    
    PHAssetCollection *collection = self.createdCollection;
    if (collection == nil) {
        [SVProgressHUD showErrorWithStatus:@"相册失败"];
        return;
    }
    
    NSError *error = nil;
    //插入自定义相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest
                                                   changeRequestForAssetCollection:collection];
        [request insertAssets:asset atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];

    if (error) {
        [SVProgressHUD showErrorWithStatus:@"error"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"success"];
    }
}

/**
 * @brief 创建相册
 * @return <#return#>
 */
- (PHAssetCollection *)createdCollection {
    NSString *bundleName = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
    
    //查
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection
                                                       fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                                       subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:bundleName]) {
            return collection;
        }
    }
    //增
    __block NSString *collectionID = nil;
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        collectionID = [PHAssetCollectionChangeRequest
                        creationRequestForAssetCollectionWithTitle:bundleName].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    if (error) {
        return nil;
    }
    return [PHAssetCollection
            fetchAssetCollectionsWithLocalIdentifiers:@[collectionID] options:nil].firstObject;
}
/**
 * @brief 获取保存的图片
 *
 * @return <#return#>
 */
- (PHFetchResult<PHAsset *> *)createdAsset {
    __block NSString *assetID = nil;
    NSError *error = nil;
    //先保存得到相机胶卷
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        assetID = [PHAssetChangeRequest
                   creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } error:&error];
    
    if (error) {
        return nil;
    }
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil];
}

@end
