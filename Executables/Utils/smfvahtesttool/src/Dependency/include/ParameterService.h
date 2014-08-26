
#ifndef PARAMETERSERVICEENTRYPOINTS_H
#define PARAMETERSERVICEENTRYPOINTS_H

namespace smf{
	class Logger;
	class ServiceChannel;
	class ParameterServiceRequestHandler;
	class ParameterServiceResponseHandler;
	class ParameterServiceRequestHandlerExt1;
	class ParameterServiceResponseHandlerExt1;

	namespace ParameterService{
		

		const char* LibName();
		
		
		//! \brief This function will create a ParameterServiceRequestHandler which can be used to query and update parameter values from the SMF server.
		//! \param responseHandler You must provide an implementation of this.  Your implementation of the smf::ParameterServiceResponseHandler interface.
		//!							See the samples/PsdService directory in the SMF-SDK for an example implementation.
		//! \param channel			Use smf::Client::Connect to get this
		//!							The ServiceChannel returned from the call to smf::Client::Connect. See Opening an SMF service channel.
		//! \param logger			Can be 0, your own implementation of an smf::Logger or a file logger 
		//!							(use smf::fileLogger function)
		//!							A local file logger return from a call to smf::InternalLogger. See Opening a Logger. 
		//!							Note: you do not have to use the SMF implementation; you may provide your own implementation of the Logger interface instead.
		//! \param queueSize		The internal queue size for handling responses.
		//!							If you pass zero here the default queue size will be used.
		//! \return					A pointer to a Smf::ParameterServiceRequestHandler object.
		//!	\remark					Include: ParameterService.h, ParameterServiceRequestHandler.h, Logger.h.
		//!	\post					Cleanup: You must call smf::ParameterService::CloseRequestChannel to cleanup (see Closing a Parameter Service Request Handler).
		//! \exception				You should at least catch smf::Error. Specific exceptions that might be thrown are defined in ParameterServiceRequestHandler.h.
		//! \note					This function is thread safe. 
		ParameterServiceRequestHandler* OpenRequestChannel(
				ParameterServiceResponseHandler* responseHandler,
				ServiceChannel* channel,  
				Logger* logger , 
				unsigned int queueSize = 0 //the default queue size will be used
				);

		//! \brief This function will create a ParameterServiceRequestHandlerExt1 which can be used to query and update parameter values from the SMF server.
		//! \param responseHandler You must provide an implementation of this.  Your implementation of the smf::ResizableParameterServiceResponseHandler interface.
		//!							See the samples/PsdService directory in the SMF-SDK for an example implementation.
		//! \param channel			Use smf::Client::Connect to get this
		//!							The ServiceChannel returned from the call to smf::Client::Connect. See Opening an SMF service channel.
		//! \param logger			Can be 0, your own implementation of an smf::Logger or a file logger 
		//!							(use smf::fileLogger function)
		//!							A local file logger return from a call to smf::InternalLogger. See Opening a Logger. 
		//!							Note: you do not have to use the SMF implementation; you may provide your own implementation of the Logger interface instead.
		//! \param queueSize		The internal queue size for handling responses.
		//!							If you pass zero here the default queue size will be used.
		//! \return					A pointer to a Smf::ParameterServiceRequestHandlerExt1 object.
		//!	\remark					Include: ParameterService.h, ParameterServiceRequestHandlerExt1.h, Logger.h.
		//!	\post					Cleanup: You must call smf::ParameterService::CloseRequestChannel to cleanup (see Closing a Parameter Service Request Handler).
		//! \exception				You should at least catch smf::Error. Specific exceptions that might be thrown are defined in ResizableParameterServiceRequestHandler.h.
		//! \note					This function is thread safe. 
		ParameterServiceRequestHandlerExt1* OpenRequestChannel(
				ParameterServiceResponseHandlerExt1* responseHandler,
				ServiceChannel* channel,  
				Logger* logger , 
				unsigned int queueSize = 0 //the default queue size will be used
				);

		//! \brief You should call this function to close a smf::ParameterServiceRequestHandler once you have finished with it.
		//! \param channel				The same service channel that was passed in to OpenRequestChannel.
		//!								The smf::ServiceChannel pointer used when opening this ParameterServiceRequestHandler. 
		//! \param requestHandler		The request handler returned from OpenRequestChannel.
		//!								A request handler  created using the smf::ParameterService::OpenRequestChannel function.
		//!	\remark						Include: ParameterService.h
		//!	\exception smf::Error
		//! \note						function is thread safe.
		void CloseRequestChannel(
				ServiceChannel* channel, 
				ParameterServiceRequestHandler* requestHandler
				);

		//! \brief You should call this function to close a smf::ParameterServiceRequestHandlerExt1 once you have finished with it.
		//! \param channel				The same service channel that was passed in to OpenRequestChannel.
		//!								The smf::ServiceChannel pointer used when opening this ParameterServiceRequestHandlerExt1. 
		//! \param requestHandler		The request handler returned from OpenRequestChannel.
		//!								A request handler  created using the smf::ParameterService::OpenRequestChannel function.
		//!	\remark						Include: ParameterService.h
		//!	\exception smf::Error
		//! \note						function is thread safe.
		void CloseRequestChannel(
				ServiceChannel* channel, 
				ParameterServiceRequestHandlerExt1* requestHandler
				);

		unsigned int SetChannelLimit(unsigned int);

		void SetQueueSleep(unsigned int);
	}
}
#endif