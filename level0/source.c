#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main(int argc, char *argv[]) {

	// Convertit le deuxième argument en entier
	int input = atoi(argv[1]);

	// Compare l'entier avec 423 (0x1a7)
	if (input == 423) {

		// Prépare la chaîne à dupliquer
		char *const args[] = { strdup("/bin/sh"), NULL };

		// Obtenir les identifiants effectifs de l'utilisateur et du groupe
		gid_t gid = getegid();
		uid_t uid = geteuid();

		// Change les identifiants effectifs
		setresgid(gid, gid, gid);

		// Change les identifiants effectifs
		setresuid(uid, uid, uid);

		// Exécute /bin/sh
		execv("/bin/sh", args);

	} else {
		// Si l'entier n'est pas 423, écrire un message avec fwrite
		fwrite("No !\n", 1, 5, stderr);
	}

	return 0;
}
