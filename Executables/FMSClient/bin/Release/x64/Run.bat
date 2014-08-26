for %%i in (%0) do set aa=%%~dpi 
cd %aa%
FMSClient.exe FMSClient.dat
