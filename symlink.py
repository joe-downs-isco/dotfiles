import os

#split_path() takes a filepath and returns the parent directory OR the filename depending upon boolean inputs
def split_path(filepath, return_file, return_parent):
    final_separator_index = filepath.rfind("/")
    if final_separator_index == -1:
        final_separator_index = filepath.rfind("\\")
    if return_file == True:
        return filepath[final_separator_index:]
    if return_parent == True:
        return filepath[:final_separator_index]

#symlink() takes a src/dst, creates a symlink in the dst, and prints out a confirmation message
def symlink(src, dst):
    filename = split_path(src, return_file = True, return_parent = False)
    parent_dir = split_path(src, return_file = False, return_parent = True)
    os.symlink(src, dst)
    if os.path.exists(dst):
        print("Successfully created symbolic link for " + str(filename) + " in " + str(parent_dir))
