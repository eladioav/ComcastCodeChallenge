//
//  MasterViewModel.swift
//  ComcastCodeChallenge
//
//  Created by Eladio Alvarez Valle on 5/14/19.
//  Copyright © 2019 Eladio Alvarez Valle. All rights reserved.
//

import Foundation

class MasterViewModel {
    
    var data : [RelatedTopic] = []
    private var filteredData : [RelatedTopic] = [] {
        
        didSet {
            
            delegate.updateData()
        }
    }
    
    private var delegate : ModelToView
    
    init(delegate : ModelToView) {
        
        self.delegate = delegate
    }
    
    ///Filter data
    /// - Parameters:
    ///     - keyword: keyword to filter data
    func filterData(keyword : String) {
        
        guard (keyword != "")  else {
            
            //If keyword is "", don't filter
            self.filteredData = self.data
            return
        }
        print(keyword)
        //Filter data by keyword and sort it
        self.filteredData = self.data.filter({ $0.Text.lowercased().contains(keyword.lowercased()) })
    }
    
    /// Get character
    /// - Parameters:
    ///     - index : Element number
    /// - Returns: Character
    func getCharacter(index : Int) -> CharacterModel {
        
        let character_ = self.filteredData[index]
        var info = self.filteredData[index].Text.components(separatedBy: "-")
        let title = info.first ?? "No name"
        info.removeFirst()
        let description = info.reduce("", +)
        
        let characterModel = CharacterModel(urlImage: character_.Icon.URL, title: title, description: description)
        
        return characterModel
    }
    
    /// Get character title
    /// - Parameters:
    ///     - index : Element number
    /// - Returns: Character name
    func getTitle(index : Int) -> String {
        
        return self.filteredData[index].Text.components(separatedBy: "-").first ?? "No name"
    }
    
    /// Get character description
    /// - Parameters:
    ///     - index : Element number
    /// - Returns: Character description
    func getDescription(index : Int) -> String {

        return self.filteredData[index].Text.components(separatedBy: "-").last ?? "No description"
    }
    
    
    /// Get city from filtered data
    /// - Returns: Number of elements
    func getNumberOfElements() -> Int {
        
        return self.filteredData.count
    }
    
    /// Fetch data to object
    func fetchData() {
        
        let apiCaller = API_Caller(URL: url, httpMethodType: .GET, authenticationType: .None)
        
        apiCaller.callAPI(dataParameter: nil, customHeaders: nil) {
            
            (code, data, response) in
            
            guard code == "200", let data_ = data as? Data else {
                
                return
            }
            
            // Get data and parse it
            do {
                
                // Get Data and parse it
                let serverDataResponseModel = try JSONDecoder().decode(ServerDataResponseModel.self, from: data_)
                
                DispatchQueue.main.async {
                    
                    //Update data objects
                    self.data = serverDataResponseModel.RelatedTopics
                    self.filteredData = self.data
                }
                
            } catch {
                
                // handle error
                print("Error: \(error)")
            }
            
        }
        
    }
}
