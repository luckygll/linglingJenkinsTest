
#include <stdlib.h>
#include <iostream>

#include "ConnectionException.h"
#include <windows.h>

#include "Logger.h"

#include "Error.h"
#include "Warning.h"
#include "FileLoggerEntryPoint.h"
#include "ServiceChannel.h"
#include "SmfClient.h"
#include "ReceiverService.h"

#include "ReceiverServiceStatus.h"
#include "RequestReceiver.h"
#include "RequestHandlers.h"
#include "RequestTimeHandler.h"
#include "RequestLoadHandler.h"
#include "RequestUnloadHandler.h"
#include "RequestActivateHandler.h"
#include "RequestDeactivateHandler.h"
#include "RequestExportJournalfileHandler.h"

int main(int argc, char**argv)
{

	if(argc != 4){
		std::cout << "Usage: "<< argv[0] <<" [SMFHostLocation] [SMFConnectionPort] [LogFile]\n";
		return -1;
	}
	std::cout << "Starting...\n";

	const char* pSMFHost = argv[1];
	unsigned short iPort = atoi(argv[2]);
	const char* pLogFile = argv[3];

	try{
		//create the logger
		smf::Logger* logger =  smf::InternalLogger(pLogFile, 10000000);

		//create the handler container
		RequestHandlers handlers;
		
		//connect to SMF
		smf::ServiceChannel* channel;
		channel = smf::Client::Connect(pSMFHost , iPort, logger, 100);
		Sleep(1000);
		
		//set service status
		ReceiverServiceStatus serviceStatus(&handlers);
		channel->SetServiceStatus(&serviceStatus);
		
		//create Receiver to receive request
		smf::RequestServiceTransmitter* transmitter;
		RequestReceiver receiver(&handlers);
		transmitter = smf::ReceiverService::OpenRequestChannel(&receiver, channel, logger, 100);
		handlers.SetTransmitter(transmitter);
		Sleep(1000);
		
		//create Handler
		//std::string sHandlerName[5] = {"vah_loadvaa","vah_unloadvaa","vah_activatevaa","vah_deactivatevaa","vah_exportjournal"};	//the cmd Name
		unsigned long lIdentifier = 0;
		//RequestHandler* pHandler1,*pHandler2,*pHandler3,*pHandler4,*pHandler5;
		RequestHandler* pHandler;
			
		//sHandlerName = "RequestTime";
		//pHandler = new RequestTimeHandler(transmitter, sHandlerName, lIdentifier++);
		//handlers.AddHandler(pHandler);

		//pHandler1 = new RequestLoadHandler(transmitter, sHandlerName[0], lIdentifier++);
		//handlers.AddHandler(pHandler1);

		//pHandler2 = new RequestUnloadHandler(transmitter, sHandlerName[1], lIdentifier++);
		//handlers.AddHandler(pHandler2);

		//pHandler3 = new RequestActivateHandler(transmitter, sHandlerName[2], lIdentifier++);
		//handlers.AddHandler(pHandler3);

		//pHandler4 = new RequestDeactivateHandler(transmitter, sHandlerName[3], lIdentifier++);
		//handlers.AddHandler(pHandler4);

		//pHandler5 = new RequestExportJournalfileHandler(transmitter, sHandlerName[4], lIdentifier++);
		//handlers.AddHandler(pHandler5);

		pHandler = new RequestLoadHandler(transmitter, "vae0", lIdentifier++);
		handlers.AddHandler(pHandler);

		//register Handler and start processing
		handlers.RegisterAllHandlers();

		
		//wait for exit
		Sleep(INFINITE);
		smf::ReceiverService::CloseRequestChannel(channel, transmitter);
		smf::Client::Disconnect(channel);
	}catch(smf::ConnectionClosed &e){
		std::cout <<"SMF Error:" << e.Value() << "\n";
	}catch(smf::Error &e){
		std::cout <<"SMF Error:" << e.Value() << "\n";
	}catch(smf::Warning &w){
		std::cout << "SMF Warning:" << w.Value() << "\n";
	}catch(...){
		std::cout << "Catch unknown exception\n";
	}
	

	return 0;
}