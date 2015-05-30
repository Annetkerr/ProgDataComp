##import libraries
import xlrd
import csv
import os
import sys
import re

		
def convertFile(fn,inpath,outpath,sheet) :
	try :
		fpath = os.path.join(inpath,fn)
		workbook = xlrd.open_workbook(fpath)
		worksheet = workbook.sheet_by_name(sheet)
	except : 
		print('FAILED on file %s' % fpath)
		return
		
	
	#Set output file name
	fnparts = re.split(' ', fn)
	csvfn = fnparts[0] + '.csv'
	
	csvpath = os.path.join(outpath,csvfn)
	
	print('Processing %s', csvpath)

	try :
		csvfile = open(csvpath, 'wb')
		wr = csv.writer(csvfile, quoting=csv.QUOTE_ALL)
		for rownum in xrange(worksheet.nrows) :
			print('row %s' % rownum)
			wr.writerow(worksheet.row_values(rownum))
	except :
		print "Failed"
		return
		
	# csvfile = open(csvpath, 'wb')
	# #wr = csv.writer(csvfile, quoting=csv.QUOTE_ALL)
	# wr = csv.writer(csvfile, csv.excel, workbook.encoding)
	# for rownum in xrange(worksheet.nrows) :
		# wr.writerow(worksheet.row_values(rownum))
		
	print "Succeeded"		
	csvfile.close()
	
##############################################
for arg in sys.argv[1:]:
	print arg

# Set paths
if len( sys.argv ) > 1 :
	print "Converting Financial Files"
	inDir =  os.path.realpath("./FinFiles")
	outDir = os.path.realpath("./FinOut")
	sheetnm = "Dollars and statistics"
else :
	print "Converting Program Data Files"
	inDir =  os.path.realpath("./ProgFiles")
	outDir = os.path.realpath("./ProgOut")
	sheetnm = "FY 2014 Affiliate Data"

#print('Create outDir %s', outDir)

if not os.path.exists(outDir):
	os.makedirs(outDir)
	

for dirName, subdirList, fileList in os.walk(inDir) :
	print('Found directory: %s' % dirName)
	for fname in fileList :
		print('\t%s' % fname)
		convertFile(fname,inDir,outDir,sheetnm)
		
		
		
		


	