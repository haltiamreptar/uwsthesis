\NeedsTeXFormat{LaTeX2e}%[2022-06-01]

\ProvidesClass{wsuthesis}[2023/09/27
                                v0.1
                      A class for typesetting WSU Theses
                     Evan Crawford (e.crawford@westernsydney.edu.au)]

%% Some things are taken from https://www.westernsydney.edu.au/__data/assets/pdf_file/0006/1064364/GRS_HDR_Examination_Handbook_2019.pdf cf Appendix 1


%% A thesis is a book so lets start there!
\LoadClass[a4paper,oneside]{book}
%% Page  margiin requirements.
\RequirePackage[truedimen,a4paper,nomarginpar,left=4truecm,right=2.5truecm,top=2.5truecm,bottom=2.5truecm,nohead]{geometry}

%%  Some housekeeping things
\RequirePackage{etoolbox}
\RequirePackage{morewrites}
\RequirePackage{graphicx}
\RequirePackage{tikz}
\RequirePackage{l3keys2e}
\RequirePackage{wsucolours}
\RequirePackage{setspace}

%% Setup the degree name
%%  
\ExplSyntaxOn
\str_new:N\@deg
%%The default  is PhD!
\str_set:Nn\@deg{Doctor~of~Philosophy}
%% The keys below will override it.
\keys_define:nn{@wsudegreename}{
  degree .choice:,
  degree / mphil   .code:n = \str_set:Nn\@deg{Master~of~Philosophy},
  degree / mres    .code:n = \str_set:Nn\@deg{Master~of~Research},
  degree / mschons .code:n = \str_set:Nn\@deg{Master~of~Science~(Honours)},
  degree / msc     .code:n = \str_set:Nn\@deg{Master\c_space_tl of\c_space_tl Science},
  degree / phd     .code:n = \str_set:Nn\@deg{Doctor~of~Philosophy},
  %% Declare others here use the format:
  % degree / NAME  .code:n = \str_set:Nn\@deg{NAME~OF~DEGREE}
  % The spaces in the name must be either ~ or \c_space_tl
}
\ProcessKeysOptions{@wsudegreename}\relax


%% Now set up  the monograph type,  signature file for the SOO if wanted
%% and the spacing options
\str_new:N\@coc
\str_set:Nn\@coc{thesis}
%% Spacing Options
\newcommand{\wsu@spacing}{\onehalfspacing}

\keys_define:nn{@wsuopts}
{
  type .choice:,
  type / thesis .code:n = \str_set:Nn\@coc{thesis},
  type / coc    .code:n = \str_set:Nn\@coc{Confirmation~of~Candidature},
  type / COC    .code:n = \str_set:Nn\@coc{Confirmation~of~Candidature},
 

  signature     .code:n = \newcommand{\soo@signature}{#1},
  spacing .choice:,
  spacing / single  .code:n = \renewcommand{\wsu@spacing}{\singlespacing},
  spacing / double  .code:n = \renewcommand{\wsu@spacing}{\doublespacing},
  spacing / onehalf .code:n = \renewcommand{\wsu@spacing}{\onehalfspacing},
  spacing .default:n = onehalf,
}

\ProcessKeysOptions{@wsuopts}\relax
\ExplSyntaxOff
\typeout{Mongraph type set to`\@coc'}
\typeout{Degree name set to `\@deg'}
\let\degree=\@deg

%% Start by making the document single spaced 
\singlespacing
%%% Do optional Covers, plain WSU logo or the title/author
%% Load wsucovers with option to do that.
\RequirePackage{wsucovers}
\ExplSyntaxOn
\keys_define:nn{@wsucovers}{
  cover .choice:,
  cover / blank        .code:n = \AtBeginDocument{\@WSUcover{}{}}\typeout{Setting~Cover~to~blank~WSU~style},
  cover / title        .code:n = \AtBeginDocument{\@WSUcover{\@title}{}}\typeout{Setting~Cover~to~WSU~style~with~Title~on~first~line},
  cover / title-author .code:n = \AtBeginDocument{\@WSUcover{\@title}{\@author}}\typeout{Setting~Cover~to~WSU~style~with~Title~on~first~line,~Author~on~second},
  cover / none         .code:n = \relax\typeout{Not~adding~a~front~cover},
  back-cover           .code:n = \AtEndDocument{\@WSUbackcover}\typeout{Adding~the~WSU~back~cover},
}
\ProcessKeysOptions{@wsucovers}\relax
\ExplSyntaxOff



%% Guide requires a title page
%% Lets do that with an option and a sub-package
\ExplSyntaxOn
\bool_new:N \@_titlepage
\bool_set_true:N \@_titlepage
\keys_define:nn{@wsutitle}{
  titlepage .code:n = \usepackage[]{wsuthesis-title-#1}\bool_set_false:N\@_titlepage,
  titlepage .default:n = default,
 
}
\ProcessKeysOptions{@wsutitle}\relax
\bool_if:NT\@_titlepage{\usepackage{wsuthesis-title-default}}
\ExplSyntaxOff
%% Add the titlepage  to the document  
%% It is the first unnumbered page, so set that up too
\AtBeginDocument{\pagenumbering{gobble}}
\AtBeginDocument{\maketitle}

%% Statement of origionality
\DeclareRobustCommand{\@WSUorigionality}{
{\clearpage\thispagestyle{empty}\vspace*{\fill}
\begin{center}
\begin{minipage}{0.6\textwidth}
%\chapter*{Statement of Authentication}
The work presented in this \@coc\ is, to the best of my knowledge and belief, original except as acknowledged in the text.

~

I hereby declare that I have not submitted this material, either in full or in part, for a degree at this or any other institution.

\ifdefined\soo@signature %
%\fbox
{\parbox[t][1.5cm][c]{\textwidth}{\centering\includegraphics[height=2.5cm]{\soo@signature}}}\typeout{adding signature}\par
\else%
\vspace*{1.5cm}\typeout{No signature}
\fi%
\dotfill\par
\@author\hspace*{\fill}
\ifdefined\yearrev
\ifcase\monthrev\or January\or February\or March\or April\or May\or June\or July\or August\or September\or October\or November\or December\fi\  \dayrev,\ \number\yearrev\par
\else
\@date\par
\fi
\end{minipage}
\end{center}
\vspace*{\fill}}\clearpage}

\AtBeginDocument{\@WSUorigionality}
%% Think about automating the front matter, including the LOF/LOT/LOL/LOTH



%%  Set the spacing after the frontmatter!
\AtBeginDocument{\wsu@spacing}

%\RequirePackage{wsuthesis-rest}
\ExecuteOptions{lof,lot,bib}
\ProcessOptions\relax
