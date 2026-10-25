# Fictional Worked Example: Preserving Evidence from a Suspected Compromised Laptop

| | |
|---|---|
| **Author** | Prathmesh Humane (Intern ID 2414) |
| **Organisation** | RedKross Research Foundation, Internship Programme (October 2026 batch) |
| **Companion to** | `docs/evidence-handling-guide.md` and `templates/chain-of-custody-template.md` |

> **Everything in this example is fictional.** The college, people, device, serial numbers, seal numbers and hash values are invented for training. IP addresses come from private and documentation-only ranges (RFC 1918 and RFC 5737). No real device was examined, and no data was collected from any person's device. Hash values are illustrative strings in valid SHA-256 format; they do not correspond to real files.

---

## 1. Scenario

**Meridian College of Applied Computing** (fictional) runs a small IT Security team. At **10:22 IST on Wednesday 14 October 2026**, the college firewall raised an alert: a laptop in Research Lab 2 (`10.20.4.37`) was repeatedly connecting to an external address on a threat-intelligence blocklist (`203.0.113.45`).

The laptop is a college-owned Windows 11 Pro machine used by a research student. The IT Security Officer authorised a response, and a lab assistant was sent as the **first responder**. An external forensic examiner was called in to capture memory and image the disk.

## 2. People involved (all fictional)

| Name | Role in this incident |
|---|---|
| R. Kale | Lab Assistant: first responder; author of the action log |
| A. Desai | IT Security Officer: incident lead; network isolation; evidence store custodian |
| Dr M. Rao | Head of IT: authorised the response |
| S. Iyer | External forensic examiner: memory capture, power-down, imaging |
| N. Shah | Research student: regular user of the laptop |

## 3. Evidence register

| Item | Description | Created or seized | Seal |
|---|---|---|---|
| **E1** | Laptop, Windows 11 Pro, "Fictional Model LX-14", S/N `LX14-DEMO-0007`, asset tag `MCAC-IT-LT-0412` | Seized | S-000316, later S-000341 |
| **E2** | 65 W USB-C charger belonging to E1 | Seized | S-000317 |
| **E3** | 32 GB blue USB flash drive labelled "DEMO", found in E1's left USB-A port | Seized | S-000318 |
| **E4** | Memory image of E1 (`memdump_E1.raw`), on the examiner's sterile drive | Created by examiner | N/A (digital) |
| **E5** | Scene photographs P-01 to P-10 (JPEG), taken on college work phone `MCAC-PH-07` | Created by responder | N/A (digital) |
| **E6** | Forensic disk image of E1 | Created by examiner | N/A (digital) |
| **E7** | PDF scan of R. Kale's notebook pages 1–3 (action log) | Created by responder | Original notebook held by A. Desai |

## 4. Observation and photo log

All times are by the **reference clock** (work phone on network time), IST (UTC+05:30).

| Photo | Time | What it shows |
|---|---|---|
| P-01 | 10:40 | Wide view of Desk 4: laptop open, charger and Ethernet connected, user's bag nearby (not touched) |
| P-02 | 10:40 | Screen: desktop with Outlook open; Word not open |
| P-03 | 10:40 | Left side: Ethernet connected; USB drive (E3) in the USB-A port |
| P-04 | 10:40 | Right side: charger (E2) connected; charging LED on |
| P-05 | 10:40 | Lid sticker showing asset tag `MCAC-IT-LT-0412` (photographed without moving the laptop) |
| P-06 | 10:41 | Laptop clock (10:38) next to the reference phone (10:41) |
| P-07 | 10:46 | Network icon showing "No internet" after network-side isolation |
| P-08 | 10:48 | Close-up of USB drive E3, still inserted |
| P-09 | 12:24 | Underside serial label, photographed after power-off, at the examiner's request |
| P-10 | 12:26 | Sealed bags E1, E2 and E3 with seal numbers visible |

## 5. Power-state decision record

| Question | Answer |
|---|---|
| Power state on arrival | **ON**, unlocked, logged in as N. Shah, on charger |
| Any visible destruction (wiping, encryption in progress, ransom note)? | **No** |
| Encryption | BitLocker **enabled** (per A. Desai). Recovery key held in the college directory service. **Key not recorded.** |
| Decision (guide, Step 3) | **Keep powered. Do not shut down, log out or close the lid. Isolate network-side. Call examiner for memory capture.** |
| Reason | Volatile evidence (running processes, network connections, keys) would be lost at power-off, and BitLocker would lock the disk. No active destruction justified cutting power. |
| Decided by and time | R. Kale, confirmed by A. Desai by phone, 10:43 |

## 6. Contemporaneous action log (transcribed from notebook pages 1–3)

**Clock note:** At 10:41 the laptop clock showed **10:38**, while the reference showed **10:41**. The laptop clock is **3 minutes slow**, so add 3 minutes to any laptop timestamp to get real time. N. Shah's "about 10:15" was read from the laptop clock, so it is about 10:18 real time. That fits the firewall alert at 10:22.

| Time (IST) | Who | Action | Reason | Result / observation |
|---|---|---|---|---|
| 10:31 | R. Kale | Received call from A. Desai about the firewall alert for `10.20.4.37` | Assigned as first responder | Collected kit; left for Lab 2 |
| 10:38 | R. Kale | Arrived at Lab 2, Desk 4. Asked N. Shah to step away and not touch the laptop. | Secure the scene | User complied. "Restricted" sign placed on lab door. |
| 10:39 | R. Kale | Recorded user statement (**reported, not verified**) | Capture actions taken before arrival | N. Shah: opened email attachment `Scholarship_Form.docm` at about 10:15 (laptop clock); a blue window flashed; closed Word at about 10:20. Did nothing else. |
| 10:40 | R. Kale | Photos P-01 to P-05 | Record before touching | See photo log |
| 10:41 | R. Kale | Clock comparison, photo P-06 | Timeline alignment | Laptop 3 min slow |
| 10:42 | R. Kale | Assessed power state **without contact** | Guide Step 3 | ON, unlocked, no visible destruction |
| 10:43 | R. Kale | Phoned A. Desai with power decision and encryption query | Specialist confirmation | Decision confirmed. BitLocker on; key location noted; key not written. |
| 10:45 | A. Desai (remote) | Disabled the switch port serving Desk 4 | Network isolation without touching the laptop | Reported by phone |
| 10:46 | R. Kale | Observed network icon, photo P-07 | Confirm isolation | "No internet". Ethernet cable left in place. Wi-Fi already off (icon); not touched. |
| ~~10:84~~ 10:48 *(RK, 10:49)* | R. Kale | Noted USB drive E3 in left port, photo P-08 | Minimise handling | **Left in place** for the examiner |
| 10:55 | R. Kale | Laptop locked automatically (idle timeout) | — | **Not touched.** Lock screen visible; laptop still powered. |
| 11:05 | R. Kale | Remained with laptop; no further contact | Preserve scene | — |
| 11:40 | R. Kale | Examiner S. Iyer arrived; briefed from notes and photos | Hand-over | — |
| 11:42 | R. Kale → S. Iyer | Custody transfer of E1, E2, E3 (in place, powered on) | Memory capture and power-down | Logged on CoC forms; A. Desai witnessed |
| 11:48 | S. Iyer | Asked N. Shah to unlock the laptop with their own password, witnessed by A. Desai | Required for memory capture under authorisation | Unlock recorded as a **change to system state** |
| 11:50–12:14 | S. Iyer | Memory capture to the examiner's sterile external drive | Preserve volatile data | E4 created; SHA-256 recorded (Section 7) |
| 12:18 | S. Iyer | **Forced power-off** (held power button) | Avoid "Shut down", which writes to disk | Laptop off at 12:18 |
| 12:20 | S. Iyer | Removed E3, bagged, seal S-000318 | Protect original | — |
| 12:24 | S. Iyer | Photo P-09 of underside serial label | Record identifier | S/N `LX14-DEMO-0007` |
| 12:25 | S. Iyer | E1 in anti-static bag, seal S-000316; E2 seal S-000317; photo P-10 | Protect original | Signed across seals |
| 12:30 | S. Iyer → A. Desai | Transfer of E1, E2, E3 to IT Security locker L-3 | Secure storage pending imaging | Seals intact |
| 13:05 | R. Kale | Copied P-01 to P-10 from phone to the restricted evidence share; created SHA-256 manifest | Integrity of responder-created files | E5 manifest hash recorded |
| 13:20 | R. Kale | Scanned notebook pages 1–3 to PDF; hashed it | Preserve the log | E7 hash recorded. Original notebook given to A. Desai at 13:25. |

*The 10:48 entry shows the correction rule: the wrong time was struck through with a single line, initialled and timed. It was not erased.*

## 7. Hash record (SHA-256)

| Item | What was hashed | SHA-256 (illustrative) | By | Date / time (IST) |
|---|---|---|---|---|
| E4 | `memdump_E1.raw` | `5664605743e29305853e00f40f940df3eae3d7f56a76dc1341fd2c5ad3abfd3b` | S. Iyer | 2026-10-14 12:15 |
| E5 | `E5_photos_manifest.sha256` (lists each photo's hash) | `385d2805620faaee64b1a767c1ae8351f6881a01743c65a76c2b592c8bd9dd02` | R. Kale | 2026-10-14 13:05 |
| E7 | `E7_action_log_scan.pdf` | `5267840f9abc604c327bbfb0260619e245cdc658f19e1fee7ec71d31011ba822` | R. Kale | 2026-10-14 13:20 |
| E6 | Disk image of E1 (at acquisition) | `9ba11bd5ffc4816352da6ade8c9cb9bafdeba47ecdb2ba72d097774a3fc7611e` | S. Iyer | 2026-10-15 11:02 |
| E6 | Working copy, verification | `9ba11bd5ffc4816352da6ade8c9cb9bafdeba47ecdb2ba72d097774a3fc7611e` (**match**) | S. Iyer | 2026-10-15 12:30 |

No hashing tool was ever run **on E1 while it was live**. E1's disk was hashed only as part of imaging (E6), by the examiner, through a write blocker. A printed copy of this table is held by A. Desai, separately from the digital files.

## 8. Completed chain-of-custody form: item E1

### A. Case information

| Field | Entry |
|---|---|
| Case / incident reference | MCAC-IR-2026-017 |
| Organisation / department | Meridian College of Applied Computing (fictional), Dept. of IT, Research Lab 2 |
| Incident lead | A. Desai, IT Security Officer, ext. 4410 |
| Authorised by | Dr M. Rao, Head of IT |
| Date and time authorised | 2026-10-14 10:30 IST (UTC+05:30) |

### B. Evidence item description

| Field | Entry |
|---|---|
| Evidence item number | E1 |
| Item type and description | Laptop computer, Windows 11 Pro |
| Make / model | Fictional Model LX-14 |
| Serial number | LX14-DEMO-0007 (underside label, photo P-09) |
| Asset tag / other identifiers | MCAC-IT-LT-0412 (lid sticker, photo P-05) |
| Colour, condition, visible damage | Grey; minor scratch on lid; no other damage |
| Accessories packaged with item | None (charger is a separate item, E2) |
| Power state when found | ON, unlocked, on charger |
| Power state when packaged | OFF: forced power-off by S. Iyer at 12:18 IST |
| Encryption status and recovery-key location | BitLocker enabled (per A. Desai). Key held in college directory service. Key not recorded. |
| Bag / seal number(s) | S-000316 (14 Oct); S-000341 (15 Oct, after imaging) |

### C. Collection

| Field | Entry |
|---|---|
| Collected by | R. Kale, Lab Assistant |
| Signature | *R. Kale (signed)* |
| Date and time collected | 2026-10-14 10:38 IST: control taken in place; not moved |
| Location collected | Research Lab 2, Desk 4 |
| Photograph references | P-01 to P-10 (E5) |
| Notes | User reported opening an attachment and closing Word before arrival. Auto-locked 10:55; unlocked by user at 11:48 at examiner's request, witnessed by A. Desai. |

### D. Transfer log

| # | Date and time (TZ) | Released by | Received by | Purpose | Seal no., intact? | Hash verified? | Location after transfer |
|---|---|---|---|---|---|---|---|
| 1 | 2026-10-14 11:42 IST | R. Kale *(signed)* | S. Iyer *(signed)* | Memory capture and power-down | N/A (powered on, not yet bagged) | N/A | Research Lab 2, Desk 4 |
| 2 | 2026-10-14 12:30 IST | S. Iyer *(signed)* | A. Desai *(signed)* | Secure storage pending imaging | S-000316, Y | N/A | IT Security locker L-3 |
| 3 | 2026-10-15 09:30 IST | A. Desai *(signed)* | S. Iyer *(signed)* | Disk imaging | S-000316, Y (broken by S. Iyer at 09:45 to image; documented) | N/A | IT Security forensic workroom |
| 4 | 2026-10-15 16:10 IST | S. Iyer *(signed)* | A. Desai *(signed)* | Return after imaging | S-000341 (new), Y | Y (E6 verified 12:30) | IT Security locker L-3 |

### E. Hash record

| # | Item / file hashed | Algorithm | Hash value | Computed by | Date and time (TZ) | Tool and version |
|---|---|---|---|---|---|---|
| 1 | E4 memory image of E1 | SHA-256 | 5664…bfd3b (full value in Section 7) | S. Iyer | 2026-10-14 12:15 IST | Examiner's validated toolset (version in examiner notes) |
| 2 | E6 disk image of E1, acquisition | SHA-256 | 9ba1…7611e | S. Iyer | 2026-10-15 11:02 IST | As above |
| 3 | E6 working copy, verification | SHA-256 | 9ba1…7611e (match) | S. Iyer | 2026-10-15 12:30 IST | As above |
| 4 | N/A | | | | | |

### F. Final disposition

| Field | Entry |
|---|---|
| Outcome | Retained pending investigation outcome (status as of 2026-10-15) |
| Details | To be completed at case closure |
| Authorised by | Pending |
| Witness | Pending |
| Date and time | Pending |

## 9. First responder's hand-over summary (R. Kale)

> At 10:38 IST on 14 October 2026 I took control of college laptop MCAC-IT-LT-0412 at Research Lab 2, Desk 4, following a firewall alert. It was on and unlocked, with no visible destruction. The user reported opening an email attachment and closing Word before I arrived. I photographed the scene before touching anything and recorded that the laptop clock was 3 minutes slow. I did not touch the keyboard, mouse, lid or ports. Network isolation was done at the switch by A. Desai. The USB drive was left in place. I handed the powered-on laptop to examiner S. Iyer at 11:42. I did not run any program on the laptop, open any file, or copy anything from it. My photographs and notebook scan are hashed (E5, E7).

## 10. How this example follows the guide

| Guide step | What happened here | Where to see it |
|---|---|---|
| 1. Secure the scene | User moved away; reported actions recorded separately | Log 10:38–10:39 |
| 2. Observe and record | Ten numbered photos; clock offset measured | Sections 4 and 6 |
| 3. Decide power state | ON, no destruction, so kept powered; reason recorded | Section 5 |
| 4. Isolate network | Network-side (switch port), no contact with laptop | Log 10:45–10:46 |
| 5. Document time and actions | Contemporaneous log with time zone and a proper correction | Section 6 |
| 6. Protect original | Bagged and sealed after power-off; locker storage | Log 12:20–12:30 |
| 7. Hash where appropriate | SHA-256 for images and responder-created files; none on live E1 | Section 7 |
| 8. Chain of custody | Four signed transfers; seal break and reseal documented | Section 8 |
| 9. Hand over and report | Written summary of what was and was not done | Section 9 |

**What would have gone wrong with common mistakes:**

- **"Shut down" from the Start menu:** memory evidence (E4) lost, BitLocker locks the disk, and Fast Startup writes hibernation data to disk.
- **Pulling out the USB drive to "check it" on another PC:** that PC could change the drive's contents or be infected itself. The drive's original position would also be undocumented.
- **Letting the user "show" what happened:** new activity overwrites the very evidence that shows how the compromise began.
- **No clock offset:** every laptop timestamp would be 3 minutes out of line with firewall logs, which weakens the timeline.
