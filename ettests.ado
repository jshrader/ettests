*! version 1.1.0  July 8, 2015 @ 13:14:09
program ettests, eclass
   * Initial code from Ben Jann
   *    http://repec.org/bocode/e/estout/advanced.html#advanced602
   * Updates by Jeff Shrader
version 8
   syntax varlist [if] [in], by(varname) [CASEwise NODisplay * ]
   if "`casewise'" == "" {
      marksample touse
      markout `touse' `by'
   }
   else{
      marksample touse, novar
      markout `touse' `by'
   }

   local out_list "level sd sd_1 sd_2 se p_u p_l p t df_t mu_1 mu_2 N_1 N_2 N d"
   tempname `out_list'
   foreach var of local varlist {
      quietly: ttest `var' if `touse', by(`by') `options'
      mat `level'= nullmat(`level'), r(level) 
      mat `mu_1' = nullmat(`mu_1' ), r(mu_1)
      mat `mu_2' = nullmat(`mu_2' ), r(mu_2)
      mat `d'    = nullmat(`d'    ), r(mu_1)-r(mu_2)
      mat `se'   = nullmat(`se'   ), r(se)
      mat `t'    = nullmat(`t'    ), r(t)
      mat `df_t' = nullmat(`df_t' ), r(df_t)      
      mat `p'    = nullmat(`p'    ), r(p)
      mat `p_u'  = nullmat(`p_u'  ), r(p_u)
      mat `p_l'  = nullmat(`p_l'  ), r(p_l)      
      mat `sd'   = nullmat(`sd'   ), r(sd)
      mat `sd_1' = nullmat(`sd_1' ), r(sd_1)
      mat `sd_2' = nullmat(`sd_2' ), r(sd_2)
      mat `N_1'  = nullmat(`N_1'  ), r(N_1)
      mat `N_2'  = nullmat(`N_2'  ), r(N_2)
      mat `N'    = nullmat(`N'    ), r(N_1)+r(N_2)
   }
   foreach mat in `out_list' {
      mat coln ``mat'' = `varlist'
   }
   * tempname b V
   * mat `b' = `mu_1'*0
   * mat `V' = `b''*`b'
   * eret post `b' `V'
   eret local cmd "ettests"
   foreach mat in `out_list' {
      eret mat `mat' = ``mat''
   }
   if "`nodisplay'" == "" {
      esttab , cells("mu_1(fmt(a2) label(Mean)) mu_2(fmt(a2) label( Mean))  d(star pvalue(d_p) label(Diff)) N_1(label(Obs. 1)  fmt(%12.0gc)) N_2(label(Obs. 2 ) fmt(%12.0gc))" "sd_1(fmt(a2) par label((SD)))  sd_2(fmt(a2) par label((SD))) d_se(par label((SE)))") star(* 0.10 ** 0.05 *** 0.01) compress label replace not noobs nomtitles nonum
      
   }
end
