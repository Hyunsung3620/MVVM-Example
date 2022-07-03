import UIKit

class ViewController: UIViewController {
    
    // MARK: - View Model에 들어갈 것
    private var apiKey: String {
        get {
            //. 생성한 .plist 파일 경로 불러오기
            guard let filePath = Bundle.main.path(forResource: "KeyList", ofType: "plist") else {
                fatalError("Couldn't find file 'keyList.plist'.")
            }
            // plist에서 딕셔너리로 받아오기
            let plist = NSDictionary(contentsOfFile: filePath)
            
            //. 딕셔너리에서 값 찾기
            guard let value = plist?.object(forKey: "OPENWEATHER_KEY") as? String else {
                fatalError("couldn't find OPENWEATHER_KEY in 'KeyList.plist'.")
            }
            return value
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

