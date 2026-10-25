# Chain-of-Custody Form: Digital Evidence

**Form ID:** ____________ **Page** ___ **of** ___

> **How to complete this form**
>
> - Use **one form per evidence item**.
> - Write in **ink**. Leave no field blank: write **N/A** if a field does not apply.
> - Correct mistakes with a **single line** through the error, then add your initials and the time. Never erase or use correction fluid.
> - Write every time with its **time zone**, for example `2026-10-14 10:42 IST (UTC+05:30)`.
> - **Never** write passwords or encryption recovery keys on this form. Record only *where* they are held.
>
> An editable version is in `chain-of-custody-template.docx`.

---

## A. Case information

| Field | Entry |
|---|---|
| Case / incident reference | |
| Organisation / department | |
| Incident lead (name, role, contact) | |
| Authorised by (name, role) | |
| Date and time authorised (with time zone) | |

## B. Evidence item description

| Field | Entry |
|---|---|
| Evidence item number (e.g. E1) | |
| Item type and description | |
| Make / model | |
| Serial number | |
| Asset tag / other identifiers | |
| Colour, condition, visible damage | |
| Accessories packaged with item | |
| Power state when found (on / off / sleep) | |
| Power state when packaged | |
| Encryption status (as reported) and **location** of recovery key | |
| Bag / seal number(s) | |

## C. Collection

| Field | Entry |
|---|---|
| Collected by (name, role) | |
| Signature | |
| Date and time collected (with time zone) | |
| Location collected (building, room, desk) | |
| Photograph references | |
| Notes (e.g. reported user actions, deviations) | |

## D. Transfer log

*Record every hand-off. If the seal is broken (e.g. for imaging), record who broke it, when and why, and the new seal number.*

| # | Date and time (TZ) | Released by (name and signature) | Received by (name and signature) | Purpose of transfer | Seal no., intact? (Y/N) | Hash verified? (Y/N/N/A) | Location after transfer |
|---|---|---|---|---|---|---|---|
| 1 | | | | | | | |
| 2 | | | | | | | |
| 3 | | | | | | | |
| 4 | | | | | | | |
| 5 | | | | | | | |
| 6 | | | | | | | |
| 7 | | | | | | | |
| 8 | | | | | | | |
| 9 | | | | | | | |
| 10 | | | | | | | |

## E. Hash record

*Use SHA-256. Record MD5 or SHA-1 only in addition, if a tool requires it. Never run hashing tools on a live suspect device.*

| # | Item / file hashed | Algorithm | Hash value | Computed by | Date and time (TZ) | Tool and version |
|---|---|---|---|---|---|---|
| 1 | | | | | | |
| 2 | | | | | | |
| 3 | | | | | | |
| 4 | | | | | | |
| 5 | | | | | | |

## F. Final disposition

| Field | Entry |
|---|---|
| Outcome (Returned to owner / Retained / Sanitised and disposed / Other) | |
| Details (e.g. returned to whom, sanitisation method) | |
| Authorised by (name, role, signature) | |
| Witness (name, signature) | |
| Date and time (with time zone) | |
