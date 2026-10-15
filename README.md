# Security Log Analyzer (Bash)

## Purpose
`log_analyzer.sh` helps a student or junior security analyst quickly review a text log and spot possible security problems. It filters lines containing ERROR, WARNING, or FAILED, counts those events, and optionally saves the report. This is useful when investigating failed sign-ins, service errors, or warnings without manually scrolling through every entry.

This is a keyword-based exercise, **not** a complete intrusion-detection system. It does not validate timestamps or detect every attack.

## Files
- `log_analyzer.sh` — Bash program
- `sample.log` — fictional sample input (documentation/test data, no real passwords)
- `README.md` — setup and instructions

## Run
```bash
chmod +x log_analyzer.sh
./log_analyzer.sh -h
./log_analyzer.sh -f sample.log
./log_analyzer.sh -f sample.log -l failed
./log_analyzer.sh -f sample.log -l error -o errors.txt
```

## Options
- `-f LOGFILE` required input file
- `-l LEVEL` optional `all` (default), `error`, `warning`, or `failed`
- `-o OUTPUT` optional new report file; the script refuses to overwrite an existing file
- `-h` show usage information

## How it works
1. `getopts` reads command-line options and checks for invalid or missing values.
2. Bash `[[ -f ... && -r ... ]]` confirms that the log exists and is readable.
3. `grep -Ei` searches using an **extended regular expression** (`ERROR|WARNING|FAILED` for `all`) without case sensitivity.
4. `wc -l` counts matching log lines, and `printf` displays the report.
5. With `-o`, Bash's `>` redirection writes the report to a separate file with restrictive permissions.

## Expected result
Running `./log_analyzer.sh -f sample.log -l failed` shows 2 matching events and the two FAILED login lines.

## Limitations
The search looks for keywords anywhere in the line, so an unrelated message containing those words may appear. Some log formats may use different terminology. Do not run the script on private logs unless you are authorized to analyze them.
