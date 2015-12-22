//
//  Languager.swift
//  icar
//
//  Created by gongkai on 15/5/18.
//  Copyright (c) 2015年 anytracking. All rights reserved.
//
import UIKit
private let kUserLanguage = "AppleLanguages"

/**
*  国际化工具
*/
class Languager: NSObject {
    private struct Static {
        static var onceToken : dispatch_once_t = 0
        static var staticInstance : Languager? = nil
    }
    private var _currentLanguage:String?
    
    override init() {
        super.init()
        self.initLanguages()
    }
    
    //当前语言Bundle
    internal var currentLanguageBundle:NSBundle?
    
    // 当前语言获取与切换
    var currentLanguage:String{
        get{
            if(self._currentLanguage==nil){
                self._currentLanguage = (NSUserDefaults.standardUserDefaults().valueForKey(kUserLanguage) as! [String])[0]
            }
            return self._currentLanguage!
        }
        set(newLanguage){
            if(self._currentLanguage == newLanguage){
                return
            }
            if let path = NSBundle.mainBundle().pathForResource(newLanguage, ofType: "lproj" ),let bundel = NSBundle(path:path){
                self.currentLanguageBundle = bundel
                self._currentLanguage = newLanguage
            }else{
                //如果不支持当前语言则加载info中Localization native development region中的值的lporj
                let defaultLanguage = (NSBundle.mainBundle().infoDictionary! as NSDictionary).valueForKey(kCFBundleDevelopmentRegionKey as String) as! String
                self.currentLanguageBundle =  NSBundle(path:NSBundle.mainBundle().pathForResource(defaultLanguage, ofType: "lproj" )!)
                self._currentLanguage = defaultLanguage
            }
            let def = NSUserDefaults.standardUserDefaults()
            def.setValue([self._currentLanguage!], forKey:kUserLanguage)
            def.synchronize()
            
            NSBundle.mainBundle().onLanguage()
        }
    }
    
    // 单列
    class func standardLanguager()->Languager{
        dispatch_once(&Static.onceToken) {
            Static.staticInstance = Languager()
        }
        return Static.staticInstance!
    }
    
    //初始化
    func initLanguages(){
        let language = (NSUserDefaults.standardUserDefaults().objectForKey(kUserLanguage) as! Array<String>)[0]
        if let path = NSBundle.mainBundle().pathForResource(language, ofType: "lproj" ),let bundel = NSBundle(path:path){
            self.currentLanguageBundle = bundel
            self._currentLanguage = language
        }else{
            //如果不支持当前语言则加载info中Localization native development region中的值的lporj,设置为当前语言
            self.currentLanguage = (NSBundle.mainBundle().infoDictionary! as NSDictionary).valueForKey(kCFBundleDevelopmentRegionKey as String) as! String
            print("Languager:\(language)不支持，切换成默认语言\(self._currentLanguage!)")
        }
    }
    
    /**
    获取当前语言的storyboard
    */
    func storyboard(name:String)->UIStoryboard{
        return UIStoryboard(name: name, bundle: self.currentLanguageBundle)
    }
    
    /**
    获取当前语言的nib
    */
    func nib(name:String)->UINib{
        return UINib(nibName: name, bundle: self.currentLanguageBundle)
    }
    
    /**
    获取当前语言的string
    */
    func string(key:String)->String{
        if let str = self.currentLanguageBundle?.localizedStringForKey(key, value: nil, table: nil){
            return str
        }
        return key
    }
    
    /**
    获取当前语言的image,注意，此处加载的是2x图片
    */
    func image(name:String)->UIImage?{
        let path = self.currentLanguageBundle?.pathForResource(name+"@2x", ofType: "png")
        return UIImage(contentsOfFile: path!)
    }
}

func localized(key:String)->String{
    return Languager.standardLanguager().string(key)
}

func localizedImage(key:String)->UIImage?{
    return Languager.standardLanguager().image(key)
}



