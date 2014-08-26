#include "RequestHandlers.h"
#include <iostream>
RequestHandlers::RequestHandlers()
{

}

RequestHandlers::~RequestHandlers()
{
	HandlerList::iterator it;
	for(it = m_Handlers.begin(); it != m_Handlers.end(); it++){
		delete it->second;
	}
	m_Handlers.clear();
}

/*
set the Transmitter
*/
void RequestHandlers::SetTransmitter(smf::RequestServiceTransmitter* pTransmitter)
{
	m_pTransmitter =pTransmitter;
}

/*
return true if the pHandler is added 
and the pHandler will be delete by RequestHandlers after use
*/
bool RequestHandlers::AddHandler(RequestHandler* pHandler)
{
	if(m_Handlers.find(pHandler->GetName()) == m_Handlers.end()){
		m_Handlers.insert(HandlerPair(pHandler->GetName(), pHandler));
		return true;
	}
	else
		return false;
}
	
/*
regist the Handler
*/
void RequestHandlers::RegisterAllHandlers()
{
	if(m_pTransmitter == NULL){
		std::cout << "RequestHandlers::RegisterAllHandlers: Transmitter is NULL!\n";
		return;
	}

	HandlerList::iterator it;
	for(it = m_Handlers.begin(); it != m_Handlers.end(); it++){
		m_pTransmitter->Register(it->second->GetName(), it->second->GetIdentifier());
	}
}

/*
return true if the handler is valid
*/
bool RequestHandlers::IsVaildHandler(const std::string &receiver, unsigned int identifier)
{
	return (GetHandler(receiver, identifier) != NULL);
}

/*
return NULL when the receiver does not find
*/
RequestHandler* RequestHandlers::GetHandler(const std::string &receiver, unsigned int identifier)
{
	HandlerList::iterator it = m_Handlers.find(receiver);
	if(it == m_Handlers.end()){
		return NULL;
	}

	if(it->second->GetName().compare(receiver) == 0 && it->second->GetIdentifier() == identifier)
		return it->second;
	else
		return NULL;
}

RequestHandler* RequestHandlers::GetHandler(const std::string &receiver)
{
	HandlerList::iterator it = m_Handlers.find(receiver);
	if(it == m_Handlers.end()){
		return NULL;
	}
	else{
		return it->second;
	}
}
