\ProvidesClass{cv}
\NeedsTeXFormat{LaTeX2e}

\LoadClass{article}

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Packages & Settings
%%%%%%%%%%%%%%%%%%%%%%%%%%

\usepackage{anyfontsize}
\usepackage{array}
\usepackage[english]{babel}
\usepackage{color}
\usepackage{fontspec}
\usepackage{fancyhdr,lastpage}
\usepackage{hyperref}
\usepackage{lipsum}
\usepackage{paralist}
\usepackage[nodisplayskipstretch]{setspace}
\usepackage{tabularx}
\usepackage{vwcol}
\usepackage[dvipsnames]{xcolor}
\usepackage{datetime}
\usepackage{enumitem}

\setmainfont[
   ItalicFont     = *-Italic,
   BoldFont       = *-Bold,
   BoldItalicFont = *-Bold Italic]{TeX Gyre Heros}
\definecolor{darkblue}{HTML}{003399}
\definecolor{sectiongray}{HTML}{6a6e75}
\definecolor{gray}{HTML}{4a484c}
\definecolor{lightgray}{HTML}{4e5158}

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% STRUCTURE
%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Put section titles on left
\reversemarginpar

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Set margins-- this has to be done after /reversemarginpar
\usepackage[
    paper=letterpaper, 
    includefoot, % Put page number below margin
    marginparwidth=30mm, % Length of section titles
    marginparsep=2.5mm,    % Space between titles and text
    margin=1in,           
    textheight=24cm,
    includemp
]{geometry}

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Get rid of indenting throughout entire document
\setlength{\parindent}{0in}

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Set color of links in document
\hypersetup{colorlinks,breaklinks,
            linkcolor=darkblue,urlcolor=darkblue,
            anchorcolor=darkblue,citecolor=darkblue,
            }

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Footer

% footer text style
\newcommand{\footerstyle}[1]{
    \footnotesize \color{lightgray} #1 
}

% last updated date: <month year> format
\newdateformat{monthyeardate}{\monthname[\THEMONTH] \THEYEAR}

\pagestyle{fancy}

% remove header rule
\fancyhf{}\renewcommand{\headrulewidth}{0pt}

% adjust footer margin


% hspace adds for some reason some extra horizontal margin which we correct for here
\newlength{\hspacemargin}
\setlength{\hspacemargin}{0.1cm}

\fancyfootoffset{\marginparsep-\hspacemargin}

\newlength{\footshift}
\setlength{\footshift}{0.5\textwidth+0.5\marginparsep+0.5\marginparwidth-2in+\hspacemargin} % 2in is margin on both sides defined above

\fancyfoot[L]{\hspace*{-\footshift}
    \footerstyle{\monthyeardate\today}}
\fancyfoot[C]{\hspace*{-\footshift}
    \footerstyle{Markus Löning $\cdot$ CV}}
\fancyfoot[R]{\hspace*{} % hspace also creates some extra vertical margin, hence if we use it for the [C] and [L] footers, we have to use it here too
    \footerstyle{\arabic{page} of \protect\pageref*{LastPage}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create command for section headers
\renewcommand{\section}[2]%
        {\pagebreak[2]\vspace{1.25\baselineskip}%
         \phantomsection\addcontentsline{toc}{section}{#1}%
         \leavevmode\marginpar{\flushleft \
         % leave empty line
         
         \color{sectiongray} #1}#2}

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create new column types for tables
% Uncomment this to vertically center the rows:
% \renewcommand{\tabularxcolumn}[1]{m{#1}}
\renewcommand{\arraystretch}{1.85}
\newcolumntype{l}{>{\raggedright\let\newline\\\arraybackslash}X}
\newcolumntype{c}{>{\centering\let\newline\\\arraybackslash\hspace{0pt}\hsize=.5\hsize}X}
\newcolumntype{r}{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}\hsize=.5\hsize}X}


%%%%%%%%%%%%%%%%
% Bibliography %
%%%%%%%%%%%%%%%%

\RequirePackage[style=verbose,
                maxnames=99,
                sorting=chronological, backend=biber]{biblatex}

\newbibmacro{string+doi}[1]{%
  \iffieldundef{doi}{#1}
    {\href{http://dx.doi.org/\thefield{doi}}{#1}%
  }%
  \setunit{\par}
}

\DeclareSortingTemplate{chronological}{
  \sort[direction=descending]{\field{year}}
  \sort[direction=descending]{\field{month}}
}
% \setlength{\bibhang}{0pt}

\defbibenvironment{bibliography}
  \noindent
  {\enumerate}
  {\endenumerate}
  {\item[]}

%%%%%%%%%%%%%%%%%
% Personalize   %
%%%%%%%%%%%%%%%%%

\newcommand{\underlineauthor}[1]{%
    \expandafter\ifstrequal\expandafter{\namepartfamily}{#1}%
    {\addfontfeature{Color=black}\underline{{\namepartgiveni\space}\namepartfamily}}%
    {\addfontfeature{Color=lightgray}{\namepartgiveni\space}\namepartfamily}
}

\DeclareNameFormat{author}{%
  \small
  \underlineauthor{Löning}
  \ifthenelse{\value{listcount}<\value{liststop}}
    {\addcomma\space}
    {\adddot}%
}

%%%%%%%%%%%%%%%%%
% Article Types %
%%%%%%%%%%%%%%%%%

\DeclareFieldFormat[article]{title}%
    {\usebibmacro{string+doi}{#1}}
\DeclareFieldFormat[proceedings]{title}%
    {\usebibmacro{string+doi}{#1}}
\DeclareFieldFormat[misc]{title}%
    {\usebibmacro{string+doi}{#1}}

\DeclareBibliographyDriver{article}{%
	\printfield{title}
  \newblock%
	\vspace{2.5pt}%
  \printnames{author}%
  \par%
  \newblock%
	\vspace{.5pt}%
  {%
    \small\addfontfeature{Color=black}\itshape%
    \usebibmacro{journal+issuetitle}%
    \setunit{\space}%
    \printfield{pages}%
    \newunit%
		.
  }
  \par\vspace{0.95\baselineskip}
}

\DeclareBibliographyDriver{proceedings}{%
  \printfield{title}%
  \newblock%
	\vspace{2.5pt}%
  \printnames{author}%
  \par%
  \newblock%
	\vspace{.5pt}%
  {%
    \footnotesize\addfontfeature{Color=black}\itshape%
    \printlist{organization}%
    \setunit{\space}%
    \newunit%
    \usebibmacro{journal+issuetitle}%
    \setunit*{\addcomma\space}%
    \newunit%
		.
  }
  \par\vspace{0.95\baselineskip}
}

\DeclareBibliographyDriver{misc}{%
  \printfield{title}%
  \newblock%
	\vspace{2.5pt}%
  \printnames{author}%
  \par%
  \newblock%
	\vspace{.5pt}%
  {%
    \footnotesize\addfontfeature{Color=black}\itshape%
    \printlist{organization}%
    \setunit{\space}%
    \newunit%
    \usebibmacro{journal+issuetitle}%
    \setunit*{\addcomma\space}%
    \newunit%
		.
  }
  \par\vspace{0.95\baselineskip}
}
