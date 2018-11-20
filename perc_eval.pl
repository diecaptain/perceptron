#!/usr/bin/perl -w
#Program to evaluate two classes using a perceptron based approach
#Two classes are stressed and unstressed
#Author: Kranthi K. Pamarthi
#assumption weights : W1i =-i+(-1)^i* 1.618,i = 0..2
chomp(@W1 = qw(1 -2.618 2.618));
print "Initialization and Evaluation begin\n"; 
perc_eval();
######################################################
############# Perceptron Evaluation ##################
######################################################
sub perc_eval
{
     open (STRESSH,stress_H) || die "cannot access the file : $!\n";
     open (STRESSW,stress_W) || die "cannot access the file : $!\n";
     open (NSTRESSH,nstress_H) || die "cannot access the file : $!\n";
     open (NSTRESSW,nstress_W) || die "cannot access the file : $!\n";
     open (STRESSOUT,">stress_perc") || die "cannot create file :$!\n";
     open (NSTRESSOUT,">nstress_perc") || die "cannot create file :$!\n";
     print "Accessing the stress class Husband points\n";
     while (<STRESSH>)
     {
	 push @S_H, "$_";
     }
     close (STRESSH);
     print "Accessing the stress class Wife points\n";
     while (<STRESSW>)
     {
	 push @S_W, "$_";
     }
     close (STRESSW);
     print "Accessing the non stress class Husband points\n";
     while (<NSTRESSH>)
     {
	 push @N_H, "$_";
     }
     close (NSTRESSH);
     print "Accessing the non stress class Wife points\n";
     while (<NSTRESSW>)
     {
	 push @N_W, "$_";
     }
     close (NSTRESSW);
     for ($i=0;$i<200;$i++)
     {
       $Sn[$i] = ($W1[0]+($W1[1]*$N_W[$i])+($W1[2]*$N_H[$i]));
       if ($Sn[$i] >= 0)
        {
         $Yn[$i] = 1;
        }
       else
        {
         $Yn[$i] = 0;
        }
       print NSTRESSOUT "$Yn[$i]\n";
      }
     for ($i=0;$i<201;$i++)
     {
       $Ss[$i] = ($W1[0]+($W1[1]*$S_W[$i])+($W1[2]*$S_H[$i]));
       if ($Ss[$i] >= 0)
        {
         $Ys[$i] = 1;
        }
       else
        {
         $Ys[$i] = 0;
        }
      print STRESSOUT "$Ys[$i]\n";
      }
      close (NSTRESSOUT);
      close (STRESSOUT);
     print "The files stress_perc.txt and nstress_perc.txt are printed\n\n";
}	 
         
