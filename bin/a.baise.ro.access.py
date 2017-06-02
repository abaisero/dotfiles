#!/usr/bin/env python

if __name__ == '__main__':
    access = 'a.baise.ro.access.log'

  with open(access, 'r') as f:
    accesses = f.readlines()
  print accesses
