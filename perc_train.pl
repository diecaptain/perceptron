#!/usr/bin/perl -w
#Program to train perceptron to classify stress and unstress classes
#Author : Kranthi K. Pamarthi
#Assumptions : eeta = 0.001
#Maximum number of iterations = 6281
chomp ($eeta = 0.01);
chomp (@W1 = qw(1 -2.618 2.618));
print "Training the perceptron based on evaluation set\n";
open (STRESSH,stress_H) || die "cannot access the file : $!\n";
open (STRESSW,stress_W) || die "cannot access the file : $!\n";
open (NSTRESSH,nstress_H) || die "cannot access the file : $!\n";
open (NSTRESSW,nstress_W) || die "cannot access the file : $!\n";
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
open (STRESSIN,stress_perc) || die "Cannot access the file: $!\n";
while (<STRESSIN>)
{
    push @dataYs, "$_";
}
close (STRESSIN);
open (NSTRESSIN,nstress_perc) || die "Cannot access the file: $!\n";
while (<NSTRESSIN>)
{
    push @dataYn, "$_";
}
close (NSTRESSIN);
#for ($i=0;$i<=201;$i++)
   # {
    #  $dataYs{$i} = $dataYs[$i];
    #  print "$i $dataYs{$i}\n";
   # }
#for ($i=0;$i<=200;$i++)
#    {
#      $dataYn{$i} = $dataYn[$i];
#      print "$i $dataYn{$i}\n";
#    }
perc_train();
######################################################
############ Perceptron Training #####################
######################################################
sub perc_train
{
  open (W,">W1.txt") || die "Cannot create new file : $!";
  open (W1,">W1_final") || die "Cannot create new file : $!";
  chomp ($t = 1);
  for ($t=1;$t<=6281;$t++)
  {
      print "Iteration : $t\n\n";
      $range = 400;
      $k = int(rand($range));
      print "The random number generated is $k\n";
      if ($k < 200)
      {
      $W1minus[0] = $eeta*((0-$dataYn[$k])+(0-$dataYn[$k]));
      $W1new[0] = $W1[0]+$W1minus[0];
      $W1minus[1] = $eeta*(((0-$dataYn[$k])*$N_W[$k])+((0-$dataYn[$k])*$N_H[$k]));
      $W1new[1] = $W1[1]+$W1minus[1];
      $W1minus[2] = $eeta*(((0-$dataYn[$k])*$N_W[$k])+((0-$dataYn[$k])*$N_H[$k]));
      $W1new[2] = $W1[2]+$W1minus[2];
      print W "@W1new\n";
      }
      else
      {
      $j = $k-200;
      $W1minus[0] = $eeta*((1-$dataYs[$j])+(1-$dataYs[$j]));
      $W1new[0] = $W1[0]+$W1minus[0];
      $W1minus[1] = $eeta*(((1-$dataYs[$j])*$S_W[$j])+((1-$dataYs[$j])*$S_H[$j]));
      $W1new[1] = $W1[1]+$W1minus[1];
      $W1minus[2] = $eeta*(((1-$dataYs[$j])*$S_W[$j])+((1-$dataYs[$j])*$S_H[$j]));
      $W1new[2] = $W1[2]+$W1minus[2]; 
      print W "@W1new\n";
      }
      print "The new weights at iteration $t are @W1new\n";
      @W1 = @W1new;
  }
  print "The training of perceptron ends here\n";
  print "The new weights of the perceptron are @W1\n";
  for ($j=0;$j<=2;$j++)
  {
   print W1 "@W1[$j]\n";
  }
  print "The files W1.txt and W1_final are printed\n\n";
}    
