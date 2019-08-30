import fileinput
from collections import Counter

vals = Counter()

def print_summary():
    print 'Summary (%d)' % sum(vals.values())
    print '{'
    for k in vals:
        print '\t', k, vals[k]
    print '}'

loop = 1000
i = 0
for line in fileinput.input():
    new = False
    i += 1
    line = line[:-1]
    if line not in vals:
        new = True
    vals[line] += 1
    if new or i == loop:
        print_summary()
        i = 0
