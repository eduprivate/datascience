import MapReduce
import sys

"""
Implementation of unique_trims.py in MapReduce
"""

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
    key = record[0]
    value = record[1]
    value = value[:len(value)-10]
    mr.emit_intermediate(value,1)

def reducer(key, list_of_values):
    total = 0
    for v in list_of_values:
      total += v
    mr.emit((key))
    
# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)
