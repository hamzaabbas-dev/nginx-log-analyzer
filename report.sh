#!/bin/bash

LOG_FILE="/var/log/nginx/access.log"

if [ ! -r "$LOG_FILE" ]; then
    echo "Error: Log file is missing or not readable." >&2
    exit 1
fi
date
echo "Nginx Request Report"

echo "Total requests:"
wc -l < "$LOG_FILE"

echo " Not found requests (404):"
awk '$9 == 404 {print $9}' "$LOG_FILE" | wc -l
echo "Successful responses (200):"
awk '$9 == 200 {print $9}' "$LOG_FILE" | wc -l
echo "Not modified responses (304):"
awk '$9 == 304 {print $9}' "$LOG_FILE" | wc -l
echo "Requests by client IP:"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr
echo "Paths returning 404:"
awk '$9 ==404 {print $7}' "$LOG_FILE"
