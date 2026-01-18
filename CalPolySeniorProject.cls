\ProvidesClass{CalPolySeniorProject}[2025/12/12
    Cal Poly EE 415 report class]

% --------------------------------------------------
% Base class
% --------------------------------------------------
\LoadClass[12pt,letterpaper]{report}

% --------------------------------------------------
% Packages
% --------------------------------------------------
% NOTE: In a .cls file, use \RequirePackage (not \usepackage).
% Keep lines <= 80 columns and load hyperref last.

% --------------------------------------------------
% Packages
% --------------------------------------------------
% NOTE: In a .cls file, use \RequirePackage (not \usepackage).
% Keep lines <= 80 columns and load hyperref last.

% --- Class options (before geometry) ---
% Allow users to override margins at \documentclass time, e.g.:
% \documentclass[left=1.5in,right=1.25in,top=1.25in,bottom=1.25in]{...}
\RequirePackage{kvoptions}           % key/value options for class files
\SetupKeyvalOptions{family=cpsp,prefix=cpsp@}

% Default margins (match the senior project format).
% Users can override any of these via \documentclass[...] options.
\DeclareStringOption[1.5in]{left}
\DeclareStringOption[1.25in]{right}
\DeclareStringOption[1.25in]{top}
\DeclareStringOption[1.25in]{bottom}

% Parse class options now so geometry sees the final values.
\ProcessKeyvalOptions*

% --- Core utilities ---
\RequirePackage{etoolbox}            % patching macros (\patchcmd, \appto)
\RequirePackage{graphicx}            % \includegraphics, \graphicspath
\RequirePackage[export]{adjustbox}   % \includegraphics[max width=...]
\RequirePackage{geometry}            % margins / page geometry
\RequirePackage{setspace}            % \doublespacing, \setstretch
\RequirePackage{fancyhdr}            % header/footer control
\RequirePackage{caption}             % caption styling (figures + tables)
\RequirePackage{subcaption}          % subfigures/subcaptions
\RequirePackage{tocloft}             % TOC / LOF / LOT formatting
\RequirePackage{booktabs}            % \addlinespace (and nicer tables)

% --- Tables / math ---
\RequirePackage{array}               % \newcolumntype, column padding
\RequirePackage{longtable}           % multipage tables
\RequirePackage{amsmath}             % math environments
\RequirePackage{amsfonts}            % \mathbb, etc.

% --- Typography / links ---
\RequirePackage{microtype}           % nicer spacing/line breaks
\RequirePackage{xurl}                % better URL line breaks
\RequirePackage{ragged2e}            % \RaggedRight

% --- Bibliography ---
\RequirePackage[backend=biber,style=ieee,natbib=true]{biblatex}

% --- Page geometry ---
% Apply margins from class options (or defaults above).
% IMPORTANT: Do not call \geometry{...} again later in the class.
\geometry{%
    letterpaper,
    left=\cpsp@left,
    right=\cpsp@right,
    top=\cpsp@top,
    bottom=\cpsp@bottom
}

% --- Hyperlinks (keep this last) ---
\RequirePackage[hidelinks]{hyperref} % clickable refs w/o colored boxes

% --- Hyperlinks (keep this last) ---
\RequirePackage[hidelinks]{hyperref} % clickable refs w/o colored boxes

% --------------------------------------------------
% ---------- Metadata setters (user-facing API) -----
% --------------------------------------------------
% These commands define the values that users will fill in their preamble
% (title, authors, professor, quarter, etc.). The actual formatting is
% handled later by \maketitlepage.

% Authors: \setauthor{index}{Name}{email}
% storage will be created on first use
% #1 = index (1, 2, 3, ...)
% #2 = full name
% #3 = email address
\newcommand{\setauthor}[3]{%
    \expandafter\def\csname author#1Name\endcsname{#2}%
    \expandafter\def\csname author#1Email\endcsname{\texttt{#3}}%
}

% Professor Line
\newcommand{\professor}{}   % storage for professor name
\newcommand{\setprofessor}[1]{%
    \renewcommand{\professor}{#1}%
}

% Quarter Line
\newcommand{\quarter}{}     % storage for quarter text (e.g., Fall 2025)
\newcommand{\setquarter}[1]{%
    \renewcommand{\quarter}{#1}%
}

% Title Line
\newcommand{\projecttitle}{} % storage for the big title text
\newcommand{\setprojecttitle}[1]{%
    \renewcommand{\projecttitle}{#1}%
}

% Class Line
\newcommand{\class}{}        % e.g., "EE 415"
\newcommand{\setclass}[1]{%
    \renewcommand{\class}{#1}%
}

% Department Line
\newcommand{\department}{}   % e.g., "Electrical Engineering Department"
\newcommand{\setdepartment}[1]{%
    \renewcommand{\department}{#1}%
}

% --------------------------------------------------
% Global formatting (moved from document preamble)
% --------------------------------------------------

% Path to where all images are stored by default
\graphicspath{{Images/}}

% Double-space main text
\doublespacing

% Puts each \section on a new page (like report chapters)
\AddToHook{cmd/section/before}{\clearpage}

% Roman numerals for tables
\renewcommand{\thetable}{\Roman{table}}

% Make all table outlines bolder
\setlength{\arrayrulewidth}{1pt}

% Bold table titles; normal font for table caption text
\captionsetup[table]{labelfont=bf,textfont=normalfont}

% Center all figure captions
\captionsetup{justification=centering}

% Center all table captions
\captionsetup[table]{justification=centering}

% Custom middle column with horizontal padding on each side
\newcolumntype{M}{>{\hspace{6mm}}c<{\hspace{6mm}}}

% --------------------------------------------------
% Section numbering and formatting
% --------------------------------------------------

% Roman nums for section formatting with trailing dots, e.g. "I." and "I1."
\renewcommand{\thesection}{\Roman{section}.}
\renewcommand{\thesubsection}{\thesection\arabic{subsection}.}

% Use custom format for section counters (number + quad space)
\makeatletter
\renewcommand{\@seccntformat}[1]{%
    \csname the#1\endcsname\quad
}
\makeatother

% --------------------------------------------------
% Adjust TOC / LOF / LOT formatting
% --------------------------------------------------

% Adjust TOC:
% Move TOC title upward and set spacing to first entry
\setlength{\cftbeforetoctitleskip}{-2em}
\setlength{\cftaftertoctitleskip}{1em}

% Adjust TOC indent / label width
\setlength{\cftsecnumwidth}{3em}    % width for "I." etc. in TOC
\setlength{\cftsubsecindent}{4.5em} % indent for subsections in TOC

% Adjust LOF:
% Move LOF title upward and set spacing to first entry
\setlength{\cftbeforeloftitleskip}{-2em}
\setlength{\cftafterloftitleskip}{1em}

% Width for figure number in LOF
\setlength{\cftfignumwidth}{5em}

% Add text "Figure" before LOF numbers and colon after
\renewcommand{\cftfigpresnum}{Figure~}
\renewcommand{\cftfigaftersnum}{:}

% Adjust LOT:
% Move LOT title upward and set spacing to first entry
\setlength{\cftbeforelottitleskip}{-2em}
\setlength{\cftafterlottitleskip}{1em}

% Width for table number in LOT
\setlength{\cfttabnumwidth}{5em}

% Add text "Table" before LOT numbers and colon after
\renewcommand{\cfttabpresnum}{Table~}
\renewcommand{\cfttabaftersnum}{:}

% --------------------------------------------------
% Override section format so the first line starts indented
% --------------------------------------------------
% By default LaTeX does NOT indent the first line after a section.
% This patch flips that behavior so paragraphs after sections
% use normal indentation.
\makeatletter
\patchcmd{\@startsection}
    {\@afterindentfalse}  % normal action (no indent)
    {\@afterindenttrue}   % replacement (do indent)
    {}{}                  % do nothing on failure
\makeatother

% --------------------------------------------------
% Fix appendix formatting in TOC
% --------------------------------------------------
% The goal:
%   1) Users should NOT have to manually toggle \inappendixtrue / false.
%   2) Appendix subsections should appear in the TOC as "Appendix A."
%   3) \ref to appendix items should produce "Appendix A" style labels.
%
% We achieve this by:
%   - Tracking an "appendix mode" flag.
%   - Patching \appendix to automatically enter appendix mode.
%   - Providing optional convenience commands \beginappendices/\endappendices.
%   - Using \p@subsection + \thesubsection to make references sane.

\makeatletter  % allow modifying internal commands

% Track when we are in the appendix.
% (Users should never need to call \inappendixtrue/\inappendixfalse directly.)
\newif\ifinappendix
\inappendixfalse

% Save original subsection TOC behavior so we can restore it.
\let\orig@l@subsection\l@subsection

% Save original subsection numbering for restoration when leaving appendices.
\let\cpsp@orig@thesubsection\thesubsection
\let\cpsp@orig@p@subsection\p@subsection

% Enter "appendix mode":
%   - switch subsection numbering to letters (A, B, C, ...)
%   - prefix subsection references with "Appendix "
%   - reset subsection counter so first appendix is A
\newcommand{\cpsp@enterappendix}{%
    \inappendixtrue
    \setcounter{subsection}{0}%
    \renewcommand{\thesubsection}{\Alph{subsection}}%
    \renewcommand{\p@subsection}{Appendix~}%
}

% Leave "appendix mode" (only needed if you return to normal sections later).
\newcommand{\cpsp@leaveappendix}{%
    \inappendixfalse
    \renewcommand{\thesubsection}{\cpsp@orig@thesubsection}%
    \renewcommand{\p@subsection}{\cpsp@orig@p@subsection}%
}

% Patch \appendix so it automatically enables appendix behavior.
% Users can just write \appendix and the class handles the rest.
\let\cpsp@orig@appendix\appendix
\renewcommand{\appendix}{%
    \cpsp@orig@appendix
    \cpsp@enterappendix
}

% Custom TOC line for appendix subsections.
% NOTE:
%   - We ignore the default "number width" from tocloft and print a stable
%     "Appendix A." label ourselves for consistent alignment.
\renewcommand{\l@subsection}[2]{%
    \ifinappendix
        \@dottedtocline{2}{4em}{7em}{Appendix~\Alph{subsection}.}{#2}%
    \else
        \orig@l@subsection{#1}{#2}%
    \fi
}

% Custom appendix subsection for formatting TOC + heading.
% This is what users should call for appendix entries (A, B, C, ...).
%
% IMPORTANT:
%   - If the user forgets to call \appendix, we still "do the right thing"
%     by entering appendix mode automatically the first time \appsubsection
%     is used.
\newcommand{\appsubsection}[1]{%
    \ifinappendix\else
        \cpsp@enterappendix
    \fi
    \refstepcounter{subsection}%
    \addcontentsline{toc}{subsection}%
        {Appendix~\Alph{subsection}.\hspace{1em}#1}%
    \subsection*{Appendix~\Alph{subsection}.\hspace{1em}#1}%
}

% Convenience command:
% Users can write \beginappendices instead of manually doing:
%   \section{Appendices}
%   \appendix
%
% This keeps the user-facing API simple and repeatable.
\newcommand{\beginappendices}{%
    \section{Appendices}%
    \appendix
}

% Optional command to return to normal subsection numbering.
% Only needed if the document continues with non-appendix material afterward.
\newcommand{\stopappendices}{%
    \cpsp@leaveappendix
}

\makeatother

% --------------------------------------------------
% Fix proper page numbering and placement
% --------------------------------------------------
% Override the "plain" page style (used for chapter/section starts)
% to put the page number in the upper-right and remove rules.
\RequirePackage{fancyhdr}
\fancypagestyle{plain}{%
    \fancyhf{}  % clear existing headers and footers
    \fancyhead[R]{%
        \begingroup
        \setstretch{1}  % set single spacing for header
        % \rule{1pt}{15pt}  % bar for checking header height (debug only)
        \thepage         % put page number in right header
        \endgroup
    }%
    \setlength{\headheight}{15pt}
    \renewcommand{\headrulewidth}{0pt} % Remove the header rule
    \renewcommand{\footrulewidth}{0pt} % Remove the footer rule
    \setlength{\headsep}{0.5in}       % Space between header and text
}

% --------------------------------------------------
% All bibliography tweaks live here
% --------------------------------------------------
\appto\bibsetup{%
    \setstretch{1}% single-space within entries
    \RaggedRight
    \sloppy
    \setlength{\emergencystretch}{3em}%
    \setlength{\bibitemsep}{\baselineskip}%
    % (fallback) direct vertical space at the top of the bibliography
    \vspace{.75\baselineskip}%
    % silence minor overfull/underfull box warnings here only
    \hbadness=10000\hfuzz=2pt%
}

% --------------------------------------------------
% Helper for title-page author rows
% --------------------------------------------------
\newcommand{\authorrow}[1]{%
    \large\textbf{\csname author#1Name\endcsname} &
    \csname author#1Email\endcsname
}

% --------------------------------------------------
% Custom title page macro
% --------------------------------------------------
% This macro prints the full formatted title page using all of the
% metadata set via \setprojecttitle, \setauthor, \setprofessor, etc.
\newcommand{\maketitlepage}{%
    \begin{titlepage}
        \centering
        % \vspace*{1em}  % uncomment to push content further down

        {\Huge\bfseries \projecttitle\par}
        \vspace*{3em}

        {\Large\scshape \class\par}%
        \rule{\linewidth}{0.35mm}
        \par\vspace*{0.75em}

        % Author block
        \begin{tabular}{r | l}
            \authorrow{1}%
            \ifcsname author2Name\endcsname
                \\ \addlinespace[1em]
                \authorrow{2}%
            \fi
        \end{tabular}%

        \par\vspace{0.75em}%
        \rule{\linewidth}{0.35mm}%
        \par\vspace{0.75em}%

        % Logo or other image in the center of the page
        \par\includegraphics[width=0.55\textwidth]{Images/Logo.pdf}\par
        \vspace*{1em}

        % Professor / department / university / location block
        \begin{minipage}{\textwidth}
            \centering
            \rule{0pt}{2.5ex}{\large \professor}\par
            \vspace{8pt}
            \rule{0pt}{2.5ex}{\large \department}\par
            \vspace{8pt}
            \rule{0pt}{2.5ex}%
                {\Large California Polytechnic State University}\par
            \vspace{8pt}
            \rule{0pt}{2.5ex}%
                {\small San Luis Obispo \textendash~\quarter}\par
        \end{minipage}

        \vfill
    \end{titlepage}%
}

% --------------------------------------------------
% Global looseness (help avoid ugly overfull lines)
% --------------------------------------------------
\sloppy