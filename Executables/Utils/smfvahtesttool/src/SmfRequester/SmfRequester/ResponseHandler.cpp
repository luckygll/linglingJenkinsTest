#include "ResponseHandler.h"
#include "GlobalVariable.h"


void ResponseHandler::Response(const std::string &receiver, UnsignedInt id, Payload &payload)
{
	std::cout << "\n\tReceiver: " << receiver.c_str() << " ID: " << id  << "\n";

	//std::cout << "\tContent: ";
	//for (unsigned int i = 0; i < payload.PayloadSize(); i++)
	//	std::cout << payload[i];

	time_t rawtime;
	struct tm * timeinfo;
	const unsigned int bufferSize = 80;
	char buffer[bufferSize];

	time ( &rawtime );
#ifdef WIN32
	struct tm info;
	timeinfo = &info;
	localtime_s(timeinfo, &rawtime);
#else
	timeinfo = localtime ( &rawtime );
#endif
	strftime(buffer,sizeof(buffer),"Response from Server was received.Current DateTime = %x %X",timeinfo);
	access_log<<buffer<<std::endl;   

	TiXmlDocument xmlStream;
	const char* pstr = payload.GetPayload();
	//fprintf(fp_output,"%s",pstr);
	fwrite(pstr, sizeof(char), payload.GetSize(), fp_output); /* write to file */ 
	fflush(fp_output);
	//const char* pReturn = xmlStream.Parse(pstr);
	//if (pReturn != NULL && fp_output != NULL)
	//{
	//	//xmlStream.SaveFile("ResponseCommand.xml");		
	//	xmlStream.SaveFile(fp_output);
	//}

	std::cout <<  "\n\n";
}

void ResponseHandler::ReportFailure(const std::string &receiver, UnsignedInt id, UnsignedInt reason)
{
	std::cout << "\n\tReceiver: " << receiver.c_str() << " ID: " << id 
		<< "\tFailure reason: " << m_ErrorReason.ReasonToString(reason).c_str() << "\n\n";
}