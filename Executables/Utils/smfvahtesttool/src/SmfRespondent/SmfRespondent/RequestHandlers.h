#pragma once
#include <stdlib.h>
#include <map>
#include <string>
#include "RequestHandler.h"
#include "RequestServiceReceiver.h"
#include "RequestServiceTransmitter.h"

class RequestHandlers
{
public:
	RequestHandlers();
	virtual ~RequestHandlers();

	/*
	return true if the pHandler is added 
	and the pHandler will be delete by RequestHandlers after use
	*/
	bool AddHandler(RequestHandler* pHandler);
	
	/*
	regist the Handler
	*/
	void RegisterAllHandlers();

	/*
	return true if the handler is valid
	*/
	bool IsVaildHandler(const std::string &receiver, unsigned int identifier);

	/*
	return NULL when the receiver does not find
	*/
	RequestHandler* GetHandler(const std::string &receiver, unsigned int identifier);
	RequestHandler* GetHandler(const std::string &receiver);

	/*
	set the Transmitter
	*/
	void SetTransmitter(smf::RequestServiceTransmitter* pTransmitter);


private:
	typedef std::map<std::string, RequestHandler*> HandlerList;
	typedef std::pair<std::string, RequestHandler*> HandlerPair;
	HandlerList m_Handlers;
	smf::RequestServiceTransmitter* m_pTransmitter;
};