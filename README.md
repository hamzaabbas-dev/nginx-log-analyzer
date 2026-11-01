#  Linux Nginx Log Analyzer

A beginner Bash project that reads an Nginx access log and generates a request report.

I built this project while practicing Linux and deploying my portfolio website with Nginx on Ubuntu WSL.

## Features

- Displays the report generation date and time.
- Counts all requests in the current access log.
- Counts responses with HTTP status codes 200, 304 and 404.
- Counts requests per client IP, with the highest count first.
- Lists requested paths that returned 404.
- Stops with an error message if the log file is missing or unreadable.

## Requirements

- Bash
- Standard Linux tools: awk, wc, sort, uniq, date and tee
- An Nginx access log in the expected format
- Read permission for the log file

## Project Files

- `report.sh` — the Bash script.
- `README.md` — project documentation.
- `report.txt` — generated output, created when using the save command below.

## Configuration

The script reads this log by default:

```bash
LOG_FILE="/var/log/nginx/access.log"
```

To analyze another compatible log, update this value in `report.sh`.

The script reads the log without modifying it.

## Run the Script

Open the project directory:

```bash
cd ~/nginx-log-analyzer
```

Display the report:

```bash
bash report.sh
```

Display the report and save it:

```bash
bash report.sh | tee report.txt
```

This replaces the previous contents of `report.txt`.

The script does not save a report automatically. The `tee` command handles saving.

## Example Output

These are sample results from my local practice environment. Counts change as new requests arrive.

```text
Sun Nov 1 11:29:29 PKT 2026
Nginx Request Report
Total requests:
57
Not found requests (404):
13
Successful responses (200):
1
Not modified responses (304):
43
Requests by client IP:
     57 ::1
Paths returning 404:
/error
/favicon.ico
/error-log
```

The missing-path list above is shortened.

## HTTP Status Codes

| Code | Meaning |
|------|---------|
| 200 | The request succeeded. |
| 304 | The resource was not modified; the browser can use its cached copy. |
| 404 | The requested resource was not found. |

`::1` is the IPv6 loopback address. In this local lab, requests came from the same computer.

## Log Format

The script uses whitespace-separated fields from the Nginx access log:

| Field | Value |
|-------|-------|
| 1 | Client IP address |
| 7 | Requested path |
| 9 | HTTP status code |

Custom log formats may require changes to these field numbers.

## Checks Performed

- Ran the script against a readable Nginx access log.
- Requested a missing page and verified that the 404 count increased.
- Verified that the new missing path appeared in the report.
- Saved the report using `tee`.
- Tested a missing log path and confirmed that the script stopped with an error.
- Restored the correct log path and ran the script again.

## Limitations

- Analyzes only the selected log file, not rotated logs.
- Does not filter requests by date.
- Reports separate counts only for 200, 304 and 404 responses.
- Other status codes are included in the total request count.
- Repeated missing paths remain in the output.
- Request counts do not represent unique visitors.
- The log is read several times, so active traffic may cause counts to change during a run.
- Automatic scheduling is not configured in this version.

## Skills Practiced

Bash scripts, variables, conditions, pipes, input redirection, log analysis, awk, sorting and report generation.

## Author

Hamza Abbas  
BSIT Student — Virtual University of Pakistan  
Building practical Linux, Cloud and DevOps skills.
