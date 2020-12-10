import shutil
import os
import datetime as dt
import errno
import py7zr

archive_date = dt.datetime.now().strftime("%Y-%m-%d")

baseOMG = "C:\\Users\\paulj\\OneDrive\\Documents\\scripts\\OMGClick"

OMG_folder = "OMGclick 4.0.2"
screenshots = os.path.join(baseOMG, OMG_folder, "screenshots")
screenshots_archive = os.path.join(baseOMG, "screenshots_2.7z")
os.chdir(screenshots)

file_names = os.listdir(screenshots)
backup_location = os.path.join(screenshots, archive_date)

try:
    os.mkdir(backup_location)
except OSError as e:
    if e.errno != errno.EEXIST:
        raise

for file_name in file_names:
    shutil.move(os.path.join(screenshots, file_name), backup_location)

# # print(screenshots)

os.chdir(baseOMG)
# directory = os.path.dirname(file_path)

# # file_names = os.listdir(os.path.join(screenshots, archive_date))
# for file_name in file_names:
#     with py7zr.SevenZipFile(screenshots_archive, 'a') as z:
#         z.write(file_name, archive_date)
# #     file_names[i] = os.path.join(screenshots, file_names[i])

# # Add to the backup zip
# with py7zr.SevenZipFile(screenshots_archive, 'a') as z:
#     z.write(file_names, archive_date)
