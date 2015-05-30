##import libraries
import xlrd
import csv
import os
import sys
import re
import unicodecsv
#####################
#Here here here to do:  capture category and type.   Include that in the sort for output?

##############################################
if len( sys.argv ) == 1 :
	print("Error. No Affiliate Code Supplied")
	sys.exit()

#set affiliate code
affCode = sys.argv[1]
	
# Set paths
finDir = os.path.realpath("./FinOut")
progDir = os.path.realpath("./ProgOut")
outDir = os.path.realpath("./ProgFinComp")
if not os.path.exists(outDir):
	os.makedirs(outDir)


	
print('Matching %s' % affCode)
# Set file names
fn = affCode + '.csv'

#Open output file
#fnOut = affCode + '.txt'
fnOut = affCode
outFile = os.path.join(outDir,fnOut)
f = open(outFile,'w')


########
#Build dict for program data program names and codes
progDict = dict()
progFile = os.path.join(progDir,fn)
pReader = csv.reader(open(progFile, 'r'), delimiter=',')
i = 0 
for row in pReader:
	i = i+1   #get row number for log
	#print('DEBUG!!!  Read row %s, %s, %s ' % (i,row[9],row[11]))
	
	if (row[1] != affCode) : continue       #skip all non-program data rows
	if (row[2] == "Select from List") : continue
	
	#print('DEBUG!!!  Found program %s ' % row[9])
	progName = row[9]
	
	#a = str(row[11])
	#parts = a.split('.')
	#progCode = parts[0]
	#read progCode as is for now
	progCode = str(row[11])
	
	
	#print progName + ', ' + progCode
	progDict[progName] = progCode

#print "\nHere are the program numbers from the program data file:"	
#print progDict

########
#Build dict for financial data program names and codes
iMISDict = dict()
progNoDict = dict()
finFile = os.path.join(finDir,fn)
fReader = csv.reader(open(finFile, 'r'), delimiter=',')
i = 0 

#print 'Looking for financial program name row'
for row in fReader :
	i = i+1   #get row number for log	
	#print row[0]
	if (row[0] == "Local program name") : 
		#print 'Found financial program name row'
		nameRow = row
	elif (row[0] == "iMIS ID") : 
		#print 'Found iMIS ID row'
		iMISRow = row
	elif (row[0] == "Affiliate Program No.") : 
		#print 'Found Affiliate Program No. row'
		progNumRow = row
	else : 
		continue
		
# print nameRow
# print iMISRow	
# print progNumRow		

# Read the nameRow and extract the iMIS ID and the program number for each.
skiplist = ['Local program name', 'Eliminations', 'Auto resale', 'Auto donation', 'Capital Campaign', 'General']

i = 0
for item in nameRow :
	#if (item =='Local program name') : 
	if item in skiplist :
		#print('skipping %s' % item)
		i=i+1
		continue
	if len(item) > 0 :
		#print 'DEBUG'
		#print 'New Item in Name Row'
		#print('Processing item %s, %s' % (i, item))
		#print 'iMIS ID: ' + iMISRow[i]
		#print 'Program Number: ' + progNumRow[i]
		# # # if (len(iMISRow[i]) > 0) :
			# # # print('Adding %s to iMISDict' % iMISRow[i])
			# # # iMISDict[item] = iMISRow[i]
		# # # if (len(progNumRow[i]) > 0) :	
			# # # print('Adding %s to progNoDict' % progNumRow[i])
			# # # progNoDict[item] = progNumRow[i]
	
		#print('Adding %s to iMISDict' % iMISRow[i])
		iMISDict[item] = iMISRow[i]
		#print('Adding %s to progNoDict' % progNumRow[i])
		progNoDict[item] = progNumRow[i]
	
		#print 'END DEBUG'
	i=i+1

	

	
	

# print "\nHere are the iMIS codes from the financial file:"
# print iMISDict

# print "\nHere are the program numbers from the financial file:"
# print progNoDict


# Read the program file dictionary and for each program name, print all three codes

for pName in progDict :
	print '\n\n'
	print pName
	print 'Progam Data Code', progDict[pName]
	
	try :
		print 'iMIS ID', iMISDict[pName]
	except:
		print '**Name not found**'
		
	try :
		print 'Financial Program Number', progNoDict[pName]
	except:
		print '**Name not found**'
		
	
#sort by key and print 
#keys will be unique, by definition (of dict)
print '\n\nProgram Data:' 
f.write('\n\nProgram Data\n') 
for k,v in sorted(progDict.items()) :
	line = k + ' : ' + v
	print line
	f.write(str(line))
	f.write('\n')
	
print '\n\nFinancial Data - iMIS IDs' 
f.write('\n\nFinancial Data - iMIS IDs\n')
for k,v in sorted(iMISDict.items()) :
	line = k + ' : ' + v
	print line
	f.write(str(line))
	f.write('\n')

	
print '\n\nFinancial Data - program numbers'  
f.write('\n\nFinancial Data - Program Numbers\n') 
for k,v in sorted(progNoDict.items()) :
	line = k + ' : ' + v
	print line
	f.write(str(line))
	f.write('\n')

f.close()
 
sys.exit()




