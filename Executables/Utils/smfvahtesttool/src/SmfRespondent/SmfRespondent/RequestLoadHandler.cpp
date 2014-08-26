#include "RequestLoadHandler.h"
#include <time.h>
#include <iostream>

#include "TinyXmlDll.h"
#include "Shlwapi.h"

RequestLoadHandler::RequestLoadHandler(smf::RequestServiceTransmitter* pTransmitter, const std::string& sName, unsigned long lIdentifier)
					:RequestHandler(pTransmitter,sName, lIdentifier)
{

}

RequestLoadHandler::~RequestLoadHandler()
{


}

void RequestLoadHandler::Process(const smf::ConnectionIdentity id, smf::RequestServiceReceiver::Payload& payload)
{
	TiXmlDocument xmlStream;
	const char* pstr = payload.GetPayload();//"ocicommand|....."

	time_t rawtime;
	struct tm * timeinfo;
	const unsigned int tmbufSize = 40;
	char filename[tmbufSize]={'\0',};
	time ( &rawtime );
#ifdef WIN32
	struct tm info;
	timeinfo = &info;
	localtime_s(timeinfo, &rawtime);
#else
	timeinfo = localtime ( &rawtime );
#endif
	strftime(filename,tmbufSize,"%y%m%d_%H%M%S_",timeinfo);
	memcpy(filename+14,"RequestFromClient.xml",strlen("RequestFromClient.xml"));
	//drop3 request commands begin with "ocivaddata", drop2 begin with "ocicommand", 
	//the length of "ocivaddata" is the same with "ocicommand", so it doesn't matter. 
	const char* pReturn = xmlStream.Parse(pstr+strlen("ocicommand|"));
	if (pReturn != NULL)
	{
		//xmlStream.SaveFile("RequestFromClient.xml");
		xmlStream.SaveFile(filename);
	}

	char curPath[260];
	char path[260];
	GetModuleFileNameA(NULL, curPath, 260);
	PathRemoveFileSpecA(curPath);
	PathAppendA(curPath, "..//commandsfile");
	PathCombineA(path, curPath, "ResponseCommand.xml");
	TiXmlDocument in_doc;
	bool loadOkay = in_doc.LoadFile(path);
	TiXmlPrinter printer; 
	in_doc.Accept(&printer);
	std::string buffer = printer.CStr();

	smf::RequestServiceTransmitter::Payload returnPayload(buffer.c_str(), buffer.size());
	m_pTransmitter->Response(id, m_sName, returnPayload);
}