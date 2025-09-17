%! Class = enve201notes.cls
%! Author = Len Washington III
%! Date = 9/3/25

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{enve201notes}[Len Washington III's Document Class]

\LoadClass[12pt]{report}

\RequirePackage{kvoptions}

\SetupKeyvalOptions{
	family=envenotes,
	prefix=envenotes@
}

\DeclareStringOption{lecture}
\DeclareStringOption{title}

\ProcessKeyvalOptions*

%\ifnum\envenotes@lecture=0{%
%	\renewcommand{\title}{ENVE 201 - Notes}
%}
%\else{
	\renewcommand{\title}{ENVE 201 - Lecture \envenotes@lecture\ - \envenotes@title}
%}\fi

\RequirePackage[
	title={\title},
]{enve201}
\RequirePackage{enumitem}
\RequirePackage[version=4,arrows=pgf-filled,
	textfontname=sffamily,
	mathfontname=mathsf]{mhchem}
\usetikzlibrary{shapes.geometric}

\renewcommand{\maketitle}{%
	\setcounter{chapter}{\envenotes@lecture}
	\addtocounter{chapter}{-1}
	\chapter{\envenotes@title}\label{ch:\envenotes@lecture}
}

\RequirePackage{enumitem}
\newlist{problems}{enumerate}{3}
\setlist[problems, 1]
{label=\textbf{\arabic{problemsi}.},
	leftmargin=15pt,
}

\RequirePackage{alphalph}
\RequirePackage{bookmark}
\newcommand*\makeAlph[1]{\alphalph{\the\numexpr\value{#1}+1}}
\newcommand*\makeRoman[1]{\romannumeral\the\numexpr\value{#1}+1}
%\newcommand*\makeRoman[1]{\lowercase\expandafter\@slowromancap\romannumeral\the\numexpr\value{#1}+1@}

\definecolor{problempink}{HTML}{ec008c}

\setlist[problems, 1]
{label=\textcolor{problempink}{\textbf{\envenotes@lecture-\arabic{problemsi}}},
	leftmargin=30pt,}

\setlist[problems, 2]
{label=\textbf{(\alph{problemsii})},
	leftmargin=30pt,}

\setlist[problems, 3]
{label=\textbf{(\roman{problemsiii})},
	leftmargin=35pt,}

\newcounter{problem}
\setcounter{problem}{1}
\newcommand{\problem}[1][prb:\the\numexpr\value{chapter}.\the\numexpr\value{section}.\number\value{problemsi}]{%
	\pdfbookmark[3] % Level
	{Problem \envenotes@lecture-\the\numexpr\value{problemsi}+1} % Text
	{#1}% Name/Label
	\item\label{#1}}

\newcommand{\subproblem}{%
	\pdfbookmark[4]% Level
	{Problem \envenotes@lecture-\the\numexpr\value{problemsi}\makeAlph{problemsii}}% Text
	{prb:\envenotes@lecture.\number\value{problemsi}\makeAlph{problemsii}}% Name/Label
	\item\label{prb:\number\value{problemsi}\alph{problemsii}}}

\newcommand{\subsubproblem}{%
	\pdfbookmark[5]% Level
	{Problem \the\numexpr\value{problemsi}\alph{problemsii}(\makeRoman{problemsiii})}% Text
	{prb:\envenotes@lecture.\number\value{problemsi}\alph{problemsii}.\makeRoman{problemsiii}}% Name/Label
	\item\label{prb:\number\value{problemsi}\alph{problemsii}\roman{problemsiii}}}

\newcommand{\answerfile}{%
	\ifenvenotes@corrections%
	notes\envenotes@lecture_corrections%
	\else%
	notes\envenotes@lecture_answers%
	\fi%
}
\newcommand{\addanswer}[1]{% Input the section name
	\begin{answer}\ExecuteMetaData[\answerfile]{#1}\end{answer}
}

\newcommand{\file}[1]{%
	\addtocounter{chapter}{1}%
	\section{#1}\label{sec:#1}
}

\newcommand{\definition}[2]{\emph{#1} -- #2}

\let\oldsubsubsection\subsubsection
\renewcommand{\subsubsection}[2]{
	\oldsubsubsection{#1}\label{#2}
	\pdfbookmark[4]%
	{#1}%
	{#2}%
}