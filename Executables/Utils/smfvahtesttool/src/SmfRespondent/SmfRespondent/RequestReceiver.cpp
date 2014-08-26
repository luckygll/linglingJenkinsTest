#include <iostream>
#include "RequestReceiver.h"


RequestReceiver::RequestReceiver(RequestHandlers* pHandlers)
:m_pHandlers(pHandlers)
{
	m_pHandlers = pHandlers;
	char* failures[] = {
			"Success",
			"UnclassifiedFailure",
			"UnknownReceiver",
			"ReceiverConnectionFailure",
			"SenderConnectionFailure",
			"DuplicatedRegistration",
			"InvalidSenderId",
			"CodingError", //this means there is something wrong with the code
			"MissedMessage", //this is originated at the client side 
			"ServerOverloaded",
			"SizeMismatch",
			"UnsupportedMessageType",
			"UnknownMessage",
			"TotalMessageSizeTooBig",
			0
		};
		m_ErrorReason.Set(failures);
}

RequestReceiver::~RequestReceiver()
{

}


void RequestReceiver::RegistrationSuccess(const std::string &receiver, UnsignedInt identifier)
{
	//check the recevier handler
	if(m_pHandlers->IsVaildHandler(receiver, identifier) == false){
		std::cout << "RequestReceiver::RegistrationSuccess : identifier incorrect!\n";
	}

}

void RequestReceiver::RegistrationFailure(	const std::string &receiver, 
											UnsignedInt identifier,
											UnsignedInt reason) 
{
	std::cout << "Registration failed for " << receiver.c_str() 
				<< " because " << m_ErrorReason.ReasonToString(reason).c_str() << "\n";
	
	//check the recevier handler
	if(m_pHandlers->IsVaildHandler(receiver, identifier) == false){
		std::cout << "RequestReceiver::RegistrationFailure : identifier incorrect!\n";
	}
}

void RequestReceiver::Request(const smf::ConnectionIdentity id, const std::string &receiver, smf::RequestServiceReceiver::Payload &payload) 
{
	RequestHandler* pHandler = m_pHandlers->GetHandler(receiver);
	if(pHandler == NULL){
		std::cout << "RequestReceiver::Request : called for non existant receiver!\n";
	}
	else{
		pHandler->Process(id, payload);
	}
}

void RequestReceiver::ReportFailure(	const std::string &receiver, 
										UnsignedInt identifier,
										UnsignedInt reason) 
{
	std::cout << "General failure reported for " << receiver.c_str() 
				<< " because " << m_ErrorReason.ReasonToString(reason).c_str() << "\n";
	
}
		
void RequestReceiver::ReportConnectionInformation(	const std::string &receiver, 
													UnsignedInt identifier,
													const ConnectionInformation& info){
	for(ConnectionInformation::const_iterator iter = info.begin(); iter != info.end(); iter++){
		std::cout << "type: ";
		switch(iter->Type()){
			case smf::RequestServiceConnectionInfo::ExternalIp :
				std::cout << "external ip" << std::endl; break;
			case smf::RequestServiceConnectionInfo::LocalIp :
				std::cout << "local ip" << std::endl; break;
			case smf::RequestServiceConnectionInfo::HostName :
				std::cout << "hostname" << std::endl; break;
			default:
				std::cout << "unknown" << std::endl;
		}
		std::cout << "string: " << iter->String() << std::endl;
	}
}
