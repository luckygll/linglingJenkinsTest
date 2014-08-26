
#ifndef SENDERSERVICE_H
#define SENDERSERVICE_H

namespace smf{
	class Logger;
	class ServiceChannel;
	class RequestServiceRequestHandler;
	class RequestServiceResponseHandler;

	namespace SenderService{
		const char* LibName();

		//! \brief Opens a channel to the Sender service which can send arbitrary request messages to 
		//!	a receiver and receive response from it
		//! \param responseHandler	You must provide an implementation of this
		//! \param channel			Use smf::Client::Connect to get this
		//! \param logger           Can be 0, your own implementation of an smf::Logger or
		//!							a file logger (use smf::fileLogger function)
		//! \param queueSize		The default queue size will be used
		RequestServiceRequestHandler* OpenRequestChannel(
				RequestServiceResponseHandler* responseHandler,
				ServiceChannel* channel,  
				Logger* logger, 
				unsigned int queueSize = 0 //the default queue size will be used
				);

		//! \brief It closes the request channel
		//! \param channel           The same service channel that was passed in to OpenRequestChannel
		//! \param requestHandler	 The request handler returned from OpenRequestChannel
		void CloseRequestChannel(
				ServiceChannel* channel, 
				RequestServiceRequestHandler* requestHandler
				);

        unsigned int SetChannelLimit(unsigned int limit);

		void SetQueueSleep(unsigned int);
	}
}
#endif