#ifndef RESPONSEHANDLER
#define RESPONSEHANDLER

#include <stdlib.h>
#include <iostream>
#include <time.h>
#include "ErrorReason.h"
#include "RequestServiceResponseHandler.h"

#include "TinyXmlDll.h"


class ResponseHandler: public smf::RequestServiceResponseHandler
{
public:
	ResponseHandler()
	{
		char* failures[] = {
			"Success",
			"UnclassifiedFailure",
			"UnknownReceiver",
			"ReceiverConnectionFailure",
			"SenderConnectionFailure",
			"DuplicatedRegistration",
			"InvalidSenderId",
			"CodingError", //this means there is something wrong with the code
			"MissedMessage", //this is originated at the client side 
			"ServerOverloaded",
			"SizeMismatch",
			"UnsupportedMessageType",
			"UnknownMessage",
			"TotalMessageSizeTooBig",
			0
		};
		m_ErrorReason.Set(failures);
	}

	virtual ~ResponseHandler() {;}

	virtual void Response(const std::string &receiver, UnsignedInt id, Payload &payload);

	virtual void ReportFailure(const std::string &receiver, UnsignedInt id, UnsignedInt reason);

private:
	ErrorReason m_ErrorReason;

};

#endif