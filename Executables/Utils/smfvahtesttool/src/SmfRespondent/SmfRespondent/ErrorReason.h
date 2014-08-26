
#ifndef ERRORREASON_H
#define ERRORREASON_H

#include <map>

class ErrorReason{

private:


	typedef std::map<unsigned long, std::string> Reasons;
	Reasons reasons;
public:
	ErrorReason();
	ErrorReason(const char*const* reasons);
	void Set(const char*const* reasons);

	std::string ReasonToString(unsigned long indx)const;

	void Add(unsigned long reason, std::string& detail);
};

#endif