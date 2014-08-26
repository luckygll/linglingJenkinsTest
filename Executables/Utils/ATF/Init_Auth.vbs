'Author: Mike Zhao in Feb 2011
'The script is to resolve the performance issue of host key generation for the first time running, 
'you just need to run this script and then the host key will be stored on each remote servers automatically.

'Steps:
'1.Update totalServerNO (total server number).
'2.Update each serverIP,username and password of each remote servers.

dim serverIP(12)
dim username(12)
dim password(12)

set ws=CreateObject("wscript.shell")
workingPath = left(Wscript.ScriptFullName,len(Wscript.ScriptFullName)-len(Wscript.ScriptName))
appPath=workingPath&"\LocalTools\Plink.exe"

totalServerNO=1

serverIP(0)="10.35.54.132"
username(0)="reutadmin"
password(0)="Tin.netSA"

for i=0 to totalServerNO-1
	ws.run "cmd /c echo Y | "+appPath+" -l " + username(i) + " -pw "+ password(i) + " " + serverIP(i)+" pwd"
Next
