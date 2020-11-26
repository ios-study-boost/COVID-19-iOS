//
//  Area.swift
//  COVID-19-iOS
//
//  Created by Eunjee Shin on 2020/11/06.
//

import Foundation

//extension Area {
//    func add(_ added :Area){
//        self.death
//    }
//}

struct Area {

    let deathCnt : Int
    let areaName : String
    let increaseCnt : Int
    let isolClear : Int
    let numInfected : Int
    let createDate : String
    
    init(deathCnt: String, areaName: String, incDec: String, isolClearCnt: String, qurRate: String, createDt: String){
        self.deathCnt = Int(deathCnt) ?? 0
        self.areaName = areaName
        self.increaseCnt = Int(incDec) ?? 0
        self.isolClear = Int(isolClearCnt) ?? 0
        self.numInfected = Int((Double(qurRate) ?? 0.0 * 10000000))
        self.createDate = createDt
    
    }
    
    func getAreaDetail()-> String{
        return "확진자: \(self.numInfected), \(self.increaseCnt)"
    }
}
