#!/usr/bin/env perl
###############################################################################
# Tool for generating Model from mysql schemas. Creates dir Model and put files
# with table names inside. Also generates base class inside called Model/DBI.pm
###############################################################################
use DBI;
use strict;
use warnings;
use Getopt::Long;

use constant EOL => "\n";

my $VERSION = '0.02';

# class-dbi generate
GetOptions(
    \my %opt,  "user=s",      "pass=s", "database=s",
    "table=s", "namespace=s", "help",   "version", 
    "nobase"
);

if ( $opt{help} or not keys %opt ) {
    &usage;
}

if ( $opt{version} ) {
    print EOL . "[version] $0 version is $VERSION" . EOL . EOL;
    exit;
}

if ( not $opt{user} ) {
    $opt{user} = 'root';
}

if ( not $opt{pass} ) {
    print "Please enter your password: ";
    system( '/bin/stty', '-echo' );
    chomp( $opt{pass} = <STDIN> );
    system( '/bin/stty', 'echo' );
}

my $dbh = DBI->connect( "dbi:mysql:" . $opt{database}, $opt{user}, $opt{pass} )
  or die "Connection to database failed - " . $DBI::errstr;
{
    my @tables;
    if ( exists $opt{table} ) {
        @tables = ( $opt{table} );
    }
    else {
        @tables = get_all_tables();
    }

    if ( not -d 'Model' ) {
        mkdir('Model') or die 'Failed to mkdir Model - $!';
        print " Created directory Model/\n";
    }

    if ( not $opt{nobase} ) {
        my $code = gen_dbi_base( $opt{user}, $opt{pass}, $opt{database} );
        my $file = 'Model/DBI.pm';
        open my $f, ">", $file or die "Failed to open file $file - $!";
        print $f $code;
        close $f;
        print " Wrote $file\n";
    }

    foreach my $table (@tables) {
        my @fields = get_fields($table);
        my $code   = get_code( $opt{database}, $table, @fields );
        my $file   = 'Model/' . ucfirst( lc $table ) . '.pm';

        open my $mf, '>', $file
          or die "Failed to open file $file for writing - $!";
        print $mf $code;
        close $mf;

        print " Wrote $file\n";
    }
}
$dbh->disconnect;

sub gen_dbi_base
{
    my ( $username, $password, $database ) = @_;
    my $namespace = 'Model::DBI';

    my $o = 'package ' . $namespace . ';' . EOL;
    $o .= 'use base qw/Class::DBI/;' . EOL;
    $o .=
        $namespace
      . '->connection("dbi:mysql:'
      . $database . '", "'
      . $username . '", "'
      . $password
      . '", { mysql_enable_utf8 => 1 } );'
      . EOL;
    $o .= '1;' . EOL . EOL;

    return $o;
}

sub get_code
{
    my ( $database, $table, @fields ) = ( shift, shift, @_ );

    my $namespace = 'Model';
    $namespace .= '::' . ucfirst( lc $table );

    my $o = 'package ' . $namespace . ';' . EOL;
    $o .= 'use base qw/Model::DBI/;' . EOL;
    $o .= 'our $VERSION = "0.01";' . EOL;
    $o .= $namespace . '->table("' . $table . '");' . EOL;
    $o .= $namespace . '->columns(All => qw/' . join( " ", @fields ) . '/);' . EOL;
    $o .= '1; # End of ' . $namespace . EOL;
    $o .= EOL;
    $o .= '=pod' . EOL . EOL;
    $o .= get_create_definition($table);
    $o .= EOL . EOL;
	$o .= '=cut' . EOL . EOL;

    return $o;
}

sub get_fields
{
    my $tbl = shift;
    my $sth = $dbh->prepare("describe $tbl");
    $sth->execute;
    my @cols = map { $_->[0] } @{ $sth->fetchall_arrayref };
    $sth->finish;
    return @cols;
}

sub get_all_tables
{
    my $sth = $dbh->prepare( "show table status from " . $opt{database} );
    $sth->execute;
    return map { $_->{Name} } values %{ $sth->fetchall_hashref('Name') };
}

sub get_create_definition
{
    my $table = shift;
    my $sth = $dbh->prepare("show create table $table");
    $sth->execute;
    my $row = $sth->fetchrow_arrayref;
	$sth->finish;
	return $row->[1];
}

sub usage
{
    my $message = shift;
    print $message . EOL;
    print "usage: $0 -user=root -pass=******* -database=blog" . EOL;
    print "  -user     - MySQL username (default is root)" . EOL;
    print '  -pass     - MySQL password' . EOL;
    print '  -database - MySQL database name' . EOL;
    print '  -table    - MySQL table ( or will generate for all tables)' . EOL;
    print '  -nobase   - skip creation of Model/DBI.pm file used to establish connection with database.' . EOL;
    print '  -version  - print out this program version' . EOL;
    print '  -help     - print this help' . EOL;
    exit;
}
