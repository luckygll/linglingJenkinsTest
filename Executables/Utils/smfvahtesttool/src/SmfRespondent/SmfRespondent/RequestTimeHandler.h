#pragma once
#include <stdlib.h>
#include <string>
#include "RequestHandler.h"

class RequestTimeHandler : public RequestHandler
{
public:
	RequestTimeHandler(smf::RequestServiceTransmitter* pTransmitter, const std::string& sName, unsigned int lIdentifier);
	virtual ~RequestTimeHandler();

	virtual void Process(const smf::ConnectionIdentity id, smf::RequestServiceReceiver::Payload& payload);

private:



};
