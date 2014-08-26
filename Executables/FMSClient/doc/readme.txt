------------------------------
FMSClient Release Notes v2.2.0.3
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE, CVA, CVG... systems to communicate with FMS.


Changes from the previous version
-------------------

Change list:

1. FMSClient: Fix for a potential thread monitoring failure on a slow running job, which might terminate FMSClient by mistake
2. FMSClient: Ensure the shut down of FMSClient when a monitored thread failed repeatedly


FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.5"
		Name="TRWF2_VERSION"
		Value="trwf2.3.4.L2.win.sou"
		Name="pugixml_VERSION"
		Value="1.2"
		Name="BOOST_VERSION"
		Value="1.55"
		Name="CIF_VERSION"
		Value="1.1.4"
		Name="DataDictionary_VERSION"
		Value="1.1.9"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.8.CIF114"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.8.CIF114"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.1.0"
		Name="ThreadUtils_VERSION"
		Value="2.0.4"
		Name="URLLib_VERSION"
		Value="1.0.3"
		Name="ZLIB_VERSION"
		Value="1.2.8"

------------------------------
FMSClient Release Notes v2.2.0.2
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE, CVA, CVG... systems to communicate with FMS.


Changes from the previous version
-------------------

Change list:

1. Add more details to exception logging and ensure first 1024 bytes of message are logged
2. Fix to housekeep pending reply objects when a message from FMSClient never gets a reply
3. Fix to filter dat/tim/date time fields in Snap reqeusts - structure packing issue
4. Fix for sending all fields after a changed field being returned in a snap request
5. Fix for exception caused by no locking on snap queue
6. Fix for leaving pointers to deleted snap requests on the snap queue
7. Fix to avoid CIF error mesages about undefined timer in ControlComponent
8. Fix control component layout issues and improve command summary by detailing logmask bits
9. Add support for supplying a start time and duration to the FMSClient logging commands
10. Add support for explictly logging closing run notifcations
11. Add support for displaying the currently enabled logging
12. Add thread monitoring
13. Make FMSAPI message serialise routines thread safe
14. Fix for fractions in Win32 build
15. Fix for a potential zlib expansion buffer overflow


FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.5"
		Name="TRWF2_VERSION"
		Value="trwf2.3.4.L2.win.sou"
		Name="pugixml_VERSION"
		Value="1.2"
		Name="BOOST_VERSION"
		Value="1.55"
		Name="CIF_VERSION"
		Value="1.1.4"
		Name="DataDictionary_VERSION"
		Value="1.1.9"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.8.CIF114"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.8.CIF114"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.1.0"
		Name="ThreadUtils_VERSION"
		Value="2.0.4"
		Name="URLLib_VERSION"
		Value="1.0.3"
		Name="ZLIB_VERSION"
		Value="1.2.8"

------------------------------
FMSClient Release Notes v2.2.0.1
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE, CVA, CVG... systems to communicate with FMS.


Changes from the previous version
-------------------

Change list:

1. FMSClient: Escape on filter string and simplify add_escape_chars()
2. FMSClient: Fixed an empty ddsReal processing/encoding issue
3. FMSAPIClient: Upgraded to TCPMsg 1.0.9 which have removed some unnecessary buffer copy
4. FMSClient: Tuned DataDictionaryCache to reduce CPU usage
5. FMSClient: Upgraded to zlib 1.2.8 to get better performance when decompressing FMS massages
6. FMSClient: Fixed a ReconResultRequest processing error in FMSClient, reference: https://thehub.thomsonreuters.com/message/242152
7. FMSClient: Log exception type and info during uploading Surplus / ReconResults and re-throw for low level exceptions
8. FMSClient: Corrected the LH state (live or standby) in recon result file name


FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.5"
		Name="TRWF2_VERSION"
		Value="trwf2.3.0.L1.win.sou"
		Name="pugixml_VERSION"
		Value="1.2"
		Name="CIF_VERSION"
		Value="1.1.3"
		Name="DataDictionary_VERSION"
		Value="1.1.7"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.6"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.3"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.9"
		Name="ThreadUtils_VERSION"
		Value="2.0.3"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"
		Name="ZLIB_VERSION"
		Value="1.2.8"

------------------------------
FMSClient Release Notes v2.2.0.0
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE, CVA, CVG... systems to communicate with FMS.


Changes from the previous version
-------------------

Change list:

1. FMSAPI: Add Move Constructor and Move Assignment Operator on FMSAPI::t_dbe_global_field, to enable LH to use it more efficiently with std::move()
2. FMSClient: Print out/log notification cache map size if enabled via log bit mask "LM 73" using telnet
3. FMSClient: Fix for memory leak when encoding from xml to trwf maps and element list
4. FMSClient: encoding map entry key and action at any position for shell meta data and order book
5. FMSClient: remove default value:0 of ddsReal::value according to the subfield unchanged flag in extract decoding


FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.5"
		Name="TRWF2_VERSION"
		Value="trwf2.3.0.L1.win.sou"
		Name="pugixml_VERSION"
		Value="1.2"
		Name="CIF_VERSION"
		Value="1.1.3"
		Name="DataDictionary_VERSION"
		Value="1.1.7"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.6"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.3"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.8"
		Name="ThreadUtils_VERSION"
		Value="2.0.3"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"
		Name="ZLIB_VERSION"
		Value="1.2.5"

------------------------------
FMSClient Release Notes v2.1.0.0
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE, CVA, CVG... systems to communicate with FMS.


Changes from the previous version
-------------------

Change list:

1. Add a new flag (t_createReorgTrigger CreateReorgRequest::m_createReorgTrigger) to the CreateReorg Start message to indicate if this is an auto recon or an FMS initiated weekly recon
2. Fix for FMSClient logging of date and datetime fields
3. Add support for display string representation of enumerated types in logging
4. Add extra logging around unhandled exception reporting from CIF
5. Fix for crash on buffer overrun - remove 1000 byte length restriction on all responses 


FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.5"
		Name="TRWF2_VERSION"
		Value="trwf2.3.0.L1.win.sou"
		Name="pugixml_VERSION"
		Value="1.2"
		Name="CIF_VERSION"
		Value="1.1.3"
		Name="DataDictionary_VERSION"
		Value="1.1.7"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.6"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.3"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.8"
		Name="ThreadUtils_VERSION"
		Value="2.0.3"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"
		Name="ZLIB_VERSION"
		Value="1.2.5"

------------------------------
FMSClient Release Notes v2.0.0.0
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE, CVA, CVG... systems to communicate with FMS.


Changes from the previous version
-------------------

Change list:

1. Remove SurplusRecordsRequest from FMSAPI – ReconResultsRequest should be used
2. Make FMSClient obey the R_DB_SUBFIELD_MOD array in extracted messages so that we can remove unwanted OutputFormat subfields
3. Fix for Access Violation in RMTES converter when FMS uses a large number of outstanding requests
4. Fix for processing names in symbol lists when XML empty tag short form is used (<tag/> as opposed to <tag></tag>) TT581998
5. Fix the escaping in rmtes string decoder. Stop at the first character below 0x20 and avoid issue when inserting icf
6. Update 3rd party libraries to the latest available version

FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.5"
		Name="TRWF2_VERSION"
		Value="trwf2.3.0.L1.win.sou"
		Name="pugixml_VERSION"
		Value="1.2"
		Name="CIF_VERSION"
		Value="1.1.3"
		Name="DataDictionary_VERSION"
		Value="1.1.7"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.6"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.3"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.8"
		Name="ThreadUtils_VERSION"
		Value="2.0.3"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"
		Name="ZLIB_VERSION"
		Value="1.2.5"

------------------------------
FMSClient Release Notes v1.8.0.9
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE, CVA, CVG... systems to communicate with FMS.


Changes from the previous version
-------------------

Change list:

1. Add message limit config for notification cache: notification_cache_message_limit_count. 300k by default, memory usage about 1-1.5 GB
2. Return error if domain is missing in FMS messages


FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.3"
		Name="TRWF2_VERSION"
		Value="trwf2.1.0.L6.win.sou"
		Name="CIF_VERSION"
		Value="1.0.9"
		Name="DataDictionary_VERSION"
		Value="1.1.5"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.6"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.8"
		Name="ThreadUtils_VERSION"
		Value="2.0.3"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"
		Name="ZLIB_VERSION"
		Value="1.2.5"

------------------------------
FMSClient Release Notes v1.8.0.8
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE, CVA, CVG... systems to communicate with FMS.


Changes from the previous version
-------------------

Change list:

1. Escape for any character less than 0x0020, to fix the issue of CHE sending RMTES value starts with 0x0000 and length greater than 0


FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.3"
		Name="TRWF2_VERSION"
		Value="trwf2.1.0.L6.win.sou"
		Name="CIF_VERSION"
		Value="1.0.9"
		Name="DataDictionary_VERSION"
		Value="1.1.5"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.6"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.8"
		Name="ThreadUtils_VERSION"
		Value="2.0.3"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"
		Name="ZLIB_VERSION"
		Value="1.2.5"

------------------------------
FMSClient Release Notes v1.8.0.7
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE, CVA, CVG... systems to communicate with FMS.


Changes from the previous version
-------------------

Change list:

1. Add headend version info on registration request messages
2. Fix for RMTES ISO2022J decoding
3. Remove dependency on ICU libraries for ISO2022 decoding
4. Move FMSClient and FMSAPIClient version info from state enquery reply to registration request messages
5. Fix for RMTES ISO2022C decoding on Linux
6. Add LinuxWindows namespace to windows.h
7. Add mode and status into RegistrationInfoReply to FMS
8. Remove the length restriction of 64 characters for RIC and SIC in FMSClient
9. Fixed the missing job id issue when FMSClient 1.8.0.x sends xml parsing error message back to FMS
10. Fix the warning of StructuredException::AccessViolation when doing a SnapRequest right after the handler is disconnected


FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.3"
		Name="TRWF2_VERSION"
		Value="trwf2.1.0.L6.win.sou"
		Name="CIF_VERSION"
		Value="1.0.9"
		Name="DataDictionary_VERSION"
		Value="1.1.5"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.6"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.8"
		Name="ThreadUtils_VERSION"
		Value="2.0.3"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"
		Name="ZLIB_VERSION"
		Value="1.2.5"

------------------------------
FMSClient Release Notes v1.8.0.6
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE, CVA, CVG... systems to communicate with FMS.


Changes from the previous version
-------------------

Change list:

1. Add timeout support when FMSAPIClient exit, 5 seconds by default, configurable on FMSAPIClient::connect()
2. Switch to TCPMsg 1.0.8 to avoid a potential deaklock


FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.3"
		Name="TRWF2_VERSION"
		Value="trwf2.1.0.L6.win.sou"
		Name="CIF_VERSION"
		Value="1.0.9"
		Name="DataDictionary_VERSION"
		Value="1.1.5"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.6"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.8"
		Name="ThreadUtils_VERSION"
		Value="2.0.3"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"
		Name="ZLIB_VERSION"
		Value="1.2.5"

------------------------------
FMSClient Release Notes v1.8.0.5
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE, CVA, CVG... systems to communicate with FMS.


Changes from the previous version
-------------------

Change list:

1. Clean up the timer routines to avoid unassigned timer errors.

2. Add more logs on exception handling.

3. Replace the standard ISO-2022 decoder with a RMTES decoder.

4. Fix the issue that FMSAPIClient lost control of field editable settings since FMSAPIClient release 1.8.0.0


FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.3"
		Name="TRWF2_VERSION"
		Value="trwf2.1.0.L6.win.sou"
		Name="CIF_VERSION"
		Value="1.0.8"
		Name="DataDictionary_VERSION"
		Value="1.1.5"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.6"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.7"
		Name="ThreadUtils_VERSION"
		Value="2.0.2"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"
		Name="ZLIB_VERSION"
		Value="1.2.5"

------------------------------
FMSClient Release Notes v1.8.0.4
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE, CVA, CVG... systems to communicate with FMS.


Changes from the previous version
-------------------

Change list:

1. Add support for specifying subtype (m_vmtype) and target (m_vmtarget) on VehicleMaintenanceNotification2Request. 
   This will allow for sending closing run notifcations to FMS

2. Convert DDSReal encoded as a fraction to XML as a fraction rather than dividing through to give a real.

3. Add config paramater for notification cache clean interval

4. Fix to convert domain to string correctly in multiservice registration when extracted by command line tools.

5. Fix for conversion of trwfReal numbers with more than 14 decimal places.

6. Fix to prioritise new requests from FMS over notification messages.

7. Fix to prevent notification messages loss/corruption at high volume.

8. Fix to improve notification cache memory usage.

9. Fix for resending large volumes of cached notifications using a timer rather than inline.

FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.3"
		Name="TRWF2_VERSION"
		Value="trwf2.1.0.L6.win.sou"
		Name="CIF_VERSION"
		Value="1.0.8"
		Name="DataDictionary_VERSION"
		Value="1.1.5"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.6"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.7"
		Name="ThreadUtils_VERSION"
		Value="2.0.2"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"
		Name="ZLIB_VERSION"
		Value="1.2.5"

------------------------------
FMSClient Release Notes v1.8.0.3
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE, CVA, CVG... systems to communicate with FMS.


Changes from the previous version
-------------------

Change list:
1. Fix for notification failure at high volume

FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.3"
		Name="TRWF2_VERSION"
		Value="trwf2.1.0.L6.win.sou"
		Name="CIF_VERSION"
		Value="1.0.8"
		Name="DataDictionary_VERSION"
		Value="1.1.5"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.6"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.6"
		Name="ThreadUtils_VERSION"
		Value="2.0.2"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"
		Name="ZLIB_VERSION"
		Value="1.2.5"


------------------------------
FMSClient Release Notes v1.8.0.3
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE, CVA, CVG... systems to communicate with FMS.


Changes from the previous version
-------------------

Change list:
1. Fixed the xml parsing issue with escape characters in container types including Map, NameList and ElementList

FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.3"
		Name="TRWF2_VERSION"
		Value="trwf2.1.0.L6.win.sou"
		Name="CIF_VERSION"
		Value="1.0.8"
		Name="DataDictionary_VERSION"
		Value="1.1.5"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.6"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.6"
		Name="ThreadUtils_VERSION"
		Value="2.0.2"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"
		Name="ZLIB_VERSION"
		Value="1.2.5"


------------------------------
FMSClient Release Notes v1.8.0.2
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE, CVA, CVG... systems to communicate with FMS.


Changes from the previous version
-------------------

Change list:
1. Support for decoding ISO 2022 character sets on RMTES_STRING fields received from line handlers
2. Fix the false Query match when the query string actually only match the beginning of the field value buffer
3. Support for registration retry on timeout
4. Support for reconnection and resend of data to FMS on port 8004 on failure
5. Avoid crashing when Querying field value starts or ends with spaces

FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.3"
		Name="TRWF2_VERSION"
		Value="trwf2.1.0.L6.win.sou"
		Name="CIF_VERSION"
		Value="1.0.8"
		Name="DataDictionary_VERSION"
		Value="1.1.5"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.6"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.6"
		Name="ThreadUtils_VERSION"
		Value="2.0.2"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"
		Name="ZLIB_VERSION"
		Value="1.2.5"


------------------------------
FMSClient Release Notes v1.8.0.1
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE, CVA, CVG... systems to communicate with FMS.


Changes from the previous version
-------------------

Change list:
1. Switch to TCPMSG 1.0.6 to fix the FMSAPIClient crashing issue on debug version, when disconnected from FMSClient. The problem was introduced in TCPMSG 1.0.5 (non-blocking socket change)
2. Fixed the issue of uninitialised exclude flag in Query get next message to API
3. Fixed the issue of #BLANK# value without outputFormat caused ddsreal encoding fail
4. Remove the field from array if it failed encoding and continue with the following fields on the instrument

FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.3"
		Name="TRWF2_VERSION"
		Value="trwf2.1.0.L6.win.sou"
		Name="CIF_VERSION"
		Value="1.0.8"
		Name="DataDictionary_VERSION"
		Value="1.1.5"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.6"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.6"
		Name="ThreadUtils_VERSION"
		Value="2.0.2"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"
		Name="ZLIB_VERSION"
		Value="1.2.5"


------------------------------
FMSClient Release Notes v1.8.0.0
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE, CVA, CVG... systems to communicate with FMS.


Changes from the previous version
-------------------

Change list:
1. Disable the config of filtering on a host list which allows to perform write operations. Write operations will be performed without the restriction of allow_write_op_hosts config. The config could be removed or commented out to avoid confusion in future.
2. Added support to explicitly enable migration from registration messages: bool m_enable_migration on RegistrationRequest and MultiServiceRegistrationRequest. FMS won't do migration if any line handler involved didn't set this as true.
3. Added support to request NDA data updates in registration messages. t_ndafilter m_ndafilter on RegistrationRequest or on serviceFilter for MultiServiceRegistrationRequest.
4. Switched to a new XML parser and kept the same code base as the Linux version.
5. Added Warning / Clear log to SMF when FMS server connection failed / recovered. TeamTrack ID: 500041
6. Fixed the issue that Search on SIC not working from FMSClient v1.7.0.0
7. Optimized compression for best speed
8. Added pdb files for release versions
9. Fix to handle #BLANK# in TRWF2 containers without crashing
10. Omit PRIVATE.DAT in FMSClient release

FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.3"
		Name="TRWF2_VERSION"
		Value="trwf2.1.0.L6.win.sou"
		Name="CIF_VERSION"
		Value="1.0.8"
		Name="DataDictionary_VERSION"
		Value="1.1.5"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.6"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.5"
		Name="ThreadUtils_VERSION"
		Value="2.0.2"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"
		Name="ZLIB_VERSION"
		Value="1.2.5"


------------------------------
FMSClient Release Notes v1.7.0.3
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE, CVA, CVG... systems to communicate with FMS.


Changes from the previous version
-------------------

Change list:
1. Support for passing reference data as a new data type of element list to NDA/AIS in Vehicle_Maintenance_Notification2_msg
2. Fix to ensure success status is consistently set to 0 in all Requests originating from FMSAPI currently some are returning 1 as a success code
3. Fix to set domain to 0 in query RecordRetrieveRequsts  (accmode=FIRST or NEXT)
4. Upgrade to DataDictionary 1.1.4

FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.3"
		Name="TRWF2_VERSION"
		Value="trwf2.1.0.L6.win.sou"
		Name="CIF_VERSION"
		Value="1.0.6"
		Name="DataDictionary_VERSION"
		Value="1.1.4"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.5"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.5"
		Name="ThreadUtils_VERSION"
		Value="2.0.2"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"
		Name="ZLIB_VERSION"
		Value="1.2.5"


------------------------------
FMSClient Release Notes v1.7.0.2
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE, CVA, CVG... systems to communicate with FMS.


Changes from the previous version
-------------------

Change list:
1. Fix for displaying empty symbol_list
2. Improve performance for query and migrate
3. OTFC related fixes
4. Omit smf dll files from FMSClient release
5. Omit TRWF2.DAT in FMSClient release
6. Correct fms job id in state enquiry request in FMSAPI message
7. Reduce memory usage on large amount of otfc
8. Add more message logging between FMS, FMSClient and FMSAPIClient
9. Update to TCPMSG v1.0.5
10. Update to ThreadUtils v2.0.2
11. Update to SMF 1.3 (referenced only in CIF)
12. Fix the false alarm of error logs when connecting release version of FMSClient from telnet to turn on message logging
13. Update to PRIVATE.DAT v1.0.3
14. Update to CIF 1.0.7, ConfigurationComponent 1.0.6 and ConfigurationComponentInterface 1.0.3. Fix for the hardcoded "ApplicationName" in smf log
15. Update to trwf2.1.0.L6.win.sou

FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.3"
		Name="TRWF2_VERSION"
		Value="trwf2.1.0.L6.win.sou"
		Name="CIF_VERSION"
		Value="1.0.6"
		Name="DataDictionary_VERSION"
		Value="1.1.3"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.5"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.5"
		Name="ThreadUtils_VERSION"
		Value="2.0.2"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"
		Name="ZLIB_VERSION"
		Value="1.2.5"


------------------------------
FMSClient Release Notes v1.7.0.1
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE, CVA, CVG... systems to communicate with FMS.


Changes from the previous version
-------------------

Change list:
1. Improved performance on the Query function
2. Update DataDictionary to version 1.1.3
3. Update PRIVATE.DAT to version 1.0.1
4. Added support to DateList
5. Omit TRWF2.DAT in FMSClient release

FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.2P3"
		Name="TRWF2_VERSION"
		Value="trwf2.1.0.L5.win.sou"
		Name="CIF_VERSION"
		Value="1.0.6"
		Name="DataDictionary_VERSION"
		Value="1.1.3"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.5"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.4"
		Name="ThreadUtils_VERSION"
		Value="2.0.1"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"
		Name="ZLIB_VERSION"
		Value="1.2.5"


------------------------------
FMSClient Release Notes v1.7.0.0
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE, CVA, CVG... systems to communicate with FMS.


This version is for evaluation and integration by CHE. Please note that the query functionality can be tested immediately using the DB_EXTRACT Perl script.

Changes from the previous version
-------------------

Change list:
1. Update PRIVATE.DAT to version 1.0.0, update TRWF.DAT to version 4.10.03
2. Bug fix for TT 357987 – long symbol list support
3. Switch to CIF 1.0.6 and ConfigurationComponent 1.0.5
4. Support for nested Map of different container types
5. Support data migration. Added a new enum of t_move on CreateModifyRequest and DeleteRequest. Added 2 more delete action on DeleteRequest: DROP_CLOSERECOVER and PURGE
6. Support for extract by query
7. Support for independent handling of TX and RX compression modes
8. Bug fix for processing conversions from xml to unsigned 32 & 64 bit int types (10 digit closing run group support)

FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.2P3"
		Name="TRWF2_VERSION"
		Value="trwf2.1.0.L5.win.sou"
		Name="CIF_VERSION"
		Value="1.0.6"
		Name="DataDictionary_VERSION"
		Value="1.1.2"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.5"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.4"
		Name="ThreadUtils_VERSION"
		Value="2.0.1"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"
		Name="ZLIB_VERSION"
		Value="1.2.5"


------------------------------
FMSClient Release Notes v1.6.0.1
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE and CVA systems to communicate with FMS.


Changes from v1.6.0.0
-------------------

Change list:
1. Switch to DataDictionary 1.1.2 with the fix of "#426097 [CXA]FMS would not Display RIC in MDE with 52WK_HIGH/LOW"

FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.2P3"
		Name="TRWF2_VERSION"
		Value="trwf2.1.0.L5.win.sou"
		Name="CIF_VERSION"
		Value="1.0.5"
		Name="DataDictionary_VERSION"
		Value="1.1.2"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.4"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.4"
		Name="ThreadUtils_VERSION"
		Value="2.0.1"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"
		Name="ZLIB_VERSION"
		Value="1.2.5"


------------------------------
FMSClient Release Notes v1.6.0.0
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE and CVA systems to communicate with FMS.


Changes from v1.5.4.5
-------------------

Change list:
1. Added support for message compression between FMS Server and FMSClient
2. Added support for source (GEDA, FMS, NDA) as an enum FMSAPI::t_source on CreateModify (Utility) messages in APIMsg version 1.6.0.0
3. Support for filter extraction on request to support FMS command line exl tools
4. Performance improvement to allow sending of responses interleaved in the CIF request receive stream to improve throughput.
5. Support for FMS command line tools

Fixed issue list:
1. Fix to respect trailing zeros when converting from XML to TRWF_REAL ¨C previously these are ignored.

FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.2P3"
		Name="TRWF2_VERSION"
		Value="trwf2.1.0.L5.win.sou"
		Name="CIF_VERSION"
		Value="1.0.5"
		Name="DataDictionary_VERSION"
		Value="1.1.1"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.4"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.4"
		Name="ThreadUtils_VERSION"
		Value="2.0.1"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"
		Name="ZLIB_VERSION"
		Value="1.2.5"


------------------------------
FMSClient Release Notes v1.5.4.5
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE and CVA systems to communicate with FMS.


Changes from v1.5.4.4
-------------------

This is the 6th release in 1.5 drop 4

Change list:
1. Switched to SMF version 1.2 P3
2. Updated PRIVATE.DAT to version 0.91, which will work with schema version 1.0.3

Fixed issue list:
1. Fixed the multilanguage/utf-8 encoding issue
2. Fixed the ChangeKey message not working issue
3. Fixed the reconnection issue caused by unclean buffer in TCPMsg component, updated TCPMsg version to 1.0.4. TeamTrack ID: 408888


FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.2P3"
		Name="TRWF2_VERSION"
		Value="trwf2.1.0.L5.win.sou"
		Name="CIF_VERSION"
		Value="1.0.5"
		Name="DataDictionary_VERSION"
		Value="1.1.1"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.4"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.4"
		Name="ThreadUtils_VERSION"
		Value="2.0.1"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"


------------------------------
FMSClient Release Notes v1.5.4.4
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE and CVA systems to communicate with FMS.


Changes from v1.5.4.3
-------------------

This is the 5th release in 1.5 drop 4

Change list:
1. Changed to use DataDictionary version 1.1.1 since there's a non backward compatible issue in 1.1.0
2. Fixed the false error on config validation in FMSClient log


FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.0.5"
		Name="TRWF2_VERSION"
		Value="trwf2.1.0.L5.win.sou"
		Name="CIF_VERSION"
		Value="1.0.5"
		Name="DataDictionary_VERSION"
		Value="1.1.1"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.4"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.2"
		Name="ThreadUtils_VERSION"
		Value="2.0.1"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"


------------------------------
FMSClient Release Notes v1.5.4.3
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE and CVA systems to communicate with FMS.


Changes from v1.5.4.2
-------------------

This is the 4th release in 1.5 drop 4

Change list:
1. Changed to use DataDictionary version 1.1.0 and PRIVATE.DAT version 0.90, which requires TRWF2.DAT min version 4.10.


FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.0.5"
		Name="TRWF2_VERSION"
		Value="trwf2.1.0.L5.win.sou"
		Name="CIF_VERSION"
		Value="1.0.5"
		Name="DataDictionary_VERSION"
		Value="1.1.0"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.4"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.2"
		Name="ThreadUtils_VERSION"
		Value="2.0.1"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"


------------------------------
FMSClient Release Notes v1.5.4.2
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE and CVA systems to communicate with FMS.


Changes from v1.5.4.1
-------------------

This is the 3rd release in 1.5 drop 4

Fixed issue list:
1. Upgrade PRIVATE.DAT to version 0.84
2. Fixed a potential TCP connection issue from FMSClient to FMS. Check whether the connection is still active and reconnect if the state is DISCONNECTED before sending data.


FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.0.5"
		Name="TRWF2_VERSION"
		Value="trwf2.1.0.L5.win.sou"
		Name="CIF_VERSION"
		Value="1.0.5"
		Name="DataDictionary_VERSION"
		Value="1.0.9"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.4"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.2"
		Name="ThreadUtils_VERSION"
		Value="2.0.1"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"


------------------------------
FMSClient Release Notes v1.5.4.1
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE and CVA systems to communicate with FMS.


Changes from v1.5.4.0
-------------------

This is the 2nd release in 1.5 drop 4

New feature list:
1. Added last update date to the inactive records in ReconResultsRequest, which replaced std::vector<RICDomainPair> ReconResultsRequest::m_Inactive_records with std::vector<RICDomainLastUpdateDate> ReconResultsRequest::m_Inactive_dated_records
2. Changed the format of Recon Result xml to use attributes
3. Added a new message of VehicleMaintenanceNotification2Request which consumes global field list (tm_dp_field_array) instead of xml in VehicleMaintenanceNotificationRequest. Both are acceptible and cached in FMSClient now.


FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.0.5"
		Name="TRWF2_VERSION"
		Value="trwf2.1.0.L5.win.sou"
		Name="CIF_VERSION"
		Value="1.0.5"
		Name="DataDictionary_VERSION"
		Value="1.0.9"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.4"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.2"
		Name="ThreadUtils_VERSION"
		Value="2.0.1"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"


------------------------------
FMSClient Release Notes v1.5.4.0
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE and CVA systems to communicate with FMS.


Changes from v1.5.3.4
-------------------

This is the 1st release in 1.5 drop 4

New feature list:
1. Added inactive duration/since time in Recon/CreateReorgRequest message.
2. Added new ReconResultsRequest and ReconResultsReply messages, to provide dropped, created and inactive RICs from LineHandler to FMS.
3. Merged OTFC and IFFM into a new Vehicle Maintenance Notification message with reply. New FMSAPIClient won't be able to send OTFC and IFFM anymore. It has to use the new message. While new FMSClient can still handle OTFC and IFFM sending from old FMSAPIClient along with the new message from new FMSAPIClient to maintain backward compatibility.
4. Caching the new Vehicle Maintenance Notification messages in FMSClient for a configurable time period (5 mins by default). When FMS starts or any LineHandler changes state from standby to live, FMS will ask FMSClient to send the cached notification messages (within the configured time period) to be resend from FMSClient to FMS.
5. Added version info on release exe and dll files.
6. Added FMSClient and FMSAPIClient version info into the StateReply from FMSClient to FMS. These version info will be displayed on FMS.

Fixed issue list:
1. Fixed RIC length error logging.
2. Fixed the issue of OutputFormat in DDS Real was always 0 on FMS if the field is BLANK.

FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.0.5"
		Name="TRWF2_VERSION"
		Value="trwf2.1.0.L5.win.sou"
		Name="CIF_VERSION"
		Value="1.0.5"
		Name="DataDictionary_VERSION"
		Value="1.0.8"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.4"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.2"
		Name="ThreadUtils_VERSION"
		Value="2.0.1"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"


------------------------------
FMSClient Release Notes v1.5.3.5
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE and CVA systems to communicate with FMS.


Changes from v1.5.3.4
-------------------

This is the 6th release in 1.5 drop 3

Fixed issue list:
1. Correct Date/Time encoding issues in maps

FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.0.5"
		Name="TRWF2_VERSION"
		Value="1.3.0"
		Name="CIF_VERSION"
		Value="1.0.5"
		Name="DataDictionary_VERSION"
		Value="1.0.8"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.4"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.2"
		Name="ThreadUtils_VERSION"
		Value="2.0.1"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"


------------------------------
FMSClient Release Notes v1.5.3.4
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE and CVA systems to communicate with FMS.


Changes from v1.5.3.3
-------------------

This is the 5th release in 1.5 drop 3

Fixed issue list:
1. Changed the default map entry action from UPDATE to ADD. It'll fix the problem of shell meta data and orderbook without map entry action from GEDA exl files couldn't be sent correctly to downstreams via CHE.

FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.0.5"
		Name="TRWF2_VERSION"
		Value="1.3.0"
		Name="CIF_VERSION"
		Value="1.0.5"
		Name="DataDictionary_VERSION"
		Value="1.0.8"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.4"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.2"
		Name="ThreadUtils_VERSION"
		Value="2.0.1"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"


------------------------------
FMSClient Release Notes v1.5.3.3
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE and CVA systems to communicate with FMS.


Changes from v1.5.3.2
-------------------

This is the fourth release in 1.5 drop 3

Fixed issue list:
1. Fix for operation result.
2. Fix a potential issue that empty FIDs in EXL files will cause errors in FMSClient and eventually crash.
3. Fix the issue of Orderbook not parsing correctly on x64

FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.0.5"
		Name="TRWF2_VERSION"
		Value="1.3.0"
		Name="CIF_VERSION"
		Value="1.0.5"
		Name="DataDictionary_VERSION"
		Value="1.0.8"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.4"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.2"
		Name="ThreadUtils_VERSION"
		Value="2.0.1"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"


------------------------------
FMSClient Release Notes v1.5.3.2
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE and CVA systems to communicate with FMS.


Changes from v1.5.3.1
-------------------

This is the third release in 1.5 drop 3

Fixed issue list:
1. Fixed a potential memory usage issue. It's a fix on FMSClient only and there's no change on FMSAPIMsgs and FMSAPIClient from 1.5.3.1

2. Incorporate the latest chnages to the SHELL_MDAT fid names in private.dat

FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.0.5"
		Name="TRWF2_VERSION"
		Value="1.3.0"
		Name="CIF_VERSION"
		Value="1.0.5"
		Name="DataDictionary_VERSION"
		Value="1.0.8"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.4"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.2"
		Name="ThreadUtils_VERSION"
		Value="2.0.1"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"


------------------------------
FMSClient Release Notes v1.5.3.1
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE and CVA systems to communicate with FMS.


Changes from v1.5.3.0
-------------------

This is the second release in 1.5 drop 3

Fixed issue list:
1. Changed the current message version to 0.1.5.3 to make it consistent with the FMSClient release version number
2. Added current message version as the default parameter for serialise functions
3. Fixed another issue in backward compatibility mechanism

FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.0.5"
		Name="TRWF2_VERSION"
		Value="1.3.0"
		Name="CIF_VERSION"
		Value="1.0.5"
		Name="DataDictionary_VERSION"
		Value="1.0.8"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.4"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.2"
		Name="ThreadUtils_VERSION"
		Value="2.0.1"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"


------------------------------
FMSClient Release Notes v1.5.3.0
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE and CVA systems to communicate with FMS.


Changes from v1.5.2.1
-------------------

This is the first release in 1.5 drop 3

New feature list:
1. Support BLANK field by adding a boolean flag R_DB_FIELD_IS_BLANK on t_dbe_global_field
2. Support remove all map entries by setting the mask TRWF_DATA_MP_MSK_IND_REMOVE_ALL_ENTRIES on the encoded trwfMap level
3. Added the helper function to get a field from create modify message by field ID. Required by CVA team.

Fixed issue list:
1. Fixed the issue in backward compatibility mechanism

FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.0.5"
		Name="TRWF2_VERSION"
		Value="1.3.0"
		Name="CIF_VERSION"
		Value="1.0.5"
		Name="DataDictionary_VERSION"
		Value="1.0.8"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.4"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.2"
		Name="ThreadUtils_VERSION"
		Value="2.0.1"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"


------------------------------
FMSClient Release Notes v1.5.2.1
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE and CVA systems to communicate with FMS.


Changes from v1.5.0
-------------------

This is the first release in 1.5 drop 2

New feature list:
1. Add support for Summary Data in Orderbook map
2. Add Shell Meta Data as Map for Element List
3. Upgrade to Visual Studio 2010

Fixed issue list:
1. Fix for empty penultimate tag corrupting the next message
2. Switch to use xxxx_DBG_MDd version of TRWF2 lib to avoid some warnings

FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.0.5"
		Name="TRWF2_VERSION"
		Value="1.3.0"
		Name="CIF_VERSION"
		Value="1.0.5"
		Name="DataDictionary_VERSION"
		Value="1.0.8"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.4"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.2"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.1"
		Name="TCPMsg_VERSION"
		Value="1.0.2"
		Name="ThreadUtils_VERSION"
		Value="2.0.1"
		Name="URLLib_VERSION"
		Value="1.0.2"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"


------------------------------
FMSClient Release Notes v1.5.1.1
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE and CVA systems to communicate with FMS.


Changes from v1.5.0
-------------------

This is a fix/patch version for 1.5.0
Version name convention was changed to 4 digit. For example, v1.5.1.1 stands for 1.5, drop 1, release 1

Fixed issue list:
1. Switch to DataDictionary version 1.0.6 to avoid crash/not starting issue when using new TRWF2.DAT V4.00.13
2. CLEAR field value was not working within Orderbook map in the previous version
3. Price in OrderBook was converted to trwf float rather than DDSReal
4. "false" in bool type was not properly processed in v1.5.0, TeamTrack id:319983
5. A registration timeout issue, team track id: 320384

FMSClient has been built against the following versions of its dependents

		Name="SMF_VERSION"
		Value="1.0.1"
		Name="TRWF2_VERSION"
		Value="1.1.0"
		Name="CIF_VERSION"
		Value="1.0.4"
		Name="DataDictionary_VERSION"
		Value="1.0.6"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.3"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.0"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.0"
		Name="TCPMsg_VERSION"
		Value="1.0.1"
		Name="ThreadUtils_VERSION"
		Value="2.0.0"
		Name="URLLib_VERSION"
		Value="1.0.1"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"


------------------------------
FMSClient Release Notes v1.5.0
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE and CVA systems to communicate with FMS.


Changes from v1.0.9
-------------------

?NEW FMSClientSolution incorporating all aspects of FMSClient, API's and test harnesses
?NEW Dependency versioning, incorporated seamlessly 
?NEW Release mechanism, automated into new solution
?Significant performance enhancements to improve cpu usage, memory footprint and msg throughput
?XMLLITE replaces XERCES-C for XML parsing, all XML parsing refactored for efficiency and maintainability
?DataDictionary 1.0.5 using TRWF2.DAT and PRIVATE.DAT deprecates MasterFieldList.csv
	The configuration file fmsclient.dat has been updated to reflect the change.  SMF partition
	will need to be updated when running from SMF.
		fmsclient.trwf_field_list_source		FMSClientConfiguration/TRWF2.DAT
		fmsclient.private_field_list_source		FMSClientConfiguration/PRIVATE.DAT
		fmsclient.trwf_field_list			TRWF2.DAT
		fmsclient.private_field_list			PRIVATE.DAT
?Integration of Elektron 1.5 Drop changes
?- MultiServiceRegistrationRequest allows a line handler to register for multiple services/domains/filters
?- Orderbook support added 
		NEW T_MAP as used in MARKET_BY_ORDER allows complex map types within a trwfBuffer
		NEW FMSAPIMsg RecordRetrieveRequest fields
			unsigned  u_row_start
			unsigned  u_row_count
		representing the orderbook range requested, defaulting to zero
?- NEW FMSAPIMsg RebuildDBRequest field
		time_t m_rebuildFrom
	  0 for full rebuild or valid time to rebuild from, defaults to zero
?- NEW FMSAPIMsg ClosingRunRequest field
		unsigned short m_domain
	  allows for the domain to be passed within this message
?- FMSAPIMsg CreateModifyRequest modified to default instrument type to NORMAL_RECORD
?- NEW FMSAPIMsg field added to FMSClientOut messages
		unsigned m_FMS_job_id
	  FMS job id of the FMS job that generated the message, defaults to zero
	  Serialised within DeleteRequest, CreateModifyRequest, ChangeKeyRequest, 
	  RecordRetrieveRequest, CreateReorgRequest, ClosingRunRequest, RebuildDBRequest,
	  RPCRequest
?- NEW FMSAPIMsg field added to SurplusRecordRequest messages
		unsigned m_FMS_job_id
	  FMS job id needs to be copied by the LH from the initiating CreateReorgRequest start/end
	  The ftp'd file will append this job id for end to end identification
?- NEW FMSAPIMsg field added to CreateReorgRequest messages
		enum t_createReorgType{FULL,PARTIAL,NOT_SET};
		t_createReorgType m_type;
	  m_type reflects the originating type from FMS
?- FMSClient logic modified for request processing to allow simultaneous snap requests
	  for different row ranges.
?- FMSClient has been built against the following versions of its dependents
	  
		Name="SMF_VERSION"
		Value="1.0.1"
		Name="TRWF2_VERSION"
		Value="1.1.0"
		Name="CIF_VERSION"
		Value="1.0.4"
		Name="DataDictionary_VERSION"
		Value="1.0.5"
		Name="ConfigurationComponent_VERSION"
		Value="1.0.3"
		Name="ConfigurationComponentInterface_VERSION"
		Value="1.0.0"
		Name="ControlComponentInterface_VERSION"
		Value="1.0.0"
		Name="TCPMsg_VERSION"
		Value="1.0.1"
		Name="ThreadUtils_VERSION"
		Value="2.0.0"
		Name="URLLib_VERSION"
		Value="1.0.1"
		Name="PerformanceStatisticsInterface_VERSION"
		Value="1.0.0"
		Name="FMSClientInterface_VERSION"
		Value="1.0.0"
		Name="FMProcessorInterface_VERSION"
		Value="1.0.0"
		Name="FMSAPIClient_TGT_VERSION"
		Value="1.0.9.0"
		Name="CVA_VERSION"
		Value="0.41"

Changes from v1.0.8
-------------------

?Rationalised fmsclient.dat configuration file.
?Reconnection retry attempts
?Rationalised message processing.
?Resolve issue processing empty/null trwfBuffer based fields.
?Improved robustness during the processing at fid and messages level.
?Logging improved to log the raw FMSAPI messages causing exceptional issues.
?Logging improved to log the raw SOAP messages causing exceptional issues.
?Resolve issue processing ChangeKey messages.
?Implementing the new FMAPIMSGS reply message result enumerations, backwards compatible.
?Improved timeout processing where connection fails and registration message is automatically re-generated.
?Unsolicited registration message support.
?DateTimeField date processing logic for MICRO and MILLI second formats.
?Dependencies updated:

3rd Party      SMF                                 1.01
3rd Party      TRWF2                              0.9.0
3rd Party      xerces-c                           3.0.1
3rd Party      zlib                                    
Common         CIF                                1.0.4
Common         DataDictionary                     1.0.2
Common         ConfigurationComponent             1.0.3
Common         ConfigurationComponentInterface    1.0.0
Common         ControlComponentInterface          1.0.0
Common         TCPMsg                             1.0.1
Common         ThreadUtils                        2.0.0
Common         URLLib                             1.0.1
CVA            *                                   0.51
FMSClientBase  FMSAPIClient                       1.0.6
FMSClientBase  FMSAPIMsgs                         1.0.6
FMSClientBase  FMSAPIServer                       1.0.5
FMSClientBase  FMSProcessorInterface              1.0.0
FMSClientBase  PerformanceStatisticsInterface     1.0.0
FMSClientBase  FMSClientInterface                 1.0.0
FMSClientBase  FMSClient                          1.0.9
FMSClientBase  FMSClientStub                      0.7.1


------------------------------
FMSClient Release Notes v1.0.8
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE and CVA systems to communicate with FMS.


Changes from v1.0.7
-------------------

- Implement the editable flag against individual fields to indicate ownership
- Implement RecordRetrieve constituent ID's
- Implement support for unsolicited SOAP messages to FMS
- Implement IFFM as unsolicited message removing ftp functionality
- Implement OTFC as unsolicited message removing ftp functionality
- Removed zip libraries from build no longer required for IFFM and OTFC
- Consolidated use of schema versioning within SOAP messages
- Fixed bugs in the retrieval of MasterFieldList.csv from FMS ftp host
- Implemented more control over the retrieval of MasterFieldList.csv including facility 
  for online application
- Built against the following component versions

3rd Party      SMF                                  1.0
3rd Party      TRWF2                              0.8.0
3rd Party      xerces-c                           3.0.1
3rd Party      zlib                                    
Common         CIF                                1.0.3
Common         DataDictionary                     1.0.1
Common         ConfigurationComponent             1.0.2
Common         ConfigurationComponentInterface    1.0.0
Common         ControlComponentInterface          1.0.0
Common         TCPMsg                             1.0.1
Common         ThreadUtils                        2.0.0
Common         URLLib                             1.0.1
CVA            *                                   0.51
FMSClientBase  FMSAPIClient                       1.0.5
FMSClientBase  FMSAPIMsgs                         1.0.5
FMSClientBase  FMSAPIServer                       1.0.4
FMSClientBase  FMSProcessorInterface              1.0.0
FMSClientBase  PerformanceStatisticsInterface     1.0.0
FMSClientBase  FMSClientInterface                 1.0.0
FMSClientBase  FMSClient                          1.0.8
FMSClientBase  FMSClientStub                      0.6.0


------------------------------
FMSClient Release Notes v1.0.7
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE and CVA systems to communicate with FMS.


Changes from v1.0.6
-------------------

- Implement improved exit handling, logging critial messages to SMF.
- Implement SurplusRecordsReply message, reporting status of FTP operation to requester.
- Implement logging silence for Release builds when messages contain NULL/EMPTY fields.
- Implement s_apply_ds flag to indicate if the message should be applied downstream.
- Fixed SurplusRecordRequest messages causing "cad allocation" or "access violation" exceptions.
- Fixed NULL trwfBuffer handling to complement a QuoteTypeLib change.
- Built against the following component versions


3rd Party	SMF				0.41
3rd Party	TRWF2				0.7.0
3rd Party	xerces-c			3.0.1
3rd Party	zlib				1.2.3
Common		CIF				1.0.2
Common		DataDictionary			1.0.0
Common		ConfigurationComponent		1.0.1
Common		ConfigurationComponentInterface	1.0.0
Common		ControlComponentInterface	1.0.0
Common		TCPMsg				1.0.1
Common		ThreadUtils			2.0.0
Common		URLLib				1.0.0
CVA		*				0.51
FMSClientBase	FMSAPIClient			1.0.4
FMSClientBase	FMSAPIMsgs			1.0.4
FMSClientBase	FMSAPIServer			1.0.3
FMSClientBase	FMSProcessorInterface		1.0.0
FMSClientBase	PerformanceStatisticsInterface	1.0.0
FMSClientBase	FMSClientInterface		1.0.0
FMSClientBase	FMSClient			1.0.7



------------------------------
FMSClient Release Notes v1.0.6
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE and CVA systems to communicate with FMS.

Changes from v1.0.5
-------------------

- Fixed build dependencies with SMF v0.41
- Built against the following component versions

3rd Party	SMF				0.41
3rd Party	TRWF2				0.7.0
3rd Party	xerces-c			3.0.1
3rd Party	zlib				1.2.3
Common		CIF				1.0.2
Common		ConfigurationComponent		1.0.1
Common		ConfigurationComponentInterface	1.0.0
Common		ControlComponentInterface	1.0.0
Common		TCPMsg				1.0.1
Common		ThreadUtils			2.0.0
Common		URLLib				1.0.0
CVA		*				0.4
FMSClientBase	FMSAPIClient			1.0.2
FMSClientBase	FMSAPIMsgs			1.0.3
FMSClientBase	FMSAPIServer			1.0.2
FMSClientBase	FMSProcessorInterface		1.0.0
FMSClientBase	PerformanceStatisticsInterface	1.0.0
FMSClientBase	FMSClientInterface		1.0.0
FMSClientBase	FMSClient			1.0.5


------------------------------
FMSClient Release Notes v1.0.5
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE and CVA systems to communicate with FMS.

Changes from v1.0.4
-------------------

- Fixed bug with timestamp processing, being applied to all CreateModifyRequest messages.
- ClosingRunRequest support for VIEW, SUSPEND, RESUME
- Fixed bug with ExtractFieldComparator

FMSClient Release Notes v1.0.4
------------------------------

FMSClient supplied as Win32 and x64 executables in both Debug and Release forms.

FMSClient is an application that allows CHE and CVA systems to communicate with FMS.

Changes from v1.0.3
-------------------

- Fixed crash if message returned that a RIC had changed
- If duplicate MDE extract, remove previous instead of error
- Increased TCP/IP receive buffer size
- Fixed bug when writing data
- Simplified read/writes of FMS sessions code
- Added fields to allow better handler rebuilding
- Made some errors more informative
- Increased some parsing buffer that was too small
- Added handler and hostname to all messages going back to FMS

Changes from v1.0.2
-------------------

- Fixes for MDE requests

Changes from v1.0.1
-------------------

- Another fix to stop running out of timers

Changes from v1.0.0
-------------------

- Fix to not encode XML data twice
- Fix to do MDE extracts in READONLY mode and not LOOKUP
- Use CIF v1.0.1, which should stop isse with running out of timers

Install
-------

copy desired platform and build files to target directory
copy MasterFieldList.csv to target directory
copy fmsclient.dat to target directory
edit fmsclient.dat and use comments to modify following entries

fmsclient.server.ip
fmsclient.server.name
fmsclient.ws.live_ip
fmsclient.fmsapi_server.ip

Running
-------

execute FMSClient passing in the configuration file as a paramter

FMSClient fmsclient.dat

Files
-----
bin/Debug/Win32/FMSClient.exe
bin/Debug/Win32/FMSClient.pdb
bin/Debug/Win32/LogClientService.msc1500.c++libs505.smf160.32bit.dbg.dll
bin/Debug/Win32/PSDBulkClientService.msc1500.c++libs505.smf160.32bit.dbg.dll
bin/Debug/Win32/PSDClientService.msc1500.c++libs505.smf160.32bit.dbg.dll
bin/Debug/Win32/psddirect.msc1500.c++libs505.smf160.32bit.dbg.dll
bin/Debug/Win32/SmfClient.msc1500.c++libs505.smf160.32bit.dbg.dll
bin/Debug/Win32/xerces-c_3_0D.dll
bin/Debug/x64/FMSClient.exe
bin/Debug/x64/FMSClient.pdb
bin/Debug/x64/LogClientService.msc1500.c++libs505.smf160.64bit.dbg.dll
bin/Debug/x64/PSDBulkClientService.msc1500.c++libs505.smf160.64bit.dbg.dll
bin/Debug/x64/PSDClientService.msc1500.c++libs505.smf160.64bit.dbg.dll
bin/Debug/x64/psddirect.msc1500.c++libs505.smf160.64bit.dbg.dll
bin/Debug/x64/SmfClient.msc1500.c++libs505.smf160.64bit.dbg.dll
bin/Debug/x64/xerces-c_3_0D.dll
bin/Release/Win32/FMSClient.exe
bin/Release/Win32/LogClientService.msc1500.c++libs505.smf160.32bit.dll
bin/Release/Win32/PSDBulkClientService.msc1500.c++libs505.smf160.32bit.dll
bin/Release/Win32/PSDClientService.msc1500.c++libs505.smf160.32bit.dll
bin/Release/Win32/psddirect.msc1500.c++libs505.smf160.32bit.dll
bin/Release/Win32/SmfClient.msc1500.c++libs505.smf160.32bit.dll
bin/Release/Win32/xerces-c_3_0.dll
bin/Release/x64/FMSClient.exe
bin/Release/x64/LogClientService.msc1500.c++libs505.smf160.64bit.dll
bin/Release/x64/PSDBulkClientService.msc1500.c++libs505.smf160.64bit.dll
bin/Release/x64/PSDClientService.msc1500.c++libs505.smf160.64bit.dll
bin/Release/x64/psddirect.msc1500.c++libs505.smf160.64bit.dll
bin/Release/x64/SmfClient.msc1500.c++libs505.smf160.64bit.dll
bin/Release/x64/xerces-c_3_0.dll
FMSClient.dat
MasterFieldList.csv
readme.txt