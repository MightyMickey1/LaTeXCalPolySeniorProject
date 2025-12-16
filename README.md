# CalPolySeniorProject LaTeX Template

A reusable LaTeX template for Cal Poly EE senior project reports, packaged as a custom class file:

- `CalPolySeniorProject.cls`

It also includes a complete example you can compile immediately, then edit into
your own report.

## Folder structure

```
.
├── CalPolySeniorProject.cls      % The class (formatting + helper macros)
├── Project.tex                   % Example report you can edit into your own
├── Sources.bib                   % Example BibLaTeX database (biber backend)
├── Project.pdf                   % Optional: output PDF (generated)
└── Images/
    └── Logo.pdf                  % Title page logo (PDF recommended)
```

Notes:
- The `Images/` folder name matters: the class sets `\graphicspath{{Images/}}`.
- If you use the recommended LaTeX Workshop settings below, you may also see a
  `build/` folder created automatically for intermediate files.

## Using the template

### Option A: Start from the example (recommended)

1. Open this folder in VSCode.
2. Open `Project.tex`.
3. Build (LaTeX Workshop “play” button).
4. Replace the placeholder content with your report.

### Option B: Create your own report from scratch

Create `main.tex` and start with:

```tex
\documentclass{CalPolySeniorProject}

% Metadata setters (fill these in)
\setprojecttitle{Your Title\par Optional Second Line}
\setauthor{1}{Author One}{author1@school.edu}
\setauthor{2}{Author Two}{author2@school.edu}
\setprofessor{Dr.\ Your Professor}
\setclass{EE 4XX}
\setdepartment{Electrical Engineering Department}
\setquarter{Fall 2025}

% Bibliography file
\addbibresource{Sources.bib}

\begin{document}
\maketitlepage
% ... your content ...
\printbibliography
\end{document}
```

## Add citations

This class uses `biblatex` with `biber`.

In the preamble:

```tex
\addbibresource{references.bib}
```

In the text:

```tex
Cite like this \autocite{somekey}.
```

Where you want the bibliography:

```tex
\printbibliography
```

## Figures and tables

- Put images in `Images/` (PDF preferred for plots/diagrams).
- Include them with `\includegraphics` (the class already loads `graphicx`).

The example file includes two figure environments and a table to demonstrate
standard formatting.

## Appendices

To start appendices:

```tex
\beginappendices
```

For each appendix entry:

```tex
\appsubsection{Title of Appendix}
```

If you ever need to return to normal subsection numbering afterward:

```tex
\stopappendices
```

## Margin overrides (optional)

The class supports margin overrides at `\documentclass` time:

```tex
\documentclass[
    left=1.5in,
    right=1.25in,
    top=1.25in,
    bottom=1.25in
]{CalPolySeniorProject}
```

If you omit these options, the class defaults are used.

## Recommended VSCode LaTeX Workshop settings

These settings keep your project tidy by putting intermediate/aux files in a
`build/` folder and copying the final PDF back to the repo root.

Open VSCode settings JSON and add:

```json
{
    "latex-workshop.latex.autoBuild.run": "onSave",
    "latex-workshop.latex.outDir": "build",

    "latex-workshop.latex.tools": [
        {
            "name": "latexmk → build/",
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
            "tools": ["latexmk → build/", "copy pdf to root (zsh)"]
        },
        {
            "name": "Clean build/",
            "tools": ["clean build/ (latexmk)"]
        }
    ],

    "latex-workshop.latex.recipe.default": "Build to build/ + copy PDF",

    "latex-workshop.latex.clean.fileTypes": [
        "*.aux", "*.bbl", "*.blg", "*.fdb_latexmk", "*.fls",
        "*.log", "*.out", "*.run.xml", "*.bcf", "*.synctex.gz", "*.toc"
    ]
}
```

## Troubleshooting

### “Undefined control sequence … \addlinespace”
The class/example uses `\addlinespace` for nicer spacing in tables, which comes
from `booktabs`. Make sure `booktabs` is still being loaded by the class.

### Citations show as [??] / bibliography is empty
This template uses `biblatex` with `biber`.

- Make sure `biber` is installed (MacTeX includes it).
- Rebuild twice (LaTeX needs multiple passes).
- Confirm the `.bib` filename in `\addbibresource{...}` matches your file.

### Title page logo missing
If you see a “file not found” error for `Images/Logo.pdf`, either:
- Add a `Logo.pdf` to `Images/`, or
- Temporarily comment out the `\includegraphics` line in the class.

### PDF builds, but VSCode shows stale output
If you’re writing output to `build/`, make sure your recipe copies the PDF back
to the root (see the settings above), or open the PDF from `build/` directly.
