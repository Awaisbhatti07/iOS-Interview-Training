import UIKit

//MARK: - Single-responsibility principle

/* -> There should never be more than one reason for a class to change.”In other words, every class should have only one responsibility*/

/* -> A common mistake in development is creating classes that handle multiple responsibilities. Each class should have a single, well-defined purpose. For instance, avoid creating a class responsible for network calls, handling functions, passing data to ViewControllers, and more.*/


// Bad Example
class NetworkManager1 {
    static let shared = NetworkManager1()
    
    private init() {}
    
    func handleAllActions() {
        let userData = getUsers()
        let userArray = parseDataToJson(data: userData)
        saveDataToDB(users: userArray)
    }
    
    func getUsers() -> Data {
        //Send API request and wait for a response
        print("Get User")
        return Data()
    }
    
    func parseDataToJson(data: Data) -> [String] {
        // parse the data and convert it to array\
        print("parse Data To Json")
        return []
    }
    
    func saveDataToDB(users: [String]) {
        print("save Data To DB")
        // save that array into CoreData...
       
    }
}


// Good Example
class NetworkManager {
    var userAPIHandler: UserAPIHandler?
    var parseDataHandler: ParseDataHandler?
    var saveDataToDBHandler: SaveDataToDBHandler?
    
    init(userAPIHandler: UserAPIHandler, parseDataHandler: ParseDataHandler, saveDataToDBHandler: SaveDataToDBHandler) {
        self.userAPIHandler = userAPIHandler
        self.parseDataHandler = parseDataHandler
        self.saveDataToDBHandler = saveDataToDBHandler
    }
    
    func handleAllActions() {
        guard let userAPIHandler else { return }
        guard let parseDataHandler else { return }
        guard let saveDataToDBHandler else { return }
        
        let userData = userAPIHandler.getUsers()
        let userArray = parseDataHandler.parseDataToJson(data: userData)
        saveDataToDBHandler.saveDataToDB(users: userArray)
    }
}

class UserAPIHandler {
    func getUsers() -> Data {
        //Send API request and wait for a response
        print("Get User")
        return Data()
    }
}

class ParseDataHandler {
    func parseDataToJson(data: Data) -> [String] {
        // parse the data and convert it to array\
        print("parse Data To Json")
        return []
    }
}

class SaveDataToDBHandler {
    func saveDataToDB(users: [String]) {
        print("save Data To DB")
        // save that array into CoreData...
       
    }
}

var apiHandler = UserAPIHandler()
var parseDataHandler = ParseDataHandler()
var saveDataToDBHandler = SaveDataToDBHandler()

var networkManager = NetworkManager(userAPIHandler: apiHandler, parseDataHandler: parseDataHandler, saveDataToDBHandler: saveDataToDBHandler)
networkManager.handleAllActions()

