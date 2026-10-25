# Hash Demo: Proving Integrity with SHA-256 (macOS / Linux)

This lab shows **why** the guide asks for hashes and what they can and cannot prove. It runs entirely on **invented files** that the script creates itself.

> **Safety:** The script works only inside a new folder it creates under `results/`. It reads no personal data, changes no other files, needs no internet and no administrator rights. Do **not** point it at real evidence or at anyone else's device.

## Requirements

- macOS (any recent version; uses the built-in `shasum`) **or** Linux (uses `sha256sum`, or `shasum` if that is missing)
- A terminal. No installation needed.

## How to run

From the repository root:

```bash
cd lab/hash-demo
chmod +x hash_demo.sh          # only needed once
EXAMINER="Prathmesh Humane" ./hash_demo.sh
```

The script pauses after each step so you can take a screenshot. Add `--no-pause` to run straight through.

**Run it as your normal user, not with `sudo`.** Root ignores file permissions, so Test T2 would be skipped.

## What each step does

| Step | What happens | Test | Expected result |
|---|---|---|---|
| 0 | Records date/time (UTC and local), OS, bash version and hash tool | — | — |
| 1 | Creates 3 fictional "evidence" files in `original/` | — | — |
| 2 | Hashes them and compares with `expected-hashes.sha256` | **T1** Reproducibility | `MATCH`: the same content gives the same hash on any computer |
| 3 | Makes `original/` read-only and tries to write to it | **T2** Protection | `PROTECTED`: "Permission denied" |
| 4 | Copies to `working/` and verifies against the original manifest | **T3** Verified copy | `VERIFIED`: all 3 files OK |
| 5 | Changes only the *timestamp* of one working file | **T4** Metadata | `HASH UNCHANGED`: hashes cover content, not timestamps |
| 6 | Changes *one character* (`.45` → `.46`) in one working file | **T5** Tampering | `DETECTED`: verification FAILED for that file |
| 7 | Writes a summary and hashes the action log to "seal" it | — | Hash of `action_log.txt` printed |

## Reference hashes

`expected-hashes.sha256` holds the SHA-256 values of the three fictional files. Because the script writes the files byte-for-byte the same on every machine, your Step 2 values should match these:

```text
0ed594d479bbd324e67db56e71ec01a31914523820d2dcf00eb7dde46268d9ae  email_header_sample.txt
31a45b0a4a632f156dc366069c4c68e4905cf19d227c357b7e9b10051fc34729  firewall_alert_sample.log
a7fd7d1a1363f1ff5225d47c8985a35cf85792b25b7a0155582ebe82284fe996  responder_notes.txt
```

This mirrors ACPO Principle 3: an independent person should be able to repeat the process and get the same result.

## Output

Each run creates `results/hash-demo-run-<UTC timestamp>/`:

```text
hash-demo-run-20261021T101500Z/
├── original/                 # fictional files, read-only
├── working/                  # verified copy, then deliberately modified
├── hashes/
│   ├── original_manifest.sha256
│   └── action_log.sha256     # seal for the action log
└── logs/
    ├── action_log.txt        # timestamped who/what/why/result entries
    ├── summary.txt           # T1–T5 expected vs observed
    └── terminal_transcript.txt
```

The script prints paths relative to the repository, so your home-folder name does not appear in the transcript.

## Screenshots to take (save in `results/screenshots/`)

| File name | Capture at |
|---|---|
| `01-environment.png` | Step 0 |
| `02-reference-match.png` | Step 2 (shows `OK` × 3 and the MATCH message) |
| `03-readonly-protected.png` | Step 3 |
| `04-copy-verified.png` | Step 4 |
| `05-timestamp-same-hash.png` | Step 5 (before/after timestamp and identical hashes) |
| `06-tamper-detected.png` | Step 6 (`FAILED` line and the two different hashes) |
| `07-summary-sealed-log.png` | Step 7 |

## Cleaning up

The originals are read-only, so restore write permission before deleting a run:

```bash
chmod -R u+w results/hash-demo-run-<id> && rm -rf results/hash-demo-run-<id>
```

## Limitations

- This demonstrates **file-level** hashing on small text files. Real investigations hash whole forensic images, created through a write blocker.
- `chmod` read-only is a teaching stand-in for real write protection (hardware write blockers, write-once media). It does not stop an administrator.
- Results describe *this* demo only. They are not a test of any forensic tool.
