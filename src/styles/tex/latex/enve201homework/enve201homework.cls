%! Class = enve201homework.cls
%! Author = Len Washington III
%! Date = 2/1/25

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{enve201homework}[Len Washington III's Document Class]

\LoadClass[12pt]{report}

\RequirePackage{kvoptions}

\SetupKeyvalOptions{
	family=envehomework,
	prefix=envehomework@
}

\DeclareStringOption{number}
\DeclareBoolOption[true]{answers}
\DeclareBoolOption[false]{corrections}
\DeclareStringOption[]{title}

\ProcessKeyvalOptions*

\renewcommand{\title}{ENVE 201 - Homework \envehomework@number\ifx\envehomework@title\empty\else\ - \envehomework@title\fi}

\RequirePackage[
	title={\title},
]{enve201}
\RequirePackage{makecell}
\usetikzlibrary{shapes.geometric}

\hypersetup{
	linkcolor=black
}

\renewcommand{\maketitle}{%
	\begin{center}\textbf{\title}\end{center}
	\vspace{0.5em}
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
{label=\textcolor{problempink}{\textbf{\envehomework@number-\arabic{problemsi}}},
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
	{Problem \envehomework@number-\the\numexpr\value{problemsi}+1} % Text
	{#1}% Name/Label
	\item\label{#1}}

\newcommand{\subproblem}{%
	\pdfbookmark[4]% Level
	{Problem \envehomework@number-\the\numexpr\value{problemsi}\makeAlph{problemsii}}% Text
	{prb:\envehomework@number.\number\value{problemsi}\makeAlph{problemsii}}% Name/Label
	\item\label{prb:\number\value{problemsi}\alph{problemsii}}}

\newcommand{\subsubproblem}{%
	\pdfbookmark[5]% Level
	{Problem \the\numexpr\value{problemsi}\alph{problemsii}(\makeRoman{problemsiii})}% Text
	{prb:\envehomework@number.\number\value{problemsi}\alph{problemsii}.\makeRoman{problemsiii}}% Name/Label
	\item\label{prb:\number\value{problemsi}\alph{problemsii}\roman{problemsiii}}}

\newcommand{\answerfile}{%
	\ifenvehomework@corrections%
	homework\envehomework@number_corrections%
	\else%
	homework\envehomework@number_answers%
	\fi%
}
\newcommand{\addanswer}[1]{% Input the section name
	\begin{answer}\ExecuteMetaData[\answerfile]{#1}\end{answer}
}

\newcommand{\file}[1]{%
	\addtocounter{chapter}{1}%
	\section{#1}\label{sec:#1}
}