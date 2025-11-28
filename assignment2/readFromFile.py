"""
4. Read from a File.
We used open in read mode and file.read to read and print to display.

Explanation of the code:
- Create a variable filename and store the target file path. 
- Performed file operation using with.
- It provides better handling of files in python and automatically closes the file after completion of with block
- Since we are using r flag, the file must exists at the time time of reading
- file content after reading is stored in data
- data is displayed using print command at the end of with block
"""


filename = "file2read.txt"

with open(filename, "r") as fileHandler:
    data = fileHandler.read()
    print(data)


