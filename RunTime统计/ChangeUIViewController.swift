

//这个类主要是RunTime在统计这块的作用，通过交换UIViewController个UIControl里面的方法，实现对于每个VC和每个Btn的统计

//  ChangeUIViewController.swift
//  RunTime统计
//
//  Created by sks on 17/3/1.
//  Copyright © 2017年 besttone. All rights reserved.
//


import Foundation
import UIKit
extension UIViewController{
    
    override open class func initialize(){
        super.initialize()
        DispatchQueue.once(token: "com.besttone.jyBesttone") {
            //交换viewDidAppear和viewWillDisappear方法，统计每个页面进入和离开，然后再通过plist文件直接取对应的统计ID
            let primaryAppearSel = #selector(UIViewController.viewDidAppear(_:))
            let replaceAppearSel = #selector(UIViewController.jyViewDidAppear(_:))
            
            SwiftRunTimeTool.methodSwizze(cls: UIViewController.self, originalSelector: primaryAppearSel, swizzeSelector: replaceAppearSel)
            
            let primaryDisapperaSel = #selector(UIViewController.viewWillDisappear(_:))
            let replaceDisapperaSel = #selector(UIViewController.jyViewWillDisAppear(_:))
            
            SwiftRunTimeTool.methodSwizze(cls: UIViewController.self, originalSelector: primaryDisapperaSel, swizzeSelector: replaceDisapperaSel)
        }
    }
    
    func jyViewDidAppear(_ animation : Bool){
        self.jyViewDidAppear(animation)
        if VCIDTool.getVCID(className: object_getClass(self), isEnter: true) != ""{
            print(VCIDTool.getVCID(className: object_getClass(self), isEnter: true))
        }
    }
    func jyViewWillDisAppear(_ animation : Bool){
        self.jyViewWillDisAppear(animation)
        if VCIDTool.getVCID(className: object_getClass(self), isEnter: false) != ""{
            print(VCIDTool.getVCID(className: object_getClass(self), isEnter: false))
        }
    }
}

extension UIControl{
    //通过交换UIControl的sendAction方法，去到对应的类和对于的方法名，进行统计
    override open class func initialize(){
        super.initialize()
        DispatchQueue.once(token: "com.besttone.jycontrol") { 
            let primarySendActionSel = #selector(UIControl.sendAction(_:to:for:))
            let replaceSendActionSel = #selector(UIControl.jySendAction(_:to:for:))
            SwiftRunTimeTool.methodSwizze(cls: UIControl.self, originalSelector: primarySendActionSel, swizzeSelector: replaceSendActionSel)
        }
    }
    func jySendAction(_ action: Selector, to target: Any?, for event: UIEvent?){
        self.jySendAction(action, to: target, for: event)
        if VCIDTool.getControlID(className: object_getClass(target), controlAction: action) != ""{
            print(VCIDTool.getControlID(className: object_getClass(target), controlAction: action))
        }
    }
}

class VCIDTool : NSObject{
    //从Plist文件取VC统计ID
    class func getVCID(className : AnyClass , isEnter : Bool) -> String{
        let filePath = Bundle.main.path(forResource: "ViewControllerIDList", ofType: "plist") ?? ""
        let vcDic : NSDictionary = NSDictionary(contentsOfFile: filePath) ?? NSDictionary()
        let vcName = "\(className)"
        if let vcSomeDic = vcDic[vcName] {
            return ((vcSomeDic as! NSDictionary)["PageEnentIDs"] as! NSDictionary)[isEnter ? "Enter" : "Leave"] as! String
        }else{
            return ""
        }
    }
    //从Plist文件取Btn的统计ID
    class func getControlID(className : AnyClass , controlAction : Selector) ->String{
        let filePath = Bundle.main.path(forResource: "ViewControllerIDList", ofType: "plist") ?? ""
        let vcDic : NSDictionary = NSDictionary(contentsOfFile: filePath) ?? NSDictionary()
        let vcName = "\(className)"
        if let vcSomeDic = vcDic[vcName] {
            return ((vcSomeDic as! NSDictionary)["ControlEventIDs"] as! NSDictionary)[controlAction.description] as! String
        }else{
            return ""
        }
    }
}




















