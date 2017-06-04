//
//  Storage.swift
//  TwilioSms
//
//  Created by Emily on 6/4/17.
//  Copyright © 2017 Twilio. All rights reserved.
//

import Foundation

var ngrok = "http://30e415d8.ngrok.io"

// Emergency Contacts
var emergencyNumbers: [Int] = []
var emergencyNames: [String] = []
var emergencyDelay: [Float] = []
var emergencyIndexes: [String] = []

// Contacts
var contactNames: [String] = []
var contactNumbers: [Int] = []
var contactDelay: [Float] = []
var contactAdditionalInfo: [String] = []

// not being used
var yourNumber = 6505754922
var isVerified = false // tracks whether your number is verified
var verifiedNumbers: [Int] = [16504223512] // list of verified numbers

// UIColors - https://rtorres.me/uicolor/

// Contacts -> Customize
var clickedIndex: Int!
