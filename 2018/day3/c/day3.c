#include <stdio.h>
#include <stdlib.h>

#define SIZE 1000

void
part1(FILE *input) {
	unsigned int fabric[SIZE][SIZE] = { { 0 } };
	unsigned int x, y, width, height;
	while (fscanf(input, "#%*u @ %u,%u: %ux%u\n", &x, &y, &width, &height) != EOF) {
		for (size_t row = y; row < y + height; row += 1) {
			for (size_t column = x; column < x + width; column += 1) {
				fabric[row][column] += 1;
			}
		}
	}
	unsigned int total = 0;
	for (size_t i = 0; i < SIZE; i += 1) {
		for (size_t j = 0; j < SIZE; j += 1) {
			if (fabric[i][j] > 1) {
				total += 1;
			}
		}
	}
	printf("%u\n", total);
}

#define NUM_CLAIMS 1331

void
part2(FILE *input) {
	int claimed[SIZE][SIZE] = { { 0 } };
	int claim_id_conflict[NUM_CLAIMS] = { 0 };
	unsigned int claim_id, x, y, width, height;
	while (fscanf(input, "#%u @ %u,%u: %ux%u\n", &claim_id, &x, &y, &width, &height) != EOF) {
		for (size_t row = y; row < y + height; row += 1) {
			for (size_t column = x; column < x + width; column += 1) {
				if (claimed[row][column]) {
					claim_id_conflict[claimed[row][column]] = 1;
					claim_id_conflict[claim_id] = 1;
				}
				claimed[row][column] = claim_id;
			}
		}
	}
	size_t uncontested = 0;
	for (size_t i = 1; i < NUM_CLAIMS; i += 1) { // skip 0
		if (!claim_id_conflict[i]) {
			uncontested = i;
		}
	}
	printf("%lu\n", uncontested);
}

int
main(int argc, char *argv[]) {
	if (argc != 2) {
		fprintf(stderr, "Give me a file\n");
		return EXIT_FAILURE;
	}
	FILE *input = fopen(argv[1], "r");
	part2(input);
	return EXIT_SUCCESS;
}
