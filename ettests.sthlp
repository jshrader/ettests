{smcl}
{* *! version 1.1.0  July 5, 2015 @ 10:10:13}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] ttest" "help ttest"}{...}
{vieweralsosee "[R] tabstat" "help tabstat"}{...}
{vieweralsosee "[R] esttab" "help esttab"}{...}
{viewerjumpto "Syntax" "ettests##syntax"}{...}
{viewerjumpto "Description" "ettests##description"}{...}
{viewerjumpto "Options" "ettests##options"}{...}
{viewerjumpto "Remarks" "ettests##remarks"}{...}
{viewerjumpto "Examples" "ettests##examples"}{...}
{title:Title}

{phang}
{bf:ettests} {hline 2} Calculate two sample t tests over many variables and save the results in {cmd:e()}.


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:ettests}
[{varlist}]
{ifin}
{cmd:,}
{opth by:(varlist:groupvar)}
[{it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{p2coldent:* {opth by:(varlist:groupvar)}}variable defining the groups{p_end}
{synopt:{opt case:wise}}perform casewise deletion of observations{p_end}
{synopt:{opt nod:isplay}}stops display of t tests{p_end}
{synoptline}
{p2colreset}{...}

{marker description}{...}
{title:Description}

{pstd}
{cmd:ettests} calculates two sample t tests over a {varlist}, saving the results to e() so that they can be easily exported to a table by {help esttab}.

{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opth by:(varlist:groupvar)} specifies the {it:groupvar} that defines the two
groups that {help ttest} will use to test the hypothesis that their means are
equal.  You must specify a {opt by()} variable for this command. 
Do not confuse the {opt by()} option with the {cmd:by} prefix; you can specify
both.

{phang}
{opt casewise} specifies casewise deletion of observations.  Statistics
   are to be computed for the sample that is not missing for any of the
   variables in {varlist}.  The default is to use all the nonmissing values
   for each variable.

{phang}
{opt nodisplay} stops the display of results of the t tests in a table in the Results
   window. The default is to display a table.

{marker examples}{...}
{title:Examples}

    {cmd:. sysuse auto}                                               (setup)
    {cmd:. ettests gear_ratio rep78, by(foreign)}                     (two t tests)

    {cmd:. ettests gear_ratio rep78, by(foreign) casewise}            (note the different observations)
    {cmd:. esttab, cells("mu_1(fmt(a2) label(Mean)) mu_2(fmt(a2) }    (creating a LaTeX table)
    {cmd:>   label(Mean)) d(star pvalue(d_p) label(Diff.)) }
    {cmd:>   N(label(Total obs.))" "sd_1(par fmt(a2) label((SD)))}
    {cmd:>   sd_2(par fmt(a2) label((SD))) d_se(par fmt(a2) label((SE)))")}
    {cmd:>   star(* 0.10 ** 0.05 *** 0.01) compress label tex not}
    {cmd:>   noobs nomtitles}  

{marker results}{...}
{title:Stored results}

{pstd}
{cmd:ettests} stores the following in {cmd:e()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:e(mu_1)}}x_1 bar, mean for sample 1{p_end}
{synopt:{cmd:e(mu_2)}}x_2 bar, mean for sample 2{p_end}
{synopt:{cmd:e(N_1)}}sample size n_1{p_end}
{synopt:{cmd:e(N_2)}}sample size n_2{p_end}
{synopt:{cmd:e(N)}}total sample size for each variable{p_end}
{synopt:{cmd:e(sd_l)}}standard deviation for sample 1{p_end}
{synopt:{cmd:e(sd_2)}}standard deviation for sample 2{p_end}
{synopt:{cmd:e(d)}}difference in means{p_end}
{synopt:{cmd:e(d_t)}}t statistic for difference in means{p_end}
{synopt:{cmd:e(d_t)}}standard error for difference in means{p_end}
{synopt:{cmd:e(d_p)}}two-sided p-value for difference{p_end}
{p2colreset}{...}
