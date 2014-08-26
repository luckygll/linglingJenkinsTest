SPGGen v0.79
===========

* Changelog:

v0.79 Add an option (-V) to set vendor

V0.78 Update the help information in cmd window

V0.77 Allow OS to be set to “Win-All-All?in SPBGen command -o option.

V0.76 fixed a small bug, The -X parameter doesn't work if the target file name has spaces in.

v0.75 added a new parameter (-G:<group>) which sets the access group, "-G:DDS" to dc_dds_dev_ag, "-G:IDN" to dc_idn_dev_ag, and allow any other group to be specified directly, the default is sample:all-objects
      correct the version format description in this file from xx.yy.zz to xx-yy-zz

v0.74 fixed a small bug, The -X parameter doesn't work if the target directory has spaces in.

v0.73 fixed a small bug, which to extend the building timout limitation from 20 seconds to 60 seconds.

v0.70: added -automation switch which writes the correct internal properties for Elektron Automation packages. Any packages built with -automation will deploy to D:\ThomsonReuters\Staging\<spb name> and will not execute any files (as per the correct process). Also added -nologo switch to disable the SPBGen logo showing and made a minor addition to the standard output (now shows the name of the SPB being generated). Finally, the valid OS values have been extended to Win and Sol (not just Win-xxxx-yy) etc.

v0.60: fixed file recreation (immediately after being removed) during uninstallation. If a given package was being uninstalled then its .msi (or script, if -U was specified) would be run successfully and the application removed. However any files copied as a first step (e.g. installation files to a temporary folder) were being correctly removed at uninstallation, but then created again straight after. This was due to the "erase existing files prior to installation" feature that had been requested in SPBGen. A different method is now being used to do the pre-install clear - during post-installation all files will now be correctly removed.
Product names can now be alphanumeric. The GMI 'spmove' script specifies alphas only in the regular expression but this is not actually enforced, and IBM standards for TPM state that alphanumeric is okay.
The external program for compressing the .tar file has been replaced with a newer implementation which can handle long paths (previously only 128 characters were supported) and is much faster. .tar.Z builds should be marginally quicker now.

v0.58: added a new parameter (-H) which enables "heavy mode" (in contrast to -L, light mode). When this parameter is used, SPBGen will generate .spd, .spb, .xml and .tar.Z files in the output folder, useful for testing purposes.

v0.57: MSI logging is now turned on by default and writes log files to <system drive>:\reuters\gmi\tpm\logs\<spb name>\msi\<spb name>.log. The version number of SPBGen is now also displayed in the standard console output and written as a comment in the .spd file.

v0.562: changed the temp MSI location to $(sp_temp)\$(sp_name). It was found that if the temp folder was not empty at the time of installation then TPM would fail the install, so the SPB name is used now as a subfolder to try and create some uniqueness.

v0.561: bugfix: correctly escaped the temp folder location for MSI installations (C:\\temp instead of c:\temp).

v0.56: fixed an issue with the new rollback module where the working directory might not have been correctly set. Also fixed a crashing issue where SPBGen would crash on completion if the temporary working folder for GMI signatures was not empty.

v0.55: when TPM is used to uninstall an SPB, it is now possible for a command to be executed at this time, such as a rollback script or an uninstaller. This was discovered by Marios Charalambous and simply involves specifying a "during_remove" item for the execute_user_program stanza. The script to be executed at uninstallation time should be specified with the -U: switch, such as -U:uninstall_commands.bat - the script itself should be bundled into the SPB along with the current scripts used for installing. Unfortunately this has meant for the first time I have had to change one of the switches, as previously -U was used to specify uncompressed output (i.e. tar instead of .tar.Z). This functionality remains and has simply been moved to the -N switch.

v0.54: fixes a bug with MSI installation (rarely seen). Essentially if the source drive for the MSI on the build machine did not exist on the endpoint, SPBGen was wrongly telling TPM to use the build machine's drive (which did not exist on the endpoint) to temporarily store the MSI prior to execution. This was not often seen as most teams built their MSI from the C: or D: drive on their machines which typically exist on the endpoint. The fix was to set the "image_dir" property in the install_msi_product stanza to a temporary path.

v0.53: a new parameter (-K) was added in relation to the change in v0.51 of deleting files in the destination folder before copying. -K disables this behaviour and ensures any existing files are not deleted. A bug was also fixed related to the signature file - when SPBGen closes it automatically removes any temporary signature files that may have been created. However in the case of invalid SPB options being specified on the command line it would be trying to remove a file that didn't exist. Some defensive code has been added to check if there are any signature files to remove first.

v0.52: added ability to specify MSI properties with -P:<MSI properties>, as requested by TSC team.

v0.51: added "source_host_name = ALL" into the .spd. Unsure what it is doing but noticed it was present in all TPM-generated SPDs but not the SPD from SPBGen. Checked no other differences exist. MSI installation now supported - if -X is specified with a file ending in .msi it will write different code to the SPD file. If executing a .bat or .cmd file, this will continue to use the existing SPD code.
Old temporary installer files will now be removed when deploying an SPB generated with SPBGen v0.51 or later. The latest temporary installer files will always be maintained to ease development/support work.
Minor presentation tweak on the console output.

v0.5: .Z compression (LZW) now supported, equivalent to the 'compress' command on a Unix machine. This delivers .tar.Z files which can be used with the GMI import task. To generate uncompressed .tar files simply use the new command line switch of -U. To generate only .SPBs you can continue to use -L.
DCM XML file should now be removed in the post-generation clean up (this wasn't working due to the filename change in v0.4). Finally the GMI sigs should also be removed in the post-generation clean up.

v0.41: changed the destination path for the signature file from %SYSTEMDRIVE%\Reuters... to $(system_drive)\Reuters...

v0.4: fixes the SPB filename in the DCMExport xml to include the .spb extension -- this was causing installs to fail when deploying with the full .tar file as opposed to the .spb on its own. The version inside the DCM XML file has also been aligned with the SPB version (previously hardcoded as 1.0). Finally, the DCM XML filename has been changed from DCMExport.xml to <spbname>.xml.

v0.3: new arguments. -F sets the FORCE property in the SPB to TRUE (by default it is false). -L is a "light mode" argument and instructs SPBGen to only produce the .spb file, not the entire .tar package.

v0.2: fixed a bug where files copied over to the endpoint were being removed immediately after. Any SPBs generated with v0.1 will have this issue.

v0.1: initial release in time for Drop 7 of Elektron PD MTC v1.0. May be buggy in extreme cases but has been tested with normal use cases against Arbitration Server and Snapshot Server/Client. Let me know if any issues.

* Usage:

SPBGen has mandatory and optional requirements (any optional requirements have some defaults which should be common enough to the Elektron systems).

SPBGen [-options]

where options include:
        -i:<code>       sets infrastructure code to <code>
                        [Optional (default: IDN)]
                        [3 capital letters]

        -c:<capability> sets infrastructure capability to <capability>
                        [Optional (default: DDS)]
                        [3/4 capital letters]

        -n:<name>       sets product name to <name>
                        [Required]
                        [Alphanumeric with hyphens]

        -o:<os>         sets OS to <os>
                        [Required]
                        [OS-Ver-nn]
                                OS is Win
                                win_ver 2003 | XP | 2008 | All
                                nn      32 | 64 | All

        -v:<version>    sets version to <version>
                        [Required]
                        [Numeric up to 3 parts: xx-yy-zz]

        -a:<action>     sets action type to <action>
                        [Optional (default: install)]
                        [install | upgrade | files | commit]

        -b:<build>      sets build number to <build>
                        [Optional (default: 01)]
                        [Numeric]

        -S:<path>       sets source path to <path>
                        [Required]
                        [Path without trailing slash]

        -D:<path>       sets destination path to <path>
                        [Required if not executing a .msi installer]
                        [Path without trailing slash]

        -X:<file>       sets post-copy file to execute to <file>
                        [Optional - if a .msi file is specified then no copying will take place]
                        [Filename]

        -U:<file>       sets file to be executed upon uninstallation to <file>
                        [Optional]
                        [Filename]

        -P:<properties> sets MSI properties to <properties>
                        [Optional - if an .msi file is specified with -X then these properties can be specified]
                        [MSI properties]

        -R              ensures a post-install reboot takes place
                        [Optional]

        -F              sets FORCE to yes, forcing the installation via TPM
                        [Optional]

        -N              don't compress the final .tar into a .tar.Z
                        [Optional]

        -L              light mode - only generates an .spb file
                        [Optional]

        -H              heavy mode - generate .spd .spb .xml and .tar.Z files
                        [Optional]

        -O:<folder>     specifies the TAR file should be saved to <folder>
                        [Optional]
                        [Path without trailing slash]

        -K              keeps existing files found in the destination folder
                        [Optional]

	-G:<group>      specifies the access group
                        [Optional]
                        <group> is IDN, or DDS, or others

	-V:<vendor>     sets vendor name
                        [Optional(default: Thomson Reuters)]

        -automation     used for generating Elektron automation packages
                        [Optional]

        -nologo         stop the SPBGen logo from showing
                        [Optional]

Example:
SPBGen -n:ArbitrationServer -o:Win-2008-64 -v:1-0 -S:"C:\SPB" -D:"D:\Temp\AS" -X:"DDS_AS_Install.bat" -U:"DDS_AS_Uninstall.bat" -R -O:C:\temp


This would generate a .tar.Z file in the C:\temp folder, using installation files sourced from C:\SPB. The files would be copied to D:\Temp\AS on the endpoint and the batch file 'DDS_AS_Install.bat' executed from the D:\Temp\AS folder. Once installation is complete a system reboot would occur. If the package is uninstalled then 'DDS_AS_Uninstall.bat' will be executed from the D:\Temp\AS folder.