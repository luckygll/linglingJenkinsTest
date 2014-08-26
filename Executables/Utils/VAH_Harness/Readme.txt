1. What's VAH Harness?
    VAH Harness is a tool located between VAH (VAH is downstream component) and the 
    3rd party utility Traffic Generator(TG which is the upstream component).
    In this version, VAH Harness provides below 4 features.
    1) Perform Login Process for VAH via (RSSL + TRWF2) protocol (opaque to user)
    2) Provide Source Directory Information for VAH via (RSSL + TRWF2) protocol (opaque to user)
    3) Handle Source Subscription from VAH via (RSSL + TRWF2) protocol (opaque to user)
    4) Relay TRWF2 message in MTP protocol to VAH (trasparent to user)
    5) Support multiple constitute (64 consititutes)
    6) Support Symbol List (CBR - Symbol list)
    7) Configure Item Solicited Response Message (L1/L2)
    8) CSN (Item Sequence) maintenance

2. Where to find the VAH Harness Setup materials?
    VAH Harness_V1.0.Win32.zip
    VAH Harness_V1.0.Win64.zip

3. How to use VAH Harness? -- A quick tour
    Users are supposed to use VAH Harness as following order:
    1) Install VAH (if already installed, please ignore it).
    2) Install Traffic Generator(if already installed, please ignore it).
    3) Install VAH Harness. Please note, the 3 items(VAH, TG and Harness) can either 
       be installed on the same HW or separated HWs depends on the resouce usage or 
       the users' intention. A recommanded mode is to set up VAH in one HW and set up 
       TG and Harness on another HW.
    4) If TG and Harness are set up on the same HW then set an Windows enviorment variable
       TG_HOME to the Traffic Genertor installation directory. Provided this env variable,
       user can utilize the shortcut command StartupTG.bat to launch the TG and automatically 
       give the TG open the harness defaulted message templates. Otherwise, user can also 
       launch TG, but would have to find the Message Template themselves manually.
    5) Set MTP parameter in 'VahHarness->Config->VahHarnessConfig.xml' file accordingly.
    6) Launch VAH Harness
    7) Launch VAH (Order of 6) and 7) is not complusory, but preform 6) prior to 7) is recommended)
    8) Send Response Message for items (Response message is necessary before any other message)
    9) Send working Messages for VAH subscribed items
    10)For more details please refer to the <VAH Harness User Guide.doc>.

4. Contacts
    Johnny.Cao@thomsonreuters.com
    Chen.Li@thomsonreuters.com
    Jun.Hong@thomsonreuters.com
