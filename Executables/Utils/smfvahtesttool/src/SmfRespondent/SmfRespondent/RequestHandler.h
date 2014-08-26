#pragma once
#include <stdlib.h>
#include <map>
#include <string>
#include "RequestServiceTransmitter.h"
#include "RequestServiceReceiver.h"
#include "ConnectionIdentity.h"

class RequestHandler
{
public:
	RequestHandler(smf::RequestServiceTransmitter* pTransmitter, const std::string& sName, unsigned long lIdentifier)
		:m_pTransmitter(pTransmitter),
		 m_sName(sName),
		 m_lIdentifier(lIdentifier)
	{
	}

	virtual ~RequestHandler()	{;}

	virtual void Process(const smf::ConnectionIdentity id, smf::RequestServiceReceiver::Payload& payload)=0;

	const std::string& GetName()	{return m_sName;}
	unsigned long GetIdentifier()	{return m_lIdentifier;}

protected:
	smf::RequestServiceTransmitter* m_pTransmitter;
	std::string m_sName;
	unsigned long m_lIdentifier;

};