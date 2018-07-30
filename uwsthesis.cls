\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{uwsthesis}[2017/07/30
                                v2.5a
                      A class for typesetting UWS/WSU  Theses
                     Evan Crawford (e.crawford@westernsydney.edu.au)]





\RequirePackage{graphicx}
\RequirePackage{multicol,multirow} 
\RequirePackage{morewrites}
\LoadClass[a4paper,oneside,openany]{book}
%\RequirePackage[truedimen,showframe,a4paper,nomarginpar,left=4truecm,right=2.5truecm,top=2.5truecm,bottom=2.5truecm,nohead]{geometry}
\RequirePackage[truedimen,a4paper,nomarginpar,left=4truecm,right=2.5truecm,top=2.5truecm,bottom=2.5truecm,nohead]{geometry}
\RequirePackage[nottoc]{tocbibind}
\RequirePackage{setspace}
%\RequirePackage[printonlyused,withpage]{acronym}
\RequirePackage[printonlyused]{acronym}
%\RequirePackage{acronym}





\RequirePackage[sectionbib]{natbib}
\RequirePackage{multibib}
%\RequirePackage[breaklinks=true]{hyperref}
\newcites{BIB}{Bibliography}
\RequirePackage{listings}
\RequirePackage{rotating}
\RequirePackage{bibentry}
\RequirePackage{supertabular}
\RequirePackage{lscape}
\RequirePackage{xspace}
\RequirePackage{bookmark}
\RequirePackage{etoolbox}
%\RequirePackage{dates}

%% Degree Names
\DeclareRobustCommand{\@deg}{}
\DeclareOption{mphil}{\renewcommand{\@deg}{Master of Philosophy}}
\DeclareOption{mres}{\renewcommand{\@deg}{Master of Research}}
\DeclareOption{msc}{\renewcommand{\@deg}{Master of Science (Honours)}}
\DeclareOption{phd}{\renewcommand{\@deg}{Doctor of Philosophy}}
\DeclareOption{bithns}{\renewcommand{\@deg}{Bachelor of Information Technology (Honours)}}
\DeclareOption{bicthns}{\renewcommand{\@deg}{Bachelor of Information and Communication Technology (Honours)}}
\DeclareOption{compscihns}{\renewcommand{\@deg}{Bachelor of Computer Science (Honours)}}
\DeclareOption{comphns}{\renewcommand{\@deg}{Bachelor of Computing (Honours)}}
\DeclareOption{scimathns}{\renewcommand{\@deg}{Bachelor of Science Mathematics (Honours)}}


%% Document Types
\DeclareRobustCommand{\@coc}{}
\DeclareOption{coc}{\renewcommand{\@coc}{Confirmation of Candidature\\}}
\DeclareOption{thesis}{\renewcommand{\@coc}{thesis}}

%% Copyright Statement
\DeclareRobustCommand{\@copy}{\null}
\DeclareOption{copy}{\renewcommand{\@copy}{\centering\copyright\ \@author \ --\  \number\year\null}}
\DeclareOption{nocopy}{\renewcommand{\@copy}{\null}}


%% Originality Statement
\DeclareOption{soo}{\DeclareRobustCommand{\origionality}{
{\clearpage\thispagestyle{empty}\vspace*{\fill}
\begin{center}
\begin{minipage}{0.6\textwidth}
%\chapter*{Statement of Authentication}
The work presented in this \@coc\ is, to the best of my knowledge and belief, original except as acknowledged in the text.

~

I hereby declare that I have not submitted this material, either in full or in part, for a degree at this or any other institution.

\vspace*{1.5cm}\dotfill\par
\@author\hspace*{\fill}\@date
\end{minipage}
\end{center}
\vspace*{\fill}}\clearpage}}
\DeclareOption{nosoo}{\DeclareRobustCommand{\origionality}{}}


%% Logo 
\DeclareOption{nologo}{\DeclareRobustCommand{\title@logo}{}}
\DeclareOption{logo}{\DeclareRobustCommand{\title@logo}{\centering{\includegraphics[width=0.33\textwidth]{WSU-logo-colour}}}}

%% List of Tables
\DeclareOption{lot}{\DeclareRobustCommand{\@dolistoftables}{\listoftables}}
\DeclareOption{nolot}{\DeclareRobustCommand{\@dolistoftables}{}}

%% List of figures
\DeclareOption{lof}{\DeclareRobustCommand{\@dolistoffigures}{\listoffigures}}
\DeclareOption{nolof}{\DeclareRobustCommand{\@dolistoffigures}{}}


%% Additional bibliography
\DeclareOption{nobib}{\DeclareRobustCommand{\@dobibliography}{}}
\DeclareOption{bib}{\DeclareRobustCommand{\@dobibliography}{
\bibliographystyleBIB{apalike}
\nociteBIB{*}
%% Change it to references
%\renewcommand{\bibname}{References}
\bibliographyBIB{bibliography}}}


%% Institutional Name
\DeclareOption{uws}{\DeclareRobustCommand{\@institution}{University of Western Sydney}}
\DeclareOption{wsu}{\DeclareRobustCommand{\@institution}{Western Sydney University}}

%% Spacing Options
\DeclareOption{doublespace}{\DeclareRobustCommand{\wsu@spacing}{\onehalfspacing}}
\DeclareOption{realdoublespace}{\DeclareRobustCommand{\wsu@spacing}{\doublespacing}}
\DeclareOption{nodoublespace}{\DeclareRobustCommand{\wsu@spacing}{\singlespacing}}


%% The defaults
\ExecuteOptions{lof,lot,soo,phd,thesis,copy,doublespace,bib,wsu,logo}
\ProcessOptions\relax


%% Numbering and Contents
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}

%% How to hide a whole bunch of stuff
\DeclareRobustCommand{\comment}[1]{}


%% Thing to print citations if they exist, show if >0
\newcommand{\cites}[1]{\textbf{\ifnum 0#1>0  \\Citations: #1\fi}}



\pagestyle{plain}

% new title page
%% Supervisors, added to title page if used
\DeclareRobustCommand{\supervisors}[1]{\DeclareRobustCommand{\@super}{#1}}
\newcommand{\@supline}[1]{#1\par}
\def\thickhrulefill{\leavevmode \leaders \hrule height 1pt\hfill \kern \z@}
\renewcommand{\maketitle}{\onehalfspacing\begin{titlepage}%
\title@logo\par
    \let\footnotesize\small
    \let\footnoterule\relax
    \parindent \z@
    \reset@font
    \null\vskip 60pt
    \hrule height 4pt
    \vskip 10\p@
    \begin{flushright}
      \Huge 
      \strut \@title \par
      \vskip 15\p@\LARGE
      \strut \@author \par
    \vskip 5\p@
    \hrule height 4pt
    \vskip 120\p@
\centering
      A \@coc\ submitted for the degree of \par
     \@deg\par
      at\par
      \@institution\par
      \vskip 15\p@
      \ifcase\month\or January\or February\or March\or April\or May\or June\or July\or August\or September\or October\or November\or December\fi\ \number\year\par
    \end{flushright}
\ifdefined\@super
    \vskip 20\p@
    \centering
   \Large
    Supervisors:\\
    \large    
      \begingroup\edef\x{\endgroup\noexpand\forcsvlist\noexpand\@supline{\@super}}\x
\fi
   \vspace*{\fill}\normalsize\@copy
  \end{titlepage}%
  \setcounter{footnote}{0}\wsu@spacing%
}



%hack for centred chapters

\def\@makechapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \centering
    \normalfont
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
       \huge\bfseries \@chapapp\space \thechapter
        \par\nobreak
        \vskip 20\p@
      \fi
    \fi
    \interlinepenalty\@M
    \Huge \bfseries #1\par\nobreak
    \vskip 40\p@
  }}

\def\@schapter#1{\if@twocolumn
                   \@topnewpage[\@makeschapterhead{#1}]%
                 \else
                   \@makeschapterhead{#1}%
                   \@afterheading
                 \fi}

\def\@makeschapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \centering
    \normalfont
    \interlinepenalty\@M
    \Huge \bfseries  #1\par\nobreak
    \vskip 40\p@
  }}

%%Hack for maths in headings

\DeclareRobustCommand*{\bfseries}{%
  \not@math@alphabet\bfseries\mathbf
  \fontseries\bfdefault\selectfont
  \boldmath
}  

%% Submission Date
\DeclareRobustCommand{\subdate}[3]{\renewcommand{\year}{#3}\renewcommand{\month}{#2}\renewcommand{\day}{#1}}

%% Abstract
\DeclareRobustCommand{\abst}{\chapter{Abstract}\theabst}
\newcommand{\theabst}{}
\DeclareRobustCommand{\abstract}[1]{\renewcommand{\theabst}{#1}}

%% Acknowledgements
\DeclareRobustCommand{\acknowledgements}[1]{\DeclareRobustCommand{\@akn}{#1}}

%% Dedication
\DeclareRobustCommand{\dedication}[1]{\DeclareRobustCommand{\@ded}{#1}}

%% Publications 
\DeclareRobustCommand{\pubs}[1]{\DeclareRobustCommand{\@pubs}{#1}}

%% Foreword
\DeclareRobustCommand{\foreword}[1]{\DeclareRobustCommand{\@fore}{#1}}



%% Acronyms
\DeclareRobustCommand{\theacro}{}
\DeclareRobustCommand{\theacrowd}{}
\DeclareRobustCommand{\arcos}{
\chapter{List of Abbreviations}
%% uncomment the begin multicols and end to turn on multicols acronym list
%\begin{multicols*}{2}
\begin{acronym}[\theacrowd]
\theacro
\end{acronym}
%\end{multicols*}
}
\DeclareRobustCommand{\acronymlist}[2]{\renewcommand{\theacro}{#2}\renewcommand{\theacrowd}{#1}}




\DeclareRobustCommand{\frontstuff}{\frontmatter
\pagenumbering{Alph}
\maketitle
\pagestyle{empty}
\cleardoublepage
\pagestyle{empty}
\ifdefined\@ded
\chapter*{Dedication}
\thispagestyle{empty}
\@ded
\cleardoublepage
\fi
\ifdefined\@akn
\chapter*{Acknowledgements}
\thispagestyle{empty}
\@akn
\cleardoublepage
\fi
\origionality
\cleardoublepage
\ifdefined\@fore
\chapter*{Foreword}
\thispagestyle{empty}
\@fore
\cleardoublepage
\fi
\pagestyle{plain}
\setcounter{page}{1}
\pagenumbering{roman}
\tableofcontents\cleardoublepage
\@dolistoftables\cleardoublepage
\@dolistoffigures\cleardoublepage
\abst\cleardoublepage
\arcos\cleardoublepage
\ifdefined\@pubs
\chapter{Publications}
\@pubs
\fi
\mainmatter}



%%% Whack this in so \bibentry picks up from references

\nobibliography*



\DeclareRobustCommand{\bibandref}{
\renewcommand{\bibsection}{\chapter*{\refname}\addcontentsline{toc}{chapter}{\refname}}
\bibliographystyle{apalike}
%% Change it to references
\renewcommand{\bibname}{References}
\bibliography{references}
\@dobibliography
}



%%% fix for ads macros

\DeclareRobustCommand{\lt}{\textless}
\DeclareRobustCommand{\gt}{\textgreater}

\let\jnl@style=\relax
\def\ref@jnl#1{{\jnl@style#1}}
\def\aj{\ref@jnl{AJ}}                   % Astronomical Journal
\def\araa{\ref@jnl{ARA\&A}}             % Annual Review of Astron and Astrophys
\def\apj{\ref@jnl{ApJ}}                 % Astrophysical Journal
\def\apjl{\ref@jnl{ApJ}}                % Astrophysical Journal, Letters
\def\apjs{\ref@jnl{ApJS}}               % Astrophysical Journal, Supplement
\def\ao{\ref@jnl{Appl.~Opt.}}           % Applied Optics
\def\apss{\ref@jnl{Ap\&SS}}             % Astrophysics and Space Science
\def\aap{\ref@jnl{A\&A}}                % Astronomy and Astrophysics
\def\aapr{\ref@jnl{A\&A~Rev.}}          % Astronomy and Astrophysics Reviews
\def\aaps{\ref@jnl{A\&AS}}              % Astronomy and Astrophysics, Supplement
\def\azh{\ref@jnl{AZh}}                 % Astronomicheskii Zhurnal
\def\baas{\ref@jnl{BAAS}}               % Bulletin of the AAS
\def\jrasc{\ref@jnl{JRASC}}             % Journal of the RAS of Canada
\def\memras{\ref@jnl{MmRAS}}            % Memoirs of the RAS
\def\mnras{\ref@jnl{MNRAS}}             % Monthly Notices of the RAS
\def\pra{\ref@jnl{Phys.~Rev.~A}}        % Physical Review A: General Physics
\def\prb{\ref@jnl{Phys.~Rev.~B}}        % Physical Review B: Solid State
\def\prc{\ref@jnl{Phys.~Rev.~C}}        % Physical Review C
\def\prd{\ref@jnl{Phys.~Rev.~D}}        % Physical Review D
\def\pre{\ref@jnl{Phys.~Rev.~E}}        % Physical Review E
\def\prl{\ref@jnl{Phys.~Rev.~Lett.}}    % Physical Review Letters
\def\pasp{\ref@jnl{PASP}}               % Publications of the ASP
\def\pasj{\ref@jnl{PASJ}}               % Publications of the ASJ
\def\qjras{\ref@jnl{QJRAS}}             % Quarterly Journal of the RAS
\def\skytel{\ref@jnl{S\&T}}             % Sky and Telescope
\def\solphys{\ref@jnl{Sol.~Phys.}}      % Solar Physics
\def\sovast{\ref@jnl{Soviet~Ast.}}      % Soviet Astronomy
\def\ssr{\ref@jnl{Space~Sci.~Rev.}}     % Space Science Reviews
\def\zap{\ref@jnl{ZAp}}                 % Zeitschrift fuer Astrophysik
\def\nat{\ref@jnl{Nature}}              % Nature
\def\iaucirc{\ref@jnl{IAU~Circ.}}       % IAU Cirulars
\def\aplett{\ref@jnl{Astrophys.~Lett.}} % Astrophysics Letters
\def\apspr{\ref@jnl{Astrophys.~Space~Phys.~Res.}}
                % Astrophysics Space Physics Research
\def\bain{\ref@jnl{Bull.~Astron.~Inst.~Netherlands}} 
                % Bulletin Astronomical Institute of the Netherlands
\def\fcp{\ref@jnl{Fund.~Cosmic~Phys.}}  % Fundamental Cosmic Physics
\def\gca{\ref@jnl{Geochim.~Cosmochim.~Acta}}   % Geochimica Cosmochimica Acta
\def\grl{\ref@jnl{Geophys.~Res.~Lett.}} % Geophysics Research Letters
\def\jcp{\ref@jnl{J.~Chem.~Phys.}}      % Journal of Chemical Physics
\def\jgr{\ref@jnl{J.~Geophys.~Res.}}    % Journal of Geophysics Research
\def\jqsrt{\ref@jnl{J.~Quant.~Spec.~Radiat.~Transf.}}
                % Journal of Quantitiative Spectroscopy and Radiative Transfer
\def\memsai{\ref@jnl{Mem.~Soc.~Astron.~Italiana}}
                % Mem. Societa Astronomica Italiana
\def\nphysa{\ref@jnl{Nucl.~Phys.~A}}   % Nuclear Physics A
\def\physrep{\ref@jnl{Phys.~Rep.}}   % Physics Reports
\def\physscr{\ref@jnl{Phys.~Scr}}   % Physica Scripta
\def\planss{\ref@jnl{Planet.~Space~Sci.}}   % Planetary Space Science
\def\procspie{\ref@jnl{Proc.~SPIE}}   % Proceedings of the SPIE
\def\nar{\ref@jnl{New A Rev.}}%
\def\rmxaa{\ref@jnl{Rev. Mexicana Astron. Astrofis.}}%
\def\cjaa{\ref@jnl{Chinese J. Astron. Astrophys.}}%
          % Chinese Journal of Astronomy and Astrophysics
\def\actaa{\ref@jnl{Acta Astron.}}%
\def\pasa{\ref@jnl{PASA}}
\let\astap=\aap
\let\apjlett=\apjl
\let\apjsupp=\apjs
\let\applopt=\ao



\def\jcap{\ref@jnl{JCAP}}               % Journal of Cosmology and Astroparticle Physics
%% add macros after here!!!
%newcommand defs start
%\newcommand{\romn}[1] {{\mathrm #1}}
\newcommand{\rmn}[1]{{\mathrm{#1}}}
\newcommand{\amp}{\&}
%\newcommand\degr{\hbox{$^\circ$}}

%\newcommand\arcmin{\hbox{$^\prime$}}

%\newcommand\arcsec{\hbox{$^{\prime\prime}$}}



%\newcommand\fs{\hbox{$.\!\!^{\reset@font\romn s}$}}

\newcommand{\la}{\,\rlap{\raise 0.5ex\hbox{$<$}}{\lower 1.0ex\hbox{$\sim$}}\,}
\newcommand{\ga}{\,\rlap{\raise 0.5ex\hbox{$>$}}{\lower 1.0ex\hbox{$\sim$}}\,}
\newcommand{\upi}{\pi}
\newcommand{\umu}{\mu}
\newcommand{\upartial}{\partial}
\newcommand\getsto{\mathrel{\mathchoice {\vcenter{\offinterlineskip
\halign{\hfil
$\reset@font\displaystyle##$\hfil\cr\gets\cr\to\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\textstyle##$\hfil\cr\gets
\cr\to\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\scriptstyle##$\hfil\cr\gets
\cr\to\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\scriptscriptstyle##$\hfil\cr
\gets\cr\to\cr}}}}}



\newcommand\cor{\mathrel{\mathchoice {\hbox{$\widehat=$}}{\hbox{$\widehat=$}}
{\hbox{$\reset@font\scriptstyle\hat=$}}
{\hbox{$\reset@font\scriptscriptstyle\hat=$}}}}


\newcommand\lid{\mathrel{\mathchoice {\vcenter{\offinterlineskip\halign{\hfil
$\reset@font\displaystyle##$\hfil\cr<\cr\noalign{\vskip1.2pt}=\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\textstyle##$\hfil\cr<\cr
\noalign{\vskip1.2pt}=\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\scriptstyle##$\hfil\cr<\cr
\noalign{\vskip1pt}=\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\scriptscriptstyle##$\hfil\cr
<\cr
\noalign{\vskip0.9pt}=\cr}}}}}



\newcommand\gid{\mathrel{\mathchoice {\vcenter{\offinterlineskip\halign{\hfil
$\reset@font\displaystyle##$\hfil\cr>\cr\noalign{\vskip1.2pt}=\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\textstyle##$\hfil\cr>\cr
\noalign{\vskip1.2pt}=\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\scriptstyle##$\hfil\cr>\cr
\noalign{\vskip1pt}=\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\scriptscriptstyle##$\hfil\cr
>\cr
\noalign{\vskip0.9pt}=\cr}}}}}



\newcommand\sol{\mathrel{\mathchoice {\vcenter{\offinterlineskip\halign{\hfil
$\reset@font\displaystyle##$\hfil\cr\sim\cr<\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\textstyle##$\hfil\cr\sim\cr
<\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\scriptstyle##$\hfil\cr\sim\cr
<\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\scriptscriptstyle##$\hfil\cr
\sim\cr<\cr}}}}}



\newcommand\sog{\mathrel{\mathchoice {\vcenter{\offinterlineskip\halign{\hfil
$\reset@font\displaystyle##$\hfil\cr\sim\cr>\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\textstyle##$\hfil\cr\sim\cr
>\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\scriptstyle##$\hfil\cr
\sim\cr>\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\scriptscriptstyle##$\hfil\cr
\sim\cr>\cr}}}}}



\newcommand\lse{\mathrel{\mathchoice {\vcenter{\offinterlineskip\halign{\hfil
$\reset@font\displaystyle##$\hfil\cr<\cr\simeq\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\textstyle##$\hfil\cr
<\cr\simeq\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\scriptstyle##$\hfil\cr
<\cr\simeq\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\scriptscriptstyle##$\hfil\cr
<\cr\simeq\cr}}}}}



\newcommand\gse{\mathrel{\mathchoice {\vcenter{\offinterlineskip\halign{\hfil
$\reset@font\displaystyle##$\hfil\cr>\cr\simeq\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\textstyle##$\hfil\cr
>\cr\simeq\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\scriptstyle##$\hfil\cr
>\cr\simeq\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\scriptscriptstyle##$\hfil\cr
>\cr\simeq\cr}}}}}



\newcommand\grole{\mathrel{\mathchoice {\vcenter{\offinterlineskip\halign{\hfil
$\reset@font\displaystyle##$\hfil\cr>\cr\noalign{\vskip-1.5pt}<\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\textstyle##$\hfil\cr
>\cr\noalign{\vskip-1.5pt}<\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\scriptstyle##$\hfil\cr
>\cr\noalign{\vskip-1pt}<\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\scriptscriptstyle##$\hfil\cr
>\cr\noalign{\vskip-0.5pt}<\cr}}}}}



\newcommand\leogr{\mathrel{\mathchoice {\vcenter{\offinterlineskip\halign{\hfil
$\reset@font\displaystyle##$\hfil\cr<\cr\noalign{\vskip-1.5pt}>\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\textstyle##$\hfil\cr
<\cr\noalign{\vskip-1.5pt}>\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\scriptstyle##$\hfil\cr
<\cr\noalign{\vskip-1pt}>\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\scriptscriptstyle##$\hfil\cr
<\cr\noalign{\vskip-0.5pt}>\cr}}}}}



\newcommand\loa{\mathrel{\mathchoice {\vcenter{\offinterlineskip\halign{\hfil
$\reset@font\displaystyle##$\hfil\cr<\cr\approx\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\textstyle##$\hfil\cr
<\cr\approx\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\scriptstyle##$\hfil\cr
<\cr\approx\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\scriptscriptstyle##$\hfil\cr
<\cr\approx\cr}}}}}



\newcommand\goa{\mathrel{\mathchoice {\vcenter{\offinterlineskip\halign{\hfil
$\reset@font\displaystyle##$\hfil\cr>\cr\approx\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\textstyle##$\hfil\cr
>\cr\approx\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\scriptstyle##$\hfil\cr
>\cr\approx\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\reset@font\scriptscriptstyle##$\hfil\cr
>\cr\approx\cr}}}}}

\newcommand\sun{\hbox{$\odot$}}
\newcommand\earth{\hbox{$\oplus$}}
\newcommand\degr{\hbox{$^\circ$}}

\newcommand\diameter{{\ifmmode\mathchoice
{\ooalign{\hfil\hbox{$\reset@font\displaystyle/$}\hfil\crcr
{\hbox{$\reset@font\displaystyle\mathchar"20D$}}}}
{\ooalign{\hfil\hbox{$\reset@font\textstyle/$}\hfil\crcr
{\hbox{$\reset@font\textstyle\mathchar"20D$}}}}
{\ooalign{\hfil\hbox{$\reset@font\scriptstyle/$}\hfil\crcr
{\hbox{$\reset@font\scriptstyle\mathchar"20D$}}}}
{\ooalign{\hfil\hbox{$\reset@font\scriptscriptstyle/$}\hfil\crcr
{\hbox{$\reset@font\scriptscriptstyle\mathchar"20D$}}}}
\else{\ooalign{\hfil/\hfil\crcr\mathhexbox20D}}%
\fi}}



\newcommand\sq{\ifmmode\squareforqed\else{\unskip\nobreak\hfil
\penalty50\hskip1em\null\nobreak\hfil\squareforqed
\parfillskip=0pt\finalhyphendemerits=0\endgraf}\fi}
\newcommand\squareforqed{\hbox{\rlap{$\sqcap$}$\sqcup$}}



\newcommand{\romn}[1] {{\mathrm #1}}



\newcommand\fd{\hbox{$.\!\!^{\reset@font\romn d}$}}

\newcommand\fh{\hbox{$.\!\!^{\reset@font\romn h}$}}

\newcommand\fm{\hbox{$.\!\!^{\reset@font\romn m}$}}

\newcommand\fs{\hbox{$.\!\!^{\reset@font\romn s}$}}

\newcommand\fdg{\hbox{$.\!\!^\circ$}}

\newcommand\farcm{\hbox{$.\mkern-4mu^\prime$}}

\newcommand\farcs{\hbox{$.\!\!^{\prime\prime}$}}

\newcommand\fp{\hbox{$.\!\!^{\reset@font\reset@font\scriptscriptstyle\romn p}$}}

\newcommand\arcmin{\hbox{$^\prime$}}

\newcommand\arcsec{\hbox{$^{\prime\prime}$}}



\def\micron{\hbox{$\umu$m}}



\DeclareRobustCommand{\ion}[2]{%
\relax\ifmmode
\ifx\testbx\f@series
{\mathbf{#1\,\mathsc{#2}}}\else
{\mathrm{#1\,\mathsc{#2}}}\fi
\else\textup{#1\,{\mdseries\textsc{#2}}}%
\fi}



