//: [Previous](@previous)

import Foundation

// Android offers a pretty sweet way to
// implement networking code:

// Kotlin

//data class MyServiceResponse(/* ... */)
//
//interface MyService {
//    @FormUrlEncoded
//    @POST("/myservice/endpoint")
//    fun call(@Header("Authorization") authorizationHeader: String,
//             @Field("first_argument") firstArgument: String,
//             @Field("second_argument") secondArgument: Int
//            ): Observable<MyServiceResponse>
//}

// That's the entire implementation!
// Everything is provided through attributes,
// and the code can be synthesized from it 🤯
   
// We cannot quite do this with Property Wrappers...
// ...but we can try to get as close as we can!

// Disclaimer: this is experimental!
// I do not recommend that you use it in
// production code!

typealias Service<Response> = (_ completionHandler: @escaping (Result<Response, Error>) -> Void) -> ()

@propertyWrapper
struct GET {
    // 👩🏽‍💻👨🏼‍💻 Implement `struct GET`
    private let url: URL
    
    init(url: String) {
        self.url = URL(string: url)!
    }
    
    var wrappedValue: Service<String> {
        get {
            return { completion in
                URLSession.shared.dataTask(with: self.url){ (data, response, error) in
                    guard error == nil else {
                        completion(.failure(error!))
                        return
                    }
                    
                    let result = String(data: data!, encoding: .utf8)!
                    
                    completion(.success(result))
                }.resume()
            }
        }
        
    }
}

struct API {
    @GET(url: "https://samples.openweathermap.org/data/2.5/weather?id=2172797&appid=b6907d289e10d714a6e88b30761fae22")
    static var getCurrentWeather: Service<String>
}

API.getCurrentWeather { result in
    print(result)
}

//: [Next](@next)
