//
//  NewStudentViewController.swift
//  StudentSignUp
//
//  Created by John Wilson on 14/11/2017.
//  Copyright © 2017 Danger Barrel. All rights reserved.
//

import UIKit

class NewStudentViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    weak var dataManager : DataManager?
    let stackView = UIStackView()
    var showingGenderPicker = false
    var showingUniversityPicker = false
    var firstNameTextfield : UITextField?
    var lastNameTextfield : UITextField?
    var genderDropDown : UITextField?
    var emailTextfield : UITextField?
    var universityDropDown : UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }

    func setupViews() {

        let unidaysBlue = UIColor.init(red: 31.0/255.0, green: 188.0/255.0, blue: 210.0/255.0, alpha: 1.0)
        let unidaysGreen = UIColor.init(red: 47.0/255.0, green: 212.0/255.0, blue: 123.0/255.0, alpha: 1.0)
        // grey 363537
        // dark blue 086788
        self.view.backgroundColor = unidaysBlue
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15.0
        stackView.distribution = .equalSpacing
        view.addSubview(stackView)
        
        let newStudentLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200.00, height: 30.00));
        newStudentLabel.text = "New Student"
        newStudentLabel.textColor = UIColor.black
        newStudentLabel.font = UIFont(name: "Arial", size: 30)
        newStudentLabel.textAlignment = .center
        newStudentLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(newStudentLabel)

        firstNameTextfield = self.textFieldFactory(name: "First Name")
        stackView.addArrangedSubview(firstNameTextfield!)
        
        lastNameTextfield = self.textFieldFactory(name: "Last Name")
        stackView.addArrangedSubview(lastNameTextfield!)
        
        genderDropDown = self.textFieldFactory(name: "Gender")
        stackView.addArrangedSubview(genderDropDown!)

        emailTextfield = self.textFieldFactory(name: "Email Address")
        stackView.addArrangedSubview(emailTextfield!)
        
        universityDropDown = self.textFieldFactory(name: "University")
        stackView.addArrangedSubview(universityDropDown!)
        
        let addStudentButton = UIButton(type: UIButtonType.system) as UIButton
        addStudentButton.backgroundColor = unidaysGreen
        addStudentButton.setTitle("Add Student", for: .normal)
        addStudentButton.tintColor = UIColor.white
        addStudentButton.addTarget(self, action: #selector(addStudentAction), for: .touchUpInside)
        addStudentButton.layer.masksToBounds = true
        addStudentButton.layer.cornerRadius = 2
        addStudentButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(addStudentButton)
        
        let cancelButton = UIButton(type: UIButtonType.system) as UIButton
        cancelButton.backgroundColor = UIColor.red
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.tintColor = UIColor.black
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        cancelButton.layer.masksToBounds = true
        cancelButton.layer.cornerRadius = 2
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(cancelButton)

        stackView.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            stackView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 8.0).isActive = true
        } else {
            stackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8.0).isActive = true
            
        }
    }
    
    // MARK: Button Actions

    @objc func addStudentAction(sender: UIButton!) {
        var errorMsg : String = ""
        if (firstNameTextfield?.text?.count)! < 1 {
            errorMsg = "First Name Required"
        } else if (lastNameTextfield?.text?.count)! < 1 {
            errorMsg = "Last Name Required"
        } else if (genderDropDown?.text?.count)! < 1 {
            errorMsg = "Gender Required"
        } else if (emailTextfield?.text?.count)! < 1 {
            errorMsg = "Email Required"
        } else if (universityDropDown?.text?.count)! < 1 {
            errorMsg = "University Required"
        }
        
        if errorMsg.count < 1 {
            saveData()
            
            dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: errorMsg, message: "Please fill in all fields", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @objc func cancelAction(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }
    
    func showPicker() {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alert.isModalInPopover = true
        
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        picker.delegate = self
        picker.dataSource = self
        
        alert.view.addSubview(picker)
        
        picker.widthAnchor.constraint(greaterThanOrEqualToConstant: 200.0).isActive = true
        picker.heightAnchor.constraint(greaterThanOrEqualToConstant: 200.0).isActive = true
        picker.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor).isActive = true
        picker.centerYAnchor.constraint(equalTo: alert.view.centerYAnchor).isActive = true
        alert.view.widthAnchor.constraint(greaterThanOrEqualTo: picker.widthAnchor).isActive = true
        alert.view.heightAnchor.constraint(greaterThanOrEqualTo: picker.heightAnchor).isActive = true

        present(alert, animated: true, completion:nil)
    }
    
    // MARK: Utility Functions

    func textFieldFactory(name:String) -> UITextField {
        let textfield: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200.00, height: 30.00));
        textfield.placeholder = name
        textfield.delegate = self
        textfield.borderStyle = UITextBorderStyle.line
        textfield.layer.borderColor = UIColor.white.cgColor
        textfield.layer.borderWidth = 1.0
        textfield.backgroundColor = UIColor.white
        textfield.layer.masksToBounds = true
        textfield.layer.cornerRadius = 2
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }
    
    func saveData() {
        let newStudentData = Student(firstName: firstNameTextfield?.text, lastName: lastNameTextfield?.text, gender: genderDropDown?.text, email: emailTextfield?.text, university: universityDropDown?.text)
        
        dataManager?.saveNewStudentData(newData: newStudentData)
    }
    
    // MARK: UIPickerViewDataSource Functions

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent: Int) -> Int {
        if showingGenderPicker {
            return Constants.genders.count
        }
        if showingUniversityPicker {
            return Constants.universityList.count
        }
        return 0
    }
    
    // MARK: UIPickerViewDelegate Functions
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if showingGenderPicker {
            return Constants.genders[row]
        }
        if showingUniversityPicker {
            return Constants.universityList[row]
        }
        return ""
    }
    
    func pickerView(_: UIPickerView, didSelectRow: Int, inComponent: Int) {
        if showingGenderPicker {
            self.genderDropDown?.text = Constants.genders[didSelectRow]
        }
        if showingUniversityPicker {
            self.universityDropDown?.text = Constants.universityList[didSelectRow]
        }
        self.dismiss(animated: true, completion: {
            if self.showingGenderPicker {
                self.showingGenderPicker = false
                self.emailTextfield?.becomeFirstResponder()
            }
            self.showingUniversityPicker = false
        })
    }
    
    // MARK: UITextFieldDelegate Functions
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        showingGenderPicker = false
        showingUniversityPicker = false
        if textField === genderDropDown {
            showingGenderPicker = true
            showPicker()
            return false
        }
        else if textField === universityDropDown {
            showingUniversityPicker = true
            showPicker()
            return false
        }

        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === firstNameTextfield {
            lastNameTextfield?.becomeFirstResponder()
        } else if textField === lastNameTextfield {
            genderDropDown?.becomeFirstResponder()
        } else if textField === genderDropDown {
            emailTextfield?.becomeFirstResponder()
        } else if textField === emailTextfield {
            universityDropDown?.becomeFirstResponder()
        } else if textField === universityDropDown {
            textField.resignFirstResponder()
        } else {
            textField.resignFirstResponder()
            addStudentAction(sender: nil)
        }
        return false
    }
}

//extension NewStudentViewController {
//
//    // This constraint ties an element at zero points from the bottom layout guide
//    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Note that SO highlighting makes the new selector syntax (#selector()) look
//        // like a comment but it isn't one
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
//    }
//
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//
//    @objc func keyboardNotification(notification: NSNotification) {
//        if let userInfo = notification.userInfo {
//            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
//            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
//            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
//            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
//            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
//            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
//                self.keyboardHeightLayoutConstraint?.constant = 0.0
//            } else {
//                self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
//            }
//            UIView.animate(withDuration: duration,
//                           delay: TimeInterval(0),
//                           options: animationCurve,
//                           animations: { self.view.layoutIfNeeded() },
//                           completion: nil)
//        }
//}

