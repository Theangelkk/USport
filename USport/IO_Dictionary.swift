import Foundation

class IO_Dictionary : ObservableObject
{
    @Published var path_dictionary : String
   
    init(newValue_path_dictionary : String)
    {
        self.path_dictionary = newValue_path_dictionary
    }
    
    func read()
    {
        
    }
    
    func write()
    {
        
    }
    
}
