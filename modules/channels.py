#!/usr/bin/env python3

import sys
import re
import requests
from bs4 import BeautifulSoup

if len(sys.argv) < 2:
    sys.exit(1)

# Last arg is page number if it's a digit
if len(sys.argv) > 2 and sys.argv[-1].isdigit():
    page = int(sys.argv[-1])
    query = " ".join(sys.argv[1:-1])
else:
    page = 1
    query = " ".join(sys.argv[1:])

url = "https://www.pornhub.com/channels"
params = {"search": query, "page": page}

headers = {
    "User-Agent": "Mozilla/5.0"
}

html = requests.get(url, params=params, headers=headers, timeout=15).text
soup = BeautifulSoup(html, "html.parser")

seen = set()

# Find channel links
for a in soup.find_all("a", href=re.compile(r"/channels/")):
    href = a.get("href", "")

    # Skip if not a proper channel link
    if not re.match(r"^/channels/[^/]+$", href):
        continue

    # Extract channel name from URL
    match = re.search(r"/channels/([^/]+)", href)
    if not match:
        continue

    channel_name = match.group(1)

    if channel_name in seen:
        continue

    # Try to get channel title from the link text or nearby elements
    title = a.get_text(strip=True)

    # If empty, try to find title in parent or nearby elements
    if not title:
        parent = a.parent
        if parent:
            title = parent.get_text(strip=True)

    if not title or len(title) > 100:
        title = channel_name

    seen.add(channel_name)
    print(f"{channel_name}|{title}")
