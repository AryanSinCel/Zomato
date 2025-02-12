import Foundation

//MARK: - API Calling on Geopify
class ViewModel: ObservableObject{
    
    func fetchPlaceNames(completion:@escaping(GeoapifyResponse)->Void){
        
        var latitude  = UserDefaults.standard.string(forKey: "latitude") ?? "28.585070"
        var longitude = UserDefaults.standard.string(forKey: "longitude") ?? "77.311600"
        
        print(latitude)
        print(longitude)
        
        guard let url = URL(string: "https://api.geoapify.com/v2/places?categories=commercial&filter=circle:\(longitude),\(latitude),5000&limit=20&apiKey=109b5563043c41278db5c25cb06cc6b4") else{
            return
        }
        let task = URLSession.shared.dataTask(with: url){ data, _, error in
            guard let data = data, error == nil else{
                return
            }

            do{
                let location = try JSONDecoder().decode(GeoapifyResponse.self, from: data)
                completion(location)
                
            }catch{
                print(error)
            }
            
        }
        task.resume()
    }
    

}


