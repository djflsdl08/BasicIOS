//
//  ViewController.swift
//  Quiz
//
//  Created by 김예진 on 2017. 10. 26..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //@IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint : NSLayoutConstraint!
    
    @IBOutlet weak var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint : NSLayoutConstraint!
    
    @IBOutlet weak var answerLabel: UILabel!

    let questions: [String] = ["What is 7+7", "What is the capital of Korea?", "From what is cognac made?"]
    let answers: [String] = ["14","Seoul","Grapes"]
    var currentQuestionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestionLabel.text = questions[currentQuestionIndex]
        updateOffScreenLabel()
    }
    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nextQuestionLabel.alpha = 0
        // alpha - 0 : totally transparent 
        //         1 : totally opaque
    }
    
    @IBAction func showNextQuestion(_ sender: UIButton) {
        currentQuestionIndex += 1
        
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        
        let question: String = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        
        animateLabelTransitions()
    }
    
    
    @IBAction func showAnswer(_ sender: UIButton) {
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    func animateLabelTransitions() {
        view.layoutIfNeeded()
        
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        UIView.animate (
            withDuration: 0.5,
            delay : 0,  // How long the system waits before the animation starts
                //usingSpringWithDamping: 0.5,
                //initialSpringVelocity: 0.5,  -> Spring Animation
            options : [.curveLinear],
            animations: {
                self.currentQuestionLabel.alpha = 0
                self.nextQuestionLabel.alpha = 1
                
                self.view.layoutIfNeeded()
            },
            completion : { _ in
                swap(&self.currentQuestionLabel,&self.nextQuestionLabel)
                swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
            }
        )
    }
}
