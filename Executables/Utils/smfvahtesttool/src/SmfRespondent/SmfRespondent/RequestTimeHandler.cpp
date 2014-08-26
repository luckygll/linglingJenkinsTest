#include "RequestTimeHandler.h"
#include <time.h>
#include <iostream>
RequestTimeHandler::RequestTimeHandler(smf::RequestServiceTransmitter* pTransmitter,const std::string& sName, unsigned int lIdentifier)
					:RequestHandler(pTransmitter,sName, lIdentifier)
{

}

RequestTimeHandler::~RequestTimeHandler()
{


}


void RequestTimeHandler::Process(const smf::ConnectionIdentity id, smf::RequestServiceReceiver::Payload& payload)
{
	//print payload
	std::cout << "Handle RequestTime. Payload : ";
	for(unsigned int i = 0; i < payload.PayloadSize(); i++){
		std::cout <<  payload[i];
	}
	std::cout << "\n";

	//response the current time
	time_t rawtime;
	struct tm * timeinfo;
	char buffer [80];

	time ( &rawtime );
#ifdef WIN32
	struct tm info;
	timeinfo = &info;
	localtime_s(timeinfo, &rawtime);
#else
	timeinfo = localtime ( &rawtime );
#endif
	strftime (buffer,sizeof(buffer),"Current Time = %X",timeinfo);
	
	smf::RequestServiceTransmitter::Payload returnPayload(buffer, (unsigned)strlen(buffer));
	m_pTransmitter->Response(id, m_sName, returnPayload);
}
