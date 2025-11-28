"""
Problem: Grade Checker
Take a score as input and print the grade based on the following:
90+ : "A"
80-89 : "B"
70-79 : "C"
60-69 : "D"
Below 60 : "F"

Explanation of the working of the code:
- It's a continuous running python app and won't end unless quit using the desired option. 
- Main Menu provides two options
- First option can be chosen by pressing numeric key 1 on your keyboard
- For any other number pressed on the main menu will terminate the program
- Program expects only numeric values to be entered.
- Program is wrapped in try catch to prevent the program to terminate due to any invalid input.
- Once user makes a choice, it's is evaluated using if else. 
- If user chooses 1, progrma asks for the marks
    - using nested if else conditions, we try to match the case where entered input matches. 
    - baesd on the if else condition match, the response is returned to the user. 
- If user input any other number (other than 1), it terminates the program


"""
execution = True

while execution == True:    

    print("Main Menu:\n")
    print("Option 1: Press 1 to Check grades\n")
    print("Option 2: Press any other number to quit \n")
    try:
        choice = int(input("Choose your option: "))
        if(choice == 1):
            marks_obtained = int(input("Enter your marks: "))
            if(marks_obtained >= 90):
                print("Your Grade is A \n")
            elif(80 <= marks_obtained <= 89 ):
                print("Your grade is B \n")
            elif(70 <= marks_obtained <= 79 ):
                print("Your grade is C \n")
            elif(60 <= marks_obtained <= 69 ):
                print("Your grade is D \n")
            else:
                print("Your grade is F \n")
            blankInput = input("Press any key to go to main")
        else:
            execution = False
    except ValueError as e:
        print("Error: Invalid input. Only numeric input allowed. Please try again with valid input \n")