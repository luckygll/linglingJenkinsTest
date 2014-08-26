
#include <stdlib.h>
#include <iostream>
//#include <fstream>

#include "RequestServiceRequestHandler.h"
#include "ConnectionException.h"
#include "Warning.h"
#include "SmfClient.h"
#include "SenderService.h"
#include "Error.h"
#include "FileLoggerEntryPoint.h"
#include "ServiceChannel.h"

#include "SenderServiceStatus.h"
#include "ResponseHandler.h"

#include "CheckedCast.h"
#include "CriticalError.h"

#include "TinyXmlDll.h"
#include "Shlwapi.h"

#include <time.h>

#include "GlobalVariable.h"

#include <io.h> 

FILE* fp_output = NULL;
std::ofstream access_log;


int main(int argc, char**argv)
{
	//open access log
	time_t rawtime;
	struct tm * timeinfo;
	const unsigned int tmbufSize = 40;
	char tmbuf[tmbufSize]="access_log";

	time ( &rawtime );
#ifdef WIN32
	struct tm info;
	timeinfo = &info;
	localtime_s(timeinfo, &rawtime);
#else
	timeinfo = localtime ( &rawtime );
#endif
	strftime(tmbuf+strlen("access_log"),tmbufSize-strlen("access_log"),"_%y%m%d_%H%M%S",timeinfo);

	access_log.open(tmbuf,std::ios::app);
	access_log<<std::endl<<std::endl<<"========================================="<<std::endl;
	access_log<<"	ACCESS_LOG BEGIN"<<std::endl;
	access_log<<"========================================="<<std::endl;

	//open error log
	tmbuf[0]='\0';
	memcpy(tmbuf,"error_log",strlen("error_log"));
	strftime(tmbuf+strlen("error_log"),tmbufSize-strlen("error_log"),"__%y%m%d_%H%M%S",timeinfo);

	std::ofstream error_log(tmbuf,std::ios::app);
	error_log<<std::endl<<std::endl<<"========================================="<<std::endl;
	error_log<<"	ERROR_LOG BEGIN"<<std::endl;
	error_log<<"========================================="<<std::endl;

	//const char* pLogFile = "smflogtemp";
	char pLogFile[tmbufSize]="ignorelogtemp";
	strftime(pLogFile+strlen("ignorelogtemp"),tmbufSize-strlen("ignorelogtemp"),"_%y%m%d_%H%M%S",timeinfo);

	if(argc != 8)
	{
		error_log << "Usage: "<< argv[0] <<" [SMFHostLocation] [SMFConnectionPort] [XmlProtoFilePath] [XmlProtoFile] [XmlRespFile] [RespFileGenMode] [TimeOut]"
			<<std::endl;
		access_log.close();
		error_log.close();
		return -1;
	}

	//std::cout << "Starting...\n";

	const char* pSMFHost = argv[1];
	//const char* pLogFile = argv[3];
	unsigned short iPort = atoi(argv[2]);
	const char* pXmlFilePath = argv[3];
	const char* pXmlFile = argv[4];
	const char* pXmlRespFile = argv[5];
	const char* pRespFileGenMode = argv[6];
	//DWORD waitvah_timeout = 5000;//default timeout value
	DWORD waitvah_timeout = atol(argv[7]);

	//if (8 == argc)
	//{
	//	waitvah_timeout = atol(argv[7]);
	//}

	errno_t errcode;

	if (0 == strcmp(pRespFileGenMode,"append"))
	{
		errcode = fopen_s(&fp_output,pXmlRespFile,"a");
	}
	else if (0 == strcmp(pRespFileGenMode,"replace"))
	{
		errcode = fopen_s(&fp_output,pXmlRespFile,"w");
	}
	else
	{
		error_log << "the command supports append/replace while outputting resp file! " << std::endl
			<< "Application will terminate NOW!" << std::endl;
		access_log.close();
		error_log.close();
		return -1;
	}

	if(errcode != 0)
	{
		error_log << "Failed to open output file! " << std::endl
			<< "Application will terminate NOW!" << std::endl;
		access_log.close();
		error_log.close();
		if(fp_output)
		{
			fclose(fp_output);
		}
		return -1;
	}

	int old = -1;
	FILE* newfp = NULL;

	try{
		//////////////////////// redirection 
		old = _dup( 1 );   
		if( -1 == old )
		{
			error_log << "Error: _dup( 1 ) failure\n" <<std::endl; 
			return -1;
		}
		if( ( newfp = fopen( "rubbishlog", "w" ) ) == NULL )
		{
			error_log << "Error: Can't open file 'rubbishlog'\n" <<std::endl; 
			return -1;
		}
		if( -1 == _dup2( _fileno( newfp ), 1 ) )
		{
			error_log << "Error: Can't _dup2 stdout\n" <<std::endl; 
			return -1;
		}
		////////////////////////

		//create the logger
		smf::Logger* logger =  smf::InternalLogger(pLogFile, 10000000);

		//connect to SMF
		smf::ServiceChannel* channel;
		channel = smf::Client::Connect(pSMFHost, iPort, logger, 100);
		Sleep(1000);

		//set service status
		SenderServiceStatus channelStatus;
		channel->SetServiceStatus(&channelStatus);

		//create sender to send request
		ResponseHandler handler;
		smf::RequestServiceRequestHandler *requester = smf::SenderService::OpenRequestChannel(
				&handler, channel, logger, 10);
		
		if (!requester){
			error_log << "Error: Cannot Create Request Handler!\n" <<std::endl;       
			smf::Client::Disconnect(channel);
			access_log.close();
			error_log.close();
			if(fp_output)
			{
				fclose(fp_output);
			}
			fflush( stdout );
			fclose( newfp );
			_dup2( old, 1 ); 
			return 1;
		}
		Sleep(1000);

		//send request
		//unsigned int iStreamID = 0;
		std::string sCmd ="";

		//char curPath[260];
		char path[260];
		//GetModuleFileNameA(NULL, curPath, 260);
		//PathRemoveFileSpecA(curPath);
		//PathAppendA(curPath, "..//..//commandsfile//");
		//PathCombineA(path, curPath, pXmlFile);
		PathCombineA(path, pXmlFilePath, pXmlFile);

		//variable definition
		time_t rawtime;
		struct tm * timeinfo;
		const unsigned int bufferSize = 80;
		char buf[bufferSize];
		TiXmlPrinter printer; 
		std::string buffer;
		std::string cmdstr = "vae0";
		//

		TiXmlDocument in_doc;
		bool loadOkay = in_doc.LoadFile(path);
		if( !loadOkay )
		{
			error_log << "Failed to load file! " << std::endl
				<< "Application will terminate NOW!" << std::endl;
			goto CLEANG;
			//return 2;
		}

		TiXmlElement* pElem = NULL;
		//pElem = in_doc.FirstChildElement("Traffic");
		//if( NULL == pElem )
		//{
		//	error_log << "Failed to get Traffic Node!" << std::endl
		//		<< "Application will terminate NOW!" << std::endl;
		//	return 2;
		//}

		pElem = in_doc.FirstChildElement("Message");
		//pElem = pElem->FirstChildElement("Message");
		if( NULL == pElem )
		{
			error_log << "Failed to get Message Node!" << std::endl
				<< "Application will terminate NOW!" << std::endl;
			goto CLEANG;
			//return 2;
		}

		pElem = pElem->FirstChildElement("MsgBase");
		if( NULL == pElem )
		{
			error_log << "Failed to get MsgBase Node!" << std::endl
				<< "Application will terminate NOW!" << std::endl;
			goto CLEANG;
			//return 2;
		}

		TiXmlElement* pElemStreamID = pElem->FirstChildElement("StreamID");
		if( NULL == pElemStreamID )
		{
			error_log << "Failed to get StreamID Node!" << std::endl
				<< "Application will terminate NOW!" << std::endl;
			goto CLEANG;
			//return 2;
		}
		const char* pstrStreamID = pElemStreamID->Attribute("value");
		int iStreamID = atoi(pstrStreamID);

		TiXmlElement* pElemMsgClass = pElem->FirstChildElement("MsgClass");
		if( NULL == pElemMsgClass )
		{
			error_log << "Failed to get MsgClass Node!" << std::endl
				<< "Application will terminate NOW!" << std::endl;
			goto CLEANG;
			//return 2;
		}
		const char* pstrMsgClass = pElemMsgClass->Attribute("value");//"Generic/others"

		pElem = pElem->FirstChildElement("ElementList");
		/////drop3
		//const unsigned int AID = 0;
		//const unsigned int MAX_REQ = 20;
		//const unsigned int ReqID = 0;
		//const unsigned int MAX_VAD = 100;
		//const unsigned int VAD_ID = 0;
		//const unsigned int BASE = 10000;
		//streamid = ( ( AID * MAX_REQ + ReqID ) * MAX_VAD ) + VAD_ID + BASE;
		/////
		/////drop3

		in_doc.Accept(&printer);

		if(0==strcmp(pstrMsgClass,"Generic"))
		{
			buffer.append("ocicommand|");
		}
		else
		{
			buffer.append("ocivaddata|");
		}
		buffer.append(printer.CStr());
		//std::string buffer = printer.CStr();
		//int iCmd = atoi(pstrData);

		access_log << "before requester->Request: " << printer.CStr() << std::endl;
		try 
		{
			unsigned int strSize = CheckedCast<unsigned int>::Cast(buffer.size());
			requester->Request(cmdstr, iStreamID, smf::ArsPayload(buffer.c_str(), strSize));
		}
		catch (smf::CriticalError &ex)
		{
			error_log << "Critical Error Found! (" << ex.Value() << ")" << std::endl
				<< "Application will terminate NOW!" << std::endl;
			goto CLEANG;
			//return 2;
		}
		access_log << "before requester->Request: " << buffer.c_str() << std::endl;

		time ( &rawtime );
#ifdef WIN32
		struct tm info;
		timeinfo = &info;
		localtime_s(timeinfo, &rawtime);
#else
		timeinfo = localtime ( &rawtime );
#endif
		strftime(buf,sizeof(buf),"Request was sent.Current DateTime = %x %X",timeinfo);
		access_log<<buf<<std::endl;   
		Sleep(waitvah_timeout*1000);
		/////
//		if( NULL == pElem )
//		{
//			/// Below only used in drop2
//			//error_log << "Failed to get ElementList Node!" << std::endl
//			//	<< "Application will terminate NOW!" << std::endl;
//			//goto CLEANG;
//			////return 2;
//			TiXmlPrinter printer; 
//			in_doc.Accept(&printer);
//			std::string buffer = "ocivaddata|";
//			buffer.append(printer.CStr());
//			//std::string buffer = printer.CStr();
//			//int iCmd = atoi(pstrData);
//			std::string cmdstr = "vae0";
//
//			try 
//			{
//				unsigned int strSize = CheckedCast<unsigned int>::Cast(buffer.size());
//				requester->Request(cmdstr, iStreamID, smf::ArsPayload(buffer.c_str(), strSize));
//			}
//			catch (smf::CriticalError &ex)
//			{
//				error_log << "Critical Error Found! (" << ex.Value() << ")" << std::endl
//					<< "Application will terminate NOW!" << std::endl;
//				goto CLEANG;
//				//return 2;
//			}
//
//			time_t rawtime;
//			struct tm * timeinfo;
//			const unsigned int bufferSize = 80;
//			char buf[bufferSize];
//
//			time ( &rawtime );
//#ifdef WIN32
//			struct tm info;
//			timeinfo = &info;
//			localtime_s(timeinfo, &rawtime);
//#else
//			timeinfo = localtime ( &rawtime );
//#endif
//			strftime(buf,sizeof(buf),"Request was sent.Current DateTime = %x %X",timeinfo);
//			access_log<<buf<<std::endl;   
//			Sleep(waitvah_timeout);
//		}
//		else if (pElem != NULL)
//		{
////			pElem = pElem->FirstChildElement("ElementEntry");
////			if( NULL == pElem )
////			{
////				error_log << "Failed to get ElementEntry Node!" << std::endl
////					<< "Application will terminate NOW!" << std::endl;
////				goto CLEANG;
////				//return 2;
////			}
////
////			if (0 == strcmp(pElem->Value(),"ElementEntry"))
////			{
////				const TiXmlElement* pName = pElem->FirstChildElement("Name");
////				const TiXmlElement* pDataType = pElem->FirstChildElement("DataType");
////				const TiXmlElement* pData = pElem->FirstChildElement("Data");
////
////				if( !pName || !pDataType || !pData )
////				{
////					error_log << "Failed to parse ElementEntry Node!" << std::endl
////						<< "Application will terminate NOW!" << std::endl;
////					goto CLEANG;
////					//return 2;
////				}
////
////				const char* pstrName = pName->Attribute("value");
////				const char* pstrDType = pDataType->Attribute("value");
////				const char* pstrData = pData->Attribute("value");
////				if (0 != strcmp(pstrName,"Command"))
////				{
////					error_log << "ElementEntry format is invalid!" << std::endl
////						<< "Application will terminate NOW!" << std::endl;
////					goto CLEANG;
////					//return 2;
////				}
////				TiXmlPrinter printer; 
////				in_doc.Accept(&printer);
////				std::string buffer = "ocicommand|";
////				buffer.append(printer.CStr());
////				//std::string buffer = printer.CStr();
////				int iCmd = atoi(pstrData);
////				std::string cmdstr="";
////				switch(iCmd)
////				{
////				case 1://Load
////					cmdstr = "vae0";
////					break;
////				case 2://Unload
////					cmdstr = "vae0";
////					break;
////				case 3://Activate
////					cmdstr = "vae0";
////					break;
////				case 4://Deactivate
////					cmdstr = "vae0";
////					break;
////				case 5://ExportJournalfile
////					cmdstr = "vae0";
////					break;
////				case 6://RicMangle
////					cmdstr = "vae0";
////					break;
////				default://undefined
////					error_log << "Unknown command!" << std::endl
////						<< "Application will terminate NOW!" << std::endl;
////					goto CLEANG;
////					//return 2;
////				}
////				try 
////				{
////					unsigned int strSize = CheckedCast<unsigned int>::Cast(buffer.size());
////					requester->Request(cmdstr, iStreamID, smf::ArsPayload(buffer.c_str(), strSize));
////				}
////				catch (smf::CriticalError &ex)
////				{
////					error_log << "Critical Error Found! (" << ex.Value() << ")" << std::endl
////						<< "Application will terminate NOW!" << std::endl;
////					goto CLEANG;
////					//return 2;
////				}
////
////				time_t rawtime;
////				struct tm * timeinfo;
////				const unsigned int bufferSize = 80;
////				char buf[bufferSize];
////
////				time ( &rawtime );
////#ifdef WIN32
////				struct tm info;
////				timeinfo = &info;
////				localtime_s(timeinfo, &rawtime);
////#else
////				timeinfo = localtime ( &rawtime );
////#endif
////				strftime(buf,sizeof(buf),"Request was sent.Current DateTime = %x %X",timeinfo);
////				access_log<<buf<<std::endl;   
////				Sleep(waitvah_timeout);
//			//}
//			//else 
//			//{	
//			//	error_log << "Failed to get ElementEntry Node!" << std::endl
//			//		<< "Application will terminate NOW!" << std::endl;
//			//	goto CLEANG;
//			//	//return 2;
//			//}
//			TiXmlPrinter printer; 
//			in_doc.Accept(&printer);
//			std::string buffer = "ocicommand|";
//			buffer.append(printer.CStr());
//			//std::string buffer = printer.CStr();
//			//int iCmd = atoi(pstrData);
//			std::string cmdstr = "vae0";
//
//			try 
//			{
//				unsigned int strSize = CheckedCast<unsigned int>::Cast(buffer.size());
//				requester->Request(cmdstr, iStreamID, smf::ArsPayload(buffer.c_str(), strSize));
//			}
//			catch (smf::CriticalError &ex)
//			{
//				error_log << "Critical Error Found! (" << ex.Value() << ")" << std::endl
//					<< "Application will terminate NOW!" << std::endl;
//				goto CLEANG;
//				//return 2;
//			}
//
//			time_t rawtime;
//			struct tm * timeinfo;
//			const unsigned int bufferSize = 80;
//			char buf[bufferSize];
//
//			time ( &rawtime );
//#ifdef WIN32
//			struct tm info;
//			timeinfo = &info;
//			localtime_s(timeinfo, &rawtime);
//#else
//			timeinfo = localtime ( &rawtime );
//#endif
//			strftime(buf,sizeof(buf),"Request was sent.Current DateTime = %x %X",timeinfo);
//			access_log<<buf<<std::endl;   
//			Sleep(waitvah_timeout);
//		}
//
CLEANG:
		access_log.close();
		error_log.close();
		if(fp_output)
		{
			fclose(fp_output);
		}
		smf::SenderService::CloseRequestChannel(channel, requester);
		smf::Client::Disconnect(channel);
		fflush( stdout );
		fclose( newfp );
		_dup2( old, 1 ); 
		//std::cout<<"OK!"<<std::endl;
	}catch(smf::ConnectionClosed &e){
		access_log.close();
		error_log.close();
		std::cout << e.Value() << "\n";
		fflush( stdout );
		fclose( newfp );
		_dup2( old, 1 ); 
	}catch(smf::ConnectionTimeout &e){
		access_log.close();
		error_log.close();
		std::cout << e.Value() << "\n";
		fflush( stdout );
		fclose( newfp );
		_dup2( old, 1 ); 
	}catch(smf::Error e){
		access_log.close();
		error_log.close();
		std::cout <<"SMF Error:" << e.Value() << "\n";
		fflush( stdout );
		fclose( newfp );
		_dup2( old, 1 ); 
	}catch(smf::Warning w){
		access_log.close();
		error_log.close();
		std::cout << "SMF Warning:" << w.Value() << "\n";
		fflush( stdout );
		fclose( newfp );
		_dup2( old, 1 ); 
	}catch(...){
		access_log.close();
		error_log.close();
		std::cout << "Catch unknown exception\n";
		fflush( stdout );
		fclose( newfp );
		_dup2( old, 1 ); 
	}

	return 0;
}
