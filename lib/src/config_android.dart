import 'package:flutter/foundation.dart';

import 'constant.dart';
import 'extension.dart';
import 'model.dart';

class AndroidConfig {
  final String appId;
  final bool debug;
  final bool useTextureView;
  final AndroidTitleBarTheme titleBarTheme;
  final bool allowShowNotify;
  final bool allowShowPageWhenScreenLock;
  final List<int> directDownloadNetworkType;
  final bool supportMultiProcess;
  final bool isPaidApp;
  final bool isCanUseLocation;
  final PangleLocation location;
  final bool isCanUsePhoneState;
  final String devImei;
  final bool isCanUseWifiState;
  final bool isCanUseWriteExternal;
  final String devOaid;

  /// Register the ad config for Android
  ///
  /// [appId] 必选参数，设置应用的AppId
  /// [debug] 测试阶段打开，可以通过日志排查问题，上线时去除该调用
  /// [allowShowNotify] 是否允许sdk展示通知栏提示
  /// [allowShowPageWhenScreenLock] 是否在锁屏场景支持展示广告落地页
  /// [supportMultiProcess] 可选参数，设置是否支持多进程：true支持、false不支持。默认为false不支持
  /// [directDownloadNetworkType] 可选参数，允许直接下载的网络状态集合
  /// [isPaidApp] 可选参数，设置是否为计费用户：true计费用户、false非计费用户。默认为false非计费用户。须征得用户同意才可传入该参数
  /// [useTextureView] 可选参数，设置是否使用texture播放视频：true使用、false不使用。默认为false不使用（使用的是surface）
  /// [titleBarTheme] 可选参数，设置落地页主题，默认为light
  /// TODO [keywords] 可选参数，设置用户画像的关键词列表 **不能超过为1000个字符**。须征得用户同意才可传入该参数
  /// TODO [isAsyncInit] 是否异步初始化sdk
  /// [isCanUseLocation] 是否允许SDK主动使用地理位置信息。true可以获取，false禁止获取。默认为true
  /// [location] 当isCanUseLocation=false时，可传入地理位置信息，穿山甲sdk使用您传入的地理位置信息
  /// [isCanUsePhoneState] 是否允许SDK主动使用手机硬件参数，如：imei。true可以使用，false禁止使用。默认为true
  /// [devImei] 当isCanUsePhoneState=false时，可传入imei信息，穿山甲sdk使用您传入的imei信息
  /// [isCanUseWifiState] 是否允许SDK主动使用ACCESS_WIFI_STATE权限。true可以使用，false禁止使用。默认为true
  /// [isCanUseWriteExternal] 是否允许SDK主动使用WRITE_EXTERNAL_STORAGE权限。true可以使用，false禁止使用。默认为true
  /// [devOaid] 开发者可以传入oaid
  AndroidConfig({
    @required this.appId,
    this.debug,
    this.allowShowNotify,
    this.allowShowPageWhenScreenLock,
    this.supportMultiProcess = false,
    this.directDownloadNetworkType = const [],
    this.isPaidApp,
    this.useTextureView,
    this.titleBarTheme = AndroidTitleBarTheme.light,
    this.isCanUseLocation,
    this.location,
    this.isCanUsePhoneState,
    this.devImei,
    this.isCanUseWifiState,
    this.isCanUseWriteExternal,
    this.devOaid,
  }) : assert(appId.isNotBlank);

  /// Convert config to json
  Map<String, dynamic> toJSON() {
    return {
      'appId': appId,
      'debug': debug,
      'allowShowNotify': allowShowNotify,
      'allowShowPageWhenScreenLock': allowShowPageWhenScreenLock,
      'supportMultiProcess': supportMultiProcess,
      'directDownloadNetworkType': directDownloadNetworkType,
      'paid': isPaidApp,
      'useTextureView': useTextureView,
      'titleBarTheme': titleBarTheme?.index,
      'isCanUseLocation': isCanUseLocation,
      'location': location?.toJson(),
      'isCanUsePhoneState': isCanUsePhoneState,
      'devImei': devImei,
      'isCanUseWifiState': isCanUseWifiState,
      'isCanUseWriteExternal': isCanUseWriteExternal,
      'devOaid': devOaid,
    };
  }
}

class AndroidSplashConfig {
  final String slotId;
  final double tolerateTimeout;
  final bool hideSkipButton;
  final bool isExpress;
  final bool isSupportDeepLink;
  final PangleExpressSize expressSize;

  /// The splash ad config for Android
  ///
  /// [slotId] The unique identifier of splash ad.
  /// [tolerateTimeout] optional. Maximum allowable load timeout, default 3s, unit s.
  /// [hideSkipButton] optional. Whether hide skip button, default NO. If you hide the skip button, you need to customize the countdown.
  /// [isSupportDeepLink] optional. Whether to support deeplink. Default true.
  /// [isExpress] optional. experimental. 个性化模板广告.
  /// [expressSize] optional. 模板宽高
  AndroidSplashConfig({
    @required this.slotId,
    this.tolerateTimeout,
    this.hideSkipButton,
    this.isSupportDeepLink = true,
    this.isExpress = true,
    this.expressSize,
  })  : assert(slotId.isNotBlank),
        assert(!isExpress || (isExpress && expressSize != null));

  /// Convert config to json
  Map<String, dynamic> toJSON() {
    return {
      'slotId': slotId,
      'tolerateTimeout': tolerateTimeout,
      'hideSkipButton': hideSkipButton,
      'isSupportDeepLink': isSupportDeepLink,
      'isExpress': isExpress,
      'expressSize': expressSize?.toJson(),
    };
  }
}

class AndroidRewardedVideoConfig {
  final String slotId;
  final String userId;
  final String rewardName;
  final int rewardAmount;
  final String extra;
  final bool isVertical;
  final bool isSupportDeepLink;
  final PangleLoadingType loadingType;
  final bool isExpress;
  final PangleExpressSize expressSize;

  /// The rewarded video ad config for Android
  ///
  /// [slotId] The unique identifier of rewarded video ad.
  /// [userId] required.
  //   Third-party game user_id identity.
  //   Mainly used in the reward issuance, it is the callback pass-through parameter from server-to-server.
  //   It is the unique identifier of each user.
  //   In the non-server callback mode, it will also be pass-through when the video is finished playing.
  //   Only the string can be passed in this case, not nil.
  /// [rewardName] optional. reward name.
  /// [rewardAmount] optional. number of rewards.
  /// [extra] optional. serialized string.
  /// [isVertical] optional. Whether video is vertical orientation. Vertical, if true. Otherwise, horizontal.
  /// [isSupportDeepLink] optional. Whether to support deeplink. default true.
  /// [loadingType] optional. 加载广告的类型，默认[PangleLoadingType.normal]
  /// [isExpress] optional. 个性化模板广告
  /// [expressSize] optional. 模板宽高
  AndroidRewardedVideoConfig({
    @required this.slotId,
    this.userId,
    this.rewardName,
    this.rewardAmount,
    this.extra,
    this.isVertical = true,
    this.isSupportDeepLink = true,
    this.loadingType,
    this.isExpress = true,
    this.expressSize,
  }) : assert(slotId.isNotBlank);

  /// Convert config to json
  Map<String, dynamic> toJSON() {
    var expressSize = this.expressSize;
    if (isExpress && expressSize == null) {
      expressSize = PangleExpressSize.aspectRatio9_16();
    }

    return {
      'slotId': slotId,
      'userId': userId,
      'rewardName': rewardName,
      'rewardAmount': rewardAmount,
      'extra': extra,
      'isVertical': isVertical,
      'isSupportDeepLink': isSupportDeepLink,
      'loadingType': loadingType?.index,
      'isExpress': isExpress,
      'expressSize': expressSize?.toJson(),
    };
  }
}

class AndroidBannerConfig {
  final String slotId;
  final PangleImgSize imgSize;
  final bool isSupportDeepLink;
  final bool isExpress;
  final PangleExpressSize expressSize;
  final int interval;

  /// The feed ad config for Android
  ///
  /// [slotId] required. The unique identifier of a banner ad.
  /// [imgSize] required. Image size.
  /// [isExpress] optional. 个性化模板广告
  /// [isSupportDeepLink] optional. Whether to support deeplink. default true.
  /// [expressSize] optional. 模板宽高
  /// [interval] The carousel interval, in seconds, is set in the range of 30~120s,
  ///   and is passed during initialization. If it does not meet the requirements,
  ///   it will not be in carousel ad.
  AndroidBannerConfig({
    @required this.slotId,
    this.imgSize = PangleImgSize.banner600_150,
    this.isSupportDeepLink = true,
    this.isExpress = true,
    this.expressSize,
    this.interval,
  })  : assert(slotId.isNotBlank),
        assert(!isExpress || (isExpress && expressSize != null));

  /// Convert config to json
  Map<String, dynamic> toJSON() {
    return {
      'slotId': slotId,
      'imgSize': imgSize?.index,
      'isSupportDeepLink': isSupportDeepLink,
      'isExpress': isExpress,
      'expressSize': expressSize?.toJson(),
      'interval': interval,
    };
  }
}

class AndroidFeedConfig {
  final String slotId;
  final PangleImgSize imgSize;
  final int count;
  final bool isSupportDeepLink;
  final bool isExpress;
  final PangleExpressSize expressSize;

  /// The feed ad config for Android
  ///
  /// [slotId] required. The unique identifier of a feed ad.
  /// [imgSize] required. Image size.
  /// [count] It is recommended to request no more than 3 ads. The maximum is 10. default 3
  /// [isSupportDeepLink] optional. Whether to support deeplink.
  /// [isExpress] optional. 个性化模板广告
  /// [expressSize] optional. 模板宽高
  AndroidFeedConfig({
    @required this.slotId,
    this.imgSize = PangleImgSize.feed690_388,
    this.count,
    this.isSupportDeepLink = true,
    this.isExpress = true,
    this.expressSize,
  })  : assert(slotId.isNotBlank),
        assert(!isExpress || (isExpress && expressSize != null));

  /// Convert config to json
  Map<String, dynamic> toJSON() {
    return {
      'slotId': slotId,
      'count': count,
      'imgSize': imgSize?.index,
      'isSupportDeepLink': isSupportDeepLink,
      'isExpress': isExpress,
      'expressSize': expressSize?.toJson(),
    };
  }
}

class AndroidInterstitialConfig {
  final String slotId;
  final PangleImgSize imgSize;
  final bool isSupportDeepLink;
  final bool isExpress;
  final PangleExpressSize expressSize;

  /// The interstitial ad config for Android
  ///
  /// [slotId] required. The unique identifier of a interstitial ad.
  /// [imgSize] required. Image size.
  /// [isSupportDeepLink] optional. Whether to support deep link. default true.
  /// [isExpress] optional. 个性化模板广告
  /// [expressSize] optional. 模板宽高
  AndroidInterstitialConfig({
    @required this.slotId,
    this.imgSize = PangleImgSize.interstitial600_400,
    this.isSupportDeepLink = true,
    this.isExpress = true,
    this.expressSize,
  })  : assert(slotId.isNotBlank),
        assert(!isExpress || (isExpress && expressSize != null));

  /// Convert config to json
  Map<String, dynamic> toJSON() {
    return {
      'slotId': slotId,
      'imgSize': imgSize?.index,
      'isSupportDeepLink': isSupportDeepLink,
      'isExpress': isExpress,
      'expressSize': expressSize?.toJson(),
    };
  }
}

class AndroidFullscreenVideoConfig {
  final String slotId;
  final bool isSupportDeepLink;
  final PangleOrientation orientation;
  final PangleLoadingType loadingType;
  final bool isExpress;
  final PangleExpressSize expressSize;

  /// The full screen video ad config for Android
  ///
  /// [slotId] required. The unique identifier of a full screen video ad.
  /// [isSupportDeepLink] optional. Whether to support deeplink. default true.
  /// [orientation] 设置期望视频播放的方向，默认[PangleOrientation.veritical]
  /// [loadingType] optional. 加载广告的类型，默认[PangleLoadingType.normal]
  /// [isExpress] optional. 个性化模板广告
  /// [expressSize] optional. 模板宽高
  AndroidFullscreenVideoConfig({
    @required this.slotId,
    this.isSupportDeepLink = true,
    this.orientation = PangleOrientation.veritical,
    this.loadingType = PangleLoadingType.normal,
    this.isExpress = true,
    this.expressSize,
  }) : assert(slotId.isNotBlank);

  /// Convert config to json
  Map<String, dynamic> toJSON() {
    var expressSize = this.expressSize;
    if (isExpress && expressSize == null) {
      expressSize = PangleExpressSize.aspectRatio9_16();
    }
    return {
      'slotId': slotId,
      'isSupportDeepLink': isSupportDeepLink,
      'isExpress': isExpress,
      'orientation': orientation?.index,
      'loadingType': loadingType?.index,
      'expressSize': expressSize?.toJson(),
    };
  }
}
