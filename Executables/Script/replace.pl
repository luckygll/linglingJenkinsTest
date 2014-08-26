my $ipconfigfile = shift @ARGV;

my $hostnamefile = shift @ARGV;

my $manifestfile = shift @ARGV;

my $application_name = shift @ARGV;

my $reference_data_lan = "VAH Input";
my $mgmt_ime_lan = 'DB+FM';

my $reference_data_ip = &Parse_IP_Address($ipconfigfile, $reference_data_lan);
print $reference_data_ip, "\n";
my $mgmt_ime_lan_ip = &Parse_IP_Address($ipconfigfile, $mgmt_ime_lan);
print $mgmt_ime_lan_ip, "\n";

my $reference_data_lan_macro = "REFERENCE-DATA-MACRO";
my $mgmt_ime_lan_macro = "MGMT-IME-LAN-MACRO";
my $EVAIHOST_MACRO = "EVAIHOST_MACRO";
my $EVAIHOST_MACRO_VALUE = "EVAI_";
my $hostname = &Get_Host_Name($hostnamefile);
$hostname =~ m/(.*)[-,_](.*)/ig;
$EVAIHOST_MACRO_VALUE = $1."_".$2;
print $manifestfile, " ", $application_name, " ", $hostname, " ";
my $FMS_WS_Primary_IP = &Get_Attribute_From_Manifest($manifestfile, $application_name, $hostname, "FMS_WS_Primary_IP");
print $FMS_WS_Primary_IP, "\n";

my $FMS_WS_Secondary_IP = &Get_Attribute_From_Manifest($manifestfile, $application_name, $hostname, "FMS_WS_Secondary_IP");
print $FMS_WS_Secondary_IP, "\n";

my $FMS_WS_Primary_IP_MACRO = "FMS-WS-Primary-IP-MACRO";
my $FMS_WS_Secondary_IP_MACRO = "FMS-WS-Secondary-IP-MACRO";

my $FMSClient_SMF_MACRO_START="FMSCLIENT_MACRO_START";
my $START_MACRO_REPRESENT_TEXT="-->";

my $FMSClient_SMF_MACRO_END="FMSCLIENT_MACRO_END";
my $END_MACRO_REPRESENT_TEXT="<!--";
$^I = ".tmpreplace";

while(<>)
{
	s/$reference_data_lan_macro/$reference_data_ip/ig;
	s/$mgmt_ime_lan_macro/$mgmt_ime_lan_ip/ig;
	s/$EVAIHOST_MACRO/$EVAIHOST_MACRO_VALUE/ig;
	if( Is_Valid_IP($FMS_WS_Primary_IP) and (Is_Valid_IP($FMS_WS_Secondary_IP)) )
	{
	s/$FMS_WS_Primary_IP_MACRO/$FMS_WS_Primary_IP/ig;
	s/$FMS_WS_Secondary_IP_MACRO/$FMS_WS_Secondary_IP/ig;
	s/$FMSClient_SMF_MACRO_START/$START_MACRO_REPRESENT_TEXT/ig;
	s/$FMSClient_SMF_MACRO_END/$END_MACRO_REPRESENT_TEXT/ig;
	}
	
	print;
}
sub Is_Valid_IP
{
  my $Input_IP_Text = shift @_;
  my $IsMatched = $Input_IP_Text=~/(\d{1,3}).(\d{1,3}).(\d{1,3})$/;
  return $IsMatched;
}
sub Parse_IP_Address{
	my $file_name = shift @_;
	my $network_card_name = shift @_;
	if($network_card_name =~ /(.*?)(\+)(.*)/ig)
	{
		$network_card_name = $1."\\+".$3;
	}
	my $HANDLE;
	if(!open (HANDLE, "<$file_name"))
	{
		print "fail to open file - $file_name with error - $!\n";
		return -1;
	}
	my $is_found = 0;
	while(<HANDLE>)
	{
		if(/$network_card_name/i)
		{
			$is_found = 1;
		}
		if($is_found == 1)
		{
			if(/(.*IPv4 Address.*: )(.*)/i)
			{
				close HANDLE;
				return $2;
			}
		}
	}
	close (HANDLE);
	return -1;
}

sub Get_Host_Name{
	my $file_name = shift @_;
	my $HANDLE;
	if(!open(HANDLE, "<$file_name"))
	{
		print "fail to open file - $file_name with error -$!\n";
		return -1;
	}
	while(<HANDLE>)
	{
		chomp;
		return $_;
	}
	-1;
}

sub Get_Attribute_From_Manifest{
	my $file_name = shift @_;
	my $application_tag = shift @_;
	my $host_name = shift @_;
	my $attrib_name = shift @_;
	my $HANDLE;
	if(!open (HANDLE, "<$file_name"))
	{
		print "fail to open file - $file_name with error - $!\n";
		return -1;
	}
	my $is_app_found = 0;
	while(<HANDLE>)
	{
		if(/<$application_tag>/i)
		{
			$is_app_found = 1;
		}
		if($is_app_found == 1)
		{
			if(/($host_name.*$attrib_name.*?")(.*?)(".*)/i)
			{
				close HANDLE;
				return $2;
			}
		}
	}
	close (HANDLE);
	return -1;
}