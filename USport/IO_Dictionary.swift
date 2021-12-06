import Foundation

typealias Codable_IO = Decodable & Encodable

class IO_Dictionary<T : Codable_IO>
{
    @Published var path_dictionary : URL?
    
    var decoder : JSONDecoder = JSONDecoder()
    var encoder : JSONEncoder = JSONEncoder()
   
    init(newValue_path_dictionary : URL?)
    {
        self.path_dictionary = newValue_path_dictionary
        
        self.decoder = JSONDecoder()
        
        self.encoder = JSONEncoder()
    }
    
    func read()
    {
        do
        {
            let data = try Data(contentsOf: self.path_dictionary!)
            let jsonData = try self.decoder.decode(T.self,from: data)
            
        } catch
        {
            print("Read Error Json:\(error)")
        }
    }
    
    func write(obj : T)
    {
        /*let usr: User = User(nickname: nickname,height: height, weight: weight, workout: workout)

        let usrenc: UserEnc = UserEnc(nickname: usr.nickname, height: usr.height, weight: usr.weight, workout: usr.workout)
         */
        
        
        if let jsonData = try? encoder.encode(obj)
        {
            if let jsonString = String(data: jsonData, encoding: .utf8)
            {
                do
                {
                    try jsonString.write(to: self.path_dictionary!, atomically: true, encoding: .utf8)
                }
                catch
                {
                    print("Write Error Json:\(error)")
                }
            }
        }
    }
    
}
