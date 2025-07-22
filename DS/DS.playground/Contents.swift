import UIKit

/*
 
 Stage 1: Core Foundations

 🔹 1. Arrays
 🔹 2. Strings
 🔹 3. Dictionaries (HashMaps)
 🔹 4. Sets
 
 */

// MARK: - 1. What is an Array?
/*
 
 An array is a list of items stored in order, and each item can be accessed using an index (number).
 
 var numbers: [Int] = [1, 2, 3, 4]
 var names: [String] = ["Ali", "Awais", "Sara"]

 Access: O(1) → fast
 Insert/Delete: O(n) → slower when you move elements
 
 */

// MARK: - 2. Strings
/*
 
 A string is a collection of characters, like a word or a sentence.
 
 let name: String = "Awais"
 let char: Character = "A"

 */

// MARK: - 3. Dictionaries (HashMaps)
/*
 
 A dictionary stores key-value pairs. You use the key to find the value fast.

 var studentMarks: [String: Int] = ["Ali": 90, "Sara": 85]
 let json = ["name": "Ali", "age": 25]

 */

// MARK: - 4. Sets
/*
 
 A set is like an array but:

 No duplicates
 No order
 
 var numbers: Set<Int> = [1, 2, 3, 3, 2]
 // This will store only [1, 2, 3]

 let searchedIDs: Set<Int> = [101, 102, 103]

 }
 
 */
 
 // MARK: - 5. Stacks
 /*
  
  Stack is a data structure where the last item you add is the first one you remove — just like a stack of plates.
  
  var stack: [Int] = []
  stack.append(10)   // Push
  stack.removeLast() // Pop

 */

struct Stack<T> {
    private var elements: [T] = []

    mutating func push(_ value: T) {
        elements.append(value)
    }

    mutating func pop() -> T? {
        return elements.popLast()
    }

    func peek() -> T? {
        return elements.last
    }
}

// MARK: - 6. Queues
/*
 
 Queue works like a real-life line: the first item you add is the first one that gets removed.
 
 var queue: [Int] = []
 queue.append(1)      // Enqueue
 queue.removeFirst()  // Dequeue


*/

// MARK: - 7. Linked Lists
/*
 
     A linked list is made of nodes, where each node stores:
     A value
     A reference (next) to the next node
 
 There are 3 types:

     Singly Linked List → points to next only
     Doubly Linked List → points to next and previous
     Circular → last node points back to head
 
 | Feature        | Singly           | Doubly                 | Circular                        |
 | -------------- | ---------------- | ---------------------- | ------------------------------- |
 | Direction      | Forward only     | Forward + Backward     | Forward only (loops back)       |
 | Node Structure | `next`           | `next`, `prev`         | `next` (last → head)            |
 | Traverse       | Easy             | Easy (both ways)       | Needs `repeat` or special check |
 | Delete Node    | Need previous    | Easier (due to `prev`) | Tricky (track last, head)       |
 | Memory         | Less (1 pointer) | More (2 pointers)      | Same as singly (but cyclic)     |

*/

class Node {
    var value: Int
    var next: Node?

    init(_ value: Int) {
        self.value = value
        self.next = nil
    }
}

// MARK: - 7A. Singly Linked List
/*
 
 A Singly Linked List is a list where each node only points to the next node.
 Imagine train coaches connected one-way — each coach only knows about the next one.
 [10] → [20] → [30] → nil

 🔸 Key Features:
     Each node has one pointer (to the next node).
     You can only move forward, not backward.
     Starts from head and goes until nil (null).

 📌 When to use:
     When you just need to go in one direction.
     Saves memory because there's only one pointer per node.
 
*/

func traverse(head: Node?) {
    var current = head
    while current != nil {
        print(current!.value)
        current = current!.next
    }
}

func deleteNode(head: Node?, target: Int) -> Node? {
    var current = head
    var prev: Node? = nil

    while current != nil {
        if current!.value == target {
            if prev == nil {
                return current!.next // Deleting head
            } else {
                prev!.next = current!.next
                return head
            }
        }
        prev = current
        current = current!.next
    }
    return head
}

let n1 = Node(10)
let n2 = Node(20)
let n3 = Node(30)
n1.next = n2
n2.next = n3

print("➡️ Singly List:")
traverse(head: n1)

print("❌ Deleting 20:")
let newHead = deleteNode(head: n1, target: 20)
traverse(head: newHead)


// MARK: - 7B. Doubly Linked List
/*
 
 A Doubly Linked List is a list where each node points to both the next and previous nodes.
 Think of a train where each coach knows about the one ahead and the one behind.
 nil ← [10] ⇄ [20] ⇄ [30] → nil

 🔸 Key Features:
     Each node has two pointers:
     One for the next node
     One for the previous node
     You can move forward and backward.
     More flexible than singly linked lists.

 📌 When to use:
     When you need bidirectional navigation.
     Useful in apps like photo galleries or undo/redo systems.

*/

class DoubleNode {
    var value: Int
    var next: DoubleNode?
    var prev: DoubleNode?

    init(_ value: Int) {
        self.value = value
    }
}


func forwardTraverse(head: DoubleNode?) {
    var current = head
    while current != nil {
        print(current!.value)
        current = current!.next
    }
}

func backwardTraverse(tail: DoubleNode?) {
    var current = tail
    while current != nil {
        print(current!.value)
        current = current!.prev
    }
}

func deleteNode(head: DoubleNode?, target: Int) -> DoubleNode? {
    var current = head

    while current != nil {
        if current!.value == target {
            if let prev = current!.prev {
                prev.next = current!.next
            } else {
                // Deleting head
                current!.next?.prev = nil
                return current!.next
            }

            if let next = current!.next {
                next.prev = current!.prev
            }
            break
        }
        current = current!.next
    }
    return head
}

let d1 = DoubleNode(100)
let d2 = DoubleNode(200)
let d3 = DoubleNode(300)
d1.next = d2; d2.prev = d1
d2.next = d3; d3.prev = d2

print("➡️ Doubly List:")
forwardTraverse(head: d1)

print("❌ Deleting 200:")
let newDHead = deleteNode(head: d1, target: 200)
forwardTraverse(head: newDHead)


// MARK: - 7C. Circular Linked List
/*
 
 A Circular Linked List is a list where the last node connects back to the head, forming a loop.
 There is no nil — it keeps going in a circle.

 [10] → [20] → [30]
   ↑              ↓
    ← ← ← ← ← ← ←

 🔸 Key Features:
     It can be singly or doubly, but the last node always connects back to the first node.
     There's no end — it's a circle.

 📌 When to use:
     When you want cyclic behavior, like looping through a playlist or carousel.
     Good for problems where you want to keep cycling through items.
 
*/

class CircularNode {
    var value: Int
    var next: CircularNode?

    init(_ value: Int) {
        self.value = value
    }
}



func traverseCircular(head: CircularNode?) {
    guard let head = head else { return }
    var current: CircularNode? = head
    repeat {
        print(current!.value)
        current = current!.next
    } while current !== head
}


func deleteCircularNode(head: CircularNode?, target: Int) -> CircularNode? {
    guard let head = head else { return nil }

    var current = head
    var prev: CircularNode? = nil

    repeat {
        if current.value == target {
            if current === head {
                // Find last node to update its next
                var last = head
                while last.next !== head {
                    last = last.next!
                }
                last.next = head.next
                return head.next
            } else {
                prev?.next = current.next
                return head
            }
        }
        prev = current
        current = current.next!
    } while current !== head

    return head
}

let c1 = CircularNode(5)
let c2 = CircularNode(10)
let c3 = CircularNode(15)
c1.next = c2; c2.next = c3; c3.next = c1 // Make it circular

print("➡️ Circular List:")
traverseCircular(head: c1)

print("❌ Deleting 10:")
let newCHead = deleteCircularNode(head: c1, target: 10)
traverseCircular(head: newCHead)

// MARK: - 8. Recursion
/*
 
 Recursion means a function calling itself.
     It is used to break big problems into smaller ones.
     Every recursive function must have a base case (to stop) and a recursive case (where it calls itself).

*/

func factorial(_ n: Int) -> Int {
    if n == 0 { return 1 }           // Base case
    return n * factorial(n - 1)      // Recursive case
}

print(factorial(5)) // Output: 120

// MARK: - Introduction to Trees
// A Tree is a hierarchical data structure consisting of nodes connected by edges.
// - Each node holds a value and can have children.
// - The topmost node is the **root**.
// - Nodes with no children are **leaves**.
// - Trees are used to represent hierarchical data, like file systems, organization charts, or decision trees.

// MARK: - Binary Tree
// Definition:
// A Binary Tree is a tree where each node has **at most two children**: a left child and a right child.
// There are no rules about the values of nodes—they can be arranged in any order.

// Why Use Binary Trees?
// - Represent hierarchical relationships (e.g., family trees, company hierarchies).
// - Useful in scenarios where data doesn't need to follow a specific order.
// - Basis for specialized trees like Binary Search Trees, Heaps, or Tries.

// Example Binary Tree:
//       10
//      /  \
//    20    30
//   /        \
//  40        50
// - Root: 10
// - Left child of 10: 20
// - Right child of 10: 30
// - Left child of 20: 40
// - Right child of 30: 50

// MARK: - Binary Search Tree (BST)
// Definition:
// A Binary Search Tree is a binary tree with a specific rule:
// - For any node, the **left child** has a value **smaller** than the node.
// - The **right child** has a value **larger** than the node.

// Why Use BST?
// - Efficient for searching, insertion, and deletion (average O(log n) time complexity).
// - In-order traversal produces values in sorted order.
// - Used in applications like databases, autocomplete systems, and priority queues.

// Example BST:
//       25
//      /  \
//    15    50
//   / \    / \
//  10  22 35  70
// - Root: 25
// - Left subtree (values < 25): 15, 10, 22
// - Right subtree (values > 25): 50, 35, 70
// - For node 15: left child 10 (< 15), right child 22 (> 15)
// - For node 50: left child 35 (< 50), right child 70 (> 50)

// MARK: - TreeNode Class
// Defines a node used for both Binary Trees and BSTs.
class TreeNode {
    var value: Int              // The data stored in the node (integer in this case)
    var left: TreeNode?        // Pointer to left child (optional, can be nil)
    var right: TreeNode?       // Pointer to right child (optional, can be nil)

    init(_ value: Int) {
        self.value = value
        self.left = nil        // Initialize with no children
        self.right = nil
    }
}

// MARK: - Binary Tree Implementation

// Why Manual Creation?
// - For a general binary tree, we manually create nodes to demonstrate structure without ordering rules.
// - Useful for testing or when specific tree shapes are needed.

// Create Binary Tree Manually
let root = TreeNode(10)            // Create root node with value 10
root.left = TreeNode(20)           // Left child of root (value 20)
root.right = TreeNode(30)          // Right child of root (value 30)
root.left?.left = TreeNode(40)     // Left child of 20 (value 40)
root.right?.right = TreeNode(50)   // Right child of 30 (value 50)

// Diagram of Created Binary Tree:
//       10
//      /  \
//    20    30
//   /        \
//  40        50

// MARK: - Traversals
// Traversals are ways to visit all nodes in a tree. Common types:
// 1. In-Order (Left -> Root -> Right): Useful for BSTs to get sorted order.
// 2. Pre-Order (Root -> Left -> Right): Useful for copying trees or getting prefix notation.
// 3. Post-Order (Left -> Right -> Root): Useful for deleting trees or evaluating expressions.

// In-Order Traversal
// Why Use In-Order?
// - Visits nodes in Left -> Root -> Right order.
// - For BSTs, produces values in ascending order.
// - For general binary trees, explores left subtree, then root, then right subtree.
func inOrderTraversal(_ node: TreeNode?) {
    if node == nil { return } // Base case: stop if node is nil

    inOrderTraversal(node?.left)      // Recursively visit left subtree
    print(node!.value, terminator: " ") // Process current node (print value)
    inOrderTraversal(node?.right)     // Recursively visit right subtree
}

// Pre-Order Traversal
// Why Use Pre-Order?
// - Visits Root first, useful for creating a copy of the tree or getting a prefix expression.
func preOrderTraversal(_ node: TreeNode?) {
    if node == nil { return } // Base case: stop if node is nil

    print(node!.value, terminator: " ") // Process current node (print value)
    preOrderTraversal(node?.left)       // Recursively visit left subtree
    preOrderTraversal(node?.right)      // Recursively visit right subtree
}

// Post-Order Traversal
// Why Use Post-Order?
// - Visits Left -> Right -> Root, useful for deleting trees or evaluating postfix expressions.
func postOrderTraversal(_ node: TreeNode?) {
    if node == nil { return } // Base case: stop if node is nil

    postOrderTraversal(node?.left)      // Recursively visit left subtree
    postOrderTraversal(node?.right)     // Recursively visit right subtree
    print(node!.value, terminator: " ") // Process current node (print value)
}

// MARK: - Binary Search Tree Implementation

// Insert into BST
// Why Use Insert Function?
// - Maintains BST property: left child < node < right child.
// - Recursively finds the correct position for a new value.
// - Handles empty trees and leaf nodes by creating new nodes.
func insertBST(_ root: TreeNode?, _ value: Int) -> TreeNode {
    if root == nil {
        // If tree is empty or at a leaf, create and return a new node
        return TreeNode(value)
    }

    if value < root!.value {
        // Value is less than current node, insert into left subtree
        root!.left = insertBST(root!.left, value)
    } else {
        // Value is >= current node, insert into right subtree
        // Note: This code places equal values in the right subtree
        root!.right = insertBST(root!.right, value)
    }

    return root! // Return current node to maintain tree structure
}

// Create BST by Inserting Values
var bstRoot: TreeNode? = nil
let bstValues = [25, 15, 50, 10, 22, 35, 70]

// Insert values one-by-one to build the BST
for value in bstValues {
    bstRoot = insertBST(bstRoot, value)
}

// Diagram of Created BST:
//       25
//      /  \
//    15    50
//   / \    / \
//  10  22 35  70

// MARK: - Running the Code

// Test Binary Tree Traversals
print("📌 Binary Tree Traversals:")
print("In-Order (Left -> Root -> Right):", terminator: " ")
inOrderTraversal(root) // Output: 40 20 10 30 50
print()

print("Pre-Order (Root -> Left -> Right):", terminator: " ")
preOrderTraversal(root) // Output: 10 20 40 30 50
print()

print("Post-Order (Left -> Right -> Root):", terminator: " ")
postOrderTraversal(root) // Output: 40 20 50 30 10
print()

// Test BST Traversals
print("\n📌 Binary Search Tree Traversals:")
print("In-Order (Sorted Order):", terminator: " ")
inOrderTraversal(bstRoot) // Output: 10 15 22 25 35 50 70
print()

print("Pre-Order:", terminator: " ")
preOrderTraversal(bstRoot) // Output: 25 15 10 22 50 35 70
print()

print("Post-Order:", terminator: " ")
postOrderTraversal(bstRoot) // Output: 10 22 15 35 70 50 25
print()

// MARK: - Additional Notes
// 1. In-Order Traversal in BST gives sorted output because of the BST property.
// 2. The insertBST function places equal values in the right subtree. To handle duplicates differently, you could:
//    - Add a check to skip duplicates.
//    - Store a count in each node for duplicates.
// 3. Binary Trees are flexible but less efficient for searching compared to BSTs.
// 4. BSTs are efficient for operations like search, insert, and delete (average O(log n) time complexity).
// 5. To extend this code, you could add:
//    - Search function for BST.
//    - Delete function for BST.
//    - Height or balance checks for trees.
