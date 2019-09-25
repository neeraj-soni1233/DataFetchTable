//
//  ViewController.swift
//  fetchTableView
//
//  Created by Neeraj on 25/09/19.
//  Copyright © 2019 Neeraj Soni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
     var dataModelArray = [DataModel] ()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         self.tableView.register(UINib(nibName:"DataViewCell", bundle: nil), forCellReuseIdentifier: "dataViewCell")
        self.parseJSON(page:1)
    }


}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return dataModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataViewCell", for: indexPath) as! DataViewCell
        cell.title.text = self.dataModelArray[indexPath.row].title
        cell.date.text = self.dataModelArray[indexPath.row].title
        
        return cell
        
    }
}
extension ViewController {
    func parseJSON(page:Int) {
        
        let url = URL(string: "https://hn.algolia.com/api/v1/search_by_date?tags=story&page=1")
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
            guard error == nil else {
                print("returning error")
                return
            }
            
            guard let content = data else {
                print("not returning data")
                return
            }
            
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Error")
                return
            }
         
            var name: String = ""
             var date: String = ""
            if let jsonResult = json as Dictionary<String, AnyObject>?{
                for (key, value) in jsonResult {
                    if key == "hits"{
                        let jsonItem = value as! NSMutableArray
                        print(jsonItem)
                        for item in jsonItem{
                            print(item)
                            
                           // let title = item["data"] as! [String:Any]
                            for (key, value) in item as! [String:Any]{
                                if key == "title" {
                                    name =  value as! String
                                }
                                if key == "created_at" {
                                    date = value as! String
                                }
                                let data = DataModel.init(tit: name, date: date)
                                self.dataModelArray.append(data)
                            }
                        }
                    }

                }
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
        task.resume()
        
    }
}

extension String {
    
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        
        return date
        
    }
}


