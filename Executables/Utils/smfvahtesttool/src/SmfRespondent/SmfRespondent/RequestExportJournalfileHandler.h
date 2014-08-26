#pragma once
#include <stdlib.h>
#include <string>
#include "RequestHandler.h"

class RequestExportJournalfileHandler : public RequestHandler
{
public:
	RequestExportJournalfileHandler(smf::RequestServiceTransmitter* pTransmitter, const std::string& sName, unsigned long lIdentifier);
	virtual ~RequestExportJournalfileHandler();

	virtual void Process(const smf::ConnectionIdentity id, smf::RequestServiceReceiver::Payload& payload);

private:



};