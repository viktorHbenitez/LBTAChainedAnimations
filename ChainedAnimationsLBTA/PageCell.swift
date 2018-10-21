//
//  ViewController.swift
//  LessonPlanner
//
//  Created by Brian Voong on 3/27/18.
//  Copyright © 2018 Brian Voong. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var parentController: PageController?
    
    var page: Page! {
        didSet {
            titleLabel.text = page.title
            bodyLabel.text = page.body
        }
    }

    let stackView = UIStackView()
    let titleLabel = UILabel()
    let bodyLabel = UILabel()
    let blackView = UIView()
    
    fileprivate func setupUI() {
        blackView.backgroundColor = .black
        titleLabel.text = "Quick Lists"
        titleLabel.font = UIFont(name: "Futura", size: 44)
        titleLabel.numberOfLines = -1
        bodyLabel.text = "How to create a custom list under one minute"
        bodyLabel.font = UIFont(name: "HelveticaNeue", size: 22)
        bodyLabel.numberOfLines = -1
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)
        stackView.axis = .vertical
        stackView.spacing = 0
        
        addSubview(blackView)
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor, constant: -100).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTitleTap)))
        titleLabel.isUserInteractionEnabled = true
        bodyLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBodyTap)))
        bodyLabel.isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc func handleBodyTap() {
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .black
        bodyLabel.backgroundColor = .black
        bodyLabel.textColor = .white
    }
    
    @objc func handleTitleTap(gesture: UITapGestureRecognizer) {
        titleLabel.backgroundColor = .black
        titleLabel.textColor = .white
        bodyLabel.backgroundColor = .clear
        bodyLabel.textColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func handleTap(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        if location.x < frame.width / 2 {
            reset()
        } else {
            animatePageOut()
        }
    }
    
    fileprivate func animatePageOut() {
        animateLabelOut()
    }

    override func prepareForReuse() {
        reset()
    }
    
    fileprivate func animateLabelOut(up: Bool = true, completion: (() -> ())? = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.titleLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.titleLabel.alpha = 0
                self.titleLabel.transform = CGAffineTransform(translationX: -30, y: -150 * (up ? 1 : -1))
            }, completion: { (_) in
                
            })
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.75, options: .curveEaseOut, animations: {
            self.bodyLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        }) { (_) in
            self.perform(#selector(self.advance), with: nil, afterDelay: 0.3)
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.bodyLabel.alpha = 0
                self.bodyLabel.transform = CGAffineTransform(translationX: -30, y: -350 * (up ? 1 : -1))
            }, completion: { (_) in
                
            })
        }
    }
    
    @objc func advance() {
        self.parentController?.scrollToNext()
    }
    
    fileprivate func reset() {
        titleLabel.transform = .identity
        titleLabel.alpha = 1
        bodyLabel.transform = .identity
        bodyLabel.alpha = 1
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .black
        bodyLabel.backgroundColor = .clear
        bodyLabel.textColor = .black
    }
    
    
    
    
    
    
    
    
    
    
    
    

}

