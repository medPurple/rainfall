
	; Initilalisation de la fonction

   0x08048ec0 <+0>:	push   %ebp ; Sauvegarde du registre de base (base pointer)
   0x08048ec1 <+1>:	mov    %esp,%ebp ; Etablissement d'un nouveau cadre de pile
   0x08048ec3 <+3>:	and    $0xfffffff0,%esp ; Alignement de la pile sur une limite 16 octets pour des raisons d'efficacite.
   0x08048ec6 <+6>:	sub    $0x20,%esp ; Reservation de 32 octets d'espace sur la pile pour les variables locales.

	; Traitement de l'argument de la ligne de commande

   0x08048ec9 <+9>:	mov    0xc(%ebp),%eax ; Chargement du deuxième argument de la ligne de commande (argv[1]) dans %eax.
   0x08048ecc <+12>:	add    $0x4,%eax ;  Déplacement vers le troisième argument de la ligne de commande (argv[2]).
   0x08048ecf <+15>:	mov    (%eax),%eax ; Chargement de l'adresse de argv[2] dans %eax.
   0x08048ed1 <+17>:	mov    %eax,(%esp) ; Placement de cette adresse en haut de la pile.
   0x08048ed4 <+20>:	call   0x8049710 <atoi> ; Appel de la fonction atoi pour convertir argv[2] en entier.

	; Comparaison de l'entier obtenu

   0x08048ed9 <+25>:	cmp    $0x1a7,%eax ; Comparaison de l'entier obtenu avec 0x1a7 (423 en décimal).
   0x08048ede <+30>:	jne    0x8048f58 <main+152> ; Si l'entier n'est pas égal à 423, saut vers l'instruction à l'adresse 0x8048f58.

	; Si l'entier est egal a 423

	; Copie de la chaîne à l'adresse 0x80c5348 et appels aux fonctions strdup,
	; getegid, geteuid, setresgid, setresuid, execv pour dupliquer la chaîne,
	; obtenir les IDs effectifs de groupe et utilisateur, et les définir,
	; puis exécuter un programme spécifique avec ces identifiants.

   0x08048ee0 <+32>:	movl   $0x80c5348,(%esp)
   0x08048ee7 <+39>:	call   0x8050bf0 <strdup>
   0x08048eec <+44>:	mov    %eax,0x10(%esp)
   0x08048ef0 <+48>:	movl   $0x0,0x14(%esp)
   0x08048ef8 <+56>:	call   0x8054680 <getegid>
   0x08048efd <+61>:	mov    %eax,0x1c(%esp)
   0x08048f01 <+65>:	call   0x8054670 <geteuid>
   0x08048f06 <+70>:	mov    %eax,0x18(%esp)
   0x08048f0a <+74>:	mov    0x1c(%esp),%eax
   0x08048f0e <+78>:	mov    %eax,0x8(%esp)
   0x08048f12 <+82>:	mov    0x1c(%esp),%eax
   0x08048f16 <+86>:	mov    %eax,0x4(%esp)
   0x08048f1a <+90>:	mov    0x1c(%esp),%eax
   0x08048f1e <+94>:	mov    %eax,(%esp)
   0x08048f21 <+97>:	call   0x8054700 <setresgid>
   0x08048f26 <+102>:	mov    0x18(%esp),%eax
   0x08048f2a <+106>:	mov    %eax,0x8(%esp)
   0x08048f2e <+110>:	mov    0x18(%esp),%eax
   0x08048f32 <+114>:	mov    %eax,0x4(%esp)
   0x08048f36 <+118>:	mov    0x18(%esp),%eax
   0x08048f3a <+122>:	mov    %eax,(%esp)
   0x08048f3d <+125>:	call   0x8054690 <setresuid>
   0x08048f42 <+130>:	lea    0x10(%esp),%eax
   0x08048f46 <+134>:	mov    %eax,0x4(%esp)
   0x08048f4a <+138>:	movl   $0x80c5348,(%esp)
   0x08048f51 <+145>:	call   0x8054640 <execv>
   0x08048f56 <+150>:	jmp    0x8048f80 <main+192>

	; Si l'entier n'est pas egal a 423

	; Si l'entier obtenu n'est pas 423, préparation et appel
	; de la fonction fwrite pour écrire un message spécifique.

   0x08048f58 <+152>:	mov    0x80ee170,%eax
   0x08048f5d <+157>:	mov    %eax,%edx
   0x08048f5f <+159>:	mov    $0x80c5350,%eax
   0x08048f64 <+164>:	mov    %edx,0xc(%esp)
   0x08048f68 <+168>:	movl   $0x5,0x8(%esp)
   0x08048f70 <+176>:	movl   $0x1,0x4(%esp)
   0x08048f78 <+184>:	mov    %eax,(%esp)
   0x08048f7b <+187>:	call   0x804a230 <fwrite>

	; Fin de la fonction

   0x08048f80 <+192>:	mov    $0x0,%eax ; Préparation du retour de la fonction avec 0 comme code de sortie.
   0x08048f85 <+197>:	leave ; Réinitialisation de la pile et restauration du registre de base.
   0x08048f86 <+198>:	ret ; Retour de la fonction.
