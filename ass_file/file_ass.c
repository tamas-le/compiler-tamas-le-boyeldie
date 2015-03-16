#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "file_ass.h"

#define FILE_PATH "../ass.ass"
#define TAILLE_MAX 1000



void display_file(){
	FILE* fichier = NULL;
    char chaine[TAILLE_MAX] = "";
 
    fichier = fopen("./ass.ass", "r+");
 
    if (fichier != NULL)
    {
        while (fgets(chaine, TAILLE_MAX, fichier) != NULL) 
        {
            printf("%s", chaine);
        }
 
        fclose(fichier);
    }
}


void replace_line(int num_line,int to,FILE *file){
	int num_ligne_courrante=0;
    char chaine[TAILLE_MAX] = "";
    int indice_pi;
    int taille;
    printf("Remplacement de ligne\n");

    FILE * fichier=fopen("./ass.ass", "r+");


    if (fichier !=NULL)
    {
        printf("Le fichier existe et est ouvert\n");

    	while(fgets(chaine, TAILLE_MAX, fichier) != NULL)
    	{
            printf("Parcours ligne par ligne\n");
    		num_ligne_courrante++;
    		printf("%s",chaine );
    		if (num_ligne_courrante==num_line){
    			printf("C'est la bonne ligne !\n");
    			indice_pi=trouver_indice(chaine);
    			taille=strlen(chaine);
    			fseek(fichier,-taille,SEEK_CUR);
    			printf("indice du ? : %d\n",indice_pi);
    			printf("Nouvelle chaine : %s",generer_chaine(to,chaine,indice_pi) );
    			fputs(generer_chaine(to,chaine,indice_pi),fichier);
    		}
    	}
        fclose(fichier);
    } else {
        printf("Erreur fichier\n");
    }

}


int trouver_indice(char * ligne){
	char c;
    int indice_chaine=0;
    do{
    	c=ligne[indice_chaine];
    				
    	if (c=='?') return indice_chaine;
    	
    	indice_chaine++;
    }while(c!='\n');

    return -1;

}

char * generer_chaine(int to,char * chaine_depart,int indice){
	char * resultat = malloc (sizeof(char)*50);
	chaine_depart[indice]='\0';
	sprintf(resultat,"%s%d \n",chaine_depart,to);
	return resultat;
}

/*int main(int argc, char const *argv[])
{
	printf("Test de la gestion du fichier\n");
	//display_file();
	//char test[]="salut poto";
	//generer_chaine(2,test,2);
	//printf("%s\n",test ); 
	replace_line(8,20);
	return 0;
}*/
