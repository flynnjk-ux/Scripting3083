#!/usr/bin/env bash
# Summarize matching events from a text-based security log.
set -o pipefail

usage() {
  cat <<'HELP'
Usage: ./log_analyzer.sh -f LOGFILE [-l LEVEL] [-o OUTPUT] [-h]
Analyze a log for ERROR, WARNING, or FAILED entries (case-insensitive).
  -f LOGFILE   Input text log file (required)
  -l LEVEL     Filter level: all (default), error, warning, failed
  -o OUTPUT    Save matching lines and summary to a new text file
  -h           Show this help message
Examples:
  ./log_analyzer.sh -f sample.log
  ./log_analyzer.sh -f sample.log -l failed
  ./log_analyzer.sh -f sample.log -l error -o errors.txt
HELP
}

log_file=""
level="all"
output=""
while getopts ":hf:l:o:" opt; do
  case "$opt" in
    h) usage; exit 0 ;;
    f) log_file=$OPTARG ;;
    l) level=${OPTARG,,} ;;
    o) output=$OPTARG ;;
    :) echo "Error: -$OPTARG requires a value." >&2; usage >&2; exit 2 ;;
    \?) echo "Error: unknown option -$OPTARG." >&2; usage >&2; exit 2 ;;
  esac
done
shift $((OPTIND - 1))
if (( $# > 0 )); then echo "Error: unexpected argument: $1" >&2; usage >&2; exit 2; fi
if [[ -z $log_file ]]; then echo "Error: -f LOGFILE is required." >&2; usage >&2; exit 2; fi
if [[ ! -f $log_file || ! -r $log_file ]]; then echo "Error: cannot read input file: $log_file" >&2; exit 1; fi
case "$level" in
  all) pattern='ERROR|WARNING|FAILED' ;;
  error) pattern='ERROR' ;;
  warning) pattern='WARNING' ;;
  failed) pattern='FAILED' ;;
  *) echo "Error: invalid level '$level' (choose all, error, warning, failed)." >&2; exit 2 ;;
esac
if [[ -n $output ]]; then
  if [[ $output == "$log_file" || ( -e $output && $output -ef $log_file ) ]]; then
    echo "Error: output must differ from input to avoid overwriting the log." >&2; exit 2
  fi
  if [[ -e $output ]]; then echo "Error: output file already exists: $output" >&2; exit 2; fi
fi

# Extended regular expression (-E) and case-insensitive search (-i).
# grep exits with status 1 when no matches occur, which is not an error here.
if ! matches=$(grep -Ei -- "$pattern" "$log_file"); then
  matches=""
fi
if [[ -n $matches ]]; then
  count=$(printf '%s\n' "$matches" | wc -l)
else
  count=0
fi
report=$(printf 'Log: %s\nFilter: %s\nMatching events: %s\n\nMatching lines:\n' "$log_file" "$level" "$count")
if [[ -n $matches ]]; then report+=$'\n'"$matches"; else report+=$'\n'"(none)"; fi
printf '%s\n' "$report"
if [[ -n $output ]]; then
  if ! (umask 077; printf '%s\n' "$report" > "$output"); then
    echo "Error: could not write output file: $output" >&2; exit 1
  fi
  printf 'Report saved to %s\n' "$output"
fi
