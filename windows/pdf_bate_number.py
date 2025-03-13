#!/usr/bin/env python3

# import packages
import os
import sys
from PyPDF2 import PdfReader
import re
import csv

'''
define folder path to target PDFs
    ex. mac or linux = "/path/to/pdf/files/"
    ex. windows = "C:\\path\\to\\pdf\\"
change dirPath string below or default is current script path
'''
dirPath = os.getcwd()

# define bate number pattern
search_pattern = '[A-Z]{2,}[-_]?[0-9]{4,10}+'

# set string prefix if passed
if len(sys.argv) == 2:
    searchPrefix = str(sys.argv[1])
    search_pattern = searchPrefix + '[0-9]{4,10}+'

# save results to CSV file in the same folder as this script
resultFile = (os.getcwd() + "\\pdf_bate_number_results.csv")
writer = csv.writer(open(resultFile, 'w', newline=''))
# write header
writer.writerow(["full_path","filename","bate_number","page_count"])

# loop recursively through all pdf files
for (dirpath, dirnames, filenames) in os.walk(dirPath):
    for file in filenames:
        if file.casefold().endswith('pdf'):
            fullFileName = os.path.join(dirpath,file)

            # open the pdf file
            reader = PdfReader(fullFileName)

            # get number of pages
            pageCount = len(reader.pages)

            # extract text and search for pattern
            text = reader.pages[0].extract_text() 
            res_search = re.search(search_pattern, text, re.IGNORECASE)

            # write each result to CSV file
            if res_search:
                row = (fullFileName, file,res_search.group(0),pageCount)
                print(row)
                writer.writerow(row)
print("results saved to: ", '\033[1m' + resultFile + '\033[0m')
print("done!")

'''
            # Original code to loop through all pages of PDF
            for i, page in enumerate(reader.pages):
                text = page.extract_text() 
                res_search = re.search(search_pattern, text)
                # print filename, matched text and page number
                if res_search:
                    row = (fullFileName,res_search.group(0),i)
                    print(row) 
'''