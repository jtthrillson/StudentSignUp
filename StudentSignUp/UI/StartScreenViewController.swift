//
//  ViewController.swift
//  StudentSignUp
//
//  Created by John Wilson on 10/11/2017.
//  Copyright © 2017 Danger Barrel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundYellow = UIColor.init(red: 225.0/255.0, green: 250.0/255.0, blue: 90.0/255.0, alpha: 1.0)

        self.view.backgroundColor = backgroundYellow

        let spacerViewA = UIView()
        spacerViewA.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(spacerViewA)

        let unidaysView = UIImageView(image: UIImage(imageLiteralResourceName: "UNiDAYS"))
        unidaysView.contentMode = .scaleAspectFit;
        unidaysView.tintColor = UIColor.red
        unidaysView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(unidaysView)

        let spacerViewB = UIView()
        spacerViewB.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(spacerViewB)

        let uploadButton = UIButton(type: UIButtonType.system) as UIButton
        
        uploadButton.backgroundColor = UIColor.clear
        uploadButton.setImage(UIImage(imageLiteralResourceName: "upload"), for: .normal)
//        uploadButton.setTitle("Upload", for: UIControlState.normal)
        uploadButton.tintColor = UIColor.black
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
//        uploadButton.addTarget(self, action: #selector(self.uploadAction(_:)), for: .touchUpInside)
        self.view.addSubview(uploadButton)
        
        let spacerViewC = UIView()
        spacerViewC.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(spacerViewC)

        let newStudentButton = UIButton(type: UIButtonType.system) as UIButton
        newStudentButton.backgroundColor = UIColor.clear
//        newStudentButton.setTitle("New Student", for: UIControlState.normal)
        newStudentButton.setImage(UIImage(imageLiteralResourceName: "new_user"), for: .normal)
        newStudentButton.tintColor = UIColor.black
        newStudentButton.translatesAutoresizingMaskIntoConstraints = false
//        newStudentButton.addTarget(self, action: #selector(self.newStudentAction(_:)), for: .touchUpInside)
        self.view.addSubview(newStudentButton)
        
        let spacerViewD = UIView()
        spacerViewD.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(spacerViewD)

        // Set up autolayout constraints
        // **********************************************************
        // Hard define height and width for the image and buttons
        // Center everything horizontally
        // Equal spacing vertically
        // Autosizing invisible spacer views between each important view

        let importantViews = [unidaysView, newStudentButton, uploadButton]
        let spacerViews = [spacerViewA, spacerViewB, spacerViewC, spacerViewD]

        let allViews = ["unidaysView": unidaysView,
                     "newStudentButton": newStudentButton,
                     "uploadButton": uploadButton,
                     "spacerViewA": spacerViewA,
                     "spacerViewB": spacerViewB,
                     "spacerViewC": spacerViewC,
                     "spacerViewD": spacerViewD]
        
        var allConstraints : [NSLayoutConstraint] = []

        for view in importantViews {
            let widthConstraint = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 250)
            let heightConstraint = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: ((view === unidaysView) ? 100 : 200))
            let xConstraint = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
            allConstraints.insert(widthConstraint, at: 0)
            allConstraints.insert(heightConstraint, at: 0)
            allConstraints.insert(xConstraint, at: 0)
        }

        let equalHeightConstraintA = NSLayoutConstraint(item: spacerViewA, attribute: .height, relatedBy: .equal, toItem: spacerViewD, attribute: .height, multiplier: 1.0, constant: 0)
        allConstraints.insert(equalHeightConstraintA, at: 0)
        let equalHeightConstraintB = NSLayoutConstraint(item: spacerViewB, attribute: .height, relatedBy: .equal, toItem: spacerViewA, attribute: .height, multiplier: 0.5, constant: 0)
        allConstraints.insert(equalHeightConstraintB, at: 0)
        let equalHeightConstraintC = NSLayoutConstraint(item: spacerViewC, attribute: .height, relatedBy: .equal, toItem: spacerViewA, attribute: .height, multiplier: 0.1, constant: 0)
        allConstraints.insert(equalHeightConstraintC, at: 0)

        let verticalSpacingConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[spacerViewA]-[unidaysView]-[spacerViewB]-[uploadButton]-[spacerViewC]-[newStudentButton]-[spacerViewD]-|", options: [], metrics: nil, views: allViews)
        allConstraints += verticalSpacingConstraints

        NSLayoutConstraint.activate(allConstraints)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func uploadAction(sender:UIButton!) {
        print("Button tapped")
    }
}

