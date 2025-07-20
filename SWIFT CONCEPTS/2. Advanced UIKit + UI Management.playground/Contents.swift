import UIKit

// MARK: - 1. Diffable Data Sources
/*
 
 Explanation:
     A modern way to manage UITableView or UICollectionView data.
     Automatically handles updates (insert, delete, move) with animations.
     Uses a snapshot to represent the current state of data, making updates efficient.
     
 */

// MARK: - 2. Compositional Layout
/*
 
 Explanation:
     A modern way to create flexible, complex layouts for UICollectionView.
     Defines sections with customizable layouts (e.g., grids, lists) using composable components.
     Replaces older flow layouts for more control.
     
 */

// MARK: - 3. Dynamic Cell Heights
/*
 
 Explanation:
     Allows UITableView or UICollectionView cells to resize automatically based on content.
     Uses AutoLayout in cells and UITableView.automaticDimension for table views.
     Great for varying text lengths or images.
     
 */

// MARK: - 4. Advanced AutoLayout (Constraints Priority, Hugging/Compression)
/*
 
 Explanation:
    
 In complex layouts, sometimes views fight for space. Auto Layout uses three tools to decide what to do:

     Constraint Priority:
     Tells iOS how important a constraint is. Default is 1000 (required). Lower priority constraints can be broken if needed.
     🔸 Example: You want a button to stay centered, but it can move if space is tight.

     Content Hugging Priority:
     Tells iOS: “Don’t make me wider or taller than my content.”
     🔸 Used when you don’t want views to unnecessarily expand.

     Content Compression Resistance Priority:
     Tells iOS: “Don’t shrink me so much that my content gets cut.”
     🔸 Useful to protect important text or buttons from getting squeezed.

 These settings help you control how views behave when the screen size is small or dynamic content is loaded.
     
 */


// MARK: - 5. Custom Transitions & Animations in iOS
/*
 
 Explanation:
    
 ✅ Custom Transitions & Animations (Short & Easy)
     1. UIView.animate – Simple animations jaise fade, move, resize.

     UIView.animate(withDuration: 0.3) {
         view.alpha = 0
     }
 
 2. Core Animation (CABasicAnimation) – Low-level powerful animations (e.g. layer move, rotate).
 
     let animation = CABasicAnimation(keyPath: "position")
     animation.toValue = CGPoint(x: 200, y: 300)
     animation.duration = 0.5
     animation.fillMode = .forwards
     animation.isRemovedOnCompletion = false // Stop resetting to original position

     myView.layer.add(animation, forKey: "move")

 
 3. Custom VC Transitions –
 Custom screen present/dismiss animation.
 Use UIViewControllerAnimatedTransitioning protocol.

 4. Interactive Transitions –
 User gestures ke sath screen ko dismiss ya move karna.
 Use UIPercentDrivenInteractiveTransition.

 5. UIViewPropertyAnimator –
    Advanced control — pause, reverse, track progress.

 let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
     view.alpha = 0
 }
 animator.startAnimation()
 
 🔁 Summary:
 UIView.animate → Simple UI animation
 Core Animation → Precise layer control
 Custom Transition → VC animations
 Interactive → Gesture-based transitions
 Property Animator → Pause/resume/reverse control
     
 */

