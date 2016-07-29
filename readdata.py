name = 'gisette_train.data'

matrix = []
f = open(name)
for line in f:
  words = line.split()
  matrix.append(words)
  for each in words:
    s = str(each)
    num1 = (s.split(':')[0])
    print num1, 
  print
    
  
