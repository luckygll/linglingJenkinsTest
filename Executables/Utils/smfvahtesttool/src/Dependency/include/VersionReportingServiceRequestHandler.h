
#ifndef VERSIONREPORTINGSERVICEREQUESTHANDLER_H
#define VERSIONREPORTINGSERVICEREQUESTHANDLER_H

#include "VersionReportingServiceResponseHandler.h"
#include "Warning.h"
#include "Error.h"
#include "Logger.h"
#include "Types.h"

#include <vector>
#include "VersionReportingRequestParamter.h"

//! Version Reporting Service - Request Handler
//! This interface is for the local/remote client to update/display version information of the components
//! 

namespace smf {

    class VersionReportingServiceRequestHandler {
    public:

        //! \brief Use this function to add a new application record into the SMF server.
        //! \param parameter	This is the VersionReportingRequestParamter object. The function will operate based on the values in the object
        //! \param identifier	This is an identifier supplied by you, SMF will pass it back to you when reporting the values.
        //! \remark Include: VersionReportingServiceResponseHandler.h, VersionReportingServiceRequestHandler.h, Error.h.
        //! \post The result will be reported back through your implementation of the smf::VersionReportingServiceResponseHandler in the ReportSuccessfulApplicationUpdate function
        //! \note	The VersionReportingServiceRequestHandler::AddApplication function is thread safe.
        virtual void AddApplication(const VersionReportingRequestParamter &parameter, unsigned int identifier) = 0;

        //! \brief Use this function to add a new package record into the SMF server
        //! \param parameter	This is the VersionReportingRequestParamter object. The function will operate based on the values in the object.
        //! If a empty string is passed into VersionReportingRequestParamter::SetRootAppName(), the package record will be added under the applications declared as services.
        //! \param identifier This is an identifier supplied by you, SMF will pass it back to you when reporting the values.
        //! \remark Include: VersionReportingServiceResponseHandler.h, VersionReportingServiceRequestHandler.h, Error.h
        //! \post The values will be reported back through your implementation of the smf::VersionReportingServiceResponseHandler in theReportSuccessfulPackageUpdate function
        //! \note The VersionReportingServiceRequestHandler::AddPackage function is thread safe
        virtual void AddPackage(const VersionReportingRequestParamter &parameter, unsigned int identifier) = 0;

        //! \brief Use this function to remove an application record into the SMF server
        //! \param parameter	This is the VersionReportingRequestParamter object. The function will operate based on the values in the object.
        //! \param identifier	This is an identifier supplied by you, SMF will pass it back to you when reporting the handles.
        //! \remark Include: VersionReportingServiceResponseHandler.h, VersionReportingServiceRequestHandler.h, Error.h
        //! \post The handles will be reported back through your implementation of the smf::VersionReportingServiceResponseHandler in the ReportSuccessfulApplicationRemoval function
        //! \note	The VersionReportingServiceRequestHandler::RequestHandles function is thread safe.
        virtual void RemoveApplication(const VersionReportingRequestParamter &parameter, unsigned int identifier) = 0;

        //! \brief Use this function to remove a package record into the SMF server
        //! \param parameter	This is the VersionReportingRequestParamter object. The function will operate based on the values in the object.
        //! If a empty string is passed into VersionReportingRequestParamter::SetPackageVersion(), all the package records will be removed regardless of the version
        //! If a empty string is passed into VersionReportingRequestParamter::SetRootAppName(), all the package record under the applications declared as services will be removed.        
        //! \param identifier	This is an identifier supplied by you, SMF will pass it back to you when reporting the outcome.
        //! \remark Include: VersionReportingServiceResponseHandler.h, VersionReportingServiceRequestHandler.h, Error.h
        //! \post The outcome of the update operation should be reported through your implementation of the smf::VersionReportingServiceResponseHandler in the ReportSuccessfulPackageRemoval function
        //! note The VersionReportingServiceRequestHandler::RemovePackage function is thread safe.
        virtual void RemovePackage(const VersionReportingRequestParamter &parameter, unsigned int identifier) = 0;

        //! \brief Use this function to query application records from the SMF server
        //! \param parameter	This is the VersionReportingRequestParamter object. The function will operate based on the values in the object.
        //! If a empty string is passed into VersionReportingRequestParamter::SetApplicationName(), all the applications records will be reported        
        //! \param identifier		This is an identifier supplied by you, SMF will pass it back to you when reporting the outcome.
        //! \remark	Include: VersionReportingServiceResponseHandler.h, VersionReportingServiceRequestHandler.h, Error.h
        //! \post The outcome of the update operation should be reported through your implementation of
        //! smf::VersionReportingServiceResponseHandler::ReportApplicationVersion or smf::VersionReportingServiceResponseHandler::ReportFailure
        //! (see the Parameter Service sample in the SMF-SDK samples directory for an example implementation).
        //! \note The VersionReportingServiceRequestHandler::RequestApplicationInformation function is thread safe.
        virtual void RequestApplicationInformation(const VersionReportingRequestParamter &parameter, unsigned int identifier) = 0;

        //! \brief Use this function to query package records from the SMF server
        //! \param parameter	This is the VersionReportingRequestParamter object. The function will operate based on the values in the object;
        //! If a empty string is passed into VersionReportingRequestParamter::SetRootAppName(), the packages under all applications will be reported;
        //! If a empty string is passed into VersionReportingRequestParamter::SetPackageName(), all the packages under the specified application will be reported;
        //! If a empty string is passed into both VersionReportingRequestParamter::SetRootAppName() and VersionReportingRequestParamter::SetPackageName(), all packages under all applications will be reported.
        //! \param identifier		This is an identifier supplied by you, SMF will pass it back to you when reporting the outcome.
        //! \remark	Include: VersionReportingServiceResponseHandler.h, VersionReportingServiceRequestHandler.h, Error.h
        //! \post The outcome of the update operation should be reported through your implementation of
        //! smf::VersionReportingServiceResponseHandler::ReportPackageInformation or smf::VersionReportingServiceResponseHandler::ReportFailure
        //! (see the Parameter Service sample in the SMF-SDK samples directory for an example implementation).
        //! \note The VersionReportingServiceRequestHandler::UpdateValues function is thread safe.
        virtual void RequestPackageInformation(const VersionReportingRequestParamter &parameter, unsigned int identifier) = 0;

        virtual bool IsConnected() = 0;

        virtual ~VersionReportingServiceRequestHandler() {
        }

    };
}

#endif
