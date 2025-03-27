#!/bin/bash
count=$(ss -antp |grep 16443 |grep -cv "grep|$$")
if [ "$count" -eq 0 ];then
exit 1
else
exit 0
fi
