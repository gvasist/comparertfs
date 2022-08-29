# Program to compare multiple rtf files across different folders
# This will output the differences in HTML layout

import os
import difflib
import re
from difflib import HtmlDiff
from pathlib import Path

txt_1 = r"C:\Users\vidya\Python\rtf_comparator\folder1"
txt_2 = r"C:\Users\vidya\Python\rtf_comparator\folder2"
path=r"C:\Users\vidya\Python\rtf_comparator\folder1"

fol_1 = []
fol_2 = []
for fname in os.listdir(path=txt_1):
    fol_1.append(fname)
for fname in os.listdir(path=txt_2):
    fol_2.append(fname)
for i in fol_1:
    for j in fol_2:
        print("First file is: ", i)
        print("Second file is: ", j)
        print("First folder location is: ", txt_1)
        file1lines  = open(os.path.join(txt_1, i)).readlines()
        file2lines  = open(os.path.join(txt_2, j)).readlines()
        #i = i.rstrip('\r\n')
        #j = j.rstrip('\r\n')
        i = re.sub(r'\r\n\s+',' ', i).strip()
        j = re.sub(r'\r\n\s+',' ', j).strip()
        diff = difflib.HtmlDiff().make_file(file1lines, file2lines, i, j,context=False)
        path = r"C:\Users\vidya\Python\rtf_comparator\folder1\\" + os.path.basename(i)+ '_compare.html'
        print("Output file is: ", path)
        #f=open(r"C:\Users\vidya\Python\rtf_comparator\folder1\" + str(i) + str("compare.html"),'w')
        f=open(path,'w')
        f.write(diff)
        f.close()


        #sys.stdout.writelines(diff)

