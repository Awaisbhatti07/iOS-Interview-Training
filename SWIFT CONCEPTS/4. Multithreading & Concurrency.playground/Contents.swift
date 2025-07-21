import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//MARK: - Concurrency

/*
1- The fact of two or more events or circumstances hapenning or existing at the same time.
2- It is th execution of the multiple instructons sequences at the same time.
*/

/* Problems with Concurrency
 
 1- Dirty Read Problem
 2- Unrepeatable Read Problem
 3- Lost Update Problem
 4- Phantom Read Problen
 
 Having Data Inconsistency
 
 */

// Prallelism/Parallel: Use of multiple processing elements simultaneously for solving any problem


/* Concurrency in iOS */

/*
 1- Achieving Multithreading by creating threads manually
 2- Grand Central Dispatch
 3- Operation Queues
 4- Modern Concurreny in Swift
 */


// MARK: - Achieving Multithreading by creating threads manually
//class CustomThread {
//
//    // return sum of two number
//    func createThread() {
//        let thread: Thread = Thread(target: self, selector: #selector(threadSelection), object: nil)
//        thread.start()
//    }
//
//    @objc func threadSelection() {
//        print("Custom Thread in Action")
//    }
//}
//
//var customThread = CustomThread()
//customThread.createThread()

/* Manuall Thread Problems

 1- Responsibility to manage the thread with system conditions.
 2- Deallocation once they have finish execution.
 3- Improper management may cause memory leakage in app.
 4- Maintaining the order of execution.
 
*/

// MARK: - GRAND CENTERAL DISPATCH
/*
 
 // MARK: - WHAT IS GRAND CENTERAL DISPATCH
 
 1- GCD is a queue based API that allows to execute closures / Events on workers pools in the FIFO order.

 2- Decides which thread is used to execute a task is handled by GCD not the developer and execute them on an appropriate Dispatch Queue.

 3- Dispatch Queue is the abstraction layer on the top of the queue

 4- GCD Manages a collection of the Dispatch Queues. They are usually referred as queues. The work submitted to these Dispatch queues is executed on a pool thread.

 5- A Dispatch Queue executes tasks either serially or concurrently but always in a fifo order
 
 6- An application can submit a task to queue in the form of blocks either synchronously or asynchronously.
 
 //MARK: - Synchronous vs Asynchronous
 
 Synchronous: Block the execution till this task is completed or Tasks are executed one after another in a sequential manner. Each task must complete before the next one starts.
 
 Asynchronous: Continue the execution of current task while new task will execute asynchronously. or Tasks are executed independently, allowing other tasks to continue without waiting for the current one to finish.
 
 //MARK: - Serial Queue vs Concurrent Queue
 
 Serial: One Task at time
 Concurrent: Mutiple Task at a time
 
 Even for concurrent, tasks will be dequeued serially, in a fixed order i.e FIFO statring each of the task after the previous one
 
 Serial/Concurrent affects the destination queue to which you are dispatching.
 
 Sync/Async  affects the current thread from which you are dispatching.
 
 */

//var counter = 1
//DispatchQueue.main.async { // Main queue is a serial Queue
//    for i in 0...3 {
//        counter = i
//        print("\(counter)")
//    }
//}
//
//for i in 4...6 {
//    counter = i
//    print("\(counter)")
//}
//
//DispatchQueue.main.async {
//    counter = 9
//    print("\(counter)")
//}

// MARK: - DISPATCH QUEUES
/*
 
// MARK: - MAIN QUEUE
 
 1- its a system Created Queue
 2- it is serial in nature
 3- Uses Main Thread
 4- UI Kit is tied to main thread, so all UI related operations must be performed on Main Queue
 
 // MARK: - GLOBAL CONCURRENT QUEUE
 
 1- its a system Created Queue
 2- it is Concurent in Nature
 3- Do not use main thread
 4- Priorities are decided through QOS (Quality of services)
 
*/

DispatchQueue.main.async {
    print(Thread.isMainThread ? "Execution on main Thread" : "Execution on someother thread")
}

DispatchQueue.global(qos: .userInitiated).async {
    print(Thread.isMainThread ? "Execution on main Thread" : "Execution on global concurrent queue")
}

/*
 
 // MARK: - QUALITY OF SERVICES
 
 1- User interactive -> For Animations
 2- User Initiated -> Used when we requires Immediate Results any kind of data that is required to render UI.
 3- Utility -> Long Running Tasks (Eg Downloading)
 4- Background -> Not Visible to Users (Eg creating backups, restoring something)
 
 */

DispatchQueue.global(qos: .background).async {
    for i in 11...21{
        print(i)
    }
}

DispatchQueue.global(qos: .userInteractive).async {
    for i in 0...10 {
        print(i)
    }
}

// MARK: - DISPATCH GROUP & DISPATCH WORK ITEMS

/*
 
 // MARK: - DISPATCH GROUP
 
 1- Multiple tasks can be Grouped Together
 2- We can wait for the tasks to be finished or can continue with some other tasks and can get notified when tasks in the group completes.
 
 Functions that its provided
 
 1- enter
 2- leave()
 3- wait()
 4- notify()
 
 Example reference in Folder
 
 // MARK: - DISPATCH WORK ITEM
 
 1- Encapsulates a block of code.
 2- Can be dispatched on both Dispatch Queue and Dispatch Group.
 3- Provides the flexibility to cancel the task (unless execution has started).
 
 
 CANCEL:
 
 1- if it is set true before execution, task wont execute.
 2- if work item is cancelled during execution, 'cancel' will return true but execution won't abort.
 3- wait() and notify work the same.
 
 example usage if user want to make an api call on every character when searching
 
 Example reference in Folder
 
 */

// MARK: - OPERATION QUEUE

/*
 
 // MARK: - DEFINATION :-
 
 An Operation Queue (or OperationQueue in Swift) is a high-level abstraction in iOS and macOS development for managing the execution of operations in a concurrent manner. It is part of the Foundation framework and works alongside the Operation class to provide a robust mechanism for handling multithreaded tasks.

 // MARK: - Key Features of OperationQueue:
 
 1- Concurrency Management:

 - It allows multiple operations to execute concurrently.
 - The degree of concurrency can be controlled via the maxConcurrentOperationCount property.
 
 2- Operation Dependencies:

 - Operations can have dependencies, meaning one operation won't start until its dependencies have completed.
 - This is particularly useful for tasks that must be executed in a specific order.
 
 3- Automatic Thread Management:

 - The queue manages threads for executing operations, so you don't need to handle threads directly.
 - Operations are executed on background threads by default.
 
 4- Cancelation and Suspension:

 - You can cancel individual operations or the entire queue.
 - The queue can also be suspended and resumed.
 
 5- Queue Prioritization:

 - Operations can have different priority levels using the queuePriority property of Operation.
 
 6- Integration with GCD:

 - Internally, OperationQueue uses Grand Central Dispatch (GCD) but provides a higher-level API with additional features like dependencies.
 
 
 // MARK: - OPERATIONAL QUEUE STATES
 
 open var isReady: Bool { get }
 open var isExecuting: Bool { get }
 open var isCancelled: Bool { get }
 open var isFinished: Bool { get }
 
 */

// Define an operation
class MyOperation: Operation {
    override func main() {
        if isCancelled { return } // Handle cancellation
        print("Operation started on thread: \(Thread.current)")
        sleep(2) // Simulate work
        print("Operation completed on thread: \(Thread.current)")
    }
}

// Create an OperationQueue
let operationQueue = OperationQueue()

// Add operations to the queue
operationQueue.addOperation(MyOperation())
operationQueue.addOperation {
    // Using a block operation
    print("Block operation started on thread: \(Thread.current)")
    sleep(1)
    print("Block operation completed on thread: \(Thread.current)")
}

// Set max concurrent operations (optional)
operationQueue.maxConcurrentOperationCount = 2

/*
 
 MARK: - Common Properties and Methods of OperationQueue:
 
 1- Properties:
 
 maxConcurrentOperationCount: Controls the number of concurrent operations.
 isSuspended: Pauses the queue when set to true.
 operations: Returns the operations currently in the queue.
 operationCount: Returns the number of operations in the queue.
 
 2- Methods:
 addOperation(_:): Adds an operation to the queue.
 addOperations(_:waitUntilFinished:): Adds multiple operations and optionally waits for their completion.
 cancelAllOperations(): Cancels all operations in the queue.
 
 MARK: - When to Use OperationQueue:
 When you need fine-grained control over task dependencies.
 For tasks that require concurrent execution but might involve cancellation, prioritization, or suspension.
 When you want a simpler API compared to directly managing threads with GCD.
 
 */
