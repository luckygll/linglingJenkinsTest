#ifndef FILETRANSFERSERVICE_H
#define FILETRANSFERSERVICE_H

namespace smf{
	class Logger;
	class ServiceChannel;
	class FileTransferServiceRequestHandler;
	class FileTransferServiceResponseHandler;

	namespace FileTransferService {
		const char* LibName();
		
		//! \brief This function will create a FileTransferServiceRequestHandler which can be used to get/put files from/to the SMF server.
		//! \param responseHandler You must provide an implementation of this.  Your implementation of the smf::FileTransferServiceResponseHandler interface.
		//!							See the samples/FileTransferService directory in the SMF-SDK for an example implementation.
		//! \param channel			Use smf::Client::Connect to get this
		//!							The ServiceChannel returned from the call to smf::Client::Connect. See Opening an SMF service channel.
		//! \param logger			Can be 0, your own implementation of an smf::Logger or a file logger 
		//!							(use smf::fileLogger function)
		//!							A local file logger return from a call to smf::InternalLogger. See Opening a Logger. 
		//!							Note: you do not have to use the SMF implementation; you may provide your own implementation of the Logger interface instead.
		//! \param queueSize		The internal queue size for handling responses.
		//!							If you pass zero here the default queue size will be used.
		//! \param chunkSize		The chunk size that the file will be chopped to before uploading or downloading.
		//!							If you pass zero here the default chunk size will be used.
		//! \param tempDir			The temporary directory that the file chunks will be stored in. 
		//! \return					A pointer to a Smf::FileTransferServiceRequestHandler object.
		//!	\remark					Include: FileTransferService.h, FileTransferServiceRequestHandler.h, Logger.h.
		//!	\post					Cleanup: You must call smf::FileTransferService::CloseRequestChannel to cleanup (see Closing a File Transfer Service Request Handler).
		//! \exception				You should at least catch smf::Error. Specific exceptions that might be thrown are defined in FileTransferServiceRequestHandler.h.
		//! \note					This function is thread safe. 
		FileTransferServiceRequestHandler* OpenRequestChannel(
			FileTransferServiceResponseHandler* responseHandler,
			ServiceChannel* channel,
			Logger* logger,
			unsigned int queueSize = 0,
			unsigned int chunkSize = 0,
			const char* tempDir = ""
			);

		//! \brief You should call this function to close a smf::FileTransferServiceRequestHandler once you have finished with it.
		//! \param channel				The same service channel that was passed in to OpenRequestChannel.
		//!								The smf::ServiceChannel pointer used when opening this FileTransferServiceRequestHandler. 
		//! \param requestHandler		The request handler returned from OpenRequestChannel.
		//!								A request handler created using the smf::FileTransferService::OpenRequestChannel function.
		//!	\remark						Include: FileTransferService.h
		//!	\exception smf::Error
		//! \note						function is thread safe.
		void CloseRequestChannel(
			ServiceChannel* channel,
			FileTransferServiceRequestHandler* requestHandler
			);

		unsigned int SetChannelLimit(unsigned int);

		void SetQueueSleep(unsigned int);
	}
}

#endif
