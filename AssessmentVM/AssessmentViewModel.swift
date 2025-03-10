//
//  AssessmentViewModel.swift
//  Estihlaal
//
//  Created by Maryam Amer Bin Siddique on 09/09/1446 AH.
//

import SwiftUI

class AssessmentViewModel: ObservableObject {
    @Published var selectedField: String? = nil
    @Published var selectedMajor: String? = nil
    @Published var selectedInterests: [String] = []
    @Published var selectedSkills: [String] = []
    
    let majorsByField: [String: [String]] = [
        "Technology": ["Computer Science", "Software Engineering", "Cyber Security", "Data Science", "AI & Robotics"],
        "Design": ["Product Design", "UX/UI Design", "Animation", "Project Management", "Graphic Design"],
        "Business": ["Marketing", "Finance", "Human Resources"]
    ]
    
    let interestsByField: [String: [String]] = [
        "Technology": ["App Development", "Web Development", "Machine Learning", "Data Science", "Cloud Computing", "Blockchain"],
        "Design": ["UI/UX Design", "Branding", "Motion Graphics", "Illustration", "3D Design"],
        "Business": ["Digital Marketing", "Business Strategy", "Entrepreneurship", "Consulting", "Sales"]
    ]
    
    let skillsByField: [String: [String]] = [
        "Technology": ["Programming Languages", "Machine Learning", "Data Analysis", "Cloud Computing", "Cybersecurity","Android Development", "iOS Development", "Blockchain", "AI/Deep Learning", "SQL & Database Management", "React & Web Development"],
        "Design": ["UI/UX Design", "Wireframing", "Brand Identity", "Graphic Design", "3D Animation", "Motion Graphics"],
        "Business": ["Project Management", "Financial Analysis", "E-commerce & Market Research", "SEO & Digital Marketing", "Social Media Marketing & Advertising", "Google Analytics & Data-Driven Marketing", "Supply Chain Management"]
    ]
}
