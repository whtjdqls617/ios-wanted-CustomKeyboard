//
//  ReviewListViewModel.swift
//  CustomKeyboard
//
//  Created by 조성빈 on 2022/07/19.
//

import Combine
import UIKit

class ReviewListViewModel: ObservableObject {
    
    @Published var reviewList : ReviewList? // 서버가 문제다
    let reviewDataManager = ReviewDataManager()
    
    init() {
        print(#function)
    }
}

extension ReviewListViewModel {
    func getDataFromServer() {
        reviewDataManager.getData("https://api.plkey.app/theme/review?themeId=PLKEY0-L-81&start=0&count=20") { result in
            self.reviewList = result
        }
    }
    
    func postDataToServer(_ content : String) {
        reviewDataManager.postData("https://api.plkey.app/tmp/theme/PLKEY0-L-81/review", content)
    }
}

extension ReviewListViewModel {
    func makeTimeLine(_ time : String) -> String {
        // 우선 현재 시간이랑 차이를 구해야함
        
        // 현재 시간
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh"
        let current = formatter.string(from: Date()).split(separator: " ")
        let currentDate = current[0]
        let currentHour = current[1]
        
        // 주어진 시간
        let splitReviewDate = time.split(separator: "T")
        let reviewDate = splitReviewDate[0]
        let reviewTime = splitReviewDate[1]
        let splitReviewTime = reviewTime.split(separator: ":")
        let reviewHour = isFirstZero(String(splitReviewTime[0]))
        let reviewMinute = isFirstZero(String(splitReviewTime[1]))
        
        if currentDate != reviewDate {
            return String(reviewDate)
        } else { // 하루 이내
            if currentHour != reviewHour {
                // 분 단위 표시
                 return ("\(reviewMinute)분 전")
            } else {
                // 시간 단위 표시
                 return ("\(reviewHour)시간 전")
            }
        }
    }
    
    func isFirstZero(_ timeString : String) -> String {
        if timeString.first == "0" {
            return String(timeString.dropFirst())
        } else {
            return String(timeString)
        }
    }
    
    func makeStringToImage(_ imageString : String) -> UIImage? {
        guard let url = URL(string: imageString) else {return nil}
        do {
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        } catch {
            print("error")
            return nil
        }
    }
}
