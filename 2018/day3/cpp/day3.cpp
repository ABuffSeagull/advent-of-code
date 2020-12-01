#include <cstdio>
#include <unordered_set>
#include <utility>


int
main(int argc, char *argv[]) {
	if (argc != 2) {
		printf("Give me a file\n");
		return 1;
	}
	FILE *input = fopen(argv[1], "r");
	std::unordered_set<std::pair<size_t, size_t>> fabric;
	unsigned int claim, x, y, width, height;
	while (fscanf(input, "#%u @ %u,%u: %ux%u\n", &claim, &x, &y, &width, &height) != EOF) {
		for (size_t row = y; row < y + height; row += 1) {
			for (size_t column = x; column < x + width; column += 1) {
				std::pair<size_t, size_t> coord(x, y);
				if (fabric.find(coord) == fabric.end()) {

				}
			}
		}
	}
	return 0;
}
