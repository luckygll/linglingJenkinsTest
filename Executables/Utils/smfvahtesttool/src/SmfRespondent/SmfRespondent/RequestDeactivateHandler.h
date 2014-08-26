#pragma once
#include <stdlib.h>
#include <string>
#include "RequestHandler.h"

class RequestDeactivateHandler : public RequestHandler
{
public:
	RequestDeactivateHandler(smf::RequestServiceTransmitter* pTransmitter, const std::string& sName, unsigned long lIdentifier);
	virtual ~RequestDeactivateHandler();

	virtual void Process(const smf::ConnectionIdentity id, smf::RequestServiceReceiver::Payload& payload);

private:



};