#!/usr/bin/env python3
import re
main = []
subr = []
x = input()
while x != '':
    x = x.split()
    for i in range(len(x)):
        if x[i][:4] == 'proc':
            line = re.split(r'[,)]+', x[i][10:])
            if line[1] == 'fw':
                line[1] = 'forward'
            if line[1] == 'turn':
                line[1] = 'beep'
            if line[1] == 'subr':
                line[1] = 'subroutine'
            if x[i][:9] == 'proc(main':
                main.append((int(line[0]), line[1]))
            else:
                subr.append((int(line[0]), line[1]))
    x = input()
# print(len(main))
main = sorted(main, key=lambda x: x[0])
subr = sorted(subr, key=lambda x: x[0])
# main.sort(lambda x: x[0])
# subr.sort(lambda x: x[0])
for i in main:
    print(i[1], end=' ')
print('.')
for i in subr:
    print(i[1], end=' ')
print('.')
