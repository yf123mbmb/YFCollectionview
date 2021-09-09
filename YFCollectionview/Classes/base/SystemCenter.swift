
import UIKit
import Foundation

//获取当前版本号
public let CurrentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
//获取历史版本号
public let SandboxVersion = UserDefaults.standard.object(forKey: "CFBundleShortVersionString") as? String ?? ""
//
////版本比较
//if currentVersion.compare(sandboxVersion) == ComparisonResult.orderedDescending {
//    //发现新版本 存储当前的版本到沙盒
//    UserDefaults.standard.set(currentVersion, forKey: "CFBundleShortVersionString")
//}

//获取app信息
public let InfoDictionary : Dictionary = Bundle.main.infoDictionary!
//程序名称
public let AppDisplayName : String = InfoDictionary["CFBundleDisplayName"] as! String
//版本号
public let MajorVersion :String = InfoDictionary ["CFBundleShortVersionString"] as! String
//build号
public let minorVersion :String = InfoDictionary ["CFBundleVersion"] as! String

//获取设备信息
//ios版本
public let iOSVersion : NSString = UIDevice.current.systemVersion as NSString
//设备udid
public let UDID  = UIDevice.current.identifierForVendor
//设备名称
public let DeviceName : String = UIDevice.current.name
//系统名称
public let SystemName : String = UIDevice.current.systemName
//设备型号
public let iOSModel = UIDevice.current.model
//设备区域化型号如A1533
public let LocalizedModel = UIDevice.current.localizedModel
///data转字典
public func DataToDictionary(data:Data) ->Dictionary<String, Any>?{
    
    do{
        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        
        let dic = json as! Dictionary<String, Any>
        return dic
    }catch _ {
        
        PrintLog(message: "失败")
        
        return nil
        
    }
    
}

//Debug模式下打印
public func PrintLog<T>(message: T, fileName: String = #file, funcName: String = #function, lineNum : Int = #line) {
    #if DEBUG
    // 1.对文件进行处理
    let file = (fileName as NSString).lastPathComponent
    // 2.打印内容
    print("[\(file)]]-->[\(funcName)]-->第\(lineNum)行\("\n")打印信息：\(message)")
    #endif
}
///延时
public func Delay(time:Double,callBack:@escaping ()->()){
    //延时 0.5s 执行
    DispatchQueue.global().asyncAfter(deadline: DispatchTime.now()+time) {
        //此时处于主队列中
        callBack()
    }
}

///GCD
func GCDBF(){
    let group = DispatchGroup()
    let queue = DispatchQueue.global()
    
    queue.async(group: group, execute: {
        ///通知 group,下个任务要放入 group 中执行
        group.enter()
        
        ///模拟网络请求
        queue.asyncAfter(deadline: .now() + 4) {
            PrintLog(message: "1")
            ///通知 group,任务成功完成,要移除,与 enter成对出现
            group.leave()
        }
    })
    queue.async(group: group, execute: {
        group.enter()
        
        ///模拟网络请求
        queue.asyncAfter(deadline: .now() + 1) {
            PrintLog(message: "2")
            group.leave()
        }
    })
    
    queue.async(group: group, execute: {
        group.enter()
        
        ///模拟网络请求
        queue.asyncAfter(deadline: .now() + 6) {
            PrintLog(message: "3")
            group.leave()
        }
    })
    queue.async(group: group, execute: {
        group.enter()
        
        ///模拟网络请求
        queue.asyncAfter(deadline: .now() + 10) {
            PrintLog(message: "4")
            group.leave()
        }
    })
    queue.async(group: group, execute: {
        group.enter()
        PrintLog(message: "5")
        group.leave()
    })
    
    ///只要任务全部完成了,就会在最后调用
    group.notify(queue: DispatchQueue.main) {
        PrintLog(message: "完结咯，刷新UI")
        
    }
    
    
}

///多线程信号量
func Semaphore_demo() {

    let group = DispatchGroup.init()
    //任务A1
    DispatchQueue.global().async(group: group, execute: DispatchWorkItem.init(block: {
        
        //创建信号量为0
        let semaphore = DispatchSemaphore.init(value: 0)
        //开启异步任务
        DispatchQueue.global().async {
            //模拟网络请求两秒后返回
            Thread.sleep(forTimeInterval: 2)
            print("完成网络请求A1\(Thread.current)")
            semaphore.signal()
        }
        //调用wait()方法，此时信号量为0，会阻塞当前线程，任务A1不会返回，所以就不会通知任务A
        semaphore.wait()
        print("完成任务A1\(Thread.current)")
    }))
    
    //任务A2
    DispatchQueue.global().async(group: group, execute: DispatchWorkItem.init(block: {
        
        //创建信号量为0
        let semaphore = DispatchSemaphore.init(value: 0)
        //开启异步任务
        DispatchQueue.global().async {
            //模拟网络请求两秒后返回
            Thread.sleep(forTimeInterval: 2)
            print("完成网络请求A2\(Thread.current)")
            semaphore.signal()
        }
        //调用wait()方法，此时信号量为0，会阻塞当前线程，任务A2不会返回，所以就不会通知任务A
        semaphore.wait()
        print("完成任务A2\(Thread.current)")
    }))
    
    //任务A3
    DispatchQueue.global().async(group: group, execute: DispatchWorkItem.init(block: {
        
        //创建信号量为0
        let semaphore = DispatchSemaphore.init(value: 0)
        //开启异步任务
        DispatchQueue.global().async {
            //模拟网络请求两秒后返回
            Thread.sleep(forTimeInterval: 2)
            print("完成网络请求A3\(Thread.current)")
            semaphore.signal()
        }
        //调用wait()方法，此时信号量为0，会阻塞当前线程，任务A3不会返回，所以就不会通知任务A
        semaphore.wait()
        print("完成任务A3\(Thread.current)")
    }))
    
    //通知任务A，三个任务已经全部完成
    group.notify(queue: DispatchQueue.main) {
        print("全部完成\(Thread.current)")
    }

    //任务B
    print("异步任务不会阻塞线程")
}



