# CalPolySeniorProject LaTeX Template

A reusable LaTeX format for Cal Poly Electrical Engineering senior project
reports.

The template is packaged as a custom class file:

- `CalPolySeniorProject.cls`

It also includes a complete example report that can be compiled immediately and
then edited into your own project.

## Folder structure

```text
.
├── CalPolySeniorProject.cls      % The class file
├── Project.tex                   % Example report
├── Sources.bib                   % Example BibLaTeX database
├── Project.pdf                   % Local preview PDF
├── Images/
│   └── Logo.pdf                  % Title page logo
├── tests/
│   └── golden/Project.pdf        % Visual regression baseline
└── build/                        % Local build output, ignored by git
```

The class sets `\graphicspath{{Images/}}`, and the title page expects
`Images/Logo.pdf` to exist.

## Install LaTeX

For macOS, install MacTeX. It includes the tools used by this template:

```sh
latexmk --version
biber --version
```

Windows users can use MiKTeX or TeX Live. Linux users can install TeX Live from
their package manager, including `latexmk` and `biber`.

## VS Code workflow

This repo is intended to work well with a VS Code writing setup:

- LaTeX Workshop for building and viewing the PDF.
- LTeX+ for grammar and spell checking.
- Zotero with Better BibTeX, or another BibLaTeX export workflow, for managing
  `Sources.bib`.

Recommended setup:

1. Open this repo folder in VS Code.
2. Install the LaTeX Workshop extension.
3. Install the LTeX+ extension.
4. Open `Project.tex`.
5. Build with the LaTeX Workshop green build button.
6. Use the built-in PDF viewer from LaTeX Workshop.

### LaTeX Workshop settings

These settings build into `build/` and copy the final PDF back to the repo
root, matching the local macOS workflow used for this template.

Open VS Code settings JSON and add:

```json
{
    "latex-workshop.latex.autoBuild.run": "onSave",
    "latex-workshop.latex.outDir": "build",

    "latex-workshop.latex.tools": [
        {
            "name": "latexmk to build/",
            "command": "latexmk",
            "args": [
                "-pdf",
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "-outdir=build",
                "%DOC%"
            ]
        },
        {
            "name": "copy pdf to root (zsh)",
            "command": "/bin/zsh",
            "args": [
                "-lc",
                "PDF=\"build/%DOCFILE%.pdf\"; "
                "[ -f \"$PDF\" ] && cp \"$PDF\" \"%DIR%\""
            ]
        },
        {
            "name": "clean build/ (latexmk)",
            "command": "latexmk",
            "args": ["-C", "-outdir=build"]
        }
    ],

    "latex-workshop.latex.recipes": [
        {
            "name": "Build to build/ + copy PDF",
            "tools": ["latexmk to build/", "copy pdf to root (zsh)"]
        },
        {
            "name": "Clean build/",
            "tools": ["clean build/ (latexmk)"]
        }
    ],

    "latex-workshop.latex.recipe.default": "Build to build/ + copy PDF",

    "latex-workshop.latex.clean.fileTypes": [
        "*.aux", "*.bbl", "*.blg", "*.fdb_latexmk", "*.fls",
        "*.log", "*.out", "*.run.xml", "*.bcf", "*.synctex.gz",
        "*.toc", "*.lof", "*.lot"
    ]
}
```

## Command-line build

The VS Code recipe runs the same build process as this command:

```sh
latexmk -pdf -synctex=1 -interaction=nonstopmode -file-line-error \
    -outdir=build Project.tex
```

To clean generated files:

```sh
latexmk -C -outdir=build Project.tex
```

## Build verification

GitHub Actions builds `Project.tex`, uploads the generated PDF, and renders both
`tests/golden/Project.pdf` and the fresh `build/Project.pdf` to compare their
pages.

The root `Project.pdf` is a convenient local preview. Your VS Code workflow may
overwrite it after each build. The golden PDF is the stable visual regression
baseline. If the class or example intentionally changes the expected output,
regenerate and commit both `Project.pdf` and `tests/golden/Project.pdf`.

## Using the template

The fastest path is to edit `Project.tex` directly.

To start a new file, use:

```tex
\documentclass{CalPolySeniorProject}

\setprojecttitle{Your Title\par Optional Second Line}
\setauthor{1}{Author One}{author1@calpoly.edu}
\setauthor{2}{Author Two}{author2@calpoly.edu}
\setprofessor{Dr.\ Your Professor}
\setclass{EE 600}
\setdepartment{Electrical Engineering Department}
\setquarter{Fall 2025}

\addbibresource{Sources.bib}

\begin{document}
\maketitlepage

% Front matter and report content go here.

\printbibliography
\end{document}
```

Authors should be numbered contiguously starting at 1. For one author, only set
author 1. For three authors, set authors 1, 2, and 3.

## Citations with Zotero

The class uses `biblatex` with the `biber` backend and IEEE-style references.

Recommended Zotero workflow:

1. Install Zotero.
2. Install the Better BibTeX plugin for Zotero.
3. Export your project collection as BibLaTeX to `Sources.bib`.
4. Keep citation keys stable so existing `\autocite{...}` commands do not
   break.
5. Rebuild with LaTeX Workshop or `latexmk`; `biber` is run automatically.

In the preamble:

```tex
\addbibresource{Sources.bib}
```

In the text:

```tex
Cite like this \autocite{shannon1948}.
```

Where you want the bibliography:

```tex
\printbibliography
```

## Figures and tables

- Put report images in `Images/`.
- Prefer PDF for plots and diagrams when possible.
- Use `\includegraphics`; the class already loads `graphicx`.
- The example includes two figures and one table to show the expected format.

## Appendices

Start appendices with:

```tex
\beginappendices
```

Add each appendix entry with:

```tex
\appsubsection{Title of Appendix}
```

If the document returns to normal subsection numbering after appendices, use:

```tex
\stopappendices
```

## Margin overrides

The class supports margin overrides at `\documentclass` time:

```tex
\documentclass[
    left=1.5in,
    right=1.25in,
    top=1.25in,
    bottom=1.25in
]{CalPolySeniorProject}
```

If these options are omitted, the class defaults are used.

## Troubleshooting

### Citations show as question marks

Make sure `biber` is installed and that `Sources.bib` contains valid BibLaTeX
entries. Then rebuild with LaTeX Workshop or run `latexmk` again.

### The title page logo is missing

Confirm `Images/Logo.pdf` exists and that the filename matches exactly.

### VS Code shows stale PDF output

Use the recommended LaTeX Workshop recipe so the PDF is built in `build/` and
copied back to the repo root. You can also open `build/Project.pdf` directly.

### Local build output is cluttering the repo

Run LaTeX Workshop cleanup or:

```sh
latexmk -C -outdir=build Project.tex
```
