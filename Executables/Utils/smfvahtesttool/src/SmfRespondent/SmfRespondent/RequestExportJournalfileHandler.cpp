#include "RequestExportJournalfileHandler.h"
#include <time.h>
#include <iostream>

#include "TinyXmlDll.h"
#include "Shlwapi.h"

RequestExportJournalfileHandler::RequestExportJournalfileHandler(smf::RequestServiceTransmitter* pTransmitter, const std::string& sName, unsigned long lIdentifier)
					:RequestHandler(pTransmitter,sName, lIdentifier)
{

}

RequestExportJournalfileHandler::~RequestExportJournalfileHandler()
{


}

void RequestExportJournalfileHandler::Process(const smf::ConnectionIdentity id, smf::RequestServiceReceiver::Payload& payload)
{
	TiXmlDocument xmlStream;
	const char* pReturn = xmlStream.Parse(payload.GetPayload());
	if (pReturn != NULL)
	{
		xmlStream.SaveFile("RequestExportJournalfileVAA.xml");
	}

	//response the current time
	time_t rawtime;
	struct tm * timeinfo;
	//const unsigned int bufferSize = 80;
	//char buffer [bufferSize];

	time ( &rawtime );
#ifdef WIN32
	struct tm info;
	timeinfo = &info;
	localtime_s(timeinfo, &rawtime);
#else
	timeinfo = localtime ( &rawtime );
#endif
	//strftime (buffer,sizeof(buffer),"[Load VAA]I received your xml file.Current DateTime = %x %X",timeinfo);

	char curPath[260];
	char path[260];
	GetModuleFileNameA(NULL, curPath, 260);
	PathRemoveFileSpecA(curPath);
	PathAppendA(curPath, "..//commandsfile//");
	PathCombineA(path, curPath, "ResponseCommand.xml");
	TiXmlDocument in_doc;
	bool loadOkay = in_doc.LoadFile(path);
	TiXmlPrinter printer; 
	in_doc.Accept(&printer);
	std::string buffer = printer.CStr();

	smf::RequestServiceTransmitter::Payload returnPayload(buffer.c_str(), buffer.size());
	m_pTransmitter->Response(id, m_sName, returnPayload);
}