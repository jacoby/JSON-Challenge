#!/bin/bash

go build jsontest.go

echo "========== Go Compiled ================================================"
time ./jsontest           > /dev/null       
echo

echo "========== Perl ======================================================="
time ./jsontest.pl        > /dev/null          
echo

echo "========== Node.js ===================================================="
time ./jsontest.js        > /dev/null          
echo

echo "========== RScript ===================================================="
time ./jsontest.rs        > /dev/null          
echo

echo "========== Go Not Compiled ============================================"
time go run jsontest.go > /dev/null                 
echo
