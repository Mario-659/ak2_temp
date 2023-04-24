#include <stdio.h>
#include <stdbool.h>

unsigned long long int my_rdtsc(char iter, bool p);

int main()
{	
	unsigned long long int wynik = my_rdtsc(10, true);
	printf("zwrocona wartosc: %llu\n", wynik);
	unsigned long long int sekundy = wynik / 3600000000;
	unsigned int minuty = sekundy / 60;
	unsigned int godziny = minuty / 60;
	unsigned int dni = godziny / 24;
	godziny = godziny % 24;
	minuty = minuty % 60;
	sekundy = sekundy % 60;
	printf("Dni: %u, Godziny: %u, Minuty: %u, Sekundy: %llu\n", dni, godziny, minuty, sekundy);
	return 0;
}
