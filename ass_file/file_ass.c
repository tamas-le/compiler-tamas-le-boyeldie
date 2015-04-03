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
    char *chaine_2;
    int indice_pi;
    int taille;

    int debug;
    char ch;

    FILE * fichier=fopen("./ass.ass", "r+");


    if (fichier !=NULL)
    {
        printf("Le changement sera ligne : %d\n",num_line);

    	while(fgets(chaine, TAILLE_MAX, fichier) != NULL)
    	{
    		num_ligne_courrante++;
            
    		if (num_ligne_courrante==num_line){
                printf("Chaine à modifier :%s\n",chaine);
    			indice_pi=trouver_indice(chaine);
                printf("Indice : %d\n",indice_pi );
    			taille=strlen(chaine);
    			fseek(fichier,-taille,SEEK_CUR);
                chaine_2=generer_chaine(to,chaine,indice_pi);
                printf("Chaine générée : %s\n",chaine_2);
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
    int dig=digit_number(to);
    char * padding;
    switch(dig){
        case 1:
        padding = malloc(sizeof(2));
        padding[0]=' ';
        padding[1]=' ';
        break;
        case 2:
        padding = malloc(sizeof(1));
        padding[0]=' ';
        break;
    }
    printf("chaine depart : %s \n",chaine_depart);
	sprintf(resultat,"%s%d%s",chaine_depart,to,padding);
	return resultat;
}

int digit_number(int entier){
    if (entier<10){
        return 1;
    } else if (entier >=10 && entier <100){
        return 2;
    } else {
        return 3;
    }

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
