#!/usr/bin/env python


  import sys


  if len(sys.argv) != 2:
	print "Usage: split_ref.py filename"
	sys.exit()

  refs={}
  f=open("references.bib")
  n=f.read()
f.close()
o=n.split('@')
for p in o:
	if p and not p.startswith('%'):
		key=p.split('{')[1].split(',')[0]
		refs[key]=p


#print refs


f2=open("%s.aux"%sys.argv[1].split('.')[0])
cited=f2.read().split('\n')
f2.close()

for l in cited:
	if l.startswith("\citation{"):
		key=l.split('{')[1].split('}')[0]
#		print key
		if key.find(',')>=0:
			print 'many'
			for nkey in key.split(','):
				if nkey in refs:
					del refs[nkey]
		else:
			if key in refs:
				del refs[key]
import os
os.system("cp bibliography.bib bibliography-%i.bib"%os.getpid())
f3=open("bibliography.bib","w")
for k in refs:
	f3.write( "@%s" % refs[k])
f3.close()
