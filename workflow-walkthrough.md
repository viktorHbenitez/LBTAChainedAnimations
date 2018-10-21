

# How to Chain Animations for Impressive Visual Effects

### Let's learn how to chain animations together in today's lesson to achieve some stunning visual effects.  Nothing too hard, but you need to make sure you don't overdo it with animations.  

![imagen](../master/assets/sketch1.gif) 

## 1. Add view's in viewController

[LBTA ] (https://www.letsbuildthatapp.com/course_video?id=2982)

### Steps

1. Create a  title label and body lable programmatically  
1.1 into stack view: title and body title
1.2 Add constraints 
```swift
    let stackView = UIStackView(arrangedSubviews: [titleLabel, bodyLabel])
    stackView.axis = .vertical
    stackView.spacing = 8
    view.addSubview(stackView)  // Add constraint after add to subview
    
    //enables autolayout
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true

```
## 2. Add animation 

2.1 When the user tapped in the viewController, run chain animation
```swift
 
 override func viewDidLoad() {
        super.viewDidLoad()
       ...
       
        // fun animations
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapAnimations)))
    }


    @objc fileprivate func handleTapAnimations() {
        print("Animating")
        // 1. Translate label title to left
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            self.titleLabel.transform = CGAffineTransform(translationX: -30, y: 0)
            
        }) { (_) in
            // 1.2 Translate label title to the top view
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.titleLabel.alpha = 0
                self.titleLabel.transform = self.titleLabel.transform.translatedBy(x: 0, y: -200)
            })
            
        }
        
        // 2 Translate label body to the left delay 0.5
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            self.bodyLabel.transform = CGAffineTransform(translationX: -30, y: 0)
            
        }) { (_) in
            // 3. Translate label body to the top of the view
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.bodyLabel.alpha = 0
                self.bodyLabel.transform = self.bodyLabel.transform.translatedBy(x: 0, y: -200)
            })
            
        }
    }

```
