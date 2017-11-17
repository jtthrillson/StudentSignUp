//
//  NewStudentModel.swift
//  StudentSignUp
//
//  Created by John Wilson on 14/11/2017.
//  Copyright © 2017 Danger Barrel. All rights reserved.
//

import Foundation

//struct Student {
//    var firstName : String?
//    var lastName : String?
//    var gender : String?
//    var email : String?
//    var university : String?
//}

class Student: NSObject, NSCoding {
    
    var firstName : String?
    var lastName : String?
    var gender : String?
    var email : String?
    var university : String?

    init(firstName: String?, lastName: String?, gender: String?, email: String?, university: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.email = email
        self.university = university
    }
    
    required init(coder aDecoder: NSCoder) {
        firstName = aDecoder.decodeObject(forKey: "firstName") as? String ?? ""
        lastName = aDecoder.decodeObject(forKey: "lastName") as? String ?? ""
        gender = aDecoder.decodeObject(forKey: "gender") as? String ?? ""
        email = aDecoder.decodeObject(forKey: "email") as? String ?? ""
        university = aDecoder.decodeObject(forKey: "university") as? String ?? ""
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(gender, forKey: "gender")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(university, forKey: "university")
    }
}

struct Constants {
    static let genders = ["Male",
                          "Female",
                          "Other",
                          "Prefer not to answer"]
    static let universityList = ["University of Aberdeen",
                                 "Abertay University",
                                 "Aberystwyth University",
                                 "Anglia Ruskin University",
                                 "Arden University",
                                 "Aston University",
                                 "Bangor University",
                                 "University of Bath",
                                 "Bath Spa University",
                                 "University of Bedfordshire",
                                 "University of Birmingham",
                                 "Birmingham City University",
                                 "University College Birmingham",
                                 "Bishop Grosseteste University",
                                 "University of Bolton",
                                 "The Arts University Bournemouth",
                                 "Bournemouth University",
                                 "BPP University",
                                 "University of Bradford",
                                 "University of Brighton",
                                 "University of Bristol",
                                 "Brunel University",
                                 "University of Buckingham",
                                 "Buckinghamshire New University",
                                 "University of Cambridge",
                                 "Canterbury Christ Church University",
                                 "Cardiff Metropolitan University",
                                 "Cardiff University",
                                 "University of Chester",
                                 "University of Chichester",
                                 "Coventry University",
                                 "Cranfield University",
                                 "University for the Creative Arts",
                                 "University of Cumbria",
                                 "De Montfort University",
                                 "University of Derby",
                                 "University of Dundee",
                                 "Durham University",
                                 "University of East Anglia",
                                 "University of East London",
                                 "Edge Hill University",
                                 "University of Edinburgh",
                                 "Edinburgh Napier University",
                                 "University of Essex",
                                 "University of Exeter",
                                 "Falmouth University",
                                 "University of Glasgow",
                                 "Glasgow Caledonian University",
                                 "University of Gloucestershire",
                                 "Glyndŵr University",
                                 "University of Greenwich",
                                 "Harper Adams University",
                                 "Heriot-Watt University",
                                 "University of Hertfordshire",
                                 "University of the Highlands & Islands",
                                 "University of Huddersfield",
                                 "University of Hull",
                                 "Imperial College London",
                                 "Keele University",
                                 "University of Kent",
                                 "Kingston University",
                                 "University of Central Lancashire",
                                 "Lancaster University",
                                 "University of Leeds",
                                 "Leeds Beckett University",
                                 "Leeds Trinity University",
                                 "University of Leicester",
                                 "University of Lincoln",
                                 "University of Liverpool",
                                 "Liverpool Hope University",
                                 "Liverpool John Moores University",
                                 "University of London",
                                 "Birkbeck, University of London",
                                 "City, University of London",
                                 "Royal Central School of Speech and Drama",
                                 "Courtauld Institute of Art",
                                 "Goldsmiths, University of London",
                                 "Heythrop College",
                                 "Institute of Cancer Research",
                                 "King's College London",
                                 "London Business School",
                                 "London School of Economics and Political Science",
                                 "London School of Hygiene and Tropical Medicine",
                                 "Queen Mary, University of London",
                                 "Royal Academy of Music",
                                 "Royal Holloway, University of London",
                                 "Royal Veterinary College",
                                 "St George's, University of London",
                                 "School of Oriental and African Studies",
                                 "University College London",
                                 "London Metropolitan University",
                                 "London South Bank University",
                                 "Loughborough University",
                                 "University of Manchester",
                                 "Manchester Metropolitan University",
                                 "Middlesex University",
                                 "Newcastle University",
                                 "Newman University",
                                 "University of Northampton",
                                 "Northumbria University",
                                 "Norwich University of the Arts",
                                 "University of Nottingham",
                                 "Nottingham Trent University",
                                 "The Open University",
                                 "University of Oxford",
                                 "Oxford Brookes University",
                                 "University of Plymouth",
                                 "University of Portsmouth",
                                 "Queen Margaret University",
                                 "Queen's University Belfast",
                                 "University of Reading",
                                 "Regent's University London",
                                 "The Robert Gordon University",
                                 "Roehampton University",
                                 "Royal Agricultural University",
                                 "University of Salford",
                                 "University of Sheffield",
                                 "Sheffield Hallam University",
                                 "University of South Wales",
                                 "University of Southampton",
                                 "Southampton Solent University",
                                 "University of St Andrews",
                                 "University of St Mark & St John",
                                 "St Mary's University",
                                 "Staffordshire University",
                                 "University of Stirling",
                                 "University of Strathclyde",
                                 "University of Suffolk",
                                 "University of Sunderland",
                                 "University of Surrey",
                                 "University of Sussex",
                                 "Swansea University",
                                 "Teesside University",
                                 "University of the Arts London",
                                 "Ulster University",
                                 "University of Law",
                                 "University of Wales",
                                 "University of Warwick",
                                 "University of the West of England",
                                 "University of the West of Scotland",
                                 "University of West London",
                                 "University of Westminster",
                                 "University of Winchester",
                                 "University of Wolverhampton",
                                 "University of Worcester",
                                 "University of York",
                                 "York St John University"]
}
