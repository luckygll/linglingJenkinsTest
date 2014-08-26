
#ifndef BULKPARAMETERSERVICEENTRYPOINTS_H
#define BULKPARAMETERSERVICEENTRYPOINTS_H

namespace smf{
	class Logger;
	class ServiceChannel;
	class BulkParameterRequestHandler;
	class BulkParameterResponseHandler;
	class BulkCompParameterRequestHandler;
	class BulkCompParameterResponseHandler;
	class BulkCompParameterRequestHandlerExt1;
	class BulkCompParameterResponseHandlerExt1;

	namespace BulkParameterService{
		

		const char* LibName();
		
		
		//! \brief Opens a channel to the bulk parameter service which can send and receive bulk parameter requests and updates to the smf server
		//! \param responseHandler You must provide an implementation of this.  Your implementation of the smf::BulkParameterResponseHandler interface.
		//!							See the samples/PsdBulk directory in the SMF-SDK for an example implementation.
		//! \param channel	          Use smf::Client::Connect to get this
		//!							The ServiceChannel returned from the call to smf::Client::Connect. See Opening an SMF service channel.
		//! \param logger		Can be 0, your own implementation of an smf::Logger or a file logger (use smf::fileLogger function).  See Opening a Logger. 
		//!                                     Note: you do not have to use the SMF implementation; you may provide your own implementation of the Logger interface instead.
		//! \param queueSize            The internal queue size for handling responses.
		//! \return		          A pointer to a Smf::BulkParameterRequestHandler object.
		//!	\remark		Include: BulkParameterService.h, BulkParameterRequestHandler.h, Logger.h.
		//!	\post					Cleanup: You must call smf::BulkParameterService::CloseRequestChannel to cleanup 
		//! \exception				You should at least catch smf::Error. Specific exceptions that might be thrown are defined in BulkParameterRequestHandler.h.
		BulkParameterRequestHandler* OpenRequestChannel(
				BulkParameterResponseHandler* responseHandler,
				ServiceChannel* channel,  
				Logger* logger, 
				unsigned int queueSize = 0 //the default queue size will be used
				);


		//! \brief Opens a channel to the bulk parameter service with compression support which can send and receive bulk parameter requests and updates to the smf server
		//! \param responseHandler You must provide an implementation of this.  Your implementation of the smf::BulkCompParameterResponseHandler interface.
		//!							See the samples/PsdBulk directory in the SMF-SDK for an example implementation.
		//! \param channel	          Use smf::Client::Connect to get this
		//!							The ServiceChannel returned from the call to smf::Client::Connect. See Opening an SMF service channel.
		//! \param logger		Can be 0, your own implementation of an smf::Logger or a file logger (use smf::fileLogger function).  See Opening a Logger. 
		//!                                     Note: you do not have to use the SMF implementation; you may provide your own implementation of the Logger interface instead.
		//! \param queueSize            The internal queue size for handling responses.
		//! \return		          A pointer to a Smf::BulkCompParameterRequestHandler object.
		//!	\remark		Include: BulkParameterService.h, BulkCompParameterRequestHandler.h, Logger.h.
		//!	\post					Cleanup: You must call smf::BulkParameterService::CloseRequestChannel to cleanup 
		//! \exception				You should at least catch smf::Error. Specific exceptions that might be thrown are defined in BulkParameterRequestHandler.h.
		BulkCompParameterRequestHandler* OpenRequestChannel(
				BulkCompParameterResponseHandler* responseHandler,
				ServiceChannel* channel,  
				Logger* logger, 
				unsigned int queueSize = 0 //the default queue size will be used
				);

		//! \brief Opens a channel to the bulk resizable parameter service with compression support which can send and receive bulk parameter requests and updates to the smf server
		//! \param responseHandler You must provide an implementation of this.  Your implementation of the smf::BulkCompParameterResponseHandlerExt1 interface.
		//!							See the samples/PsdBulk directory in the SMF-SDK for an example implementation.
		//! \param channel	          Use smf::Client::Connect to get this
		//!							The ServiceChannel returned from the call to smf::Client::Connect. See Opening an SMF service channel.
		//! \param logger		Can be 0, your own implementation of an smf::Logger or a file logger (use smf::fileLogger function).  See Opening a Logger. 
		//!                                     Note: you do not have to use the SMF implementation; you may provide your own implementation of the Logger interface instead.
		//! \param queueSize            The internal queue size for handling responses.
		//! \return		          A pointer to a Smf::BulkCompParameterRequestHandlerExt1 object.
		//!	\remark		Include: BulkParameterService.h, BulkCompParameterRequestHandlerExt1.h, Logger.h.
		//!	\post					Cleanup: You must call smf::BulkParameterService::CloseRequestChannel to cleanup 
		//! \exception				You should at least catch smf::Error. Specific exceptions that might be thrown are defined in BulkParameterRequestHandler.h.
		BulkCompParameterRequestHandlerExt1* OpenRequestChannel(
				BulkCompParameterResponseHandlerExt1* responseHandler,
				ServiceChannel* channel,  
				Logger* logger, 
				unsigned int queueSize = 0 //the default queue size will be used
				);

		//! \brief You should call this function to close a smf::BulkParameterRequestHandler once you have finished with it.
		//! \param channel  The same service channel that was passed in to OpenRequestChannel
		//!                        The smf::ServiceChannel pointer used when opening this BulkParameterRequestHandler. 
		//! \param requestHandler  The request handler returned from OpenRequestChannel
		//!                                     A request handler created using the smf::BulkParameterService::OpenRequestChannel function.
		//!	\remark						Include: BulkParameterService.h
		//! \exception smf::Error
		void CloseRequestChannel(
				ServiceChannel* channel, 
				BulkParameterRequestHandler* requestHandler
				);

		//! \brief You should call this function to close a smf::BulkCompParameterRequestHandler once you have finished with it.
		//! \param channel  The same service channel that was passed in to OpenRequestChannel
		//!                        The smf::ServiceChannel pointer used when opening this BulkCompParameterRequestHandler. 
		//! \param requestHandler  The request handler returned from OpenRequestChannel
		//!                                     A request handler created using the smf::BulkParameterService::OpenRequestChannel function.
		//!	\remark						Include: BulkParameterService.h
		//! \exception smf::Error
		void CloseRequestChannel(
				ServiceChannel* channel, 
				BulkCompParameterRequestHandler* requestHandler
				);

		//! \brief You should call this function to close a smf::BulkCompParameterRequestHandlerExt1 once you have finished with it.
		//! \param channel  The same service channel that was passed in to OpenRequestChannel
		//!                        The smf::ServiceChannel pointer used when opening this BulkCompParameterRequestHandlerExt1. 
		//! \param requestHandler  The request handler returned from OpenRequestChannel
		//!                                     A request handler created using the smf::BulkParameterService::OpenRequestChannel function.
		//!	\remark						Include: BulkParameterService.h
		//! \exception smf::Error
		void CloseRequestChannel(
				ServiceChannel* channel, 
				BulkCompParameterRequestHandlerExt1* requestHandler
				);

		unsigned int SetChannelLimit(unsigned int);

		void SetQueueSleep(unsigned int);
	}
}
#endif