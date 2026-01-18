# CalPolySeniorProject LaTeX Template

A reusable LaTeX template for Cal Poly EE senior project reports, packaged as 
a custom class file:

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

## Install LaTeX

Install a LaTeX distribution if not already installed:

- **macOS (recommended):** Install **MacTeX** (full TeX Live for Mac).
  Make sure `latexmk` and `biber` are available (MacTeX includes both).
- **Windows:** Install **MiKTeX** or **TeX Live**.
  If you use MiKTeX, enable on-the-fly package installs (or preinstall).
- **Linux:** Install **TeX Live** via your package manager.
  You’ll also want `latexmk` and `biber` (often separate packages).

## Set Up LaTeX in VS Code

Set up LaTeX in VS Code 

1. **Install LaTeX Workshop**
   - Open **Extensions** → search **LaTeX Workshop** → **Install**.

2. **Optional: grammar + spellcheck (recommended)**
   - Install **LTeX+ — grammar/spell checking using LanguageTool**.

3. **Open the template**
   - `File → Open Folder…` → choose the repo folder (contains `Project.tex`).

4. **Build + view (your workflow)**
   - Open `Project.tex`.
   - Click the green **Build** arrow (LaTeX Workshop).
   - Click the **PDF viewer** icon to open the PDF (SyncTeX works).

5. **Optional: apply the recommended build settings**
   - Command Palette → **Preferences: Open User Settings (JSON)**.
   - Paste the LaTeX Workshop settings from this README to:
     - build on save
     - put aux files in `./build`
     - copy the final PDF to the repo root

## Using the template

### Option A: Start from the example (recommended)

1. Open this folder in VS Code.
2. Open `Project.tex`.
3. Build (LaTeX Workshop “play” button).
4. Replace the placeholder content with your report.

### Option B: Create your own report from scratch

Create `main.tex` and start with:

**Authors:** the title page supports **one or two** authors. If you only have one author, set only author **1** and *do not* call `\setauthor{2}{...}{...}`.

```tex
\documentclass{CalPolySeniorProject}

% Metadata setters (fill these in)
\setprojecttitle{Your Title\par Optional Second Line}
\setauthor{1}{Author One}{author1@school.edu}
% Optional second author (omit entirely if you only have one author)
%\setauthor{2}{Author Two}{author2@school.edu}
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
\addbibresource{Sources.bib}
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

## Recommended VS Code LaTeX Workshop settings

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

### PDF builds, but VS Code shows stale output
If you’re writing output to `build/`, make sure your recipe copies the PDF back
to the root (see the settings above), or open the PDF from `build/` directly.

### If the build gets cursed
- Run **LaTeX Workshop: Clean up auxiliary files**
- Delete the `build/` folder (if you’re using one)
- Build again (green arrow)
- If VS Code still shows stale output, open the PDF from `build/` directly, or
  use the “copy PDF to repo root” recipe so the viewer always opens the newest
  file.
