\NeedsTeXFormat{LaTeX2e}%[2022-06-01]

\ProvidesClass{wsuthesis}[2023/09/27
                                v0.1
                      A class for typesetting WSU Theses
                     Evan Crawford (e.crawford@westernsydney.edu.au)]


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


%% Setup the degree name
%%  
\ExplSyntaxOn
\str_new:N\@deg
%%The default  is PhD!
\str_set:Nn\@deg{Doctor~of~Philosophy}
%% The keys below will override it.
\keys_define:nn{degreename}{
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
\ProcessKeysOptions{degreename}\relax
\ExplSyntaxOff

\typeout{Degree name set to `\@deg'}
\let\degree=\@deg

%%% Do optional Covers, plain WSU logo or the title/author
%% Load wsucovers with option to do that.
\RequirePackage{wsucovers}
%% Think about automating the front matter, including the LOF/LOT/LOL/LOTH



\RequirePackage{wsuthesis-rest}
\ExecuteOptions{lof,lot,soo,thesis,copy,doublespace,bib,wsu,logo}
\ProcessOptions\relax