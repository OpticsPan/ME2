"""Print all numbered chapters of outputs/reports/MEtrology.md to ME_New.pdf.

Requires Chrome or Edge, markdown-it-py, beautifulsoup4, Pillow, matplotlib,
NumPy, PyMuPDF, and Chinese fonts. Set CHROME to override the browser path;
the established ME2 workstation provides PyMuPDF via D:/Codex/cache/pdf-python.
Run from the repository root in PowerShell:

    $env:PYTHONPATH = "D:/Codex/cache/pdf-python"
    python -B outputs/code/build_me_new_pdf_v1.py

Each export has its own working directory. The output is replaced only after
the PDF has been reopened and its page count and bookmarks checked.
"""
import argparse
import hashlib
import html
import os
from pathlib import Path
import re
import shutil
import subprocess
import tempfile
from urllib.parse import unquote, urlsplit, quote

repo = Path(__file__).resolve().parents[2]
workspace = repo / "work/approved-metrology-pdf"
workspace.mkdir(parents=True, exist_ok=True)
session = tempfile.TemporaryDirectory(prefix="export-", dir=workspace, ignore_cleanup_errors=True)
work = Path(session.name)
reports = repo / "outputs/reports"
assets = work / "assets"
assets.mkdir(exist_ok=True, parents=True)
os.environ.setdefault("MPLCONFIGDIR", str(workspace / "matplotlib"))
os.environ["TMP"] = os.environ["TEMP"] = str(work)

import pymupdf as fitz
from bs4 import BeautifulSoup
from markdown_it import MarkdownIt
from matplotlib import rc_context
from matplotlib.font_manager import FontProperties
from matplotlib.mathtext import math_to_image
from PIL import Image


def escaped(text):
    return html.escape(str(text), quote=True)


def vector_math(expr, display):
    expression = " ".join(expr.split())
    expression = re.sub(r"\\(mathrm|mathbf|mathit)\s+([A-Za-z])", r"\\\1{\2}", expression)
    name = hashlib.sha256(expression.encode("utf-8")).hexdigest()[:18]
    target = assets / f"eq-{name}.svg"
    size = 13
    if not target.exists():
        with rc_context({"mathtext.fontset": "stix", "svg.hashsalt": "metrology"}):
            math_to_image(
                "$" + expression + "$",
                target,
                prop=FontProperties(size=size),
                format="svg",
                color="#162d3f",
            )
    svg = target.read_text(encoding="utf-8")
    w, h = map(float, re.search(r'<svg[^>]+width="([\d.]+)pt" height="([\d.]+)pt"', svg).groups())
    return (
        f'<img class="math {"block-math" if display else "inline-math"}" '
        f'style="width:{w/size:.4f}em" src="{target.as_uri()}" alt="{escaped(expression)}">'
    )


def convert_math(md):
    resources = []

    def store(match, display):
        n = len(resources)
        resources.append(vector_math(match[1], display))
        key = f"MATHRENDERPLACEHOLDER{n:04d}END"
        return f"\n\n{key}\n\n" if display else key

    md = re.sub(r"\$\$\s*(.*?)\s*\$\$", lambda m: store(m, True), md, flags=re.S)
    md = re.sub(r"(?<!\\)\$(?!\$)([^$\r\n]+?)\$", lambda m: store(m, False), md)
    rendered = MarkdownIt("commonmark", {"html": True}).enable("table").render(md)
    for n, markup in enumerate(resources):
        rendered = rendered.replace(f"MATHRENDERPLACEHOLDER{n:04d}END", markup)
    return rendered


def gh_link(path, anchor=""):
    ref = path.resolve().relative_to(repo).as_posix()
    return (
        "https://github.com/OpticsPan/ME2/blob/main/"
        + quote(ref)
        + ("#" + quote(unquote(anchor)) if anchor else "")
    )


def split_figure(path):
    # Split only between cards, where a full row is the page background colour.
    with Image.open(path) as src:
        im = src.convert("RGB")
        w, h = im.size
        original_gutters = {
            ("WZIM-三光斑双向找平与IFM读数_v1.png", 2440, 2248): (1128,),
            ("WZIM-YTZ单M4双向取样_v5.png", 2440, 3040): (1010, 1778),
        }
        known = original_gutters.get((path.name, w, h))
        if h / w < 1.5 and known is None:
            return [path]
        import numpy as np

        p = np.asarray(im)
        blank = (
            np.abs(p[:, w // 30 : -w // 30].astype(int) - p[0, 0].astype(int)).max(axis=2) < 5
        ).mean(axis=1) > 0.995
        centers = [
            (m.start() + m.end()) // 2
            for m in re.finditer("1{6,}", "".join("1" if v else "0" for v in blank))
        ]
        centers = [v for v in centers if 0.14 * h < v < 0.89 * h]
        # Keep each independently paginated piece large enough for a complete
        # optical panel. For figure 3.6 this finds its three native gutters.
        cuts = [0]
        for v in centers:
            if v - cuts[-1] >= 0.22 * w and h - v >= 0.22 * w:
                cuts.append(v)
        if known:
            assert all(blank[v] for v in known)
            cuts = [0, *known]
        if len(cuts) == 1:
            return [path]
        cuts.append(h)
        pieces = []
        for i, (y0, y1) in enumerate(zip(cuts, cuts[1:]), 1):
            target = assets / f"{path.stem}-part-{i}.png"
            im.crop((0, y0, w, y1)).save(target, optimize=True)
            pieces.append(target)
        return pieces


def prepare():
    md = (reports / "MEtrology.md").read_text(encoding="utf8")
    matches = list(re.finditer(r"^## (\d+)\.\s+([A-Za-z0-9–-]+)\s*[—–-]\s*(.+)$", md, re.M))
    if not matches:
        raise ValueError("No approved numbered chapters")
    roots = {m[2].lower() for m in matches}
    soup = BeautifulSoup(convert_math(md[matches[0].start() :]), "html.parser")
    for elem in soup.find_all("h2"):
        k = re.search(r"\d+\.\s+([A-Za-z0-9–-]+)", elem.get_text())
        if k:
            elem["id"] = k[1].lower()
    for par in list(soup.find_all("p")):
        anchors = par.find_all("a", attrs={"name": True}, recursive=False)
        if anchors and not par.get_text(strip=True) and not par.find("img"):
            dest = par.find_next_sibling()
            while (
                dest and dest.name == "p" and not dest.get_text(strip=True) and not dest.find("img")
            ):
                dest = dest.find_next_sibling()
            if dest:
                dest.attrs.setdefault("data-anchors", []).extend(a["name"] for a in anchors)
            par.decompose()
    for block in soup.find_all(attrs={"data-anchors": True}):
        for n in block.attrs.pop("data-anchors"):
            if n == block.get("id"):
                continue
            a = soup.new_tag("span", id=n)
            a["class"] = "dest"
            block.insert(0, a)
    valid = {n["id"] for n in soup.select("[id]")} | roots | {"calibration-index"}
    for a in soup.find_all("a", href=True):
        u = urlsplit(a["href"])
        if u.scheme:
            continue
        path = reports / unquote(u.path) if u.path else reports / "MEtrology.md"
        if path.resolve() == (reports / "MEtrology.md").resolve() and u.fragment in valid:
            a["href"] = "#" + u.fragment
        else:
            a["href"] = gh_link(path, u.fragment)
    for im in list(soup.select("img:not(.math)")):
        path = (reports / unquote(im["src"])).resolve()
        if not path.is_file():
            raise FileNotFoundError(path)
        par = im.find_parent("p")
        caption = par.find_next_sibling() if par else None
        is_figure = bool(re.match(r"图\s*\d+\.", im.get("alt", "")))
        pieces = split_figure(path) if is_figure else [path]
        with Image.open(path) as pic:
            w, h = pic.size
        images = []
        for part in pieces:
            tag = soup.new_tag("img", src=part.as_uri(), alt=im.get("alt", ""))
            tag["class"] = "figure-img" if is_figure else "equation-img"
            if not is_figure:
                tag["style"] = f"width:{min(100,w/14.6):.2f}%"
            images.append(tag)
        if not par:
            im.replace_with(images[0])
            continue
        if not is_figure:
            par["class"] = "equation"
            im.replace_with(images[0])
            continue
        anchors = par.select("span.dest")
        for i, tag in enumerate(images):
            fig = soup.new_tag("figure")
            fig["class"] = "illustration"
            if i == 0:
                for a in anchors:
                    fig.append(a.extract())
            fig.append(tag)
            iscaption = (
                caption
                and caption.name == "p"
                and re.match(r"图\s*\d+\.", caption.get_text(strip=True))
            )
            if i == len(images) - 1 and iscaption:
                caption.name = "figcaption"
                fig.append(caption.extract())
            par.insert_before(fig)
        par.decompose()
    for im in soup.select("img.block-math"):
        im.parent["class"] = "equation display-equation"
    for p in soup.find_all("p"):
        if not p.find("a"):
            continue
        nolinks = p.get_text(strip=True)
        for a in p.find_all("a"):
            nolinks = nolinks.replace(a.get_text(strip=True), "")
        if not nolinks.replace("·", "").strip():
            p["class"] = "navigation"
    data = []
    for m in matches:
        key = m[2].lower()
        tag = soup.find(id=key)
        sub = []
        for dest in tag.find_all_next("h3"):
            if dest.find_previous("h2") != tag:
                break
            a = dest.select_one(".dest")
            if a:
                sub.append((a["id"], dest.get_text(strip=True)))
        data.append((m[1], m[2], m[3], key, sub))
    return soup, data


CSS = r"""
@page{size:A4;margin:14mm 13.5mm 15mm;
 @top-left{content:"ME / 计量校准";font:8pt "Microsoft YaHei";color:#52727c}
 @top-right{content:"已审核项目汇编";font:8pt "Microsoft YaHei";color:#52727c}
 @bottom-left{content:"ME2 · Metrology";font:8pt "Microsoft YaHei";color:#617680}
 @bottom-right{content:counter(page);font:bold 9pt Arial;color:#173d50}}
*{box-sizing:border-box}html{-webkit-print-color-adjust:exact;print-color-adjust:exact}
body{margin:0;color:#1b303c;font:10pt/1.67 "Microsoft YaHei","SimSun",sans-serif}
h1,h2,h3,h4,h5{font-family:"Microsoft YaHei",sans-serif;color:#123d50;break-after:avoid;page-break-after:avoid;line-height:1.3}
h2{break-before:page;border-bottom:2.5pt solid #067776;font-size:21pt;letter-spacing:.1pt;margin:0 0 2.1mm;padding:2mm 0 3mm}
h3{font-size:16pt;border-bottom:.65pt solid #92b8b7;margin:5mm 0 1.7mm;padding:0 0 1.3mm}
h4{font-size:13pt;margin:4mm 0 1.2mm}h5{font-size:11pt;margin:3mm 0 1.2mm;color:#174e62}
p{margin:1.5mm 0 2.2mm;orphans:2;widows:2;overflow-wrap:anywhere}
strong{font-weight:700;color:#142f42}a{color:#006b76;text-decoration:none}
.navigation{font-size:8.5pt;line-height:1.55;color:#467781;margin:1.7mm 0 2.8mm}
.dest{display:inline;line-height:0;font-size:0}
ul,ol{padding-left:7mm;margin:2mm 0}li{padding-left:1mm;margin:.8mm 0}
blockquote{border-left:2pt solid #75a59e;background:#f3f7f6;padding:1.1mm 4mm;margin:2.2mm 0}
blockquote p{margin:1.3mm 0}code{font:9pt/1.55 Consolas,"Microsoft YaHei",monospace;color:#234251;background:#edf2f4;overflow-wrap:anywhere}
table{width:100%;border-collapse:collapse;margin:2mm 0 3mm;font-size:8.8pt;line-height:1.5;table-layout:auto}
thead{display:table-header-group}th,td{text-align:left;border:0.5pt solid #bdcdd1;padding:1.35mm 1.7mm;vertical-align:top;overflow-wrap:anywhere}
th{background:#e3efed;font-weight:700;color:#224b55}tr{break-inside:avoid}
figure{margin:3mm 0;background:white;break-inside:avoid}
.figure-img{width:100%;max-height:197mm;max-width:100%;object-fit:contain;display:block;margin:auto}
figcaption{margin:1.8mm .5mm 0;line-height:1.53;font-size:9pt;color:#364e58;overflow-wrap:anywhere}
.equation{text-align:center;margin:2.5mm 0;break-inside:avoid}
.equation-img{max-width:100%;max-height:46mm;object-fit:contain;vertical-align:middle}
.inline-math{height:auto;vertical-align:-.16em}
.block-math{max-width:100%;height:auto;vertical-align:middle}
.display-equation{padding:2mm 2.5mm;background:#f0f6f6}
.cover{padding:13mm 3mm 0;break-after:page}
.cover .eyebrow{color:#087871;font-size:12pt;margin:0 0 4mm;font-weight:700}
.cover h1{font-size:30pt;line-height:1.32;letter-spacing:1pt;margin:0;color:#123849}
.cover .contents-title{font-size:14pt;margin:15mm 0 3mm;border-bottom:.8pt solid #65858a;padding-bottom:2mm}
.cover .item{border-bottom:.7pt solid #c3d3d5;padding:5.5mm 0 5mm;break-inside:avoid}
.cover .row{display:flex;align-items:baseline;gap:4mm}.cover .abbr{font-weight:700;font-size:16pt;color:#123d50}.cover .cn{font-size:13pt}
.cover .pg{margin-left:auto;font:12pt Arial;color:#315567}.cover .sub{margin:1.5mm 0 0 0;font-size:9pt}
.cover .source{font-size:9pt;color:#47646d;margin:7mm 0}
"""


def compose(soup, data, pages):
    cards = []
    for idx, abbr, cn, key, sub in data:
        links = "　·　".join(f'<a href="#{escaped(s)}">{escaped(t)}</a>' for s, t in sub)
        cards.append(
            f'<div class="item"><div class="row"><a class="abbr" href="#{key}">{idx}. {abbr}</a>'
            f'<a class="cn" href="#{key}">{escaped(cn)}</a><a class="pg" href="#{key}">{pages.get(key,"")}</a></div>'
            f'<div class="sub">{links}</div></div>'
        )
    return (
        '<!doctype html><html lang="zh-CN"><head><meta charset="utf-8"><title>晶圆台计量校准 · 已审核项目汇编</title>'
        "<style>" + CSS + '</style></head><body><section class="cover" id="calibration-index">'
        '<p class="eyebrow">MEtrology</p><h1>晶圆台计量校准</h1><p>已审核项目汇编</p>'
        '<h3 class="contents-title">目录</h3>'
        + "".join(cards)
        + f'<p class="source"><a href="{gh_link(reports/"MEtrology.md")}">在线正文与资料导航</a></p></section>'
        + str(soup)
        + "</body></html>"
    )


def chrome_binary():
    paths = [
        os.environ.get("CHROME"),
        shutil.which("google-chrome"),
        shutil.which("chromium"),
        shutil.which("chrome"),
    ]
    for d in ("ProgramFiles", "ProgramFiles(x86)"):
        base = Path(os.environ.get(d, "C:/Program Files"))
        paths.extend(
            [
                base / "Google/Chrome/Application/chrome.exe",
                base / "Microsoft/Edge/Application/msedge.exe",
            ]
        )
    return next(Path(p) for p in paths if p and Path(p).is_file())


def print_pdf(markup):
    pre = work / "approved.html"
    pre.write_text(markup, encoding="utf-8")
    pdf = work / "printed.pdf"
    if pdf.exists():
        pdf.unlink()
    chrome = chrome_binary()
    args = [
        str(chrome),
        "--headless=new",
        "--disable-gpu",
        "--disable-extensions",
        "--disable-background-networking",
        "--disable-sync",
        "--no-default-browser-check",
        "--no-first-run",
        "--allow-file-access-from-files",
        "--no-pdf-header-footer",
        f"--user-data-dir={work/'chrome-profile'}",
        f"--disk-cache-dir={work/'chrome-cache'}",
        f"--print-to-pdf={pdf}",
        pre.as_uri(),
    ]
    result = subprocess.run(
        args,
        capture_output=True,
        timeout=110,
        creationflags=getattr(subprocess, "CREATE_NO_WINDOW", 0),
    )
    if result.returncode or not pdf.is_file():
        raise RuntimeError(result.stderr.decode("utf8", "replace"))
    return pdf


def locate(doc, data):
    toc = []
    pages = {}
    for p in doc:
        for block in p.get_text("dict", flags=fitz.TEXTFLAGS_DICT & ~fitz.TEXT_PRESERVE_IMAGES)[
            "blocks"
        ]:
            for line in block.get("lines", []):
                spans = line["spans"]
                title = "".join(sp["text"] for sp in spans).strip()
                if not title or not spans:
                    continue
                sz = max(sp["size"] for sp in spans)
                for n, a, cn, key, _ in data:
                    if p.number > 0 and sz > 17 and re.match(rf"^{n}\.\s*{a}\b", title):
                        pages[key] = p.number + 1
                        toc.append([1, title, p.number + 1])
                if 14.5 < sz < 17.5 and title.startswith(("Purpose", "How", "Principle")):
                    toc.append([2, title, p.number + 1])
    if len(pages) != len(data):
        raise RuntimeError(f"chapter locations: {pages}")
    return pages, toc


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--target", type=Path, default=reports / "ME_New.pdf")
    args = parser.parse_args()
    soup, data = prepare()
    first = print_pdf(compose(soup, data, {}))
    with fitz.open(first) as doc:
        pages, _ = locate(doc, data)
    second = print_pdf(compose(soup, data, pages))
    with fitz.open(second) as doc:
        final_pages, toc = locate(doc, data)
        assert final_pages == pages
        doc.set_toc([[1, "目录", 1]] + toc)
        meta = doc.metadata
        meta.update(title="晶圆台计量校准 · 已审核项目汇编", subject="、".join(m[1] for m in data))
        doc.set_metadata(meta)
        fd, filename = tempfile.mkstemp(dir=args.target.parent, suffix=".pdf", prefix=".metrology-")
        os.close(fd)
        temp = Path(filename)
        try:
            doc.save(temp, garbage=3, deflate=True)
            with fitz.open(temp) as checked:
                assert len(checked) == len(doc) and checked.get_toc() == [[1, "目录", 1]] + toc
                assert all(1 <= entry[2] <= len(checked) for entry in checked.get_toc())
            os.replace(temp, args.target)
        finally:
            temp.unlink(missing_ok=True)
    print(args.target, pages, flush=True)


if __name__ == "__main__":
    main()
