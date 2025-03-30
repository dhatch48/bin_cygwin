#!/usr/bin/env python3

# import packages
import os
import sys
#from PyPDF2 import PdfReader
import pypdfium2 as pdfium
import re
import csv

'''
define folder path to target PDFs
    ex. mac or linux = "/path/to/pdf/files/"
    ex. windows = "C:\\path\\to\\pdf\\"
change dirPath string below or default is current script path
'''
dirPath = os.getcwd()

# define bate number pattern and resultFile
search_pattern = '[A-Z]{2,}[-_]?[0-9]{4,10}+'
resultFile = (os.getcwd() + "\\pdf_bates_number_results.csv")

# set string prefix if passed
if len(sys.argv) == 2:
    searchPrefix = str(sys.argv[1])
    search_pattern = searchPrefix + '[0-9]{4,10}+'
    resultFile = (os.getcwd() + "\\pdf_bates_number_" + searchPrefix + "results.csv")

# save results to CSV file in the same folder as this script
writer = csv.writer(open(resultFile, 'w', newline='', encoding='utf-8'), dialect='excel')
# write header
writer.writerow(["Bates number", "Page count" ,"File path" ,"File name", "File extension", "Native path"])

# loop recursively through all folders and files
for (path, directories, files) in os.walk(dirPath):
    for curFile in files:
        # get current file extension and file path
        fileExt = os.path.splitext(curFile)[1][1:].strip().lower()
        fullFilePath = os.path.join(path,curFile)
        relFilePath = os.path.relpath(fullFilePath,dirPath)

        # Search only PDF files
        if fileExt == "pdf":

            # open the pdf file
            #reader = PdfReader(fullFileName)
            reader = pdfium.PdfDocument(relFilePath)

            # get number of pages
            #pageCount = len(reader.pages)
            pageCount = len(reader)

            # extract text and search for pattern
            #text = reader.pages[0].extract_text()
            text = reader[0].get_textpage().get_text_bounded()
            res_search = re.search(search_pattern, text, re.IGNORECASE)

            # write each result to CSV file
            if res_search:
                row = (res_search.group(0), pageCount, relFilePath, curFile, fileExt, curFile)
            else:
                row = ("no match found", pageCount, relFilePath, curFile, fileExt, curFile)
            print(row)
            writer.writerow(row)
        
        # Ignore this script and result file
        elif curFile.startswith("pdf_bate"):
            continue

        # Ignore python
        elif relFilePath.startswith("_internal"):
            continue

        # log all other files
        else:
            row = ("n/a", "n/a", relFilePath, curFile, fileExt, curFile)
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
                    row = (fullFilePath,res_search.group(0),i)
                    print(row)
'''
