#include <stdio.h>
#include <zlib.h>

int main() {
	static unsigned char compressed[] = {
		0x78,0x9c,0xf3,0x48,0xcd,0xc9,0xc9,0xd7,0x51,0x28,
		0xcf,0x2f,0xca,0x49,0x51,0x64,0x00,0x00,0x24,0xe8,
		0x04,0x8a };

	unsigned char hello_buffer[20];
	unsigned long hello_size = sizeof(hello_buffer);
	if (uncompress(hello_buffer, &hello_size,
	               compressed, sizeof(compressed)) != Z_OK) {
		return 1;
	}

	printf("%s\n", hello_buffer);
	return 0;
}
