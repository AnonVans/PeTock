//
//  ContentViewController.swift
//  Mini2
//
//  Created by Jovanna Melissa on 23/06/24.
//

import Foundation
import SwiftData
import SwiftUI

class TimeAssignmentViewModel: ObservableObject {
    @Published var studySessionTotal: Int = 2
    @Published var breakSessionTotal: Int = 1
    @Published var studyTimeinMinutes = 35
    @Published var currentSession = 1
    @Published var totalSession = 3
    
    @Published var sessionOver = false
    var sessionDuration = 5
//    @Published var studySessionTime:[Int] = []
//    @Published var breakSessionTime:[Int] = []
    
    private static var timeAssignVM: TimeAssignmentViewModel?
    
    static func getInstance() -> TimeAssignmentViewModel {
        if self.timeAssignVM == nil {
            timeAssignVM = TimeAssignmentViewModel()
        }
        return self.timeAssignVM!
    }
    
    func timeAssignment(_ studyTime:Int){
        studyTimeinMinutes = studyTime * 60
        print(studyTimeinMinutes)
        
        self.studySessionTotal = studyTimeinMinutes/30
        self.breakSessionTotal = studySessionTotal - 1
        self.totalSession = self.studySessionTotal + self.breakSessionTotal
        
        print(studySessionTotal)
        print(breakSessionTotal)
        
//        studySessionTime = [25]
//        studyTimeinMinutes -= 25
//
//        breakSessionTime = [5]
//        studyTimeinMinutes -= 5
//
//        var breakSessionCounter = 2
//        while(studyTimeinMinutes>0){
//            if(studyTimeinMinutes >= 25 && studyTimeinMinutes != 30){
//                studySessionTime.append(25)
//                studyTimeinMinutes -= 25
//
//                if(breakSessionTotal >= 2 && breakSessionCounter <= breakSessionTotal && (breakSessionCounter%4 != 0)){
//                    breakSessionTime.append(5)
//                    studyTimeinMinutes -= 5
//                } else {
//                    breakSessionTime.append(15)
//                    studyTimeinMinutes -= 15
//                }
//                breakSessionCounter += 1
//            } else if(studyTimeinMinutes == 30){
//                studySessionTime.append(30)
//                studyTimeinMinutes -= 30
//            } else {
//                studySessionTime.append(studyTimeinMinutes)
//                studyTimeinMinutes = 0
//            }
//        }
//        print(studySessionTime)
//        print(breakSessionTime)
    }
    
    func getStudySession() -> Int {
        if currentSession%2 != 0 {
            return (currentSession + 1) / 2
        } else {
            return currentSession / 2
        }
    }
    
    func getBreakSession() -> Int {
        if currentSession%2 != 0 {
            return (currentSession - 1) / 2
        } else {
            return currentSession / 2
        }
    }
    
    func updateSession() {
        self.currentSession += 1
        calculateSessionDuration()
        print("Session: \(currentSession) || Remaining: \(studyTimeinMinutes)")
    }
    
    func checkEndSession() {
        if self.studyTimeinMinutes == 0 {
            self.sessionOver = true
        }
    }
    
    func calculateSessionDuration() {
        if currentSession%2 == 1 {
            //Return Study Session
            if studyTimeinMinutes > 30 {
                self.studyTimeinMinutes -= 25
//                self.sessionDuration = 25*60
                print("25 Minute Study")
                self.sessionDuration = 5
            } else {
//                self.sessionDuration = self.studyTimeinMinutes*60
                self.studyTimeinMinutes = 0
                print("Irregular Minute Study")
                self.sessionDuration = 5
            }
        } else {
            //Return Break Session
            let currBreak = getBreakSession()
            if currBreak%4 == 0 {
                self.studyTimeinMinutes -= 15
//                self.sessionDuration = 15*60
                print("15 Minute Break")
                self.sessionDuration = 5
            } else {
                self.studyTimeinMinutes -= 5
//                self.sessionDuration = 5*60
                print("5 Minute Break")
                self.sessionDuration = 5
            }
        }
    }
    
    func resetCurrentSession() {
        self.currentSession = 1
    }
}
