//
//  ViewController.swift
//  Location
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 zhangyanlin. All rights reserved.
//

import UIKit

class ViewController: UIViewController,BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate {

    @IBOutlet weak var addressLabel: UILabel!
    var locationService : BMKLocationService!
    var geoCodeSearch : BMKGeoCodeSearch!
    var address = String()
    var lat = Double()
    var lon = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        geoCodeSearch = BMKGeoCodeSearch()
        locationService = BMKLocationService()
        
        locationService.startUserLocationService()
        navigationController?.hidesBarsOnSwipe = !false

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        geoCodeSearch.delegate = self
        locationService.delegate = self
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        geoCodeSearch.delegate = nil
        locationService.delegate = nil
    }

/**
     *用户位置更新后，会调用此函数
     *@param userLocation 新的用户位置
     */
    func didUpdate(_ userLocation: BMKUserLocation!)
    {
        self.lat = userLocation.location.coordinate.latitude
        self.lon = userLocation.location.coordinate.longitude
        let reverseGeocodeSearchOption = BMKReverseGeoCodeOption()
        reverseGeocodeSearchOption.reverseGeoPoint = CLLocationCoordinate2DMake(self.lat, self.lon)
        
        print("目标位置:\(self.lat)\(self.lon)")
        //发送反编码请求.并返回是否成功
        let flag = geoCodeSearch.reverseGeoCode(reverseGeocodeSearchOption)
        
        if (flag)
        {
            print("反geo检索发送成功")
        } else {
            print("反geo检索发送失败")
        }
    }
    /**
     *返回反地理编码搜索结果
     *@param searcher 搜索对象
     *@param result 搜索结果
     *@param error 错误号，@see BMKSearchErrorCode
 
    - (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error;
  */
    func onGetReverseGeoCodeResult(_ searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        print("返回错误信息%@",error)
        if (error == BMK_SEARCH_NO_ERROR) {
            print("返回正常")
            
            self.addressLabel.text = result.address
            
        } else {
            print("返回错误....")
        }
        
    }
}

