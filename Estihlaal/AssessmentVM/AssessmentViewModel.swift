////
////  AssessmentViewModel.swift
////  Estihlaal
////
////  Created by Maryam Amer Bin Siddique on 09/09/1446 AH.
////
//
//import SwiftUI
//
//class AssessmentViewModel: ObservableObject {
//    @Published var selectedField: String? = nil
//    @Published var selectedMajor: String? = nil
//    @Published var selectedInterests: [String] = []
//    @Published var selectedSkills: [String] = []
//    
//        let majorsByField: [String: [String]] = [
//            "Technology": ["Computer Science", "Software Engineering", "Cyber Security", "Data Science", "AI & Robotics"],
//            "Design": ["Product Design", "UX/UI Design", "Animation", "Project Management", "Graphic Design"],
//            "Business": ["Marketing", "Finance", "Human Resources"]
//        ]
//    
//        let interestsByField: [String: [String]] = [
//            "Technology": ["App Development", "Web Development", "Machine Learning", "Data Science", "Cloud Computing", "Blockchain"],
//            "Design": ["UI/UX Design", "Branding", "Motion Graphics", "Illustration", "3D Design"],
//            "Business": ["Digital Marketing", "Business Strategy", "Entrepreneurship", "Consulting", "Sales"]
//        ]
//    
//        let skillsByField: [String: [String]] = [
//            "Technology": ["Programming Languages", "Machine Learning", "Data Analysis", "Cloud Computing", "Cybersecurity","Android Development", "iOS Development", "Blockchain", "AI/Deep Learning", "SQL & Database Management", "React & Web Development"],
//            "Design": ["UI/UX Design", "Wireframing", "Brand Identity", "Graphic Design", "3D Animation", "Motion Graphics"],
//            "Business": ["Project Management", "Financial Analysis", "E-commerce & Market Research", "SEO & Digital Marketing", "Social Media Marketing & Advertising", "Google Analytics & Data-Driven Marketing", "Supply Chain Management"]
//        ]
//
//    }
import SwiftUI

class AssessmentViewModel: ObservableObject {
    @Published var selectedField: String? = nil
    @Published var selectedMajor: String? = nil
    @Published var selectedInterests: [String] = []
    @Published var selectedSkills: [String] = []

    let majorsByField: [String: [String]] = [
        "Technology": [
            "Computer Science", "Software Engineering", "Cyber Security", "Data Science",
            "AI & Robotics", "Game Development", "Information Technology", "Cloud Computing",
            "Network Engineering", "Embedded Systems", "Internet of Things (IoT)",
            "Software Architecture", "Web Development", "Mobile Application Development"
        ],
        "Design": [
            "UX/UI Design", "Graphic Design", "Animation & Motion Graphics", "Product Design",
            "Digital Media Design", "3D Modeling & Game Art", "Visual Communication",
            "Interaction Design", "Multimedia Design", "HCI (Human-Computer Interaction)"
        ],
        "Business": [
            "Marketing", "Finance", "Human Resources", "Business Administration",
            "Entrepreneurship", "International Business", "Accounting", "Economics",
            "Supply Chain Management", "Management Information Systems (MIS)", "E-commerce",
            "Business Analytics", "Consulting & Strategy"
        ]
    ]

    let interestsByField: [String: [String]] = [
        "Technology": [
            "App Development", "Web Development", "Machine Learning", "Data Science",
            "Cloud Computing", "Blockchain", "Cybersecurity", "Game Development",
            "Internet of Things (IoT)", "AR/VR Development", "Quantum Computing",
            "Software Engineering Practices", "Big Data & AI Integration"
        ],
        "Design": [
            "UX Research", "Wireframing & Prototyping", "Motion Graphics", "3D Design",
            "User Interface Animation", "Brand Identity & Logo Design",
            "Typography & Visual Aesthetics", "Augmented Reality (AR) UX",
            "User-Centered Design Principles", "Interactive UI/UX Development"
        ],
        "Business": [
            "Digital Marketing", "Business Strategy", "Entrepreneurship", "Consulting",
            "Sales & Negotiation", "Investment & Trading", "Brand Management",
            "Customer Experience Management", "Operations & Logistics",
            "Corporate Social Responsibility (CSR)", "Growth Hacking & Market Expansion"
        ]
    ]

    let skillsByField: [String: [String]] = [
        "Technology": [
            "Programming Languages (Python, Java, C++)", "Machine Learning", "Data Analysis",
            "Cloud Computing (AWS, Azure, Google Cloud)", "Cybersecurity Fundamentals",
            "Full-Stack Web Development", "iOS & Android Development", "Blockchain Engineering",
            "AI/Deep Learning", "SQL & Database Management", "React & Front-End Development",
            "Software Testing & QA", "DevOps & CI/CD", "Embedded Systems Development"
        ],
        "Design": [
            "UI/UX Design", "Wireframing & Prototyping", "Brand Identity", "Graphic Design",
            "Motion Graphics & Animation", "Adobe Creative Suite (Photoshop, Illustrator, After Effects)",
            "Design Thinking & Problem-Solving", "3D Design for Digital Products",
            "HCI (Human-Computer Interaction)", "Figma, Sketch & Adobe XD Mastery"
        ],
        "Business": [
            "Project Management (PMP, Agile, Scrum)", "Financial Analysis",
            "E-commerce & Market Research", "SEO & Digital Marketing",
            "Social Media Marketing & Advertising", "Google Analytics & Data-Driven Marketing",
            "Supply Chain & Logistics Optimization", "Strategic Planning & Leadership",
            "Risk Management", "Product Management & Go-to-Market Strategy"
        ]
    ]
}
