//
//  TableViewController.swift
//  COVID-19-iOS
//
//  Created by Eunjee Shin on 2020/11/05.
//

import UIKit
import Alamofire
import SwiftyXMLParser


class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var areas : [String: Area] = [:]
    var areaNames : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testForAPI()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.areas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegionCell", for: indexPath)
        
        return cell
    }
    
    func testForAPI() {
        let baseURL = "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson"

        let params: [String:Any] = ["serviceKey":"yOnwo%2Bo9O9KpHIrKU1jZIyPCFdlRVkLIsa714mrNIOfNPQAEVelNNF%2F%2FveF6iRhqmySy4KGM07vdpaU6W8YosA%3D%3D", "pageNo":1, "numOfRows":10, "startCreateDt":20200310, "endCreateDt":20200315]
        
        func getURL(url:String, params:[String: Any]) -> URL {
            let urlParams = params.compactMap({ (key, value) -> String in
                return "\(key)=\(value)"
            }).joined(separator: "&")
            let withURL = url + "?\(urlParams)"
            
            return URL(string: withURL)!
        }
        
        func getCoronaData(params: [String:Any]) {
            let url = getURL(url: baseURL, params: params)
            
            let request = AF.request(url, method: .get).validate()
            
            request.responseString { response in
                //if case success
                switch response.result {
                case .success(let value):
                    let responseString = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue )
                    guard let xml = try? XML.parse(String(responseString!)) else {
                        return
                    }
                    for item in xml.response.body.items.item {
                        let thisArea : String = item.gubun.text ?? ""
                        self.areaNames.append(thisArea)
            
                        let area : Area = Area(deathCnt: item.deathCnt.text ?? "", areaName: item.gubun.text ?? "", incDec: item.incDec.text ?? "", isolClearCnt: item.isolClearCnt.text ?? "", qurRate: item.qurRate.text ?? "", createDt: item.createDt.text ?? "")
                        print("\(item.qurRate.text)")
                        if self.areas[thisArea] != nil{
                            
                        }else{
                            self.areas[thisArea] = area
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        getCoronaData(params: params)
        //testForXMLParser()
    }

    func testForXMLParser() {
            let str = """
            <ResultSet>
                <Result>
                    <Hit index=\"1\">
                        <Name>Item1</Name>
                    </Hit>
                    <Hit index=\"2\">
                        <Name>Item2</Name>
                    </Hit>
                </Result>
            </ResultSet>
            """
            
            // parse xml document
            let xml = try! XML.parse(str)
            
            // access xml element
            let accessor = xml["ResultSet"]
            
            // access XML Text
            
            if let text = xml["ResultSet", "Result", "Hit", 0, "Name"].text {
                print(text)
            }
            
            if let text = xml.ResultSet.Result.Hit[0].Name.text {
                print(text)
            }
            
            // access XML Attribute
            if let index = xml["ResultSet", "Result", "Hit", 0].attributes["index"] {
                print(index)
            }
            
            // enumerate child Elements in the parent Element
            for hit in xml["ResultSet", "Result", "Hit"] {
                print(hit)
            }
            
            // check if the XML path is wrong
            if case .failure(let error) =  xml["ResultSet", "Result", "TypoKey"] {
                print(error)
            }
        }
    
}
