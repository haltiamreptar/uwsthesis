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
\RequirePackage{wsucolours}
\RequirePackage{etoolbox}
\RequirePackage{morewrites}
\RequirePackage{graphicx}
\RequirePackage{tikz}
\RequirePackage{l3keys2e}

\RequirePackage{setspace}


%%% Set up  the fonts -- thesse are the *free* versions of what is defined in 
%%% the style guide.
%\usepackage{tgschola}
\usepackage{libertinus}
\usepackage[defaultsans,scale=0.8]{opensans}
%\usepackage{courier}


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
% Requirements
% Title page
% This page contains the thesis title, your full name, 
% the name of the degree for which the thesis is submitted, 
% the name of the university and the year of submission.
% This page should not be numbered.
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


%% TODO
% Dedication page
% The dedication honours those who inspired or encouraged the writing of the 
% thesis. 
% A maximum of one page is permitted. 
% This page is not numbered and is optional.


%%TODO
% Acknowledgements page
% This page is to express recognition of and appreciation for special
% professional assistance provided by academic supervisors, 
% other persons, agencies and institutions.
% This page is not numbered and is optional.

%% Statement of originality
%% Done and compliant, follows wording of Guide except for COC where the
%% COC name is used. Signature can be added as a file that is an option to 
%% the class, or a placeholder can be put in.
%%
% Statement of Authentication page
% This is a signed statement to the effect that the work has not been submitted 
% for a higher degree at any other institution and an undertaking that the work 
% is original and a result of the candidates own research endeavour.
% This page is not numbered and is compulsory.
% You must sign this page – even if you are submitting electronically. 
% A scanned copy of your signature is acceptable.

%% Statement of origionality
\DeclareRobustCommand{\@WSUorigionality}{
{\clearpage\thispagestyle{empty}\vspace*{\fill}
\begin{center}
\begin{minipage}{0.55\textwidth}
%\chapter*{Statement of Authentication}
\begingroup\hyphenation{conformation of candidature}
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
\endgroup
\end{minipage}
\end{center}
\vspace*{\fill}}\clearpage}

\AtBeginDocument{\@WSUorigionality}
%% Think about automating the front matter, including the LOF/LOT/LOL/LOTH

%%TODO
%% Dates need to be done -- on cover, in soo etc...
%% 

%%TODO
% Declarations page
% This page includes declarations to acknowledge any external support you have received during your candidature. This may include:
% ≥ Professional editing services;
% ≥ Australian Government funded scholarships;
% ≥ Industry funded scholarships;
% ≥ Contributions from donors; and,
% ≥ Any declarations that are not suited to your personal acknowledgements page.
% You should also use this section to declare any conflicts of interest.
% This page is not numbered and is optional. ≥ 
%% Table of contents page
% ≥ The table of contents page is a guide to the contents of the thesis.
% ≥ The first item listed should be the first item that appears after the table of contents.
% ≥ Every heading and subheading within the text should be listed verbatim in the table of contents.
% ≥ The headings on the table of contents page should be indented in a consistent style.
% ≥ Page numbers should be aligned with the correct heading or with the last line of multi-line heading.
% List of tables page
% Tables (including those in appendices) should be
% listed and numbered (Arabic numerals) in the order of appearance in the manuscript. Even if there is only one table it should be included in a list of tables.
% List of figures and illustrations page
% The list of figures and illustrations can be formatted similarly to the list of tables.

%%  Set the spacing after the frontmatter!
\AtBeginDocument{\wsu@spacing}

%\RequirePackage{wsuthesis-rest}
\ExecuteOptions{lof,lot,bib}
\ProcessOptions\relax
