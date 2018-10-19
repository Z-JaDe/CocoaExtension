//
//  JDSwiftFunctions.swift
//  AppExtension
//
//  Created by 郑军铎 on 2018/6/11.
//  Copyright © 2018年 ZJaDe. All rights reserved.
//

import UIKit
public struct jd {

}
extension jd {
    /// ZJaDe: 返回命名空间
    public static var mainNamespace: String {

        return getNamespace(bundle: Bundle.main)!
    }
    public static func getNamespace(bundle: Bundle) -> String? {
        return bundle.infoDictionary?["CFBundleExecutable"] as? String
    }
    /// ZJaDe: 返回app名称
    public static var appDisplayName: String? {
        if let bundleDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            return bundleDisplayName
        } else if let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            return bundleName
        }
        return nil
    }

    /// ZJaDe: 返回app版本号
    public static var appVersion: String {
        guard let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            assertionFailure("获取不到版本号")
            return ""
        }
        return appVersion
    }

    /// ZJaDe: 返回app测试号
    public static var appBuild: String {
        guard let appBuild = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String else {
            assertionFailure("获取不到测试号")
            return ""
        }
        return appBuild
    }

    /// ZJaDe: 返回app版本号+测试号
    public static var appVersionAndBuild: String {
        if appVersion == appBuild {
            return "v\(appVersion)"
        } else {
            return "v\(appVersion)+(\(appBuild))"
        }
    }

    /// ZJaDe: 返回设备版本号
    public static var deviceVersion: String {
        var size: Int = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: Int(size))
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String(cString: machine)
    }
}
extension jd {
    /// ZJaDe: 返回是否DEBUG
    public static var isDebug: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }

    /// ZJaDe: 返回是否Release
    public static var isRelease: Bool {
        #if DEBUG
            return false
        #else
            return true
        #endif
    }

    /// ZJaDe: 返回是否是模拟器
    public static var isSimulator: Bool {
        #if targetEnvironment(simulator)
            return true
        #else
            return false
        #endif
    }

    /// ZJaDe: 是否是真机
    public static var isDevice: Bool {
        #if targetEnvironment(simulator)
            return false
        #else
            return true
        #endif
    }
}
extension jd {
    public static var keyWindow: UIWindow {
        return UIApplication.shared.keyWindow!
    }
    public static var rootWindow: UIWindow {
        return UIApplication.shared.delegate!.window!!
    }
    public static func endEditing() {
        self.keyWindow.endEditing(true)
    }
}
extension jd {
    /** 震动、响音 */
    public static func remindAndVibrate() {
        vibrate()
        AudioServicesPlaySystemSound(1007)
    }
    /** 震动 */
    public static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
extension jd {

    #if os(iOS)

    /// ZJaDe: 返回屏幕方向
    public static var screenOrientation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }

    #endif

    /// ZJaDe: 返回屏幕scale
    public static var screenScale: CGFloat {
        return UIScreen.main.scale
    }
    public static var screenBounds: CGRect {
        return UIScreen.main.bounds
    }
    public static var screenSize: CGSize {
        return UIScreen.main.bounds.size
    }
    public static var onePx: CGFloat {
        return 1 / screenScale
    }
    /// ZJaDe: 根据设备品种和方向，返回屏幕宽度
    public static let screenWidth: CGFloat = {

        #if os(iOS)

            return UIScreen.main.bounds.size.width
//            if UIInterfaceOrientationIsPortrait(screenOrientation) {
//            } else {
//                return UIScreen.main.bounds.size.height
//            }

        #elseif os(tvOS)

            return UIScreen.mainScreen().bounds.size.width

        #endif
    }()
    /// ZJaDe: 根据设备品种和方向，返回屏幕高度
    public static let screenHeight: CGFloat = {

        #if os(iOS)

            return UIScreen.main.bounds.size.height
//            if UIInterfaceOrientationIsPortrait(screenOrientation) {
//            } else {
//                return UIScreen.main.bounds.size.width
//            }

        #elseif os(tvOS)

            return UIScreen.mainScreen().bounds.size.height

        #endif
    }()

    #if os(iOS)

    /// ZJaDe: 返回状态栏的高度
    public static var screenStatusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    /// ZJaDe: 返回导航栏内容高度
    public static var navBarContentHeight: CGFloat {
        return 44
    }
    /// ZJaDe: 返回导航栏高度
    public static var navBarHeight: CGFloat {
        return self.screenStatusBarHeight + self.navBarContentHeight
    }
    /// ZJaDe: 返回状态栏下面的屏幕高度
    public static var screenHeightWithoutStatusBar: CGFloat {
        if screenOrientation.isPortrait {
            return UIScreen.main.bounds.size.height - screenStatusBarHeight
        } else {
            return UIScreen.main.bounds.size.width - screenStatusBarHeight
        }
    }

    #endif
}
extension jd {
    /// ZJaDe: 返回国家和地图的代码
    public static var currentRegion: String? {
        return (Locale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String
    }

    /// ZJaDe: 屏幕截图的时候回调
    public static func detectScreenShot(_ action: @escaping () -> Void) {
        let mainQueue = OperationQueue.main
        let noti = UIApplication.userDidTakeScreenshotNotification
        _ = NotificationCenter.default.addObserver(forName: noti, object: nil, queue: mainQueue) { _ in
            action()
        }
    }
}

extension jd {
    /// ZJaDe: 复制字符串
    public static func copy(_ string: String) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = string
    }
    /// ZJaDe: 打电话
    public static func callPhone(_ phone: String?, closure: ((Bool, String) -> Void)?) {
        guard let phone = phone, phone.count > 0 else {
            closure?(false, "电话号码为空")
            return
        }
        guard let url = URL(string: "tel: \(phone)") else {
            closure?(false, "电话号码格式错误")
            return
        }
        openUrl(url: url) { (isSuccessful) in
            if isSuccessful {
                closure?(true, "成功调起电话")
            } else {
                closure?(false, "无法打开电话-->\(phone)")
            }
        }
    }
    /// ZJaDe: 打开AppStore
    public static func openAppStore(_ url: String, completionHandler: ((Bool) -> Swift.Void)? = nil) {
        openUrl(url, completionHandler: completionHandler)
    }
    /// ZJaDe: 打开url
    public static func openUrl(url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any] = [: ], completionHandler: ((Bool) -> Swift.Void)? = nil) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: options, completionHandler: completionHandler)
        } else {
            let result = UIApplication.shared.openURL(url)
            completionHandler?(result)
        }
    }
    /// ZJaDe: 打开url
    public static func openUrl(_ urlStr: String, options: [UIApplication.OpenExternalURLOptionsKey: Any] = [: ], completionHandler: ((Bool) -> Swift.Void)? = nil) {
        guard let url = URL(string: urlStr) else {
            completionHandler?(false)
            return
        }
        openUrl(url: url, options: options, completionHandler: completionHandler)
    }
}

import AVFoundation
extension jd {
    /// ZJaDe: 闪光灯
    public static var torchOpenState: Bool {
        get {
            guard let device: AVCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
                return false
            }
            return device.torchMode == .on
        }
        set {
            guard let device: AVCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
                return
            }
            try? device.lockForConfiguration()
            device.torchMode = newValue ? .on : .off
            device.unlockForConfiguration()
        }
    }
}
extension jd {
    public static var cachePath: String? {
        /// ZJaDe: cache文件夹目录 缓存文件都在这个目录下
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
    }
    public static func fileSizeOfCache() -> UInt {
        guard let cachePath = cachePath else {
            return 0
        }
        let fileArr = FileManager.default.subpaths(atPath: cachePath) ?? []
        //快速枚举出所有文件名 计算文件大小
        var size: UInt = 0
        for file in fileArr {
            // 把文件名拼接到路径中
            let path = "\(cachePath)/\(file)"
            // 取出文件属性
            if let floder = try? FileManager.default.attributesOfItem(atPath: path) {
                // 取出文件大小属性 累加文件大小
                size += floder[.size] as? UInt ?? 0
            }
        }
        return size
    }
    public static func fileSizeOfCacheStr(size: UInt? = nil, minUnit: String? = nil) -> String {
        var size = Double(size ?? fileSizeOfCache())
        let unitArr = ["B", "KB", "MB", "GB", "TB"]
        var index = 0
        var minUnitIndex: Int?
        if let minUnit = minUnit {
            minUnitIndex = unitArr.index(of: minUnit)
        }
        while size > 1024.0 {
            if index >= unitArr.count - 1 {
                index = unitArr.count - 1
                break
            } else {
                size /= 1024.0
                index += 1
            }
        }
        if let minUnitIndex = minUnitIndex {
            if index < minUnitIndex {
                size = 0
                index = minUnitIndex
            }
        }
        return String(format: "%.2f\(unitArr[index])", size)
    }
    public static func clearCache() {
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        // 遍历删除
        for file in fileArr! {
            let path = "\(cachePath!)/\(file)"
            if FileManager.default.fileExists(atPath: path) {
                try? FileManager.default.removeItem(atPath: path)
            }
        }
    }
}
