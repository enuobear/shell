use strict;
use Text::CSV_XS;

die "error" unless $ARGV[0];

open my $fh, "<:encoding(utf8)", $ARGV[0] or die " file $!";

my $csv = Text::CSV_XS->new ({ binary => 1, auto_diag => 1 });
my $row_num       = 1;
my %data = ();
while (my $row = $csv->getline ($fh)) {
    my $key = $row->[0];
    print  "$row_num $key  ok\n";
    if($data{$row->[0]}){
        die "row $row_num and ". $data{$row->[0]}." has same key $key";
    }

    $data{$key} = $row_num;
    $row_num++;
}
close $fh;
