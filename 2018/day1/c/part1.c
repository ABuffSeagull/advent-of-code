#include <stdio.h>
#include <stdlib.h>

int
main(int argc, char *argv[]) {
	if (argc != 2) {
		fprintf(stderr, "Give me a file name\n");
		return EXIT_FAILURE;
	}
	FILE *input = fopen(argv[1], "r");
	int total = 0;
	char sign = fgetc(input);
	while (sign != EOF) {
		int num;
		fscanf(input, "%d\n", &num);
		if (sign == '+') {
			total += num;
		} else {
			total -= num;
		}
		sign = fgetc(input);
	}
	printf("%d\n", total);
	return EXIT_SUCCESS;
}
