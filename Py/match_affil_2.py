##import libraries
import xlrd
import csv
import os
import sys
import re
import unicodecsv
#####################
#here here here to do:  allow upper or lower input parameters
#                       fix for funky characters in names (see NYNY file)

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
#Build List for program data program names and codes
progList = []
progFile = os.path.join(progDir,fn)
#print('opening file %s' % progFile)
pReader = csv.reader(open(progFile, 'r'), delimiter=',')
i = 0 
for row in pReader:
	i = i+1   #get row number for log
	l = []    #reinit list
	
	if (row[1] != affCode) : continue       #skip all non-program data rows
	if (row[2] == "Select from List") : continue
	
	l.append(row[9])       #name
	l.append(row[11])      #number
	l.append(row[2])       #impact area
	l.append(row[3])       #category
	l.append(row[4])       #type
	
	#print 'adding entry to progList'
	#print l
	progList.append(l)

#print '\n\n\nCompleted Proglist\n'
#print progList

########
#Build list for financial data program names and codes
finList = []
finFile = os.path.join(finDir,fn)
fReader = csv.reader(open(finFile, 'r'), delimiter=',')
i = 0 

#print 'Looking for financial program name row'
for row in fReader :
	i = i+1   #get row number for log	
	if (row[0] == "Impact Area") : 
		impactRow = row
	elif (row[0] == "Program Category") : 
		catRow = row
	elif (row[0] == "Program Type") : 
		typeRow = row
	elif (row[0] == "Local program name") : 
		nameRow = row
	elif (row[0] == "iMIS ID") : 
		iMISRow = row
	elif (row[0] == "Affiliate Program No.") : 
		progNumRow = row
	else : 
		continue
			
			
# Extract the ImpactAreas and the Column Range for Each
k = 0
j = 1
impacts = dict()
	#hour = timebits[0]
	#hours[hour] = hours.get(hour,0) + 1

for val in impactRow :
	#print k
	#print val
	if (k == 0) : 
		k = k+1
		continue
	if (val == "") :
		k = k+1
		continue
	#TO DO: use regex to match in case of leading or trailing spaces
	if (val == "Encouraging Positive Development") :
		print ('Encouraging Positive Development starts at column %s' %k) 
		#impacts['epd'] = k
	elif (val == "Fostering Independence") :
		print ('Fostering Independence starts at column %s' % k) 
		#impacts['fi'] = k
	elif (val == "Promoting Self-Sufficiency ") :
	#elif (k == 86) :
		#print ('Promoting Self-Sufficiency starts at column %s' % k) 		
		impacts['pss'] = k	
		
	k = k+1

#print ('Encouraging Positive Development starts at column %s' % impacts['epd'])
#print ('Fostering Independence starts at column %s' % impacts['fi'])
#print ('Promoting Self-Sufficiency starts at column %s' % impacts['pss'])
	

			
# Read the nameRow and extract the category, type and iMIS ID and the program number for each.
skiplist = ['Local program name', 'Eliminations', 'Auto resale', 'Auto donation', 'Capital Campaign', 'General']

#use i to track the current column
i = 0
for item in nameRow :
	#walk through the nameRow selecting the program name from each column
	#and then getting the other info from the same column, as necessary.  
	#Impact Area is not in the column, though. It is a header associated with a particular range, and that range varies for each affiliate file.
	if (i < impacts['fi']) :
		ia = "Encouraging Positive Development"
	elif (i < impacts['pss']) :
		ia = "Fostering Independence"
	else :
		ia = "Promoting Self-Sufficiency"
	
	l = []    #reinit list
	#if (item =='Local program name') : 
	if item in skiplist :
		#print('skipping %s' % item)
		i=i+1
		continue
	if len(item) > 0 :
		l.append(item)
		l.append(iMISRow[i])
		l.append(progNumRow[i])
		l.append(ia)
		l.append(catRow[i])
		l.append(typeRow[i])
		finList.append(l)
	
	i=i+1




# # Read the program file dictionary and for each program name, print all three codes

# for pName in progDict :
	# print '\n\n'
	# print pName
	# print 'Progam Data Code', progDict[pName]
	
	# try :
		# print 'iMIS ID', iMISDict[pName]
	# except:
		# print '**Name not found**'
		
	# try :
		# print 'Financial Program Number', progNoDict[pName]
	# except:
		# print '**Name not found**'
		
	
# # #sort by key and print 
# #keys will be unique, by definition (of dict)
# print '\n\nProgram Data:' 
# f.write('\n\nProgram Data\n') 
# for k,v in sorted(progDict.items()) :
	# line = k + ' : ' + v
	# print line
	# f.write(str(line))
	# f.write('\n')

f.write("Source;Name;iMIS ID;ProgNo;Impact Area;Category;Type\n")
#print '\n\nProgram Data:' 
#f.write('\n\nProgram Data\n') 
for item in progList :
	#for item in entry :
		line = "Service;" + item[0] + ';;' + item[1] + ';' + item[2] + ';' + item[3] + ';' + item[4]
		#print line
		#print '\n'
		f.write(str(line))
		f.write('\n')	
	
#print '\n\nFinancial Data:' 
#f.write('\n\nFinancial Data\n') 
for item in finList :
	#for item in entry :
		#print len(item)
		line = "Finance;" + item[0] + ';' + item[1] + ';' + item[2] + ';' + item[3] + ';' + item[4]  + ';' + item[5]
		#print line
		#print '\n'
		f.write(str(line))
		f.write('\n')		
	
# print '\n\nFinancial Data - iMIS IDs' 
# f.write('\n\nFinancial Data - iMIS IDs\n')
# #for k,v in sorted(iMISDict.items()) :
# for k,v in iMISDict.items():
	# line = k + ' : ' + v
	# print line
	# f.write(str(line))
	# f.write('\n')

	
# print '\n\nFinancial Data - program numbers'  
# f.write('\n\nFinancial Data - Program Numbers\n') 
# #for k,v in sorted(progNoDict.items()) :
# for k,v in progNoDict.items() :
	# line = k + ' : ' + v
	# print line
	# f.write(str(line))
	# f.write('\n')

f.close()
 
sys.exit()




