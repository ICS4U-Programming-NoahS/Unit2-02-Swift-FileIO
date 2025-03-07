//
// FileIO.swift
//
// Created by Noah Smith
// Created on 2025-03-06
// Version 1.0
// Copyright (c) 2025 Noah Smith. All rights reserved.
//
// The FileIO program reads a sample input file with integers on each line.
// It converts each of the numbers from a string to an integer.
// For each line of integers:
// It converts them from string to int.
// It calculates the sum of all the integers.
// It writes the sum to the output file.
// If any of the input is erroneous,
// it displays the error message in “output.txt” instead.

// Import foundation library
import Foundation

// Greet the user
print("Welcome to the file input/output program!")

// Define the different possible error types
enum InputError: Error {
    case invalidInput
}

// Do-catch block to catch any possible errors
do {

    // Initialize output
    var outputStr = ""

    // initialize sum
    var sum = 0

    // Initialize validInt
    var validInt = 0

    // Define the relative file paths
    let inputFile = "./Unit2-02-input.txt"
    let outputFile = "./Unit2-02-output.txt"

    // Open the input file for reading
    guard let input = FileHandle(forReadingAtPath: inputFile) else {
        // Throw an error if the input file cannot be read
        throw InputError.invalidInput
    }

    // Open the output file for writing
    guard let output = FileHandle(forWritingAtPath: outputFile) else {
        // Throw an error if the output file cannot be written to
        throw InputError.invalidInput
    }

    // Read the contents of the input file
    let inputData = input.readDataToEndOfFile()

    // Convert the data to a string
    guard let inputStr = String(data: inputData, encoding: .utf8) else {
        // Throw an error if the data cannot be converted to a string
        throw InputError.invalidInput
    }

    // Split the input string into lines
    let inputLines = inputStr.components(separatedBy: "\n")

    // Initialize line number
    var position = 0

    // While loop to go through each line
    while (position) < (inputLines.count) {

        // Reset sum
        sum = 0

        // Reset validInt
        validInt = 0

        // Get the current line
        let line = (inputLines)[position]

        // Split the line into numbers
        let numbers = line.components(separatedBy: " ")

        // For loop to go through each number
        for numStr in numbers {

            // Convert the number from a string to an integer
            if let num = Int(numStr) {

                // Add the integer to the sum
                sum += num

                // Increment validInt
                validInt += 1
    
            } else {
                // Display error message in the output file
                outputStr += "\(numStr) is not a valid integer. \n"
            }
        }

        // Check if there are no valid integers on the line
        if validInt == 0 {
            // Display error message in the output file
            outputStr += "Error: no integers were found on this line. \n"

            // Add a blank line for spacing
            outputStr += "\n"
        } else {
            // add the sum to the output string
            outputStr += "The sum of the valid integers is \(sum). \n"

            // Add a blank line for spacing
            outputStr += "\n"
        }

        // Increment the position
        position += 1
    }

    // Write the sum to the output file
    output.write(outputStr.data(using: .utf8)!)

    // Display a success message
    print("Output successfully written to the output file.")

    // Close the output file
    output.closeFile()

    // Close the input file
    input.closeFile()

// If an error occurs, catch it and display an error message
} catch InputError.invalidInput {
    // Display an error message
    print("Unable to read from the input file.")
}
