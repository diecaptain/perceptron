#!/usr/bin/perl -w
#Program to test classification using a perceptron based approach
#Two classes are stressed and unstressed
#Author: Kranthi K. Pamarthi
open (W,W1_final) || die "Cannot access the file : $!";
 while (<W>)
{
  push @W1,"$_";
}
 close (W);
print "The initialized weights of perceptron are @W1\n";
perc_test();
###########################################################
############# Perceptron Testing ##########################
###########################################################
sub perc_test
{
    open (STRESS,">stress.txt") || die "cannot create file : $!\n";
    open (NSTRESS,">nstress.txt") || die "cannot create file : $!\n";
    chomp ($t = 1);
    chomp ($s = 0);
    chomp ($n = 0);
     for ($t=1;$t<6281;$t++)
     {
	 print "iteration : $t\n";
         $l = $t-1; 
         $wrange = 25;
         $hrange = 25;
         $tw = rand($wrange);
	 $th = rand($trange);
         print "random pair are $tw and $th\n";
         $tw[$l] = $tw;
         $th[$l] = $th;
         $S[$l] = ($W1[0]+($W1[1]*$tw)+($W1[2]*$th));
         if ($S[$l] >= 0)
         {
           $Y[$l] = 1;
           $s += 1;
           print STRESS "$tw $th\n";
           print "the random pair $tw and $th are in stress class\n";
         }
         else
         {
           $Y[$l] = 0;
           $n += 1;
           print NSTRESS "$tw $th\n";
           print "the random pair $tw and $th are in unstress class\n";
         }
     }
    close (STRESS);
    close (NSTRESS);
    open (LINE,">line.txt") || die "Cannot create file : $!\n";
    for ($i=0;$i<6281;$i++)
    {
	$range = 25;
        $x1[$i] = rand($range);
        $slope = ($W1[1]/$W1[2]);
        $constant = ($W1[0]/$W1[2]);
        $temp1 = $slope*$x1[$i];
        $temp2 = $temp1+$constant;
        $x2[$i] = -$temp2;  
	 print LINE "$x1[$i] $x2[$i]\n";
    }
    close (LINE);
    print "The files line.txt stress.txt and nstress.txt are printed\n\n";
    print "The number of pairs in stress class are $s\n\n";
    print "The number of pairs in unstress class are $n\n\n";
}
