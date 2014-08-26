#ifndef ARSPAYLOAD_H
#define ARSPAYLOAD_H

#include <vector>
#include "Error.h"

namespace smf{
    class MessageBuffer;

    class ArsPayload
    {
    public:
	    class IndexOutOfBounds;

	    ArsPayload();
	    explicit ArsPayload(unsigned int size);
        ArsPayload(const char *buffer, unsigned int size);
	    ~ArsPayload();
	    ArsPayload(const ArsPayload &that);
	    ArsPayload& operator =(const ArsPayload &that);
	    unsigned int PayloadSize()const;
	    char& operator[] (unsigned int index) const;
	    char &operator[] (unsigned int index);
	    bool operator == (const ArsPayload& other)const;
		/// added
		const char* GetPayload() const
		{
			return payload;
		}
		unsigned int GetSize() const
		{
			return size;
		}
    private:
	    char *payload;
	    unsigned int size;
    };

    class ArsPayload::IndexOutOfBounds : public Error
	{
	public:
		IndexOutOfBounds();
	};
}

#endif
