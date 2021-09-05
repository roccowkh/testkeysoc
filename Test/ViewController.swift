import UIKit
class ViewController: UITabBarController, UITabBarControllerDelegate {
    var album = [Album]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign self for delegate for that ViewController can respond to UITabBarControllerDelegate methods
        self.delegate = self
        
      fetchFilms()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create Tab one
        let tabOne = TabOneViewController()
        let tabOneBarItem = UITabBarItem(title: "Tab 1", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
        
        tabOne.tabBarItem = tabOneBarItem
        
        tabOne.list = self.album
        // Create Tab two
        let tabTwo = TabTwoViewController()
        let tabTwoBarItem2 = UITabBarItem(title: "Tab 2", image: UIImage(named: "defaultImage2.png"), selectedImage: UIImage(named: "selectedImage2.png"))
        
        tabTwo.tabBarItem = tabTwoBarItem2
        
        
        self.viewControllers = [tabOne, tabTwo]
    }
    
    func fetchFilms() {
        let url = URL(string:"https://itunes.apple.com/search?term=jack+johnson&entity=album")!

        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
          if let error = error {
            print("Error with fetching films: \(error)")
            return
          }
          
          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
            print("Error with the response, unexpected status code: \(response)")
            return
          }

          if let data = data,
            let filmSummary = try? JSONDecoder().decode(Json4Swift_Base.self, from: data) {
//            completionHandler(filmSummary.results ?? [])
            print(filmSummary)
            self.album = filmSummary.results!
            let albumManager = AlbumManageer.shared
            albumManager.album = filmSummary.results
          }
        })
        task.resume()
      }
    
    func getList() {
        let url = URL(string:"https://itunes.apple.com/search?term=jack+johnson&entity=album")!
//        let url = URL(string: "https://bit.ly/3sspdFO")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print("\(String(data: data!, encoding: .utf8))")
//            let decoder = JSONDecoder()
            let jsonString = (String(data: data!, encoding: .utf8))!
            let data = Data(jsonString.utf8)
            do {
                // make sure this JSON is in the format we expect
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // try to read out a string array
                    if let names = json["names"] as? [String] {
                        print(names)
                    }
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
//            do {
//                let people = try decoder.decode([Person].self, from: jsonData)
//                print(people)
//            } catch {
//                print(error.localizedDescription)
//            }
//            do {
//                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
//                    // try to read out a string array
//                    let results = json["results"]
//                    print(results)
//                }
//            } catch let error as NSError {
//                print("Failed to load: \(error.localizedDescription)")
//            }
        }
        task.resume()
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
    }
}
