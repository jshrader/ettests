# ettests
Place t-tests in e() for table creation in Stata.

To get utility from this command, you should install estout. Most of the code for the command comes from Ben Jann here:
http://repec.org/bocode/e/estout/advanced.html#advanced602


# Sytax
```
ettests varlist [if] [in], by(varname) [CASEwise * ]
```
# Options
`casewise` - By default the command computes ttests over observations where all variables in the varlist are nonmissing. The casewise option causes the command to take all observations of each variable, subject to if and in.

`nodisplay` - Don't display the t test results interactively. You could just use quietly. 

# Example
```
sysuse auto.dta, clear
ettests length turn weight, by(foreign)
esttab, cells("mu_1 mu_2 d" "sd_1 sd_2 d_se")
```
Note that ettests doesn't display anything on its own, currently. You have to use esttab. It would be pretty simple to have ettests display results in a standard format if people want that.

To make a nice looking tex table, you can issue a more complicated esttab call:
```
esttab, cells("mu_1(fmt(a2) label(Mean)) mu_2(fmt(a2) label(Mean)) d(star pvalue(d_p) label(Diff.)) N(label(Total obs.))" "sd_1(par fmt(a2) label((SD))) sd_2(par fmt(a2) label((SD))) d_se(par fmt(a2) label((SE)))") star(* 0.10 ** 0.05 *** 0.01) compress label tex noobs nomtitles
```
