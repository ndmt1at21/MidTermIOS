//
//  Constant.swift
//  MidTerm
//
//  Created by Minh Tri on 11/23/20.
//

struct K {
    static let subTitleAlertCreateNewEvent = "Creating new event will delete all the info from the previous or current event in the app"
    
    struct segue {
        static let loginToWelcome = "LoginToWelcome"
        static let welcomeToAdmin = "MainWelcomeToAdmin"
        static let welcomeToGuest = "WelcomeToGuest"
        static let adminToCreateEvent = "AdminToCreateEvent"
        static let createEventToAddGuest = "CreateEventToAddGuest"
        static let guessWelcomeToLastName = "GuessWelcomeToLastName"
        static let searchNameToSearchResult = "SearchNameToSearchResult"
        static let searchResultToDetail = "SearchResultToDetail"
    }
    
    struct nibName {
        static let searchNameResultCell = "SearchNameResultCell"
        static let guestTableRecord = "GuestTableRecord"
        static let guestTableRecordCell = "GuestTableRecordCell"
        static let colorPicker = "ColorPicker"
        static let colorPickerCell = "ColorPickerCell"
        static let fontPicker = "FontPicker"
    }
    
    struct reuseCellID {
        static let searchNameResult = "ReuseableSearchNameResultCell"
        static let guestTableRecord =  "ReuseableGuestTableRecordCell"
        static let colorPicker = "ReuseableColorPickerCell"
        static let whoseSameTable = "ReuseableWhoseSameTableCell"
    }
    
    struct userDefaultKey {
        static let userFontSize = "UserFontSize"
        static let userFontName = "UserFontName"
        static let userColor = "UserColor"
    }
}
