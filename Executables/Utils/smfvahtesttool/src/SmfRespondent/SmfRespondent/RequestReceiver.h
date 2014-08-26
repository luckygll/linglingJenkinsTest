#pragma once

#include <stdlib.h>
#include "ErrorReason.h"
#include "RequestHandlers.h"
#include "RequestServiceReceiver.h"


class RequestReceiver :public smf::RequestServiceReceiver
{
public:
	RequestReceiver(RequestHandlers* pHandler);
	virtual ~RequestReceiver();

	
	virtual void RegistrationSuccess(const std::string &receiver, UnsignedInt identifier) ;
	virtual void RegistrationFailure(	const std::string &receiver, 
										UnsignedInt identifier,
										UnsignedInt reason) ;

	virtual void Request(const smf::ConnectionIdentity id, const std::string &receiver, smf::RequestServiceReceiver::Payload &payload) ;

	virtual void ReportFailure(	const std::string &receiver, 
									UnsignedInt identifier,
									UnsignedInt reason) ;
		
    virtual void ReportConnectionInformation(
										const std::string &receiver, 
										UnsignedInt identifier,
										const ConnectionInformation&);
	
private:
	RequestHandlers* m_pHandlers;
	ErrorReason m_ErrorReason;
};