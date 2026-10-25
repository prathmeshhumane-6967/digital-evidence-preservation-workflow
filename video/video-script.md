# Explanatory Video: Script and Shot List

**Target length:** 7–8 minutes · **Format:** screen recording with voice-over · **Upload:** YouTube (Unlisted) or Google Drive (anyone with the link can view)

The slide deck that goes with this script is a separate Slides artifact (download it as PDF or PowerPoint to present from). Speak naturally. The lines below are a guide, not something to read word-for-word. Rehearse the demo once before recording, then delete that rehearsal's `results/hash-demo-run-…` folder if you don't want it in the repo.

---

## 0:00–0:30 · Introduction
**On screen:** Slide 1 (title)

> Hi, I'm Prathmesh Humane, intern ID 2414, from the RedKross Research Foundation October batch. My task was Digital Forensics Basics: to write a safe evidence-preservation workflow for a hypothetical compromised laptop. In this video I'll explain why this matters, the workflow I designed, the chain-of-custody template and the fictional worked example, and then I'll run a live hashing demo.

## 0:30–1:30 · The task and why it matters
**On screen:** Slides 2–3

> The task asked me to cover six things: recording observations, minimising handling, documenting time and actions, protecting the original evidence, using hashes where appropriate, and chain of custody.
>
> Why does this matter? Digital evidence is fragile. On a running laptop, just opening a folder changes access times. Choosing "Shut down" in Windows writes data to disk, and everything in memory, like running malware, network connections and encryption keys, disappears when the power goes off. The first person on the scene is usually not a forensic expert. So the most valuable thing they can do is *not* destroy evidence, and write down everything they do.
>
> There's also a legal angle in India. Under Section 63 of the Bharatiya Sakshya Adhiniyam, electronic evidence needs a certificate that includes its hash value.

## 1:30–4:00 · The workflow
**On screen:** Slide 4 (ground rules), Slide 5 (nine steps), Slide 6 (power-state decision), Slide 7 (hashing). Optionally scroll through `docs/evidence-handling-guide.pdf`.

> The guide is built on five ground rules: don't make it worse, record before you touch, touch as little as possible, protect the original, and account for every hand-off.
>
> The workflow has nine steps. First, secure the scene: keep people away, including the user, and record what they say they already did as *reported* actions. Second, observe and record: photograph the screen, ports and labels before touching anything, and compare the laptop's clock with a reliable clock.
>
> Step three is the most important decision: the power state. If the laptop is off, leave it off. If it's on, don't shut it down, don't log out and don't close the lid. Keep it on its charger and call a specialist, because memory holds evidence. With BitLocker turned on, switching off can also lock the disk. The only exception is when data is visibly being destroyed. Then you isolate it and cut the power, and you log exactly why.
>
> Step four is network isolation, ideally at the switch or Wi-Fi access point so you don't touch the laptop at all. Step five runs throughout: a contemporaneous action log with time zone, who, what, why and the result. Mistakes are struck through with one line and initialled, never erased.
>
> Steps six to nine: package and seal the original, use hashes where appropriate, keep the chain of custody, and hand over with a written summary.
>
> On hashing, "where appropriate" matters. You hash forensic images and files you create, like your photos. You never run hashing tools on the live suspect laptop, because running any program changes it.

## 4:00–5:00 · Template and worked example
**On screen:** Slide 8, open `templates/chain-of-custody-template.pdf`, then Slide 9 and scroll `docs/worked-example-fictional.pdf` (action log, then completed custody form)

> This is the blank chain-of-custody form: one per evidence item, with case details, item description, collection, a transfer log, a hash record, and final disposition.
>
> The worked example is completely fictional: a college laptop beaconing to a blocklisted address. You can see the responder noted that the laptop clock was three minutes slow, and that they didn't touch the laptop. The network was cut at the switch, and the USB drive was left in place for the examiner. There's a deliberate correction in the log to show the right way to fix a mistake. The custody form shows four signed transfers, including the seal being broken for imaging and resealed with a new number.

## 5:00–6:45 · Live demo: hashing
**On screen:** Slide 10, then the terminal. Run:

```bash
cd lab/hash-demo
EXAMINER="Prathmesh Humane" ./hash_demo.sh
```

Narrate each step as it pauses:

> **Step 1–2:** The script creates three fictional files and hashes them with SHA-256. These match the reference hashes in the repo exactly. Anyone, on any machine, gets the same result. That's ACPO's third principle: repeatable.
>
> **Step 3:** I make the originals read-only and try to write to one. Permission denied. In real cases this is done with a hardware write blocker.
>
> **Step 4:** I make a working copy and verify it against the original hashes. All OK, so analysis can happen on the copy.
>
> **Step 5:** Now I change *only the timestamp* of a file. The hash is identical. That's an important finding: a hash proves the content, not the file's metadata. That's why the guide insists on documentation and full-disk imaging.
>
> **Step 6:** Now I change one single character, `.45` to `.46`. Completely different hash, and verification says FAILED. Even a one-character change is caught.
>
> **Step 7:** Finally the script writes a summary and hashes its own action log to "seal" it, the same idea as hashing your notes in a real case.

## 6:45–7:30 · Findings, limitations, recommendations
**On screen:** Slides 11–12

> My key findings: the power-state decision matters more than any other first-responder action; encryption makes keeping the laptop powered more important; and hashes prove content but not context.
>
> Limitations: the workflow hasn't been reviewed by a certified examiner or tested in a real exercise, the scenario is fictional, and the demo covers file-level hashing only.
>
> I'd recommend a tabletop exercise with IT staff, review by a qualified examiner, and making sure BitLocker recovery keys are stored centrally.

## 7:30–8:00 · Close
**On screen:** Slide 13, then the GitHub repository page

> Everything is in my GitHub repository: the guide, the template, the worked example, the technical report, the demo script and its results. Thank you for watching.

---

## Recording checklist

- [ ] Close notifications, email and chat apps; hide personal browser tabs and bookmarks
- [ ] Terminal font large (16–18 pt); window shows no personal folder names (`cd` into the repo first)
- [ ] macOS: QuickTime Player → File → New Screen Recording · Linux: OBS Studio or GNOME screen recorder
- [ ] Use a headset or quiet room for audio
- [ ] Upload as **Unlisted** (YouTube) or with **Anyone with the link can view** (Drive)
- [ ] Open the link in a private/incognito window to confirm it plays
- [ ] Paste the link into `README.md` (top table) and the submission tracker
