import os
from pathlib import Path

from pandas import DataFrame

root = Path("\\\\ROOKERY\\Media\\Books")
print(root)

file_list = []

for file in os.walk(root):
    file_list.append(file)

df = DataFrame(file_list, columns=["root", "dirs", "files"])

df.head()
# # file_list = os.walk("directory")
# print(file_list[5])

# for root, dirs, files in os.walk(root):
#     for name in files:
#         print(os.path.join(root, name))
