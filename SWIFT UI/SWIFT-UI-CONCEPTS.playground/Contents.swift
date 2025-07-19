import UIKit

// MARK: - Basic Concepts

/*
 
 // MARK: - ⁠*State Management*

 -@State
 
 Use Case: For simple, local state management within a single View.
 
 Features:
 1- State is private to the view and cannot be accessed or modified by other views.
 2- Automatically re-renders the view when the value changes.
 
 Example:

 struct CounterView: View {
     @State private var count = 0
     
     var body: some View {
         VStack {
             Text("Count: \(count)")
             Button("Increment") {
                 count += 1
             }
         }
     }
 }

 -@Binding
 
 Use Case: To pass state from a parent view to a child view.
 
 Features:
 1- Creates a two-way binding between a parent and a child.
 2- Child views can update the parent's state.
 
 Example:

 struct CounterControlView: View {
     @Binding var count: Int
     
     var body: some View {
         Button("Increment") {
             count += 1
         }
     }
 }

 struct ParentView: View {
     @State private var count = 0
     
     var body: some View {
         VStack {
             Text("Count: \(count)")
             CounterControlView(count: $count)
         }
     }
 }
 
 -@ObservedObject
 
 Use Case: For managing state in external, reusable, or shared data models.
 
 Features:
 1- Requires the data model to conform to the ObservableObject protocol.
 2- Automatically updates the view when @Published properties in the object change.
 
 Example:
 
 class CounterModel: ObservableObject {
     @Published var count = 0
 }

 struct CounterView: View {
     @ObservedObject var model: CounterModel
     
     var body: some View {
         VStack {
             Text("Count: \(model.count)")
             Button("Increment") {
                 model.count += 1
             }
         }
     }
 }
 
 -@EnvironmentObject
 
 Use Case: For sharing state across many views in a view hierarchy.
 
 Features:
 1- A shared instance is injected into the environment using .environmentObject().
 2- All child views can access the object without explicitly passing it down.
 
 Example:

 class AppSettings: ObservableObject {
     @Published var themeColor = "Blue"
 }

 struct ContentView: View {
     @EnvironmentObject var settings: AppSettings
     
     var body: some View {
         Text("Theme: \(settings.themeColor)")
     }
 }

 @main
 struct MyApp: App {
     var settings = AppSettings()
     
     var body: some Scene {
         WindowGroup {
             ContentView()
                 .environmentObject(settings)
         }
     }
 }

 -@Environment
 
 Use Case: To read system-provided or custom environment values.
 Features:
 Useful for accessing system settings like color schemes, accessibility settings, etc.
 Example:

 struct ContentView: View {
     @Environment(\.colorScheme) var colorScheme
     
     var body: some View {
         Text("Color Scheme: \(colorScheme == .dark ? "Dark" : "Light")")
     }
 }
 
 -@StateObject
 
 Use Case: For initializing and managing an ObservableObject within a view.
 
 Features:
 1- Used for creating objects that need to persist as the view rebuilds.
 2- Avoids unnecessary re-creation compared to ObservedObject.
 
 Example:

 class CounterModel: ObservableObject {
     @Published var count = 0
 }

 struct CounterView: View {
     @StateObject private var model = CounterModel()
     
     var body: some View {
         VStack {
             Text("Count: \(model.count)")
             Button("Increment") {
                 model.count += 1
             }
         }
     }
 }

 -@Redux-Style-State-Management
 
 Use Case: For complex state management in larger applications.
 
 Features:
 1- Centralized state management.
 2- Use libraries like Combine or third-party frameworks like RxSwift.
 
 Example:
 
 class AppState: ObservableObject {
     @Published var count = 0
 }

 enum Action {
     case increment
     case decrement
 }

 func reducer(state: inout Int, action: Action) {
     switch action {
     case .increment: state += 1
     case .decrement: state -= 1
     }
 }

 MARK: - Understanding @Published and ObservableObject in SwiftUI
 
 In SwiftUI, @Published and ObservableObject are used to manage and respond to changes in state across views. They enable a reactive programming approach where the UI automatically updates when the data changes.
 
 -@1. What is ObservableObject?
 
 Definition: A protocol that makes a class observable in SwiftUI. Classes conforming to ObservableObject can be observed by views.
 Purpose: Used to store and manage shared state across multiple views.
 How it Works: When a property marked with @Published changes, any views observing the object automatically refresh.
 
 Example:

 class CounterModel: ObservableObject {
     @Published var count = 0
 }

 Here, CounterModel is an ObservableObject with a count property. Whenever count changes, SwiftUI updates views that depend on it.
 
 -@2. What is @Published?
 
 Definition: A property wrapper that publishes changes to a property of an ObservableObject.
 Purpose: Marks a property for observation, triggering updates in any SwiftUI view that uses the ObservableObject.
 Behavior: Automatically sends updates to views observing the object when the property changes.
 
-@3. Using ObservableObject and @Published Together
 
 Basic Example:

 class CounterModel: ObservableObject {
     @Published var count = 0
 }

 struct CounterView: View {
     @StateObject var counter = CounterModel()

     var body: some View {
         VStack {
             Text("Count: \(counter.count)")
             Button("Increment") {
                 counter.count += 1
             }
         }
     }
 }
 
 Explanation:
 CounterModel is an ObservableObject with a @Published property, count.
 The view (CounterView) observes counter using @StateObject.
 When the "Increment" button is tapped, count changes, and the Text view updates automatically.

 
 MARK: - View Lifecycle and Composition in SwiftUI
 
 1. Building Composable Views
 
 Composable views are a fundamental concept in SwiftUI, emphasizing the ability to break down your UI into small, reusable components that can be combined to form complex interfaces.

 Key Features of Composable Views
  -Small and Reusable: Each view represents a piece of UI, often tied to a single purpose.
 Example: A Button or a Text view.
 
 -Hierarchical Composition: Combine small views into larger, complex views.

 Example:

 struct ProfileView: View {
     var body: some View {
         VStack {
             Image(systemName: "person.circle")
                 .resizable()
                 .frame(width: 100, height: 100)
             Text("John Doe")
                 .font(.title)
             Text("iOS Developer")
                 .font(.subheadline)
                 .foregroundColor(.gray)
         }
     }
 }
 
 In this example, ProfileView composes an Image and two Text views inside a VStack.
 
 -@2- Understanding the Declarative Nature of SwiftUI
 
 In a declarative framework, you focus on what the UI should look like and do, rather than how to implement it. This is different from the imperative nature of UIKit, where you explicitly update views and manage their state.

 Key Aspects of Declarative Nature
 - Describing the UI: SwiftUI views describe their appearance and behavior in a straightforward, declarative syntax.

 Example:

 Text("Hello, SwiftUI!")
     .font(.largeTitle)
     .foregroundColor(.blue)

 
 MARK: - *Layouts*
 
 1- @Stacks: HStack, VStack, ZStack
 
 -@HStack (Horizontal Stack)
 
 Arranges child views horizontally, from left to right.

 Automatically adjusts spacing and alignment.

 Example:
 
 HStack {
     Text("Hello")
     Image(systemName: "star")
     Text("World")
 }

 -@VStack (Vertical Stack)
 
 Arranges child views vertically, from top to bottom.

 Example:
 
 VStack {
     Text("Top")
     Divider()
     Text("Bottom")
 }

 -@ZStack
 
 Layers child views on top of each other along the z-axis (depth).

 Example:
 
 ZStack {
     Rectangle()
         .fill(Color.blue)
         .frame(width: 100, height: 100)
     Text("Overlay")
         .foregroundColor(.white)
 }

 2- Grids: LazyVGrid and LazyHGrid

 Grids provide a flexible way to arrange items in rows and columns, particularly for dynamic and scrollable content. They are "lazy," meaning they only create views as needed.
 
 -@LazyVGrid (Vertical Grid)
 
 Arranges items in a vertical scrolling grid, with rows stacked on top of each other.
 
 struct VerticalGridExample: View {
     let items = Array(1...10)
     
     let columns = [
         GridItem(.flexible()),
         GridItem(.flexible())
     ]
     
     var body: some View {
         ScrollView {
             LazyVGrid(columns: columns, spacing: 10) {
                 ForEach(items, id: \.self) { item in
                     Text("Item \(item)")
                         .padding()
                         .background(Color.blue)
                         .cornerRadius(8)
                 }
             }
         }
     }
 }

 
 -@LazyHGrid (Horizontal Grid)
 
 Arranges items in a horizontal scrolling grid, with columns placed side by side.

 Example:
 
 struct HorizontalGridExample: View {
     let items = Array(1...10)
     
     let rows = [
         GridItem(.flexible()),
         GridItem(.flexible())
     ]
     
     var body: some View {
         ScrollView(.horizontal) {
             LazyHGrid(rows: rows, spacing: 10) {
                 ForEach(items, id: \.self) { item in
                     Text("Item \(item)")
                         .padding()
                         .background(Color.green)
                         .cornerRadius(8)
                 }
             }
         }
     }
 }

 3- GeometryReader and Alignment Guides
 
 -@GeometryReader
 
 A container view that provides access to the size and position of its parent view, enabling dynamic layouts based on available space.

 Example:
 
 struct GeometryExample: View {
     var body: some View {
         GeometryReader { geometry in
             VStack {
                 Text("Width: \(geometry.size.width)")
                 Text("Height: \(geometry.size.height)")
             }
             .frame(width: geometry.size.width, height: geometry.size.height)
             .background(Color.orange)
         }
     }
 }

 Use case: Creating responsive layouts or centering views dynamically.
 
 -@Alignment Guides
 
 Alignment guides enable precise control over how child views are aligned within a parent.

 Example: Custom Alignment Guide
 
 struct AlignmentGuideExample: View {
     var body: some View {
         HStack(alignment: .custom) {
             Text("Short")
                 .alignmentGuide(.custom) { d in d[.bottom] }
             Text("Much longer text")
         }
     }
 }

 extension VerticalAlignment {
     private enum CustomAlignment: AlignmentID {
         static func defaultValue(in context: ViewDimensions) -> CGFloat {
             return context[.bottom]
         }
     }
     static let custom = VerticalAlignment(CustomAlignment.self)
 }

 
 Conclusion
 
 SwiftUI layouts offer incredible flexibility:

 Stacks: Simple yet powerful for most common layouts.
 Grids: Ideal for structured, repeating content.
 GeometryReader & Alignment Guides: Advanced tools for dynamic and precise layouts.
 By combining these tools, you can create complex and responsive UI designs effortlessly!
 
 
 // MARK: - Navigation in SwiftUI
 
 SwiftUI provides powerful tools for managing navigation between views in your app. These tools include NavigationStack, NavigationDestination, and NavigationLink. They allow for seamless transitions, data passing, and maintainable navigation hierarchies.
 
MARK: - 1. Navigation Components
 
 -@NavigationStack
 
 Definition: A container view that manages the navigation hierarchy. It replaces the older NavigationView in modern SwiftUI apps.

 Purpose: Acts as the starting point for navigation and tracks the stack of views.

 Example:
 
 struct MainView: View {
     var body: some View {
         NavigationStack {
             VStack {
                 Text("Home Screen")
                 NavigationLink("Go to Detail", value: "DetailView")
             }
             .navigationTitle("Main")
         }
     }
 }

 -@NavigationDestination
 
 Definition: Defines how a NavigationLink value maps to a new view in the navigation stack.

 Purpose: Separates the view to be displayed from the NavigationLink, supporting a declarative approach.

 Example:
 
 struct ContentView: View {
     var body: some View {
         NavigationStack {
             VStack {
                 NavigationLink("Go to Profile", value: "Profile")
                 NavigationLink("Go to Settings", value: "Settings")
             }
             .navigationDestination(for: String.self) { destination in
                 if destination == "Profile" {
                     ProfileView()
                 } else if destination == "Settings" {
                     SettingsView()
                 }
             }
         }
     }
 }

 struct ProfileView: View {
     var body: some View {
         Text("Welcome to the Profile Page")
     }
 }

 struct SettingsView: View {
     var body: some View {
         Text("Welcome to the Settings Page")
     }
 }

 -@NavigationLink
 
 Definition: A view that creates a tappable item to navigate to a new view.

 Use Cases:

 -Navigate to a specific view.
 -Trigger navigation programmatically with bindings.
 
 Example (Basic Navigation):
 
 NavigationLink("Details", destination: DetailView())

 struct ProgrammaticNavigation: View {
     @State private var isActive = false
     
     var body: some View {
         NavigationStack {
             VStack {
                 Button("Go to Detail") {
                     isActive = true
                 }
                 NavigationLink("", destination: DetailView(), isActive: $isActive)
             }
         }
     }
 }

 MARK: - Passing Data Between Views
 
 Passing data during navigation is straightforward in SwiftUI. You can achieve this in two main ways:
 
 -@Direct Passing with NavigationLink
 
 Pass data directly by initializing the destination view with parameters.

 Example:
 
 struct MainView: View {
     var body: some View {
         NavigationStack {
             NavigationLink(destination: DetailView(data: "Hello, SwiftUI!")) {
                 Text("Go to Detail")
             }
         }
     }
 }

 struct DetailView: View {
     let data: String
     
     var body: some View {
         Text(data)
     }
 }

 -@Using State or ObservableObject
 
 class UserData: ObservableObject {
     @Published var username: String = "John Doe"
 }

 struct ContentView: View {
     @StateObject var userData = UserData()
     
     var body: some View {
         NavigationStack {
             NavigationLink(destination: DetailView().environmentObject(userData)) {
                 Text("Go to Detail")
             }
         }
     }
 }

 struct DetailView: View {
     @EnvironmentObject var userData: UserData
     
     var body: some View {
         Text("Username: \(userData.username)")
     }
 }

 -@Managing Navigation State
 
 Navigation state is often managed using @State, @Binding, or programmatic links to ensure smooth transitions and control.
 
 Example (Custom Navigation State):
 
 struct NavigationStateExample: View {
     @State private var selectedDestination: String?
     
     var body: some View {
         NavigationStack {
             VStack {
                 Button("Go to First View") {
                     selectedDestination = "First"
                 }
                 Button("Go to Second View") {
                     selectedDestination = "Second"
                 }
             }
             .navigationDestination(for: String.self) { destination in
                 if destination == "First" {
                     FirstView()
                 } else if destination == "Second" {
                     SecondView()
                 }
             }
         }
     }
 }

 struct FirstView: View {
     var body: some View {
         Text("This is the first view")
     }
 }

 struct SecondView: View {
     var body: some View {
         Text("This is the second view")
     }
 }

 Key Benefits of SwiftUI Navigation:
 
 1- Declarative Design: Navigation flows are defined clearly and logically.
 2- Dynamic Navigation: Easily manage navigation based on app state.
 3- Seamless Data Passing: Bindings and environment objects simplify data sharing.
 
 MARK: - Modifiers in SwiftUI
 
 Modifiers in SwiftUI are methods applied to views to customize their appearance or behavior. They are chainable and declarative, making it easy to build polished user interfaces.
 
 MARK: - 1. Common View Modifiers
 
 -@padding()
 
 Adds spacing around a view's content.

 Default Behavior: Applies uniform padding around the view.

 Customization: You can specify edges or amounts.

 Examples:
 
 Text("Hello, SwiftUI!")
     .padding() // Default padding

 Text("Hello, SwiftUI!")
     .padding(.horizontal, 20) // Padding only on horizontal sides

 -@background()
 
 Sets a background for a view.

 Can use colors, shapes, or even other views as backgrounds.

 Examples:
 
 Text("Hello, SwiftUI!")
     .padding()
     .background(Color.yellow) // Simple background

 Text("Hello, SwiftUI!")
     .padding()
     .background(
         RoundedRectangle(cornerRadius: 10)
             .fill(Color.blue)
     ) // Custom background shape

 
 -@clipShape()
 
 Clips the view to a specified shape.

 Useful for rounding corners, creating circular views, or applying custom shapes.

 Examples:
 
 Image(systemName: "star.fill")
     .resizable()
     .frame(width: 100, height: 100)
     .clipShape(Circle()) // Circular clipping

 
 Text("Hello, SwiftUI!")
     .padding()
     .background(Color.green)
     .clipShape(RoundedRectangle(cornerRadius: 10)) // Rounded rectangle clipping

 -@frame()
 
 Sets the size of a view, either fixed or flexible.

 Can define width, height, and alignment.

 Examples:
 
 Text("Fixed Size")
     .frame(width: 150, height: 50) // Fixed width and height
     .background(Color.gray)

 
 Text("Flexible Height")
     .frame(maxWidth: .infinity, minHeight: 50) // Flexible width, minimum height
     .background(Color.orange)

 MARK: - 2. Conditional Modifiers
 
 In SwiftUI, you can apply modifiers conditionally using if or ternary operators to dynamically adjust the UI.
 
 -@Using-if
 
 Approach: Apply a modifier conditionally with an inline if block.

 Example:
 
 struct ConditionalModifierExample: View {
     @State private var isHighlighted = false

     var body: some View {
         Text("Hello, SwiftUI!")
             .padding()
             .background(isHighlighted ? Color.red : Color.blue)
             .onTapGesture {
                 isHighlighted.toggle()
             }
     }
 }

 -@Using View Extension for Reusability
 
 Extract conditional logic into reusable modifiers for cleaner code.

 Example:
 
 extension View {
     func highlighted(if condition: Bool) -> some View {
         self.background(condition ? Color.red : Color.blue)
     }
 }

 struct ContentView: View {
     @State private var isHighlighted = false

     var body: some View {
         Text("Hello, SwiftUI!")
             .padding()
             .highlighted(if: isHighlighted)
             .onTapGesture {
                 isHighlighted.toggle()
             }
     }
 }

 -@Complex Conditions
 
 Combine multiple modifiers using Group for complex conditions.

 Example:
 
 struct ComplexConditionExample: View {
     @State private var isLarge = false

     var body: some View {
         Text("Hello, SwiftUI!")
             .padding()
             .background(Color.yellow)
             .if(isLarge) {
                 $0.font(.largeTitle)
                     .foregroundColor(.green)
             }
             .onTapGesture {
                 isLarge.toggle()
             }
     }
 }

 extension View {
     func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
         condition ? AnyView(transform(self)) : AnyView(self)
     }
 }

 Conclusion
 SwiftUI modifiers are the foundation for customizing views. They are:

 Flexible: Can be chained and combined for complex customizations.
 Dynamic: Support conditional logic for adaptive UI behavior.
 By mastering common modifiers and conditional logic, you can build visually appealing and interactive SwiftUI interfaces effortlessly.
 
 MARK: - Lists in SwiftUI
 
 -@1. Static Lists
 
 A static list is used when the content is predefined and does not change dynamically. You can add rows with hardcoded views or data.

 Example:
 
 struct StaticListExample: View {
     var body: some View {
         List {
             Text("Item 1")
             Text("Item 2")
             HStack {
                 Image(systemName: "star")
                 Text("Item with Icon")
             }
         }
     }
 }

 - Output: A list with three static rows.
 - Customization: Add headers, footers, or sections to organize content.
 
 -@2. Dynamic Lists
 
 Dynamic lists are used when the data is variable or comes from an external source, such as an array or a database. Use ForEach inside the List to iterate over the data.

 Example (Simple Dynamic List):


 struct DynamicListExample: View {
     let items = ["Apple", "Banana", "Cherry"]

     var body: some View {
         List(items, id: \.self) { item in
             Text(item)
         }
     }
 }

 Output: A list displaying the elements of the items array.
 
 -@3. Using ForEach with Identifiable Data
 
 SwiftUI requires each item in a dynamic list to have a unique identifier. If your data model conforms to the Identifiable protocol, SwiftUI will automatically use the id property as the identifier. Otherwise, you can provide a custom id key.
 
 struct Fruit: Identifiable {
     let id = UUID()
     let name: String
 }

 struct IdentifiableListExample: View {
     let fruits = [
         Fruit(name: "Apple"),
         Fruit(name: "Banana"),
         Fruit(name: "Cherry")
     ]

     var body: some View {
         List(fruits) { fruit in
             Text(fruit.name)
         }
     }
 }

 -@3.2. Using a Custom Identifier
 
 If the data doesn't conform to Identifiable, you can specify the id explicitly.
 
 struct CustomIDListExample: View {
     let fruits = [
         (id: 1, name: "Apple"),
         (id: 2, name: "Banana"),
         (id: 3, name: "Cherry")
     ]

     var body: some View {
         List(fruits, id: \.id) { fruit in
             Text(fruit.name)
         }
     }
 }

 -@4. Interactive Rows in a List
 
 You can add interactive elements like buttons or navigation links in a list row.

 Example:
 
 struct InteractiveListExample: View {
     @State private var favorites: Set<String> = []

     let items = ["Apple", "Banana", "Cherry"]

     var body: some View {
         List(items, id: \.self) { item in
             HStack {
                 Text(item)
                 Spacer()
                 Button(action: {
                     if favorites.contains(item) {
                         favorites.remove(item)
                     } else {
                         favorites.insert(item)
                     }
                 }) {
                     Image(systemName: favorites.contains(item) ? "star.fill" : "star")
                         .foregroundColor(.yellow)
                 }
             }
         }
     }
 }

 -@5. Sections in a List
 
 You can group list rows into sections for better organization.

 Example:
 
 struct SectionedListExample: View {
     var body: some View {
         List {
             Section(header: Text("Fruits")) {
                 Text("Apple")
                 Text("Banana")
             }
             Section(header: Text("Vegetables")) {
                 Text("Carrot")
                 Text("Broccoli")
             }
         }
     }
 }

 -@6. Custom Row Layouts
 
 Each row can have a unique layout, such as images, buttons, or complex views.

 Example:
 
 
 struct CustomRowExample: View {
     struct Item: Identifiable {
         let id = UUID()
         let name: String
         let icon: String
     }

     let items = [
         Item(name: "Apple", icon: "applelogo"),
         Item(name: "Banana", icon: "leaf"),
         Item(name: "Cherry", icon: "circle.fill")
     ]

     var body: some View {
         List(items) { item in
             HStack {
                 Image(systemName: item.icon)
                 Text(item.name)
             }
         }
     }
 }

 Conclusion
 Static Lists: Use for fixed, unchanging content.
 Dynamic Lists: Use ForEach for displaying arrays or collections of data.
 Custom Rows: Combine SwiftUI views for tailored row designs.
 Interactive Features: Add buttons, toggles, or navigation for a rich user experience.
 Lists in SwiftUI provide a versatile and declarative approach to building content-rich, scrollable views. By understanding the basics and advanced techniques like sections and custom layouts, you can create polished and dynamic lists tailored to your app's needs.
 
 */

