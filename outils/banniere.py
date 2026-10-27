#!/usr/bin/env python3
"""Bannière du README : docs/images/banniere.svg + .png (1280 × 400), via cairosvg.

    python3 outils/banniere.py
"""
from pathlib import Path
import cairosvg

SORTIE = Path(__file__).resolve().parent.parent / 'docs' / 'images'
FONTE = 'font-family="DejaVu Sans, Helvetica, Arial, sans-serif"'
MARK = ('M25.946 44.938c-.664.845-2.021.375-2.021-.698V33.937a2.26 2.26 0 0 0-2.262-2.262H10.287'
        'c-.92 0-1.456-1.04-.92-1.788l7.48-10.471c1.07-1.497 0-3.578-1.842-3.578H1.237c-.92 0-1.456'
        '-1.04-.92-1.788L10.013.474c.214-.297.556-.474.92-.474h28.894c.92 0 1.456 1.04.92 1.788'
        'l-7.48 10.471c-1.07 1.498 0 3.579 1.842 3.579h11.377c.943 0 1.473 1.088.89 1.83L25.947 44.94z')

ETAPES = ['M0', 'M1', 'M2', 'M3', 'M4', 'M5', 'M6', 'M7']
ARRETS = {'M0': '①', 'M1': '②', 'M4': '③', 'M5': '④', 'M6': '⑤', 'M7': '⑥'}
RELUS = {'M1', 'M4', 'M6'}


def svg() -> str:
    p = [f'<svg xmlns="http://www.w3.org/2000/svg" width="1280" height="400" viewBox="0 0 1280 400">',
         '<defs><linearGradient id="f" x1="0" y1="0" x2="1" y2="1">'
         '<stop offset="0" stop-color="#863bff"/><stop offset="1" stop-color="#4d1aa8"/></linearGradient></defs>',
         '<rect width="1280" height="400" fill="url(#f)"/>',
         f'<g transform="translate(980 40) scale(7)" opacity="0.10"><path fill="#fff" d="{MARK}"/></g>',
         f'<g transform="translate(64 64) scale(1.6)"><path fill="#fff" d="{MARK}"/></g>',
         f'<text x="160" y="104" {FONTE} font-weight="bold" font-size="60" fill="#fff">Besoin → Plan</text>',
         f'<text x="64" y="176" {FONTE} font-size="27" fill="#e9dcff">Du besoin au plan technique. Aucune ligne de code avant le go,</text>',
         f'<text x="64" y="214" {FONTE} font-size="27" fill="#e9dcff">chaque pièce relue par un autre agent que celui qui l’a écrite.</text>']
    x0, y = 64, 290
    for i, e in enumerate(ETAPES):
        x = x0 + i * 140
        fond = '#ffffff' if e in ARRETS else '#b996ff'
        p.append(f'<rect x="{x}" y="{y}" width="110" height="54" rx="12" fill="{fond}"/>')
        p.append(f'<text x="{x+55}" y="{y+36}" text-anchor="middle" {FONTE} font-weight="bold" font-size="24" fill="#4d1aa8">{e}</text>')
        if e in RELUS:
            p.append(f'<rect x="{x+8}" y="{y+62}" width="94" height="22" rx="11" fill="#47bfff"/>')
            p.append(f'<text x="{x+55}" y="{y+78}" text-anchor="middle" {FONTE} font-size="13" fill="#1e1b2e">relu</text>')
        if e in ARRETS:
            p.append(f'<circle cx="{x+104}" cy="{y+2}" r="15" fill="#47bfff"/>')
            p.append(f'<text x="{x+104}" y="{y+9}" text-anchor="middle" {FONTE} font-weight="bold" font-size="17" fill="#1e1b2e">{ARRETS[e]}</text>')
        if i < len(ETAPES) - 1:
            p.append(f'<path d="M{x+114} {y+27} h20" stroke="#fff" stroke-width="3"/>')
    p.append(f'<text x="1216" y="378" text-anchor="end" {FONTE} font-size="18" fill="#e9dcff">LMVI Conseil · v1.2.0</text>')
    p.append('</svg>')
    return '\n'.join(p)


if __name__ == '__main__':
    SORTIE.mkdir(parents=True, exist_ok=True)
    s = svg()
    (SORTIE / 'banniere.svg').write_text(s, encoding='utf-8')
    cairosvg.svg2png(bytestring=s.encode('utf-8'), write_to=str(SORTIE / 'banniere.png'),
                     output_width=1280, output_height=400)
    print(SORTIE / 'banniere.png')
