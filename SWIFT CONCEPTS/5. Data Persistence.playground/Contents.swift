import UIKit

// MARK: - 6. Data Persistence
/*

 UserDefaults
 Codable
 FileManager
 CoreData (Fetch, Insert, Delete, Relationships, NSPredicate)
 Realm (optional, if asked)
 Keychain (for secure storage)

 ----------------- ----------------- ----------------- ----------------- ----------------- ----------------- ----------------- -----------------

 Data Persistence in iOS:
 Data Persistence means saving data so that it remains available even after the app is closed or the device is restarted.
 iOS provides several ways to persist data based on the use case.

 1. UserDefaults
    - Storing small pieces of data like settings, flags, login status.

    UserDefaults.standard.set(true, forKey: "isLoggedIn")
    let status = UserDefaults.standard.bool(forKey: "isLoggedIn")

*/

// MARK: - 2. Codable
/*

 - Encoding/decoding Swift types into/from JSON or other formats.

   Definition:
   A protocol that allows your model objects to be easily serialized and deserialized.

*/

struct User: Codable {
    var name: String
    var age: Int
}

let user = User(name: "Awais", age: 28)
let data = try JSONEncoder().encode(user)
let decodedUser = try JSONDecoder().decode(User.self, from: data)


// MARK: - 3. FileManager
/*
     Used for: Saving files like images, JSON, PDFs in local storage.

     Definition:
     API to read/write/delete files or folders in your app’s sandbox directory.

*/

let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("user.json")
try data.write(to: fileURL)


// MARK: - 4. Core Data
/*
     Used for: Complex data storage with relationships, filtering, and querying.

     Definition:
     A powerful framework for object graph management and data persistence, like a local database.

     Key Features:

         Insert: Create new objects and save them.
         Fetch: Query data using NSFetchRequest.
         Delete: Remove records from storage.
         Relationships: One-to-one, one-to-many between entities.
         NSPredicate: Filter fetch requests.

     Interview Points:

         Managed Object Context handles CRUD operations.
         Use NSFetchedResultsController for efficient table/collection view updates.
         Relationships are defined in the data model editor.
         NSPredicate supports complex queries (e.g., name CONTAINS[cd] %@).

     // Setup (in AppDelegate or PersistentContainer)
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

     // Insert
     let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
     newUser.setValue("John", forKey: "name")
     try? context.save()

     // Fetch
     let request = NSFetchRequest<NSManagedObject>(entityName: "User")
     request.predicate = NSPredicate(format: "name == %@", "John")
     let users = try? context.fetch(request)

     // Delete
     if let userToDelete = users?.first {
         context.delete(userToDelete)
         try? context.save()
     }


 ✅ 1. Core Data Example – With Comments
 🎯 Goal: Save, Fetch, and Delete User objects with name and age.
 📁 Step-by-step in SwiftUI using Core Data stack (auto from Xcode)

 📌 Model Setup in .xcdatamodeld
 Open Model.xcdatamodeld

 Add an entity named User

 name → String
 age → Integer 16

 Xcode auto-generates User+CoreDataClass.swift

 📦 Full Code:
 import SwiftUI
 import CoreData

 struct CoreDataView: View {
     // Accessing Core Data context
     @Environment(\.managedObjectContext) var context

     // State for input fields
     @State private var name = ""
     @State private var age = ""

     // Fetch all User records
     @FetchRequest(
         entity: User.entity(),
         sortDescriptors: [NSSortDescriptor(keyPath: \User.name, ascending: true)]
     ) var users: FetchedResults<User>

     var body: some View {
         VStack(spacing: 20) {
             // MARK: - Input Fields
             TextField("Enter name", text: $name)
                 .textFieldStyle(RoundedBorderTextFieldStyle())
             TextField("Enter age", text: $age)
                 .keyboardType(.numberPad)
                 .textFieldStyle(RoundedBorderTextFieldStyle())

             // MARK: - Save Button
             Button("Save to Core Data") {
                 let newUser = User(context: context)
                 newUser.name = name
                 newUser.age = Int16(age) ?? 0

                 do {
                     try context.save()
                     name = ""
                     age = ""
                     print("✅ Saved successfully.")
                 } catch {
                     print("❌ Failed to save: \(error)")
                 }
             }

             // MARK: - List of Users
             List {
                 ForEach(users, id: \.self) { user in
                     VStack(alignment: .leading) {
                         Text(user.name ?? "No Name")
                         Text("Age: \(user.age)")
                             .font(.subheadline)
                             .foregroundColor(.gray)
                     }
                 }
                 .onDelete(perform: deleteUser)
             }
         }
         .padding()
     }

     // MARK: - Delete function
     func deleteUser(at offsets: IndexSet) {
         for index in offsets {
             let userToDelete = users[index]
             context.delete(userToDelete)
         }

         do {
             try context.save()
             print("🗑 User deleted.")
         } catch {
             print("❌ Delete failed: \(error)")
         }
     }
 }


 ✅ Core Data – Interview Questions (Most Common)

 🔹 Basic Understanding
 What is Core Data?

 Core Data is an object graph and persistence framework by Apple. It helps manage the model layer of your app — including saving, fetching, and deleting records in a local database.

 How is Core Data different from SQLite?

 Core Data is an abstraction layer over SQLite (but not limited to it). SQLite is a relational DB, while Core Data is an object graph manager. Core Data doesn’t expose SQL directly.

 What are NSManagedObject and NSManagedObjectContext?

 NSManagedObject is a runtime representation of a Core Data entity.
 NSManagedObjectContext is a scratchpad used to track changes and save them to the persistent store.

 What is NSPersistentContainer?

 A container that encapsulates the Core Data stack: model, context, coordinator, and persistent store.

 🔹 Intermediate-Level

 How do you fetch data in Core Data?

 let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
 request.predicate = NSPredicate(format: "age > %d", 20)
 let result = try context.fetch(request)

 How do you delete a record in Core Data?

 context.delete(object)
 try context.save()

 What is an NSFetchedResultsController?

 A class that monitors Core Data for changes and is often used with UITableView for efficient updates.

 What are relationships in Core Data?

 To-One and To-Many relationships.

 Example: A Company can have many Employees.

 🔹 Advanced / Tricky

 What is Merge Policy in Core Data?

 When multiple contexts update the same object, a merge policy decides how to resolve conflicts (e.g., .mergeByPropertyObjectTrump).

 How to improve Core Data performance?

 Use background contexts.
 Batch updates (NSBatchUpdateRequest).
 Avoid faulting large graphs.
 Use NSPersistentContainer.performBackgroundTask.

 What is faulting in Core Data?

 Lazy loading of objects. It loads only when accessed, reducing memory usage.

 Threading in Core Data?

 Contexts are not thread-safe.
 Use .perform and .performAndWait for background work.

 What is the difference between Save vs Merge in Core Data?

*/


// MARK: - 5. Realm
/*

 Used for: Alternative to Core Data. Easier syntax, faster setup.

 Definition:
 A third-party local database solution with object-oriented APIs.

 ✅ 2. Realm Example – With Comments

 📦 Setup: Install RealmSwift via Swift Package Manager or CocoaPods

 import RealmSwift

 📌 Realm Model Class

 // MARK: - Realm Model
 class RealmUser: Object {
     @objc dynamic var name = ""
     @objc dynamic var age = 0
 }

 📦 Full Code:
 swift
 Copy
 Edit
 import SwiftUI
 import RealmSwift

 struct RealmView: View {
     // MARK: - Realm instance
     let realm = try! Realm()

     // MARK: - Input state
     @State private var name = ""
     @State private var age = ""

     // MARK: - Load all users
     @State private var users: [RealmUser] = []

     var body: some View {
         VStack(spacing: 20) {
             // Input fields
             TextField("Enter name", text: $name)
                 .textFieldStyle(RoundedBorderTextFieldStyle())
             TextField("Enter age", text: $age)
                 .keyboardType(.numberPad)
                 .textFieldStyle(RoundedBorderTextFieldStyle())

             // Save Button
             Button("Save to Realm") {
                 let user = RealmUser()
                 user.name = name
                 user.age = Int(age) ?? 0

                 do {
                     try realm.write {
                         realm.add(user)
                     }
                     name = ""
                     age = ""
                     loadUsers()
                     print("✅ User saved to Realm.")
                 } catch {
                     print("❌ Realm save failed: \(error)")
                 }
             }

             // List users
             List {
                 ForEach(users, id: \.self) { user in
                     VStack(alignment: .leading) {
                         Text(user.name)
                         Text("Age: \(user.age)")
                             .font(.subheadline)
                             .foregroundColor(.gray)
                     }
                 }
                 .onDelete(perform: deleteUser)
             }
         }
         .padding()
         .onAppear {
             loadUsers()
         }
     }

     // MARK: - Load all users
     func loadUsers() {
         users = Array(realm.objects(RealmUser.self))
     }

     // MARK: - Delete function
     func deleteUser(at offsets: IndexSet) {
         do {
             try realm.write {
                 for index in offsets {
                     realm.delete(users[index])
                 }
             }
             loadUsers()
             print("🗑 User deleted from Realm.")
         } catch {
             print("❌ Realm delete failed: \(error)")
         }
     }
 }

 ✅ Realm – Interview Questions

 🔹 Basic

 What is Realm?

 A cross-platform mobile database alternative to Core Data. Realm uses its own engine and is faster, lightweight, and easier to use.

 How is Realm different from Core Data?

 | Feature         | Core Data          | Realm                 |
 |----------------|--------------------|------------------------|
 | Setup          | Complex             | Simple                 |
 | Syntax         | Verbose             | Swift-friendly         |
 | Performance    | Good                | Better for large data  |
 | Relationships  | Supported           | Supported              |
 | Thread Safety  | Manual              | Automatic (with care)  |

 What is a Realm Object?

 class User: Object {
     @objc dynamic var name = ""
     @objc dynamic var age = 0
 }

 How do you write data in Realm?

 let realm = try! Realm()
 let user = User()
 user.name = "Ali"
 try! realm.write {
     realm.add(user)
 }

 🔹 Advanced Realm

 Can Realm observe live changes?

 Yes. Realm provides auto-updating objects and notification tokens to observe data changes in real-time.

 How does Realm handle threading?

 You cannot pass Realm objects across threads. You must re-fetch the object in the new thread/queue.

 Is Realm secure?

 Yes, Realm supports encryption using 256-bit AES. You must provide a key during Realm configuration.

 How to query with filters in Realm?

 let results = realm.objects(User.self).filter("age > 25")

 Does Realm support migrations?

 Yes. Realm allows easy migration of data when models change using schema versioning.

 let config = Realm.Configuration(
     schemaVersion: 2,
     migrationBlock: { migration, oldSchemaVersion in
         // handle changes
     }
 )
 Realm.Configuration.defaultConfiguration = config

 🧠 Opinion-Based or Tricky

 Which one would you choose — Realm or Core Data?

 It depends:
 - Core Data for Apple-supported, highly relational data models.
 - Realm for faster prototyping, simpler syntax, or if cross-platform support is needed.

 Have you used Core Data/Realm in production? What was your use case?

 Be ready to explain your actual project usage: relationships, background save, filtering, etc.

*/


// MARK: - 6. Codable
/*

 Used for: Secure storage of sensitive data like tokens, passwords.

 Definition:
 An encrypted storage managed by iOS to securely store confidential data.

 Example (using KeychainWrapper):

 KeychainWrapper.standard.set("secretToken", forKey: "authToken")
 let token = KeychainWrapper.standard.string(forKey: "authToken")
*/
