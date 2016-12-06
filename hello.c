#include <stdio.h>
#include <zlib.h>

#include "hello.zip.h"

int main() {
	unsigned char hello[32] = "";

	z_stream z = {
		.next_in   = (unsigned char *)&zip_file[30 + zip_file[26]],
		.avail_in  = zip_file[18],
		.next_out  = hello,
		.avail_out = sizeof hello,
	};

	if (inflateInit2(&z, -15) != Z_OK
			|| inflate(&z, Z_FINISH) != Z_STREAM_END
			|| inflateEnd(&z) != Z_OK) {
		return 1;
	}

	printf("%s\n", hello);
	return 0;
}
