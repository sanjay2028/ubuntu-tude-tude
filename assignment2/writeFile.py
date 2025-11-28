"""
3.Write to a File
Write a program to create a text file and write some content to it.

Using file functions like write and open.

Explanation of the code:

1. Create a variable filename and store the target file path. 
2. Performed file operation using with.
3. It provides better handling of files in python and automatically closes the file after completion of with block
4. In the code we have opened a testfile using w+ flag.
5. We added two sentences to the file. 
6. Since we are using file operation using with, closing the file is not required. 
7. You can check the file content for the validity of the code. 
8. Two sentences added in the with block will be shown in the targeted file.  

"""
filename = "testfile.txt"


with open(filename, "w+") as fileHandler:
    fileHandler.write("This is a lipsum text.\n")
    fileHandler.write("Additional text added to the file.\n")


