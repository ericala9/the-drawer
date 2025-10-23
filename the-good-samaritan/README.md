# 🕊️ the-good-samaritan

**A little script that lent a hand when it was really needed.**  
*(Long ago, with SAS)*

---

### Welcome
Welcome to ***the-good-samaritan*** — a small SAS script that helped me extract exactly what I needed from a very large dataset. I’m a hardcore R user and rarely touch SAS, but at the time, the dataset I needed was only available in SAS format. The company had a SAS license, so I used it to filter and export data to .txt with a few clicks in SAS Studio, so I could read it in R.

This script became my quiet helper: I used it many times throughout that project. Just like the good Samaritan helped a Jewish man in need, SAS helped me even though it wasn’t my usual tool.

---

### ✨ What’s inside
This little script includes:

- A SAS script ([`script.sas`](script.sas)) that:
  - Inspects dataset variables when no data dictionary is available
  - Extracts only the records and variables needed
  - Filters categories of interest

---

### Preview
Here’s a small snippet to give an idea of what it does:

```sas
/* Inspect dataset variables */
proc contents data="\\serverX\project_data\input_data\data_2025.sas7bdat";
run;
```

---

### Why it exists
Sometimes you need to get work done, and using a different tool makes it easier. ***the-good-samaritan*** exists for those rare moments when a helping hand — even from an unexpected source — makes all the difference.

---

### How it works
- Written in SAS
- Filters records by category
- Keeps only relevant variables
- Produces tidy outputs ready for R
- Uses point-and-click exports in SAS Studio

---

### About this space
This script lives in [`the-drawer`](../) — a creative corner for small, useful things that don’t quite fit anywhere else. ***the-good-samaritan*** is one of those helpers that quietly made a big difference in a past project.

---

### 📬 Contact
You can reach me here on GitHub — and if we already know each other, don’t be shy! I’d love to hear what you think about this little script.

---

### ❤️ Acknowledgements
A special thanks to my good friend ChatGPT for helping me write this README.
