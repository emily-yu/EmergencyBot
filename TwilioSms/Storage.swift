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

// Contacts
//var animals: [String] = ["Name1", "Name2", "Name3", "Name4", "Name5", "Name6"]
//var troll: [Int] = [6505754922, 6505754922, 6505754922, 6505754922, 6505754922, 6505754922, 6505754922]
var animals: [String] = [] // names
var troll: [Int] = [] // numbers
var additionalInfo: [String] = [] // additional notes

// not being used
var yourNumber = 6505754922
var isVerified = false // tracks whether your number is verified
var verifiedNumbers: [Int] = [16504223512] // list of verified numbers

var emergencyContact: [Int] = [] // retrieve emergency contacts
