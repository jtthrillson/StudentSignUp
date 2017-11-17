//
//  ViewController.swift
//  StudentSignUp
//
//  Created by John Wilson on 10/11/2017.
//  Copyright © 2017 Danger Barrel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DataManagerDelegate {

    let dataManager = DataManager()
    weak var progressIndicator : UIProgressView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.loadStudentData()
        setupViews()
    }

    func setupViews() {

        self.view.backgroundColor = unidaysYellow

        let unidaysView = UIImageView(image: UIImage(imageLiteralResourceName: "UNiDAYS"))
        unidaysView.contentMode = .scaleAspectFit;
        unidaysView.tintColor = UIColor.red
        unidaysView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(unidaysView)

        let uploadButton = UIButton(type: UIButtonType.system) as UIButton
        
        uploadButton.backgroundColor = UIColor.clear
        uploadButton.setImage(UIImage(imageLiteralResourceName: "upload"), for: .normal)
        uploadButton.tintColor = UIColor.black
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        uploadButton.addTarget(self, action: #selector(uploadAction), for: .touchUpInside)
        self.view.addSubview(uploadButton)
        
        let newStudentButton = UIButton(type: UIButtonType.system) as UIButton
        newStudentButton.backgroundColor = UIColor.clear
        newStudentButton.setImage(UIImage(imageLiteralResourceName: "new_user"), for: .normal)
        newStudentButton.tintColor = UIColor.black
        newStudentButton.translatesAutoresizingMaskIntoConstraints = false
        newStudentButton.addTarget(self, action: #selector(addNewStudent), for: .touchUpInside)
        self.view.addSubview(newStudentButton)

        var spacers: [UIView] = []
        for _ in 0...4 {
            let spacerView = UIView()
            spacerView.translatesAutoresizingMaskIntoConstraints = false
            spacers.append(spacerView)
            self.view.addSubview(spacerView)
        }

        let importantViews = [unidaysView, newStudentButton, uploadButton]

        let allViews = ["unidaysView": unidaysView,
                     "newStudentButton": newStudentButton,
                     "uploadButton": uploadButton,
                     "spacerView0": spacers[0],
                     "spacerView1": spacers[1],
                     "spacerView2": spacers[2],
                     "spacerView3": spacers[3]]
        
        var allConstraints : [NSLayoutConstraint] = []

        for view in importantViews {
            let widthConstraint = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 250)
            allConstraints.append(widthConstraint)
            let heightConstraint = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: ((view === unidaysView) ? 100 : 200))
            allConstraints.append(heightConstraint)
            let xConstraint = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
            allConstraints.append(xConstraint)
        }

        let equalHeightConstraintA = NSLayoutConstraint(item: spacers[0], attribute: .height, relatedBy: .equal, toItem: spacers[3], attribute: .height, multiplier: 1.0, constant: 0)
        allConstraints.append(equalHeightConstraintA)
        let equalHeightConstraintB = NSLayoutConstraint(item: spacers[1], attribute: .height, relatedBy: .equal, toItem: spacers[0], attribute: .height, multiplier: 0.5, constant: 0)
        allConstraints.append(equalHeightConstraintB)
        let equalHeightConstraintC = NSLayoutConstraint(item: spacers[2], attribute: .height, relatedBy: .equal, toItem: spacers[0], attribute: .height, multiplier: 0.1, constant: 0)
        allConstraints.append(equalHeightConstraintC)

        let verticalSpacingConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[spacerView0]-[unidaysView]-[spacerView1]-[uploadButton]-[spacerView2]-[newStudentButton]-[spacerView3]-|", options: [], metrics: nil, views: allViews)
        allConstraints += verticalSpacingConstraints

        NSLayoutConstraint.activate(allConstraints)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func uploadAction() {
        if !self.dataManager.isReadyToUpload() {
            let alert = UIAlertController(title: "Nothing to upload", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        // get student data
        dataManager.delegate = self
        let student = dataManager.uploadStudent()

        // build alert view
        let alert = UIAlertController(title: "Uploading...", message: "\(student.firstName ?? "") \(student.lastName ?? "")", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: {
            // build progress bar and start upload
            let margin:CGFloat = 8.0
            let rect = CGRect(x:margin, y:72.0, width:alert.view.frame.width - margin * 2.0 , height: 2.0)
            let progressView = UIProgressView(frame: rect)
            self.progressIndicator = progressView
            progressView.progress = 0.5
            progressView.tintColor = UIColor.blue
            alert.view.addSubview(progressView)
        })
        
    }
    
    @objc func uploadProgress(progress:Float) {
//        print("Progress at \(progress)")
        self.progressIndicator?.setProgress(progress, animated: false)
        if progress >= 1.0 {
            self.dismiss(animated: true, completion: {
                if self.dataManager.isReadyToUpload() {
                    self.uploadAction()
                }
            })
        }
    }

    @objc func addNewStudent(sender: UIButton!) {
        let newStudentViewController:NewStudentViewController = NewStudentViewController()
        newStudentViewController.dataManager = dataManager
        
        self.present(newStudentViewController, animated: true, completion: nil)        
    }
}

