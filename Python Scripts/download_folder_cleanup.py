from os import listdir
from os.path import isfile, join
import os
import shutil
import argparse

## initial setup taken from https://linuxhint.com/add_command_line_arguments_to_a_python_script/


parser = argparse.ArgumentParser(description='script to organise given folder')
args = parser.parse_args()

def sort_files_in_folder(mypath):
    '''
    fucntion that will sort files in downloads folder into different categories
    '''

    files = [f for f in listdir(mypath) if isfile(join(mypath, f))]
    file_type_variation_list = []
    filetype_folder_dict = {}

    for file in files:
        filetype = file.split('.')[1]
        if filetype not in file_type_variation_list:
            file_type_variation_list.append(filetype)
            new_folder_name= mypath+'/'+ filetype + '_folder'
            if os.path.isdir(new_folder_name)==True:
                continue
            else:
                os.mkdir(new_folder_name)
    
    for file in files:
        src_path=mypath+'/'+file
        filetype = file.split('.')[1]
        if filetype in filetype_folder_dict.keys():
            dest_path = filetype_folder_dict[str(filetype)]
            shutil.move(src_path, dest_path)
    
    print(src_path + '>>>' + dest_path)

if __name__=="__main__":
    mypath="C:\\Users\\paulj\\Downloads"
    sort_files_in_folder(mypath)
