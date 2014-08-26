
#ifndef SMFCLIENT_H
#define SMFCLIENT_H

#include <stddef.h>

namespace smf{
	class ServiceChannel;
	class Logger;
	class SecurityInfo;
	class SocksProxyInfo;
	
	namespace Client{
		const char* LibName();


		//! \brief Make a connection to the SMF server. You can use this connection to open
		//! request channels to this server. You cannot open multiple request channels
		//! for the same service on a single service channel.
		//! \param server           The server hostname or IP address
		//! \param port             The port (by default SMF listens on 8603)
		//! \param logger           can be 0, your own implementation of an smf::Logger or
		//!                       an smf file logger (use smf::fileLogger)
		//! \param queuesizes       The queue size for the outgoing queue, in number of queued items.
		//!                         If 0, the default value of 10 is used.
		//! \param connectionTimeout Timeout (in milliseconds) for trying to connect, send or receive a message.
		//!                             Note: If there are no messages being send or received, this timeout will not be triggered.
		//! \return A pointer to a ServiceChannel object
		//! \remark     Include: SmfClient.h, Logger.h, Error.h, ConnectionException.h
		//! \post       Cleanup: You must call smf::Client::Disconnect to cleanup (see Closing An Smf Service Channel)
		//! \exception smf::Error Specific exceptions that might be thrown are defined in ConnectionException.h.
		//! \note       These functions are thread safe.
		//!             These functions will block (upto the timeout period) whilst trying to establish a connecion.
		ServiceChannel* Connect(
							const char* server, 
							unsigned short port,
							Logger*logger,
							unsigned int queuesizes = 0,//If 0 default values will be used
							unsigned int connectionTimeout = 0
							);

		//! \brief Make a connection to the SMF server. You can use this connection to open
		//! request channels to this server. You cannot open multiple request channels
		//! for the same service on a single service channel.
		//! \param server           The server hostname or IP address
		//! \param networkservice   A service name as defined in the services file in the OS. 
		//!                         Note, you will need to edit the services file  (
		//!                         C:\WINDOWS\system32\drivers\etc \services) to add this service name if it does not exist.
		//! \param logger           can be 0, your own implementation of an smf::Logger or
		//!                          an SMF file logger (use smf::fileLogger) (see "Opening a Logger")
		//! \param queuesizes       The queue size for the outgoing queue, in number of queued items.
		//!                         If 0, the default value of 10 is used. 
		//! \param connectionTimeout Timeout (in milliseconds) for trying to connect, send or receive a message. 
		//!                             Note: If there are no messages being send or received, this timeout will not be triggered.
		//! \return A pointer to a ServiceChannel object
		//! \remark     Include: SmfClient.h, Logger.h, Error.h, ConnectionException.h
		//! \post       Cleanup: You must call smf::Client::Disconnect to cleanup (see Closing An Smf Service Channel)
		//! \exception smf::Error Specific exceptions that might be thrown are defined in ConnectionException.h.
		//! \note       These functions are thread safe. 
		//!             These functions will block (upto the timeout period) whilst trying to establish a connecion.
		ServiceChannel* Connect(
							const char* server, 
							const char* networkservice, 
							Logger*logger,
							unsigned int queuesizes = 0,//If 0 default values will be used
							unsigned int connectionTimeout = 0
							);

		//! \brief Make a connection to the SMF server over SSH. You can use this connection to open
		//! request channels to this server. You cannot open multiple request channels
		//! for the same service on a single service channel.
		//! \param server           The server hostname or IP address
		//! \param port             The port (by default SMF listens on 8603)
		//! \param logger           can be 0, your own implementation of an smf::Logger or
		//!                       an smf file logger (use smf::fileLogger)
		//! \param proxyInfo       The intance of SocksProxyInfo which provide information for 
		//!                       setting up SSH connection to the SMF server.
		//! \param queuesizes       The queue size for the outgoing queue, in number of queued items.
		//!                         If 0, the default value of 10 is used.
		//! \param connectionTimeout Timeout (in milliseconds) for trying to connect, send or receive a message.
		//!                             Note: If there are no messages being send or received, this timeout will not be triggered.
		//! \return A pointer to a ServiceChannel object
		//! \remark     Include: SmfClient.h, Logger.h, Error.h, ConnectionException.h
		//! \post       Cleanup: You must call smf::Client::Disconnect to cleanup (see Closing An Smf Service Channel)
		//! \exception smf::Error Specific exceptions that might be thrown are defined in ConnectionException.h.
		//! \note       These functions are thread safe.
		//!             These functions will block (upto the timeout period) whilst trying to establish a connecion.
		ServiceChannel* Connect(
							const char* server, 
							unsigned short port,
							Logger*logger,
							SocksProxyInfo* proxyInfo,
							unsigned int queuesizes = 0,//If 0 default values will be used
							unsigned int connectionTimeout = 0
							);

		//! \brief You should call this to close a smf::ServiceChannel once you have finished with it.
		//! Note: you should close the LogServiceRequestHandler and the ParameterServiceRequestHandler (if they were opened) before you try to close the service channel.
		//! \param sc A smf::ServiceChannel pointer created using the smf::Client::Connect function
		//! \exception smf::Error
		//! \remark Include: SmfClient.h, Logger.h
		//! \note This function is thread safe.
		void Disconnect(ServiceChannel* sc);

		void Disconnect(ServiceChannel* sc, size_t uniqueKey);

		unsigned int SetChannelLimit(unsigned int limit);

		//! \brief You should call this to create an object of smf::SocksProxyInfo for making a connection to SMF through SSH.		
		//! \param proxyAddress The proxy address to setup the SSH tunnel
		//! \param portMin The port number to setup SSH tunnel for port forwarding
		//! \param numPortsAvail The number of port availble for setting up SSH tunnel. If it is 1, it will try the port number portMin and portMin + 1
		//! \param privateKeyFile The private key file to setup SSH tunnel
		//! \param userId The user name to setup SSH tunnel e.g. reutadmin in Windows and Solaris platform
		//! \param sshTunnelPort The port number for setting up SSH tunnel to connect to SSH daemon
		//! \remark Include: SmfClient.h, Logger.h
		//! \note This function is thread safe.
		SocksProxyInfo *CreateSocksProxyInfo(const char* proxyAddress, 
											unsigned short portMin, 
											unsigned short numPortsAvail, 
											const char* privateKeyFile,
											const char* userId, 
											unsigned short sshTunnelPort);

		void DestroySocksProxyInfo(SocksProxyInfo* info);

	}
}

#endif
