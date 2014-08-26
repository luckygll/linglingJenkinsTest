setlocal
@echo on
@cd..
@cd..
@set CurPath_P = %cd%
echo %CurPath_P%
@set PerlPath=%cd%\Executables\Utils\perl\perl.exe -w
echo %PerlPath%
@set InputPrivDic=%cd%\Data\PRIVATE.DAT
@set TypeDefCfg=%cd%/Executables/Script/ConvertTypeDef.DAT
@set PerScript=%cd%/Executables/Script/DictionaryConvert.pl
@set ResultDic=%cd%/Data/Converted_PRIVATE.DAT
%PerlPath% %PerScript% %InputPrivDic% %TypeDefCfg% %ResultDic%

