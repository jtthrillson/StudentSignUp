//
//  DataManager.swift
//  StudentSignUp
//
//  Created by John Wilson on 16/11/2017.
//  Copyright © 2017 Danger Barrel. All rights reserved.
//

import Foundation

@objc protocol DataManagerDelegate {
    @objc optional func uploadProgress(progress:Float)
}

class DataManager {
    let saveFile = "studentData.plist"
    var allStudents : [Student] = []

    weak var delegate: DataManagerDelegate?
    
    var uploadPercent : Float = 0.0
    var timer : Timer?

    func isReadyToUpload() -> Bool {
        // TODO : Add connectivity check
        return allStudents.count > 0
    }

    func uploadStudent() -> Student {
        // TODO : Add upload to API
        uploadPercent = 0.2
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector:#selector(DataManager.setProgress), userInfo: nil, repeats: true)
        
        return allStudents[0]
    }
    
    @objc func setProgress() {
        uploadPercent += 0.01
        if uploadPercent >= 1.0 {
            timer!.invalidate()
            allStudents.removeFirst()
            saveStudentData()
        }
        delegate?.uploadProgress!(progress: uploadPercent)
    }
        
    // Mark: Local File Data Functions
    func saveNewStudentData(newData:Student) {
        allStudents.append(newData)
        saveStudentData()
    }
    
    func saveStudentData(toFile:String?=nil) {
        var filename = saveFile
        if toFile != nil && toFile!.count < 0 {
            filename = toFile!
        }
        let fullPath = getDocumentsDirectory().appendingPathComponent(filename)
        let stripped = fullPath.absoluteString.replacingOccurrences(of: "file://", with: "")
        NSKeyedArchiver.archiveRootObject(allStudents, toFile: stripped)
    }

    func loadStudentData(fromFile:String?=nil) {
        var filename = saveFile
        if fromFile != nil && fromFile!.count < 0 {
            filename = fromFile!
        }
        let fullPath = getDocumentsDirectory().appendingPathComponent(filename)
        let stripped = fullPath.absoluteString.replacingOccurrences(of: "file://", with: "")
        let students = NSKeyedUnarchiver.unarchiveObject(withFile: stripped) as! [Student]?
        if students != nil && (students?.count)! > allStudents.count {
            allStudents = students!
        }
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
