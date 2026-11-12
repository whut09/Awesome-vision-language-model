#!/usr/bin/env python
"""Collect ACL/EMNLP VLM papers from an official ACL Anthology volume page.

Usage: python sync_acl_anthology_vlm.py <volume_id> [<volume_id> ...]
Example: python sync_acl_anthology_vlm.py 2025.emnlp-main 2026.acl-long

Implemented in Python because Windows Schannel TLS (curl / Invoke-WebRequest)
is broken on the maintainer machine; urllib (OpenSSL) works reliably.
Filter and taxonomy mirror the other sync_* scripts via paper_categories.
"""

import re
import sys
import html
import urllib.request
from pathlib import Path

PAPER_PATTERN = re.compile(
    r'(?i)vision[- ]language[- ]models?|vision[- ]language[- ]foundation[- ]models?'
    r'|large[- ]vision[- ]language|visual[- ]language[- ]models?'
    r'|multimodal[- ]large[- ]language|multi-modal[- ]large[- ]language'
    r'|multimodal[- ]llms?|multi-modal[- ]llms?|video[- ]llms?|video[- ]large[- ]language'
    r'|\bVLMs?\b|\bMLLMs?\b'
)
EXCLUDED_PATTERN = re.compile(r'(?i)VLA|vision[- ]language[- ]action|vision[- ]language[- ]navigation|VLN')

SECTIONS = [
    'Multimodal Architecture and Training',
    'Pre-training, Alignment, and Adaptation',
    'Reasoning, Inference, and Test-Time Scaling',
    'Efficient VLMs and Deployment',
    'Grounding, Spatial, and Pixel Understanding',
    'Video, Temporal, and 4D Understanding',
    'Hallucination Mitigation and Faithfulness',
    'Safety, Security, Privacy, and Robustness',
    'Evaluation and Benchmarks',
    'Domain-Specific VLMs and Applications',
]

SECTION_RULES = [
    (re.compile(r'(?i)hallucin|faithful|semantic grounding errors'), 'Hallucination Mitigation and Faithfulness'),
    (re.compile(r'(?i)safety|jailbreak|adversarial|backdoor|privacy|security|copyright|watermark|robust|bias|unlearn|calibrat'), 'Safety, Security, Privacy, and Robustness'),
    (re.compile(r'(?i)benchmark|evaluat|probing|assess|diagnos|measure|judge|leaderboard'), 'Evaluation and Benchmarks'),
    (re.compile(r'(?i)video|temporal|streaming|motion|spatio-temporal|4D|scene segmentation'), 'Video, Temporal, and 4D Understanding'),
    (re.compile(r'(?i)ground|segmentation|detection|locali[sz]|spatial|3D|point cloud|depth|pixel|region|referring|OCR|layout|geometric'), 'Grounding, Spatial, and Pixel Understanding'),
    (re.compile(r'(?i)token pruning|token compression|token reduction|token merging|quantiz|accelerat|efficient|lightweight|distill|deployment|serving|memory-efficient|\bedge\b|\bfast\b|speed'), 'Efficient VLMs and Deployment'),
    (re.compile(r'(?i)reason|inference|test[- ]time|chain[- ]of[- ]thought|\bCoT\b|reward|GRPO|reinforcement|planning|think'), 'Reasoning, Inference, and Test-Time Scaling'),
    (re.compile(r'(?i)pre[- ]train|alignment|prompt|adapt|fine[- ]tun|continual|transfer|representation learning|encoder'), 'Pre-training, Alignment, and Adaptation'),
    (re.compile(r'(?i)medical|biomed|clinical|pathology|health|remote sensing|autonomous driving|robot|document|aerial|geospatial|forensics|industrial|art|music'), 'Domain-Specific VLMs and Applications'),
]

TABLE_HEADER = '| Year | Pub | Title | Links | Main Institution |'


def paper_section(title: str) -> str:
    for pattern, section in SECTION_RULES:
        if pattern.search(title):
            return section
    return 'Multimodal Architecture and Training'


def normalized_title(title: str) -> str:
    return re.sub(r'[^a-z0-9]', '', title.lower())


def fetch(url: str) -> str:
    request = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    with urllib.request.urlopen(request, timeout=120) as response:
        return response.read().decode('utf-8', 'ignore')


def venue_label(venue_slug: str) -> str:
    match = re.search(r'(?i)(acl|emnlp|naacl|eacl)', venue_slug)
    if not match:
        raise ValueError(f'Unknown venue in volume slug: {venue_slug}')
    return match.group(1).upper()


def main() -> None:
    if len(sys.argv) < 2:
        raise SystemExit(__doc__)
    readme = Path(__file__).resolve().parent.parent / 'README.md'
    raw = readme.read_bytes()
    has_bom = raw.startswith(b'\xef\xbb\xbf')
    text = raw.decode('utf-8-sig').replace('\r\n', '\n')
    lines = text.split('\n')

    existing = set()
    for match in re.finditer(r'\*\*(?P<title>[^*]+)\*\*', text):
        existing.add(normalized_title(match.group('title')))

    added_total = 0
    for volume in sys.argv[1:]:
        if not re.fullmatch(r'(\d{4})\.([a-z-]+)', volume):
            raise SystemExit(f'Invalid volume id: {volume}')
        year, venue_slug = volume.split('.', 1)
        pub = venue_label(venue_slug)

        page = fetch(f'https://aclanthology.org/volumes/{volume}/')
        candidates = []
        for match in re.finditer(
            r'(?is)<strong><a class=align-middle href=/' + re.escape(volume) + r'\.(\d+)/>(?P<title>.*?)</a>', page
        ):
            title = html.unescape(re.sub(r'<[^>]+>', '', re.sub(r'\s+', ' ', match.group('title'))).strip())
            if PAPER_PATTERN.search(title) and not EXCLUDED_PATTERN.search(title):
                candidates.append((title, match.group(1)))
        candidates.sort(key=lambda item: item[0].lower())

        new_rows = {section: [] for section in SECTIONS}
        added = 0
        for title, paper_id in candidates:
            if normalized_title(title) in existing:
                continue
            title = title.replace('|', '\\|')
            url = f'https://aclanthology.org/{volume}.{paper_id}/'
            new_rows[paper_section(title)].append(f'| {year} | {pub} | **{title}** | [[paper]({url})] | See paper |')
            existing.add(normalized_title(title))
            added += 1

        inserted = 0
        for section in SECTIONS:
            if not new_rows[section]:
                continue
            marker = f'### {section}'
            if marker not in lines:
                raise SystemExit(f'Missing section: {section}')
            section_index = lines.index(marker)
            header_index = section_index + 1
            while lines[header_index] != TABLE_HEADER:
                header_index += 1
            lines[header_index + 2:header_index + 2] = new_rows[section]
            inserted += len(new_rows[section])

        # Canonical order inside every table: year desc, then title asc.
        position = 0
        while position < len(lines):
            if lines[position] != TABLE_HEADER:
                position += 1
                continue
            row_start = position + 2
            row_end = row_start
            while row_end < len(lines) and re.match(r'^\|\s*\d{4}\s*\|', lines[row_end]):
                row_end += 1
            rows = sorted(lines[row_start:row_end], key=row_sort_key)
            lines[row_start:row_end] = rows
            position = row_start + len(rows)

        added_total += added
        print(f'{volume} -> Candidates: {len(candidates)}, Added: {added}, Inserted: {inserted}')

    out = '\n'.join(lines)
    data = out.encode('utf-8-sig' if has_bom else 'utf-8')
    readme.write_bytes(data)
    print(f'Total added: {added_total}')


def row_sort_key(row: str) -> str:
    parts = row.split('|')
    year = int(parts[1].strip())
    return f'{9999 - year:04d}|{parts[3].strip().lower()}'


if __name__ == '__main__':
    main()
