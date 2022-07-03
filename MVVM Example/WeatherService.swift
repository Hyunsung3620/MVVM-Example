import Foundation

// MARK: - Api 호출 받고 리턴 하기

// error 정의
enum NetworkError: Error {
    case badUrl // url을 불러 올때 실패를 했을때 표시하기 위한 케이스
    case noData // data를 받아 올때 데이터가 없거나 실패하면 불러오기 위한 케이스
    case decodingError // 받은 data를 디코딩 할때 실패를 나타내는 코드
}

class WeatherService {
    // .Plist에서 Api Key 가져오기
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
     // MARK: - 이 함수는 내 생각으로 Result안에 결과를 불러오는 함수로 만든거 같다. 비동기 실행 방식
    func getWeather(completion: @escaping (Result<WeatherData, NetworkError>) -> Void) {
        // API호출을 위한 URL
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid=\(apiKey)")
        guard let url = url else {
            return completion(.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else {
                return completion(.failure(.noData))
            }
            
            // Data 타입으로 받은 리턴을 디코드
            let weatherRes = try? JSONDecoder().decode(WeatherData.self, from: data)
            
            // if문으로 성공, 실패 여부
            if let weatherRes = weatherRes {
                print(weatherRes)
                completion(.success(weatherRes)) // 성공한 데이터 저장
            } else {
                completion(.failure(.decodingError))
            }
        }.resume() // 이 datatask 실행
        
    }
    
    
    
}
