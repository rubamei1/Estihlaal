//
//  Untitled.swift
//  Estihlaal
//
//  Created by Reem on 11/09/1446 AH.
//
//import Foundation
//
//class GroqAPI {
//    private let apiKey = "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"
//    private let endpoint = "https://api.groq.com/openai/v1/chat/completions"
//
//    // ✅ Fetch Job Details
//    func fetchJobDetails(jobTitle: String, completion: @escaping (JobDetails?) -> Void) {
//        let prompt = """
//        Provide a detailed job description for the following position:
//        - Job Title: \(jobTitle)
//
//        Return a JSON object with the following keys:
//        {
//            "description": "Brief job overview",
//            "skills": ["Skill 1", "Skill 2", "Skill 3"],
//            "certificates": ["Certification 1", "Certification 2"],
//            "salary": "Expected salary range",
//            "tools": ["Tool 1", "Tool 2"]
//        }
//        """
//
//        let jsonData: [String: Any] = [
//            "model": "llama-3.3-70b-versatile",
//            "messages": [
//                ["role": "system", "content": "You are a career advisor providing detailed job descriptions."],
//                ["role": "user", "content": prompt]
//            ],
//            "max_tokens": 300
//        ]
//
//        guard let url = URL(string: endpoint),
//              let requestData = try? JSONSerialization.data(withJSONObject: jsonData) else {
//            completion(nil)
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = requestData
//
//        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
//            if let error = error {
//                print("❌ API Error:", error.localizedDescription)
//                completion(nil)
//                return
//            }
//
//            guard let data = data,
//                  let jsonResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                print("❌ No valid JSON received from API")
//                completion(nil)
//                return
//            }
//
//            print("📥 RAW API RESPONSE: \(jsonResponse)")
//
//            if let choices = jsonResponse["choices"] as? [[String: Any]],
//               let content = choices.first?["message"] as? [String: Any],
//               let text = content["content"] as? String {
//
//                // ✅ Extract and clean JSON
//                let cleanedJSON = self?.extractJSON(from: text) ?? ""
//                
//                if let jsonData = cleanedJSON.data(using: .utf8) {
//                    do {
//                        let jobDetails = try JSONDecoder().decode(JobDetails.self, from: jsonData)
//                        DispatchQueue.main.async {
//                            completion(jobDetails)
//                        }
//                    } catch {
//                        print("❌ JSON decoding error:", error.localizedDescription)
//                        print("❌ Extracted JSON: \(cleanedJSON)") // Debugging
//                        completion(nil)
//                    }
//                } else {
//                    print("❌ Failed to convert cleaned JSON to data.")
//                    completion(nil)
//                }
//            } else {
//                print("❌ Unexpected API response format")
//                completion(nil)
//            }
//        }.resume()
//    }
//
//    // ✅ Function to clean JSON output from API response
//    private func extractJSON(from text: String) -> String {
//        var jsonString = text.trimmingCharacters(in: .whitespacesAndNewlines)
//
//        // ✅ Remove Markdown-style backticks (`json` and ` `)
//        if jsonString.hasPrefix("```json") {
//            jsonString = jsonString.replacingOccurrences(of: "```json", with: "")
//        }
//        jsonString = jsonString.replacingOccurrences(of: "```", with: "")
//
//        // ✅ Remove escape sequences that break JSON parsing
//        jsonString = jsonString.replacingOccurrences(of: "\\n", with: " ")
//        jsonString = jsonString.replacingOccurrences(of: "\\t", with: " ")
//        jsonString = jsonString.replacingOccurrences(of: "\\\"", with: "\"")
//
//        // ✅ Trim extra spaces
//        jsonString = jsonString.trimmingCharacters(in: .whitespacesAndNewlines)
//
//        print("✅ CLEANED JSON: \(jsonString)") // Debugging log
//        return jsonString
//    }
//}


import Foundation

class GroqAPI {
    private let apiKey = "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"
    private let endpoint = "https://api.groq.com/openai/v1/chat/completions"

    // ✅ Function to fetch 4 job predictions based on user inputs
    func predictJobs(field: String, major: String, interests: [String], skills: [String], completion: @escaping ([String]) -> Void) {
        
        let prompt = """
        Given the following user details:
        - Academic Field: \(field)
        - Major: \(major)
        - Interests: \(interests.joined(separator: ", "))
        - Skills: \(skills.joined(separator: ", "))

        Suggest EXACTLY 4 job positions that fit the user.
        Return ONLY job titles, separated by commas (e.g., UX Designer, Data Scientist, Software Engineer, AI Researcher).
        DO NOT include explanations, numbers, or extra text.
        """

        let jsonData: [String: Any] = [
            "model": "llama-3.3-70b-versatile",
            "messages": [
                ["role": "system", "content": "You are a career advisor providing job recommendations."],
                ["role": "user", "content": prompt]
            ],
            "max_tokens": 100
        ]

        guard let url = URL(string: endpoint),
              let requestData = try? JSONSerialization.data(withJSONObject: jsonData) else {
            completion([])
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = requestData

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("❌ API Error:", error.localizedDescription)
                completion([])
                return
            }

            guard let data = data else {
                print("❌ No data received from API")
                completion([])
                return
            }

            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let choices = jsonResponse["choices"] as? [[String: Any]],
                   let content = choices.first?["message"] as? [String: Any],
                   let text = content["content"] as? String {

                    let jobs = text.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                    DispatchQueue.main.async {
                        completion(jobs)
                    }
                } else {
                    print("❌ Unexpected API response format")
                    completion([])
                }
            } catch {
                print("❌ JSON parsing error:", error.localizedDescription)
                completion([])
            }
        }.resume()
    }


    func fetchJobDetails(jobTitle: String, completion: @escaping (JobDetails?) -> Void) {
        let prompt = """
        Provide a detailed job description for the following position:
        - Job Title: \(jobTitle)

        Return a JSON object with the following keys:
        {
            "description": "Brief job overview",
            "skills": ["Skill 1", "Skill 2", "Skill 3"],
            "certificates": ["Certification 1", "Certification 2"],
            "salary": "Expected salary range",
            "tools": ["Tool 1", "Tool 2"]
        }
        """

        let jsonData: [String: Any] = [
            "model": "llama-3.3-70b-versatile",
            "messages": [
                ["role": "system", "content": "You are a career advisor providing detailed job descriptions."],
                ["role": "user", "content": prompt]
            ],
            "max_tokens": 300
        ]

        guard let url = URL(string: endpoint),
              let requestData = try? JSONSerialization.data(withJSONObject: jsonData) else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = requestData

        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            if let error = error {
                print("❌ API Error:", error.localizedDescription)
                completion(nil)
                return
            }

            guard let data = data,
                  let jsonResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                print("❌ No valid JSON received from API")
                completion(nil)
                return
            }

            print("📥 RAW API RESPONSE: \(jsonResponse)")

            if let choices = jsonResponse["choices"] as? [[String: Any]],
               let content = choices.first?["message"] as? [String: Any],
               let text = content["content"] as? String {

                // ✅ Extract and clean JSON
                let cleanedJSON = self?.extractJSON(from: text) ?? text
                
                if let jsonData = cleanedJSON.data(using: .utf8) {
                    do {
                        let jobDetails = try JSONDecoder().decode(JobDetails.self, from: jsonData)
                        DispatchQueue.main.async {
                            completion(jobDetails)
                        }
                    } catch {
                        print("❌ JSON decoding error:", error.localizedDescription)
                        print("❌ Extracted JSON: \(cleanedJSON)") // Debugging
                        completion(nil)
                    }
                } else {
                    print("❌ Failed to convert cleaned JSON to data.")
                    completion(nil)
                }
            } else {
                print("❌ Unexpected API response format")
                completion(nil)
            }
        }.resume()
    }





    // ✅ Function to clean JSON output from API response
   private func extractJSON(from text: String) -> String {
        var jsonString = text.trimmingCharacters(in: .whitespacesAndNewlines)

        // Remove Markdown-style backticks
        if jsonString.hasPrefix("```json") {
            jsonString = jsonString.replacingOccurrences(of: "```json", with: "")
        }
        jsonString = jsonString.replacingOccurrences(of: "```", with: "")

        // Remove unwanted escape sequences
        jsonString = jsonString.replacingOccurrences(of: "\\n", with: " ")
        jsonString = jsonString.replacingOccurrences(of: "\\t", with: " ")
        jsonString = jsonString.replacingOccurrences(of: "\\\"", with: "\"")

        // Trim extra spaces
        jsonString = jsonString.trimmingCharacters(in: .whitespacesAndNewlines)

        print("✅ CLEANED JSON: \(jsonString)") // Debugging log
        return jsonString
    }






}

// ✅ Job Details Model
