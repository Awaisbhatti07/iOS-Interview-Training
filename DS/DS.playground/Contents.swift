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

// MARK: - 9. Trees
/*
 
 A Tree is a hierarchical data structure made of nodes, where each node can have children.

 Types:
     Binary Tree → Each node has at most 2 children
     BST (Binary Search Tree) → Left < Root < Right
     Heap → Min-Heap or Max-Heap (used in priority queues)
     Trie → Special tree for searching words (prefix trees)

*/

// MARK: - 9A. Binary Tree

/*
 
 A binary tree is a structure where every node has up to 2 children, but there's no rule about their values.

       10
      /  \
    20   30
    /      \
   40       50

 
*/

// Step 1: Define the TreeNode structure
class TreeNode {
    var value: Int              // Node ka value
    var left: TreeNode?         // Left child
    var right: TreeNode?        // Right child

    init(_ value: Int) {
        self.value = value
    }
}

// Step 2: Create tree nodes manually (no order rules)
let root = TreeNode(10)            // Root node
root.left = TreeNode(20)           // Left child of root
root.right = TreeNode(30)          // Right child of root
root.left?.left = TreeNode(40)     // Left child of 20
root.right?.right = TreeNode(50)   // Right child of 30

// Step 3: Traverse the tree (In-Order) => left → root → right
func inOrderTraversal(_ node: TreeNode?) {
    if node == nil { return } // Stop when node is nil

    inOrderTraversal(node?.left)      // Visit left subtree
    print(node!.value)                // Print root
    inOrderTraversal(node?.right)     // Visit right subtree
}

// Step 4: Call the traversal function
print("📌 In-Order Traversal of Binary Tree:")
inOrderTraversal(root)
// Output: 40 20 10 30 50

// MARK: - 9A. Binary Tree

/*
 
 A Binary Search Tree (BST) is a special kind of binary tree where:

 📌 Every node follows this rule:
     Left child has smaller value, and
     Right child has larger value than the current node.
 
 25
    /  \
  15    50
 / \    / \
10  22  35  70
 
 
 or
 
 
 20
/  \
10    30
/  \     \
5   15     40


 Here’s how the BST rule is working:
     10 is on the left of 20 → ✅ smaller than 20
     30 is on the right of 20 → ✅ greater than 20
     5 and 15 are on left of 10 → ✅ less than 10
     40 is on the right of 30 → ✅ greater than 30
 
*/

// Step 1: Use same TreeNode class from above

// Step 2: Insert value into BST following BST rules
func insertBST(_ root: TreeNode?, _ value: Int) -> TreeNode {
    if root == nil {
        // If tree is empty or we reached a leaf → create new node
        return TreeNode(value)
    }

    if value < root!.value {
        // Value is less → go left
        root!.left = insertBST(root!.left, value)
    } else {
        // Value is greater → go right
        root!.right = insertBST(root!.right, value)
    }

    return root!
}

// Step 3: Create BST by inserting values one-by-one
var bstRoot: TreeNode? = nil
let bstValues = [25, 15, 50, 10, 22, 35, 70]

for value in bstValues {
    bstRoot = insertBST(bstRoot, value)
}

// Step 4: Traverse BST (In-Order → sorted output)
print("📌 In-Order Traversal of BST:")
inOrderTraversal(bstRoot)
// Output: 10 15 22 25 35 50 70
