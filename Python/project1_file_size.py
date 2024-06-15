import os # allows us to interact with the operating system of the machine

directory = "."  # sets the starting directory as the current working directory (".")

file_info = {filename: os.path.getsize # Creates an empty dictionary named 'file_info' to store file information and gets the size of the file
                   (os.path.join(root, filename))  #joins the file root and file name
             
             for root, _, files in os.walk(directory) #iterates over the elements returned by os.walk, leaves out subdirectories, and presents a list containing all files found in root
             
             for filename in files
               if os.path.isfile(os.path.join(root, filename))} #creates the full file path and checks that it's an actual file and not a directory

# Print results
for filename, file_size in file_info.items(): #iterates file_info directory key-value pairs with the .items() method
  print(f"file: {filename}, size: {file_size} bytes") # prints the results of the iteration above