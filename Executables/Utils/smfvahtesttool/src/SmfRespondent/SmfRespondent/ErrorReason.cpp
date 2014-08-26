
#include "ErrorReason.h"


const char* defaults[]={
		"Success",
		"Unclassified Failure",
		"Invalid Field Name",
		"Unknown Field Name or Invalid array index",
		"Field Not Modifiable",
        "Array Index Out Of Bounds",
		"Type Mismatch",
		"String Too Long",
		"Transaction In Progress",
		"Transaction Across Partitions",
		"Illegal Path Name",
		"Path Iterator Error",
		"Null Handle",
		"Invalid Handle",//either the handle is incorrect OR the partition layout is fu
		"Unknown Handle",
		"Handles Not Supported For This Partition",//check the config file ...
		"Coding Error", //this means there is something wrong with the code
		"Field Value Too Big",
		"Invalid Update",
		"Missed Message",
		"Unknown Group",
		"Server Overloaded",
		NULL


	};

ErrorReason::ErrorReason()
{
	Set(defaults);
}

ErrorReason::ErrorReason(const char * const* reasons){
	Set(reasons);
}

void ErrorReason::Set(const char* const* reasons){
	//default reasons
	for(unsigned long i = 0; reasons[i]; i++){
		Add(i, std::string(reasons[i]));		
	}
	
}
std::string ErrorReason::ReasonToString(unsigned long indx)const {
		Reasons::const_iterator itor = reasons.find(indx);

		if(itor != reasons.end()){
			return itor->second;
		}
		return std::string("Unknown error message");
	}

void ErrorReason::Add(unsigned long reason, std::string& detail){
	reasons[reason] = detail;
}