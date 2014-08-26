#ifndef SCTRLMESSAGE_H
#define SCTRLMESSAGE_H

namespace smf{
	class SCtrlMessage
	{
	public:
		enum
		{
			TaskTypeSize = 2,
			TaskFunctionSize = 2,
			FailureReasonSize = sizeof(unsigned short)
		};

		
		enum TaskType
		{
			System,
			Smf,
			Application
		};

		enum TaskFunction
		{
			Start,
			Stop,
			Restart
		};	

		enum HealthStatus
		{
			Healthy,
			NotHealthy
		};

		enum MessageType
		{
			// Request - Process
			QueryProcesses,			// SCtrlLineCountHdr	+ SCtrlQueryProcessStatusMsgLine
			
			// Request - Schdule
			Schedule,				// SCtrlMessageHdr			+ SCtrlTaskInfoMsgLine
			Periodic,				// SCtrlMessageHdr			+ SCtrlTaskInfoMsgLine

			// Request - Task Management
			TriggerTask,			// SCtrlMessageHdr			+ SCtrlTaskIDMsgLine
			ClearTask,				// SCtrlMessageHdr			+ SCtrlTaskIDMsgLine
			RemoveTask,				// SCtrlMessageHdr			+ SCtrlTaskIDMsgLine
			QueryTasksByID,			// SCtrlLineCountHdr		+ SCtrlTaskIDMsgLine
			QueryTasksByType,		// SCtrlMessageHdr			+ SCtrlTaskTypeMsgLine

			// Monitoring
			RegisterRequest,		// SCtrlMessageHdr			+ SCtrlRegisterRequestMsgLine

			// Response		
			RegistrySuccess,		// SCtrlMessageHdr			+ SCtrlRegisterRespMsgLine
			RegistryFail,			// SCtrlMessageHdr			+ SCtrlErrorMsgLine
			CommandSuccess,			// SCtrlMessageHdr			+ SCtrlTaskIDMsgLine
			CommandFail,			// SCtrlMessageHdr			+ SCtrlErrorMsgLine
			ReportTaskStatus,		// SCtrlLineCountHdr		+ SCtrlTaskInfoMsgLine
			ReportProcessStatus,	// SCtrlLineCountHdr		+ SCtrlProcessStatusRespMsgLine
			ReportGeneralFailure,	// SCtrlMessageHdr			+ SCtrlErrorMsgLine

			//system health status
			QueryStatus,			// SCtrlMessageHdr			+ SCtrlQueryStatusMsgLine
			ReportStatus,			// SCtrlStatusLineCountHdr	+ SCtrlStatusInfoMsgLine
			UpdateHealthStatus,		// SCtrlMessageHdr			+ SCtrlHealthStatusMsgLine
			ReportSuccessfulUpdate,	// SCtrlMessageHdr			+ Null

			//Clean shutdown
			NotifyCleanShutdown,						//SCtrlMessageHdr	+ SCtrlNotifyCleanShutdownMsgLine
			ReportSuccessfulNotifyCleanShutdown,		//SCtrlMessageHdr	+ Null
			CheckAndResetCleanShutdown,					//SCtrlMessageHdr	+ SCtrlCheckCleanShutdownMsgLine
			ReportSuccessfulCheckAndResetCleanShutdown,	//SCtrlMessageHdr	+ Null

			// Control
			LastTableMessageType,
            LastMessageType = LastTableMessageType,
			FirstMessageType = QueryProcesses, 
		
			NumberOfMessageTypes = LastMessageType - FirstMessageType,
		};

		virtual ~SCtrlMessage() {}

		enum FailureReason
		{
			Success,
			UnclassifiedFailure,
			RegistrationOverLimit,
			InvalidTask,
			InvalidPid,
			PidMismatch,	//For the application stop cmd, the appName and PID do not match
			CodingError,	//SMF has detected a problem with its own code
			ServerOverloaded,
			UnsupportedMessageType,
			UnknownMessage,
			TotalMessageSizeTooBig,
			IncorrectSMFChannel, //when opening AppStatusRequestHandler, the channel does not connect to local computer
			PermissionDenied,
			ServerNotReady,
			InvalidApplicationName,
			DetectCleanShutdownDisabled
		};

		unsigned int static SCtrlIdentifier(){
			return *(unsigned int*)"SCS\0";
		}
		static unsigned int Version(){
			return *(unsigned int *)"0001";
		}	
		static unsigned int ExtendedProcInfoVersion(){
			return *(unsigned int *)"0002";
		}	
	};
}

#endif
