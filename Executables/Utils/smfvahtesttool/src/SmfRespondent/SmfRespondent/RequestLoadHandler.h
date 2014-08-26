#pragma once
#include <stdlib.h>
#include <string>
#include "RequestHandler.h"

class RequestLoadHandler : public RequestHandler
{
public:
	RequestLoadHandler(smf::RequestServiceTransmitter* pTransmitter, const std::string& sName, unsigned long lIdentifier);
	virtual ~RequestLoadHandler();

	virtual void Process(const smf::ConnectionIdentity id, smf::RequestServiceReceiver::Payload& payload);

private:



};