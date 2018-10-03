#! /usr/bin/perl -w

use locale;             # Ensure correct charset for eg 'uc()'
use DBI;                # Database connections
use strict;             # Enforce declarations
use warnings;
use DateTime;
use Archive::Zip;
use Net::FTP;
use LWP::Simple;
use Getopt::Long;

my $manualMode = 0;
GetOptions ('manual!' => \$manualMode); # If manual option is passed, skip uploading files to FTP server

my $dt = DateTime->now->set_time_zone( 'America/Los_Angeles' );

# MYSQL CONFIG VARIABLES
my $hostname = "VM5";
my $database = "Rayzist";
my $user = "rgeis";
my $password = "frog418";

# PERL CONNECT()
my $dsn = "DBI:mysql:database=$database;host=$hostname;" ;
my $dbh = DBI->connect($dsn, $user, $password) ;

# FTP to provisioning server
my $ftp = Net::FTP->new('p.ztelco.com', Debug => 0)
    or die "Cannot connect to FTP server: $0";
if (! $manualMode) {
    $ftp->login('PlcmSpIp','PlcmSpIp')
        or die "Cannot login ", $ftp->message;
    $ftp->cwd('/Directory');
}

# ...
my $phone_sql = 'SELECT Extension, MacAddress, phone_ext.Access, CONCAT_WS( " ", FirstName, LastName ) AS Description FROM phone_ext LEFT JOIN phone_dir on phone_dir.Dial = phone_ext.Extension';
my $phone_sth = $dbh->prepare($phone_sql);
$phone_sth->execute();
my $row_p;
while ($row_p = $phone_sth->fetchrow_hashref()) {
    my $ext = $row_p->{Extension};
    my $mac = $row_p->{MacAddress};
    my $acc = $row_p->{Access};
    my $des = $row_p->{Description};
    $mac =~ tr/://d;

    open (OUTPUTFILE, ">", "$mac-directory.xml") || die("Could not open/create the output file directory-000000000000.xml!\n");
    print OUTPUTFILE "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n";
    print OUTPUTFILE "<!-- edited with XMLSPY v5 rel. 4 U (http://www.xmlspy.com) -->\n";
    print OUTPUTFILE  "<?Saved @ --".$dt."-- ?>\n";
    print OUTPUTFILE "<!-- name: ".$des." -->\n";
    print OUTPUTFILE "<!-- extension: ".$ext." -->\n";
    print OUTPUTFILE  "<directory>\n";
    print OUTPUTFILE "<item_list>\n";

    my $dir_sth = $dbh->prepare('SET @sd1:=1;');
    $dir_sth->execute();
    $dir_sth = $dbh->prepare('SET @sd2:=108;;');
    $dir_sth->execute();
    my $dir_sql = '
        SELECT
            Description,
            Dial,
            bw,
            sd,
            Priority,
            Ringtone
        FROM
            (
                (
                    SELECT
                        Description,
                        Dial,
                        bw,
                        @sd1 := @sd1 + 1 AS sd,
                        Priority,
                        Ringtone
                    FROM
                        (
                            SELECT

                            IF (
                                (
                                    phone_quick.FirstName IS NULL
                                    OR phone_quick.FirstName = ""
                                )
                                AND (
                                    phone_quick.LastName IS NULL
                                    OR phone_quick.LastName = ""
                                ),
                                CONCAT_WS(
                                    " ",
                                    phone_dir.FirstName,
                                    phone_dir.LastName
                                ),
                                CONCAT_WS(
                                    " ",
                                    phone_quick.FirstName,
                                    phone_quick.LastName
                                )
                            ) AS Description,
                            phone_quick.Dial,
                            phone_quick.bw,
                            phone_quick.Priority,
                            phone_quick.Ringtone
                        FROM
                            phone_quick
                        LEFT JOIN phone_dir ON phone_dir.Dial = phone_quick.Dial
                        WHERE
                            Extension = '.$ext.'
                        ORDER BY
                            Priority,
                            Description
                        ) a
                )
                UNION
                    (
                        SELECT
                            Description,
                            Dial,
                            bw,
                            @sd2 := @sd2 + 1 AS sd,
                            Priority,
                            NULL AS Ringtone
                        FROM
                            (
                                SELECT
                                    CONCAT_WS(" ", FirstName, LastName) AS Description,
                                    Dial,
                                    bw,
                                    Priority
                                FROM
                                    phone_dir
                                WHERE
                                    Access <= '.$acc.'
                                ORDER BY
                                    Priority,
                                    Description
                            ) b
                    )
            ) c
        ORDER BY
            Priority,
            Description
    ';
    $dir_sth = $dbh->prepare($dir_sql);
    $dir_sth->execute();
    my $row_d;
    while ($row_d = $dir_sth->fetchrow_hashref()) {
        my $description = $row_d->{Description};
        my $dial = $row_d->{Dial};
        my $bw = $row_d->{bw};
        my $sd = $row_d->{sd};
        my $rt = $row_d->{Ringtone} || 'ringerdefault';
        print OUTPUTFILE "<item>";
        if (length($dial) == 3) {print OUTPUTFILE "<fn>$dial</fn>";}
        print OUTPUTFILE "<ln>$description</ln>";
        print OUTPUTFILE "<ct>$dial</ct>";
        print OUTPUTFILE "<sd>$sd</sd>";
        #print OUTPUTFILE "<lb>$column5</lb>";
        #print OUTPUTFILE "<pt>$column6</pt>";
        print OUTPUTFILE "<rt>$rt</rt>";
        #print OUTPUTFILE "<dc>$column8</dc>";
        if (length($dial) < 5) {print OUTPUTFILE "<ad>0</ad>";}
        if (length($dial) < 5) {print OUTPUTFILE "<ar>0</ar>";}
        print OUTPUTFILE "<bw>$bw</bw>";
        if (length($dial) < 5) {print OUTPUTFILE "<bb>0</bb>";}
        print OUTPUTFILE "</item>\n";
    }
    print OUTPUTFILE "</item_list>\n";
    print OUTPUTFILE "</directory>\n";


    close (OUTPUTFILE);

    $manualMode || $ftp->put("$mac-directory.xml");
}

$dbh->disconnect;

if (! $manualMode) {
    $ftp->quit;

    ### Force all phones to check and load new config
    my $result = get('http://rayzist.zray.net/check-config.php?run=1');
}


my $zip = Archive::Zip->new();

$zip->addTreeMatching( '.', '', '\.xml$' );
# and write them into a file
$zip->writeToFileNamed('Polycom Phone XML '.$dt->strftime("%F %H%M%S").'.zip');


exit;

#CREATE TABLE `phone_ext` (
#  `Extension` int(4) unsigned NOT NULL,
#  `MacAddress` varchar(17) NOT NULL,
#  `Access` int(1) unsigned DEFAULT NULL,
#  `Type` varchar(20) DEFAULT NULL,
#  PRIMARY KEY (`Extension`,`MacAddress`)
#) ENGINE=InnoDB DEFAULT CHARSET=utf8;


#CREATE TABLE `phone_dir` (
#  `id` int(6) unsigned NOT NULL AUTO_INCREMENT,
#  `FirstName` varchar(40) DEFAULT NULL,
#  `LastName` varchar(40) DEFAULT NULL,
#  `Dial` varchar(25) DEFAULT NULL,
#  `Priority` int(3) unsigned DEFAULT NULL,
#  `Access` int(1) unsigned DEFAULT NULL,
#  `bw` int(1) NOT NULL DEFAULT '0',
#  PRIMARY KEY (`id`)
#) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;


#CREATE TABLE `phone_quick` (
#  `id` int(6) unsigned NOT NULL AUTO_INCREMENT,
#  `Extension` int(4) unsigned DEFAULT NULL,
#  `FirstName` varchar(40) DEFAULT NULL,
#  `LastName` varchar(40) DEFAULT NULL,
#  `Dial` varchar(25) DEFAULT NULL,
#  `Ringtone`  varchar(40) DEFAULT NULL,
#  `Priority` int(3) DEFAULT NULL,
#  `bw` int(1) DEFAULT '1',
#  PRIMARY KEY (`id`)
#) ENGINE=InnoDB AUTO_INCREMENT=272 DEFAULT CHARSET=utf8;

##### Ringtone Lookup #####
# <rt>      Name
# ringer1	Silent Ring
# ringer2	Low Trill
# ringer3	Low Double Trill
# ringer4	Medium Trill
# ringer5	Medium Double Trill
# ringer6	High Trill
# ringer7	High Double Trill
# ringer8	Highest Trill
# ringer9	Highest Double Trill
# ringer10	Beeble
# ringer11	Triplet
# ringer12	Ringback-style
# ringer13	Low Trill Precedence
# ringer14	Ring Splash
# ringer15	Ring16
# ringer16	Cisco_Bass
# ringer17	Cisco_Jamaica
# ringer18	Cisco_Office
# ringer19	FOTC_Theme
# ringer20	Holy_Grail
# ringer21	Imperial_March
# ringer22	James_Bond
# ringer23	Jetsons_Doorbell
# ringer24	Old_Phone
# ringer25	not used

