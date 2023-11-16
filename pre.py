#!/usr/bin/env python
n, m, x, y, d, M, S, num = map(int, input().split())
print('row(%d).' % n)
print('col(%d).' % m)
print('initrow(%d).' % x)
print('initcol(%d).' % y)
print('initdir(%d).' % d)
print('main(%d).' % M)
print('subr(%d).' % S)
print('target(%d).' % num)
for i in range(n):
    line = input().split()
    for j in range(m):
        line[j] = int(line[j])
        print('height(%d,%d,%d).' % (i, j, line[j]))
for i in range(num):
    line = input().split()
    print('bulb(%d,%d).' % (int(line[0]), int(line[1])))
