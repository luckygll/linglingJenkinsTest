
#ifndef RECEIVERSERVICE_H
#define RECEIVERSERVICE_H

namespace smf{
	class Logger;
	class ServiceChannel;
	class RequestServiceTransmitter;
	class RequestServiceReceiver;

	namespace ReceiverService{
		const char* LibName();

		//! \brief Opens a channel to the Receiver service which can receive arbitrary request messages  
		//! through your implementation of request service handler
		//! \param responseHandler      You must provide an implementation of this
		//! \param channel              Use smf::Client::Connect to get this
		//! \param logger               Can be 0, your own implementation of an smf::Logger or
		//!								a file logger (use smf::fileLogger function)
		//! \param queueSize			The default queue size will be used
		RequestServiceTransmitter* OpenRequestChannel(
				RequestServiceReceiver* responseHandler,
				ServiceChannel* channel,  
				Logger* logger, 
				unsigned int queueSize = 0 //the default queue size will be used
				);

		//! \brief It closes the request chnanel
		//! \param channel            The same service channel that was passed in to OpenRequestChannel
		//! \param requestHandler     The request handler returned from OpenRequestChannel
		void CloseRequestChannel(
				ServiceChannel* channel, 
				RequestServiceTransmitter* requestHandler
				);

        unsigned int SetChannelLimit(unsigned int limit);

		void SetQueueSleep(unsigned int);
	}
}
#endif
