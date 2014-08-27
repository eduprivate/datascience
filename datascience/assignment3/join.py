import MapReduce
import sys

"""
Implementation of join with MapReduce
"""

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
    value = record
    mr.emit_intermediate(value[1], value)

def reducer(key, list_of_values):
    
    values1=[]
    values2=[]

    for v in list_of_values:
        if(v[0]=='order'):
            values1.append(v)
        else:
            values2.append(v)
    for i in values1:
        for j in values2 :
            mr.emit((i+j))

# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)