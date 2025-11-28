"""
2 Student Grades
Create a dictionary where the keys are student names and the values are their grades. 
Allow the user to:
    - Add a new student and grade.
    - Update an existing student’s grade.
    - Print all student grades.

Used dictionary and basic operations. Using if else:

Explanation of the working of the code:
- It's a continuous running python app and won't end unless quit using the desired option.
- Main menu apperas when the program is executed
- Available options are :   
        1 - to add a new student and grade
        2 - to update an existing students' grade and grades
        3 - to list all the students and their grades
        0 - to quit the program.
- List is blank at the start of program. List of students are stored in listofstudents variable as a dictionary
- Code is wrapped in try except block to prevent the program from unexpected failues like incorrect input or wrong choice chosen by user
- First level of if else checks if the user input is for an operation or to quit.
- Program terminats if user chooses 0
- else program goes to specific task based on the valid choice made by the user. 
- the choice of the user is stored in operation variable. 
- based on the operation the business logic gets executed followed by the required input. 
- For creation, operation block will ask for the name and grade
- For update, operation will will ask for the name first. Check if the student exists. Then update the grade. 
  Returns a message that student does not exists
- For listing, just iterate through the dictionary using for loop.
"""

execution  = True
listofstudents = {}
while execution == True:
    try:
        print("Available options :\n")
        print("1. Add a new student and grade")
        print("2. Update an existing student's and grade")
        print("3. Print all student grades")
        print("0. Print 0 to quit")

        operation = int(input("Enter your choice: "))

        if(operation == 0):
            execution = False
        else:
            if(operation == 1):
                
                newName = input("Enter student name: ")
                newGrade = input("Enter Grade: ")
                listofstudents[newName.lower()] = newGrade
                confirm = input("Entry added. Press any key to continue \n")
            elif(operation == 2):
                existingName = input("Enter student name: ")
                existingName = existingName.lower()
                if listofstudents.get(existingName) is None:
                    print("Student does not exists")
                else:
                    updatedGrade = input("Enter Grade: ")
                    listofstudents[existingName] = updatedGrade
                    confirm = input("Entry Updated. Press any key to continue \n")
            elif(operation == 3):
                print("\nHere is the list of Students:")
                for name, grade in listofstudents.items():
                    print(f"{name} : {grade}")
            else:
                print("Invalid choice. Try again")
    except ValueError:
        pass

