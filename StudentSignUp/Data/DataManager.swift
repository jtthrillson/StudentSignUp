//
//  DataManager.swift
//  StudentSignUp
//
//  Created by John Wilson on 16/11/2017.
//  Copyright © 2017 Danger Barrel. All rights reserved.
//

import Foundation

class DataManager {
    let filename = "studentData.plist"
    var allStudents : [Student] = []

    func saveNewStudentData(newData:Student) {
        allStudents.append(newData)
        let fullPath = getDocumentsDirectory().appendingPathComponent(filename)
        let stripped = fullPath.absoluteString.replacingOccurrences(of: "file://", with: "")
        NSKeyedArchiver.archiveRootObject(allStudents, toFile: stripped)
    }

    func loadStudentData() {
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
