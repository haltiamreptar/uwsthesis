\NeedsTeXFormat{LaTeX2e}[2022-06-01]

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

%% Setup the degree name
%%  Default is determined by initial
\ExplSyntaxOn
\keys_define:nn{degreename}{
  degree .initial:n = phd,
  degree .code:n = {\PassOptionsToPackage{#1}{wsuthesis-degreename}\typeout{Setting degree to  `#1`}},
  degree .value_required:n = true,

}
\ExplSyntaxOff
\ProcessKeysOptions{degreename}
\RequirePackage{wsuthesis-degreename}





\RequirePackage{wsuthesis-rest}
\ExecuteOptions{lof,lot,soo,thesis,copy,doublespace,bib,wsu,logo}
\ProcessOptions\relax