
my $InputPrivateDict = shift @ARGV;
#$InputPrivateDict = "PRIVATE.DAT";

my $InputPrivateTypeDef = shift @ARGV;
#$InputPrivateTypeDef = "ConvertTypeDef.DAT";

my $OutputDict = shift @ARGV;
#$OutputDict="Result.dat";
if(-e $InputPrivateDict && -e $InputPrivateTypeDef ) 
{
  if(open(PRIVATE_DICT,"$InputPrivateDict"))
  {
    @arrayPrivate_Dict_Lines=<PRIVATE_DICT>;
	@FID_TYPE_DEF_Ret = ();
	if(open(PRIVATE_TYPE_DEF,"$InputPrivateTypeDef"))
	{
	@arrayPrivate_Type_Def = <PRIVATE_TYPE_DEF>;
	foreach(@arrayPrivate_Type_Def)
	{
	   my(@Input,@Output) = &Get_FID_TYPE_LENGTH($_);
	   push(@FID_TYPE_DEF_Ret,(@Input,@Output));
	}
	
	@ReplacedResult = ();
	foreach(@arrayPrivate_Dict_Lines)
	{
	      my $line = $_;
		  my $lineresult = ReplacePrivateFIDType_Length($line,\@FID_TYPE_DEF_Ret);
		 my $InvalidRet = "-1";
		 if($lineresult eq $InvalidRet)
		 {
		   print STDOUT "$line\n";
		 }
		 else
		 {
		   push(@ReplacedResult,$lineresult);
		 }
		
	}
	if(open(OUTFILE,">$OutputDict"))
	{
	    print OUTFILE @ReplacedResult;
	}
	
  }
  else
  {
    print "fail to open file - $InputPrivateDict!\n";
  }
}
else
{
     print "fail to open file - $InputPrivateDict or - $InputPrivateTypeDef!\n";
}
sub Get_FID_TYPE_LENGTH(){
	my $Input = $_;
	@Parts = split /=/,$Input;
	@InputType_Length = split /,/,$Parts[0];
	@OutType_Length = split /,/,$Parts[1];
	return (@InputType_Length,@OutType_Length);
}
sub CalcTRWFStringLen{
  my $InputLen = shift;
  if( $InputLen >= 255 )
  {
  return $InputLen + 3;
  }
  elsif($InputLen >= 127 )
  {
  return $InputLen + 2;
  }
  else
  {
    return $InputLen+1;
  }

}
sub trim
{
    my $string = shift;
    $string =~ s/^\s+//;
    $string =~ s/\s+$//;
    if(length($string)<1){
        return "";
    }else{
        return $string;
    }    
}    
sub ReplacePrivateFIDType_Length{
  my $inputline = $_[0];
  if($inputline=~/^!/)
  {
     return $inputline;
  }
  if( $inputline=~/^\s*$/ )
  {
    return $inputline;
  }
  my @Replace_Def=@{$_[1]};

  for($Index = 0; $Index < @Replace_Def;)
  {
     my $InputType = $Replace_Def[$Index];
	 my $InputTypeLength = $Replace_Def[$Index+1];
	 my $OutputType = $Replace_Def[$Index+2];
	 my $OutputTypeLengh = $Replace_Def[$Index+3];
	  if($inputline=~/$InputType\s*$InputTypeLength/)
	 {
		$inputline =~s/$InputType/$OutputType/;
		$inputline =~s/$InputTypeLength/$OutputTypeLengh/;
		return $inputline;
	 }
	 elsif($inputline=~m/RMTES_STRING\s*[0-9]*/)
	 {
	   $Pos = index($inputline,"RMTES_STRING");
	   
	   if( $Pos >= 0 )
	   {
	     my $inputlineleft = substr($inputline,0,$Pos);
		 my $inputlineright = substr($inputline,$Pos);
	     my $Len = substr($inputline,$Pos+12);
		 my $TrimedLen = trim($Len);
		 my $OutLen = CalcTRWFStringLen($TrimedLen);
		 $inputlineright=~s/$TrimedLen/$OutLen/;
		 return $inputlineleft.$inputlineright;
	   }
	   
	 }
	  elsif($inputline=~m/ASCII_STRING\s*[0-9]*/)
	 {
	   $Pos = index($inputline,"ASCII_STRING");
	   
	   if( $Pos >= 0 )
	   {
	     my $inputlineleft = substr($inputline,0,$Pos);
		 my $inputlineright = substr($inputline,$Pos);
	     my $Len = substr($inputline,$Pos+12);
		 my $TrimedLen = trim($Len);
		 my $OutLen = CalcTRWFStringLen($TrimedLen);
		 $inputlineright=~s/$TrimedLen/$OutLen/;
		  return $inputlineleft.$inputlineright;
	   }
	   
	 }
	 else
	 {}
     $Index=$Index+4;
  } 
  return "-1"; 
#  foreach(Replace_Def)
#  {
#     my(@InputItem,@OutputItem) = $_;
#	 
#	 if($inputline=~/$InputItem[0]\s*$InputItem[1]/)
#	 {
#		$inputline =~s/"$InputItem[0]"/$OutputItem[0]/;
#		$inputline =~s/"$InputItem[1]"/$OutputItem[1]/;
#		return $inputline;
#	 }
#  }
#  return $inputline;
}}