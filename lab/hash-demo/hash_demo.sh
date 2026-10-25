#!/usr/bin/env bash
# =============================================================================
# hash_demo.sh: Safe SHA-256 integrity demonstration on FICTIONAL dummy files
#
# Project : Digital Forensics Basics, evidence-preservation workflow
# Author  : Prathmesh Humane (Intern ID 2414), RedKross Research Foundation
# Version : 1.0 (October 2026)
#
# What it shows (see README.md in this folder):
#   1. The same content gives the same SHA-256 on any machine (reproducibility).
#   2. Read-only permissions protect the "original" from accidental change.
#   3. A working copy can be verified as identical to the original.
#   4. Changing only a file's timestamp does NOT change its hash.
#   5. Changing a single character IS detected by the hash.
#   6. Your own action log can be hashed at the end to "seal" it.
#
# Safety: the script creates and works ONLY inside its own new output folder.
# It reads no personal data, touches no other files, needs no network access
# and no administrator rights. All "evidence" files are invented.
#
# Works on macOS (bash 3.2 + shasum) and Linux (sha256sum or shasum).
# =============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PAUSE=1
OUT_BASE="${SCRIPT_DIR}/../../results"
OUT_DISPLAY="results"   # path shown on screen (avoids printing your home folder)
EXAMINER="${EXAMINER:-Intern 2414}"

usage() {
  cat <<'EOF'
Usage: ./hash_demo.sh [--no-pause] [--out DIR]

  --no-pause   Run all steps without waiting for Enter between them.
  --out DIR    Parent folder for the run output (default: <repo>/results).

Set EXAMINER="Your Name" to change the name written in the action log.
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    --no-pause) PAUSE=0 ;;
    --out) shift; OUT_BASE="${1:?--out needs a folder}"; OUT_DISPLAY="$OUT_BASE" ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage; exit 2 ;;
  esac
  shift
done

# --- Choose a SHA-256 tool ---------------------------------------------------
if command -v sha256sum >/dev/null 2>&1; then
  HASH_TOOL="sha256sum"
  hash_cmd()  { sha256sum "$@"; }
  check_cmd() { sha256sum -c "$@"; }
elif command -v shasum >/dev/null 2>&1; then
  HASH_TOOL="shasum -a 256"
  hash_cmd()  { shasum -a 256 "$@"; }
  check_cmd() { shasum -a 256 -c "$@"; }
else
  echo "ERROR: neither sha256sum nor shasum was found." >&2
  exit 1
fi

# --- Output folders ----------------------------------------------------------
RUN_ID="$(date -u +%Y%m%dT%H%M%SZ)"
mkdir -p "$OUT_BASE"
CASE_DIR="$(cd "$OUT_BASE" && pwd)/hash-demo-run-${RUN_ID}"
mkdir -p "$CASE_DIR/original" "$CASE_DIR/working" "$CASE_DIR/hashes" "$CASE_DIR/logs"
SHOW_DIR="${OUT_DISPLAY}/hash-demo-run-${RUN_ID}"
LOG="$CASE_DIR/logs/action_log.txt"
TRANSCRIPT="$CASE_DIR/logs/terminal_transcript.txt"

# Mirror everything printed on screen into a transcript file.
exec > >(tee -a "$TRANSCRIPT") 2>&1

# --- Helpers -----------------------------------------------------------------
ts_utc()   { date -u +%Y-%m-%dT%H:%M:%SZ; }
ts_local() { date +"%Y-%m-%d %H:%M:%S %Z (UTC%z)"; }

log() { # log "action" "reason" "result"
  printf '%s | %s | %s | ACTION: %s | REASON: %s | RESULT: %s\n' \
    "$(ts_utc)" "$(ts_local)" "$EXAMINER" "$1" "$2" "$3" >> "$LOG"
}

step() {
  printf '\n=====================================================================\n'
  printf ' STEP %s: %s\n' "$1" "$2"
  printf '=====================================================================\n'
}

pause() {
  if [ "$PAUSE" -eq 1 ] && [ -t 0 ]; then
    printf '\n--- Take a screenshot now if you need one. Press Enter to continue. ---'
    read -r _
  fi
}

file_hash() { hash_cmd "$1" | awk '{print $1}'; }

# Result tracking (plain variables for bash 3.2 compatibility)
R_REPRO="NOT RUN"; R_PROTECT="NOT RUN"; R_COPY="NOT RUN"; R_META="NOT RUN"; R_TAMPER="NOT RUN"

# =============================================================================
step 0 "Record the environment"
printf 'Run ID              : %s\n' "$RUN_ID"
printf 'Examiner (log name) : %s\n' "$EXAMINER"
printf 'Started (UTC)       : %s\n' "$(ts_utc)"
printf 'Started (local)     : %s\n' "$(ts_local)"
printf 'Operating system    : %s %s\n' "$(uname -s)" "$(uname -r)"
printf 'Bash version        : %s\n' "$BASH_VERSION"
printf 'Hash tool           : %s\n' "$HASH_TOOL"
printf 'Output folder       : %s\n' "$SHOW_DIR"
log "Started hash demo run $RUN_ID" "Record environment for reproducibility" "OS=$(uname -s) tool=$HASH_TOOL"
pause

# =============================================================================
step 1 "Create FICTIONAL evidence files in original/"
# Contents are fixed so every machine produces the same hashes.
printf '%s\n' \
  'Return-Path: <notices@scholarship-portal.example>' \
  'From: "Scholarship Office" <notices@scholarship-portal.example>' \
  'To: student@college.example' \
  'Subject: Action required: Scholarship_Form.docm' \
  'Date: Wed, 14 Oct 2026 10:12:05 +0530' \
  'Received: from mail.scholarship-portal.example (203.0.113.45)' \
  'X-Note: FICTIONAL SAMPLE FOR TRAINING. NOT A REAL MESSAGE.' \
  > "$CASE_DIR/original/email_header_sample.txt"

printf '%s\n' \
  '2026-10-14T04:52:11Z ALERT outbound src=10.20.4.37 dst=203.0.113.45 dport=443 rule=blocklist' \
  '2026-10-14T04:53:11Z ALERT outbound src=10.20.4.37 dst=203.0.113.45 dport=443 rule=blocklist' \
  '2026-10-14T04:54:12Z ALERT outbound src=10.20.4.37 dst=203.0.113.45 dport=443 rule=blocklist' \
  '# FICTIONAL SAMPLE FOR TRAINING. Addresses are from RFC 1918 / RFC 5737 ranges.' \
  > "$CASE_DIR/original/firewall_alert_sample.log"

printf '%s\n' \
  'Responder notes (FICTIONAL)' \
  '10:38 IST Arrived. Laptop ON, unlocked. User asked to step away.' \
  '10:41 IST Laptop clock 10:38, reference 10:41: laptop 3 min slow.' \
  '10:45 IST Network isolated at switch port by incident lead.' \
  > "$CASE_DIR/original/responder_notes.txt"

( cd "$CASE_DIR/original" && ls -lg )
log "Created 3 fictional files in original/" "Provide safe test data" "email_header_sample.txt, firewall_alert_sample.log, responder_notes.txt"
pause

# =============================================================================
step 2 "Hash the originals (SHA-256) and check reproducibility"
( cd "$CASE_DIR/original" && hash_cmd email_header_sample.txt firewall_alert_sample.log responder_notes.txt ) \
  > "$CASE_DIR/hashes/original_manifest.sha256"
cat "$CASE_DIR/hashes/original_manifest.sha256"
log "Hashed originals into hashes/original_manifest.sha256" "Create integrity baseline" "3 hashes recorded"

EXPECTED="$SCRIPT_DIR/expected-hashes.sha256"
if [ -f "$EXPECTED" ]; then
  printf '\nComparing with the reference hashes in expected-hashes.sha256 ...\n'
  if ( cd "$CASE_DIR/original" && check_cmd "$EXPECTED" ); then
    R_REPRO="MATCH"
    printf '\nRESULT: Your hashes match the reference values. The same content gives the same hash on any machine.\n'
  else
    R_REPRO="MISMATCH"
    printf '\nRESULT: Hashes differ from the reference. Check that the script file was not edited.\n'
  fi
else
  R_REPRO="SKIPPED (expected-hashes.sha256 not found)"
fi
log "Compared baseline with reference hashes" "Show reproducibility (independent party gets same result)" "$R_REPRO"
pause

# =============================================================================
step 3 "Protect the originals (make them read-only)"
chmod -R a-w "$CASE_DIR/original"
( cd "$CASE_DIR/original" && ls -lg )
if [ "$(id -u)" -eq 0 ]; then
  R_PROTECT="SKIPPED (running as root: permissions do not stop root)"
  printf '\nNOTE: You are running as root/administrator, which ignores file permissions.\n'
  printf 'Write test skipped so the original is not changed. Run as a normal user to see it.\n'
else
  printf '\nTrying to append text to an original file (this SHOULD fail) ...\n'
  if ( printf 'tamper\n' >> "$CASE_DIR/original/responder_notes.txt" ) 2>/dev/null; then
    R_PROTECT="NOT PROTECTED (write succeeded)"
    printf 'RESULT: Write succeeded. The file was NOT protected.\n'
  else
    R_PROTECT="PROTECTED (write blocked)"
    printf 'RESULT: Permission denied. The original is protected from accidental change.\n'
  fi
fi
log "Set original/ read-only and attempted a write" "Protect original evidence" "$R_PROTECT"
pause

# =============================================================================
step 4 "Make a working copy and verify it against the original manifest"
cp -p "$CASE_DIR/original/"* "$CASE_DIR/working/"
chmod -R u+w "$CASE_DIR/working"
if ( cd "$CASE_DIR/working" && check_cmd ../hashes/original_manifest.sha256 ); then
  R_COPY="VERIFIED (all 3 files match)"
  printf '\nRESULT: The working copy is identical to the original. Analysis can use the copy.\n'
else
  R_COPY="MISMATCH"
  printf '\nRESULT: The copy does not match.\n'
fi
log "Copied originals to working/ and verified" "Work on verified copies only" "$R_COPY"
pause

# =============================================================================
step 5 "Change ONLY a timestamp on the working copy, then re-check"
F="$CASE_DIR/working/responder_notes.txt"
printf 'Before: '; ( cd "$CASE_DIR/working" && ls -lg responder_notes.txt )
H_BEFORE="$(file_hash "$F")"
touch -t 202001011200 "$F"   # set modified time to 2020-01-01 12:00
printf 'After : '; ( cd "$CASE_DIR/working" && ls -lg responder_notes.txt )
H_AFTER="$(file_hash "$F")"
printf '\nSHA-256 before: %s\nSHA-256 after : %s\n' "$H_BEFORE" "$H_AFTER"
if [ "$H_BEFORE" = "$H_AFTER" ]; then
  R_META="HASH UNCHANGED (timestamp changed, content did not)"
  printf '\nRESULT: Same hash. A file hash covers CONTENT, not file-system timestamps,\n'
  printf 'so timestamps must be preserved by imaging and documentation.\n'
else
  R_META="HASH CHANGED"
  printf '\nRESULT: Hash changed (unexpected).\n'
fi
log "Changed modified-time of working/responder_notes.txt to 2020-01-01 12:00" "Test whether hashes cover metadata" "$R_META"
pause

# =============================================================================
step 6 "Change ONE character in the working copy, then re-check"
F="$CASE_DIR/working/firewall_alert_sample.log"
H_BEFORE="$(file_hash "$F")"
# Change the first 203.0.113.45 to 203.0.113.46 (one character). Portable: no 'sed -i'.
awk 'BEGIN{done=0} { if(!done && sub(/203\.0\.113\.45/,"203.0.113.46")) done=1; print }' "$F" > "$F.tmp" && mv "$F.tmp" "$F"
H_AFTER="$(file_hash "$F")"
printf 'Line 1 now reads: %s\n' "$(head -n 1 "$F")"
printf '\nSHA-256 before: %s\nSHA-256 after : %s\n\n' "$H_BEFORE" "$H_AFTER"
set +e
( cd "$CASE_DIR/working" && check_cmd ../hashes/original_manifest.sha256 )
CHECK_RC=$?
set -e
if [ "$CHECK_RC" -ne 0 ] && [ "$H_BEFORE" != "$H_AFTER" ]; then
  R_TAMPER="DETECTED (verification FAILED for the changed file)"
  printf '\nRESULT: A one-character change produced a completely different hash and was detected.\n'
else
  R_TAMPER="NOT DETECTED"
  printf '\nRESULT: Change was not detected (unexpected).\n'
fi
log "Changed one character in working/firewall_alert_sample.log and re-verified" "Test tamper detection" "$R_TAMPER"
pause

# =============================================================================
step 7 "Write the summary and seal the action log"
SUMMARY="$CASE_DIR/logs/summary.txt"
{
  printf 'HASH DEMO SUMMARY: run %s\n' "$RUN_ID"
  printf 'Examiner: %s | OS: %s %s | Tool: %s | Finished (UTC): %s\n\n' "$EXAMINER" "$(uname -s)" "$(uname -r)" "$HASH_TOOL" "$(ts_utc)"
  printf '%-4s %-38s %-26s %s\n' "Test" "What was tested" "Expected" "Observed"
  printf '%-4s %-38s %-26s %s\n' "T1" "Reproducibility vs reference hashes" "MATCH" "$R_REPRO"
  printf '%-4s %-38s %-26s %s\n' "T2" "Read-only original blocks writes" "PROTECTED" "$R_PROTECT"
  printf '%-4s %-38s %-26s %s\n' "T3" "Working copy verifies against original" "VERIFIED" "$R_COPY"
  printf '%-4s %-38s %-26s %s\n' "T4" "Timestamp-only change" "HASH UNCHANGED" "$R_META"
  printf '%-4s %-38s %-26s %s\n' "T5" "One-character content change" "DETECTED" "$R_TAMPER"
} > "$SUMMARY"
cat "$SUMMARY"
log "Wrote logs/summary.txt" "Record results" "Summary written"
log "Sealed action log (hash written to hashes/action_log.sha256)" "Protect own documentation" "Final entry before sealing"
( cd "$CASE_DIR/logs" && hash_cmd action_log.txt ) > "$CASE_DIR/hashes/action_log.sha256"
printf '\nAction log sealed. SHA-256 of logs/action_log.txt:\n'
cat "$CASE_DIR/hashes/action_log.sha256"

printf '\nDone. All output is in:\n  %s\n' "$SHOW_DIR"
printf '\nTo verify the sealed log later (from the repository root):\n  cd "%s/logs" && %s -c ../hashes/action_log.sha256\n' "$SHOW_DIR" "$HASH_TOOL"
printf '\nTo delete this run later (originals are read-only), from the repository root:\n  chmod -R u+w "%s" && rm -rf "%s"\n' "$SHOW_DIR" "$SHOW_DIR"
