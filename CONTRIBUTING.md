# Contributing

This project provides a LaTeX class and example report for Cal Poly Electrical
Engineering senior project reports. Contributions should keep the template easy
to clone, build, and adapt in VS Code.

## Branching

`main` should represent the latest stable, publishable template state.

Use feature branches for in-progress changes. Merge to `main` when the example
document builds cleanly and the README describes any user-facing changes.

## Commits

Use Conventional Commits:

```text
type: short imperative summary
```

Common types:

- `feat:` for new class macros, supported formatting behavior, or workflow
  capabilities.
- `fix:` for class, example, bibliography, build, or documentation corrections.
- `docs:` for README, contributing, changelog, or example-text-only changes.
- `chore:` for repository maintenance and generated-output cleanup.
- `refactor:` for restructuring class internals without intended output changes.
- `test:` for CI or build-check changes.

Example:

```text
fix: stabilize appendix references

- Use unique appendix anchors for hyperref.
- Keep appendix entries aligned in the table of contents.
- Update the README appendix example.
```

## Local checks

Before opening a pull request or merging a change, run a clean build:

```sh
latexmk -C -outdir=build Project.tex
latexmk -pdf -synctex=1 -interaction=nonstopmode -file-line-error \
    -outdir=build Project.tex
```

Then inspect `build/Project.pdf` for the affected pages. At minimum, check the
title page, table of contents, figures/tables lists, bibliography, and
appendices after class-formatting changes.

The GitHub Actions workflow also compares the freshly built PDF against
`tests/golden/Project.pdf` by rendering both PDFs page by page. If a change
intentionally affects the output, regenerate and commit both `Project.pdf` and
`tests/golden/Project.pdf` in the same change.

## Documentation expectations

Update `README.md` when a change affects:

- Required LaTeX tools or VS Code setup.
- Public class commands such as `\setauthor`, `\maketitlepage`, or
  `\appsubsection`.
- Citation, Zotero, bibliography, figure, table, appendix, or margin behavior.
- The expected build command or GitHub Actions workflow.

Update `CHANGELOG.md` when preparing a release or when a notable user-facing
change lands.

## Releases

Use semantic version tags in the form `vMAJOR.MINOR.PATCH`.

- Increment `MAJOR` for incompatible class API or output-format changes.
- Increment `MINOR` for new compatible class features or workflow support.
- Increment `PATCH` for bug fixes, documentation corrections, and CI updates.

When preparing a release, keep the class version/date in
`CalPolySeniorProject.cls`, `CHANGELOG.md`, and the git tag aligned.
