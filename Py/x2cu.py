##import libraries
import xlrd
import csv
import os
import sys
import re
import unicodecsv


##############################################

# print "Converting Test Files"
# inDir =  os.path.realpath("./TestFiles")
# outDir = os.path.realpath("./TestOut")
# splChar = '_'


print "Converting Program Data"
inDir =  os.path.realpath("./ProgFiles")
outDir = os.path.realpath("./ProgOut")
splChar = '_'

if not os.path.exists(outDir):
	os.makedirs(outDir)
	
for dirName, subdirList, fileList in os.walk(inDir) :
	print('Found directory: %s' % dirName)
	for fname in fileList :
		print('\t%s' % fname)
		try :
			fpath = os.path.join(inDir,fname)
			workbook = xlrd.open_workbook(fpath)
		except : 
			print('FAILED on file %s' % fpath)
			sys.exit()
			
		#Display the number of sheets, and the names of each sheet
		# print('Workbook encoding is %s' % workbook.encoding)
		# print('Workbook contains %s sheets' % workbook.nsheets)
		# print workbook.sheet_names()
		
		shIdx = 0
		shName = ""
		for sheetx in range(workbook.nsheets) :
			if re.search('2014 Affiliate Data', workbook.sheet_by_index(sheetx).name) :
				if (workbook.sheet_by_index(sheetx).visibility == 1) :
					continue

				shIdx = sheetx
				shName = workbook.sheet_by_index(sheetx).name
				break
				

		print('Found sheet %s at index %s' % (shName, shIdx))
		worksheet = workbook.sheet_by_index(shIdx)
		
		fnparts = re.split(splChar, fname)
		csvfn = fnparts[0] + '.csv'
	
		csvpath = os.path.join(outDir,csvfn)
	
		print('Writing %s', csvpath)

		try :
			csvfile = open(csvpath, 'wb')
			wr = unicodecsv.writer(csvfile, encoding='utf-8', quoting=csv.QUOTE_ALL)
			for rownum in xrange(worksheet.nrows) :
				wr.writerow(worksheet.row_values(rownum))
		except :
			print "Failed"
			
		csvfile.close()	
		print "Succeeded"	
		

				
			
		
		
		


	