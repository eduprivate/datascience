import MapReduce
import sys

"""
Implementation of asymmetric_friendship in MapReduce
"""
common = []
mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
    key = record[0]
    value = record[1]
    common.append(key+" "+value)
    if (not ((value+" "+key) in common)):
        mr.emit_intermediate(key, value)
        mr.emit_intermediate(value,key)

def reducer(key, list_of_values):
    total = 0
    for v in list_of_values:
      if(not( ((v+" "+key) in common) and ((key+" "+v) in common))):
         mr.emit((key, v))

# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)
