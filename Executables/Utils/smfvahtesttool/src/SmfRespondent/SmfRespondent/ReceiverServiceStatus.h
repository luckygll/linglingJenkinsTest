#ifndef RECEIVERSERVICESTATUS_H
#define RECEIVERSERVICESTATUS_H

#include <iostream>
#include "ServiceStatus.h"
#include "ErrorReason.h"
#include "RequestHandlers.h"
#include <vector>

class ReceiverServiceStatus : public smf::ServiceStatus
{
public:
	ReceiverServiceStatus(RequestHandlers* pHandlers):m_pHandlers(pHandlers)
	{
		char* failures[] = {
			"ServerTooBusy",
			"ErrorInServerService",
			"ServerServiceTooBusy",
			"ClientServiceTooBusy",
			"UnknownMessageType",
			"MaxPayloadExceededResponse",
			0
		};
		errorReason.Set(failures);
	}

	virtual void Disconnect() 
	{
		std::cout << "The connection with the server is broken\n";
	}

	virtual void Reconnect() 
	{
		std::cout << "Reconnected to the server, re-register the receiver\n";

		m_pHandlers->RegisterAllHandlers();
	}

	virtual void MissedMessage(const char *serviceName, MissedMessageReason reason)
	{
		std::cout << "Service: " << serviceName << " - "
			<< errorReason.ReasonToString(reason).c_str() << "\n";
	}

	virtual void ServiceUnknown(const char *serviceName)
	{
		std::cout << "The service " << serviceName << " unknown\n";
	}

private:
	ErrorReason errorReason;
	RequestHandlers* m_pHandlers;
};

#endif
