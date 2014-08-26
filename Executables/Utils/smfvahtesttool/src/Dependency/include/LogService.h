
#ifndef LOGSERVICEENTRYPOINTS_H
#define LOGSERVICEENTRYPOINTS_H


namespace smf{
	class Logger;
	class ServiceChannel;
	class LogServiceRequestHandler;
	class LogServiceResponseHandler;
	class EventLogManagement;
	
	namespace LogService{
		

		const char* LibName();

		//! \brief This function will create a LogServiceRequestHandler which can be used to send logs to the SMF server. 
		//!           It opens a channel to the Log service which can send and receive log messages to and from the SMF server
		//! \param responseHandler				You must provide an implementation of this. 
		//!										See the sample log application(located in the samples\Log_Service directory of the SMF-SDK) for an example of this
		//! \param channel						Use smf::Client::Connect to get this.  The ServiceChannel returned from the call to smf::Client::Connect.  See Opening An SMF Service Channel
		//! \param logger						can be 0, your own implementation of an smf::Logger or a file logger (use smf::fileLogger function)
		//!										A local file logger return from a call to smf::InternalLogger. See Opening a Logger.  
		//!  									Note: you do not have to use the smf implementation; you may provide your own implementation of the Logger interface instead
		//! \param messageFilename				Currently this must be set to null, by default only free text msgs
		//! \param queueSize					The internal queue size for handling responses (in number of items).  If this is zero, the default value of 10 items will be used.
		//! \return 							A pointer to a smf::LogServiceRequestHandler object
		//! \remark 							Include: LogService.h, LogServiceRequestHandler.h, Logger.h
		//! \post 								Cleanup: You must call smf::LogService::CloseRequestChannel to cleanup (see Closing a Log Service Request Handler)
		//! \exception smf::Error				Specific exceptions that might be thrown are defined in LogServiceRequestHandler.h
		//! \note							This function is thread safe
		//! \see 							Sending and Receiving Log Messages
		LogServiceRequestHandler *OpenRequestChannel(
									smf::LogServiceResponseHandler *responseHandler,
									smf::ServiceChannel *channel,  // 
									smf::Logger *logger,					
									const char *messageFilename = 0,//by default only free text msgs
									unsigned int queueSize = 0);//default queue size will be used 

		//! \brief You should call this to close a smf::LogServiceRequestHandler once you have finished with it
		//! \param channel					The same service channel that was passed in to OpenRequestChannel
		//! \param requestHandler			The request handler returned from OpenRequestChannel
		//! \remark 						Include: LogService.h, Error.h
		//! \exception smf::Error			Specific exceptions that might be thrown are defined in LogServiceRequestHandler.h
		//! \note							This function is thread safe
		void CloseRequestChannel(	smf::ServiceChannel *channel, 
									smf::LogServiceRequestHandler *requestHandler);


		//! \brief This function will create a EventLogManagement object which can be used to perform event log management in the SMF server. 
		//!           It opens a channel to the Event Log Management object which can manage event log message in the SMF server
		//! \param channel						Use smf::Client::Connect to get this.  The ServiceChannel returned from the call to smf::Client::Connect.  See Opening An SMF Service Channel
		//! \param logger						can be 0, your own implementation of an smf::Logger or a file logger (use smf::fileLogger function)
		//!										A local file logger return from a call to smf::InternalLogger. See Opening a Logger.  
		//!  									Note: you do not have to use the smf implementation; you may provide your own implementation of the Logger interface instead
		//! \param queueSize		The internal queue size for handling responses.
		//!							If you pass zero here the default queue size will be used.
		//! \return 							A pointer to a smf::EventLogManagement object
		//! \remark 							Include: LogService.h, EventLogManagement.h, Logger.h
		//! \post 								Cleanup: You must call smf::LogService::CloseEventLogManagement to cleanup (see Closing a Event Log Management)
		//! \exception smf::Error			Specific exceptions that might be thrown are defined in EventLogManagement.h
		//! \note							This function is thread safe
		//! \see 							Sending and Receiving Log Messages
		EventLogManagement *OpenEventLogManagement(
									smf::ServiceChannel *channel, 
									smf::Logger *logger,
									unsigned int queueSize = 0 // the default queue size will be used);
									);

		//! \brief You should call this function to close a smf::EventLogManagement object once you have finished with it.
		//! \param channel				The same service channel that was passed in to OpenEventLogManagement.
		//!								The smf::ServiceChannel pointer used when opening this EventLogManagement. 
		//! \param eventLogManagement		The event log management object returned from OpenEventLogManagement.
		//!								A event log management created using the smf::LogService::OpenEventLogManagement function.
		//!	\remark						Include: LogService.h	
		//! \note							This function is thread safe
		void CloseEventLogManagement(
				ServiceChannel* channel,
				EventLogManagement* eventLogManagement);


		unsigned int SetChannelLimit(unsigned int limit);

		void SetQueueSleep(unsigned int);
	}
}
#endif