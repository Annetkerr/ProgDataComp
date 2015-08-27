# ProgDataComp
Scripts to compare program service and financial data files submitted by affiliates
The purpose is to create an output file that makes it easy to see if programs are named, coded, and categorized the same across both projects
Both R and Python scripts included

Python
x2c.py works for converting financial files, but fails on service data files
x2cu.py works - fixes encoding issue by using unicodecsv.writer


Python latest script is match_affil_2.py
It parses the converted fin and svc files, and has been updated to 
-match the columns (financial data has two code columns - svc only one)
-include column headers
-use semicolons as delimiter for easy import into excel
-includes logic to extract the impact area from fin files 

Output file Columns are:
Source - Financial or Service, depending on which file was the source file
Name - The name of the program in the given source file
iMIS ID - Code that only exists in the financial files
ProgNo - Code exists in both files. For some affiliates and some programs it matches;
Impact Area - Impact Area identified in the source file
Category - Program Category identified in the source file 
Type - Program Type as identified in the source file
