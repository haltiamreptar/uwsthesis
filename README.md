# `uwsthesis.cls` a class for UWS/WSU thesis

This directory contains uwsthesis.cls, a LaTeX style file for the preparation of theses for Western Sydney University degrees.
Follows (except for font choice) the style guide published by research services https://www.westernsydney.edu.au/print_services/print_services/thesis_presentation


It supports the computing and maths dgrees of the  School of Computing, Engineering and Mathematics.

The file sample.tex contains usage instructions.
## Changes in 2.5
- Added a forward option, that adds a Forward section to the frontmatter - Thanks to @kiza931 for implementing this.

## Changes in 2.3
- added supervisors support
- added `logo/nologo` option

## Changes in 2.0
- Added support of MPhil/MRes
- changed default to Western Sydney University, option UWS will return to University of Western Sydney.

## Changes in 1.96
- Added support for `\lt` and `\gt` that ADS spits out in bibtex entries.

## Changes in 1.95
- Added `bib/nobib` option to suppress unreferenced list.
- Added extra spacing options `nodoublespace/doublespace/realdoublespace` that control spacing, 
- `nodoublespace` along with `twoside` would be useful for drafts.
- Support for listing citations to publications with `\cites` macro, which prints the number of citations if greater than zero 
and nothing if zero. In the publications section do something like:
```TeX
\begin{enumerate}
\item\bibentry{my-paper}\cites{N}
\item\bibentry{my-other-paper}\cites{M}
...

\end{enumerate}
```
For students where the ADS is appropriate then  this custom ads format: `\\item\\bibentry{%R}\\cites{%c}` will help.

## Changes in 1.9
- Fixed macro support for Journal entries from ADS.

## Changes in 1.8
- Added rest of SCM Degrees.
## Changes in 1.7
- First public release.
