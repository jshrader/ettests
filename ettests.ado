*! version 1.1.0  July 8, 2015 @ 14:29:05
program ettests, eclass
   * Based on code from Ben Jann
   *    http://repec.org/bocode/e/estout/advanced.html#advanced603
   * Updates by Jeff Shrader
version 8
   syntax varlist [if] [in], by(varname) [CASEwise * ]
   if "`casewise'" == "" {
      marksample touse
      markout `touse' `by'
   }
   else{
      marksample touse, novar
      markout `touse' `by'
   }

   * Start the output table
   di as text "             {c |}       First Group {c |}      Second Group {c |}                    "
   *                                      10        20        30        40        50        60        70  
   *                             1234567890123456789012345678901234567890123456789012345678901234567890
   di as text "  Variable   {c |}     Obs   mean/sd {c |}    Obs    mean/sd {c |}  diff/se     p-val."
   di as text "{hline 13}{c +}{hline 19}{c +}{hline 19}{c +}{hline 20}"


   * Here is everything we will be saving to e()
   local out_list "level sd sd_1 sd_2 se p_u p_l p t df_t mu_1 mu_2 N_1 N_2 N d"
   tempname `out_list'
   foreach var of local varlist {
      * Run the t-tests
      quietly: ttest `var' if `touse', by(`by') `options'
      * Load restults to matrices
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

      * Output the results of the t-tests
      display as text %12s abbrev("`var'",12) " {c |}" ///
             as result ///
             %8.0g r(N_1) " "  %9.2g r(mu_1) " {c |}" ///
             %8.0g r(N_2) " "  %9.2g r(mu_2) " {c |}" ///
             %9.2g r(mu_1)-r(mu_2) "  " %9.2g r(p)
      display as text "             {c |}" ///
             as result ///
             "         "  %9.2g r(sd_1) " {c |}" ///
             "         "  %9.2g r(sd_2) " {c |}" ///
             "" %9.2g r(se) "     "
   }
   foreach mat in `out_list' {
      mat coln ``mat'' = `varlist'
   }
   eret local cmd "ettests"
   foreach mat in `out_list' {
      eret mat `mat' = ``mat''
   }
   * Finish the table
   * di as text "{hline 13}{c BT}{hline 62}"
   di as text "{hline 13}{c BT}{hline 19}{c BT}{hline 19}{c BT}{hline 20}"
end
