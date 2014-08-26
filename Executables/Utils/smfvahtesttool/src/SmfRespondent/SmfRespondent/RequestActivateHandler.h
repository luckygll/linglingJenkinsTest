#pragma once
#include <stdlib.h>
#include <string>
#include "RequestHandler.h"

class RequestActivateHandler : public RequestHandler
{
public:
	RequestActivateHandler(smf::RequestServiceTransmitter* pTransmitter, const std::string& sName, unsigned long lIdentifier);
	virtual ~RequestActivateHandler();

	virtual void Process(const smf::ConnectionIdentity id, smf::RequestServiceReceiver::Payload& payload);

private:



};