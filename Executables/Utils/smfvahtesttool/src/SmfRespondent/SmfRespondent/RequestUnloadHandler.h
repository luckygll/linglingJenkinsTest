#pragma once
#include <stdlib.h>
#include <string>
#include "RequestHandler.h"

class RequestUnloadHandler : public RequestHandler
{
public:
	RequestUnloadHandler(smf::RequestServiceTransmitter* pTransmitter, const std::string& sName, unsigned long lIdentifier);
	virtual ~RequestUnloadHandler();

	virtual void Process(const smf::ConnectionIdentity id, smf::RequestServiceReceiver::Payload& payload);

private:



};