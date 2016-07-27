name = 'dexter_test.data'

f = open(name)
for line in f:
  words = line.split()
  for each in words:
    s = str(each)
    num1 = (s.split(':')[0])
    num2 = (s.split(':')[1])
    print num1, 
  print
    
  
