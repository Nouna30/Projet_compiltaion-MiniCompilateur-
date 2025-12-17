%{
    #include "TS.h"  
	#include "syntaxique.tab.h"  
	extern YYSTYPE yylval;
    extern int nb_ligne;
    extern int nb_col;
%}

lettre       [a-zA-Z]
chiffre      [0-9]
IDF          {lettre}[a-z0-9_]*
cst_entier_non_signe     {chiffre}+ 
cst_entier_signe         "("[+-]{chiffre}+")"
cst_float_non_signe      {chiffre}+"."{chiffre}+
cst_float_signe          "("[+-]{chiffre}+"."{chiffre}+")"
write      "'".*"'"
Comm1        "//".*
CommPlu       "/*"([^*]|\*+[^*/])*"*/"
%%

"PROGRAMME"  {
				if (!find_symbol(yytext)) {
					insert_symbol(yytext,"Mc","",0,0);
				}
                nb_col = nb_col+ yyleng;
				return Program;
            }

"VAR"        {
				if (!find_symbol(yytext)) {
					insert_symbol(yytext,"Mc","",0,0);
				}
                nb_col = nb_col+ yyleng;
				return Var;
            }

"IF"         {
				if (!find_symbol(yytext)) {
					insert_symbol(yytext,"Mc","",0,0);
				}

               
                nb_col = nb_col+ yyleng;
				return If;
            }

"ELSE"       {
				if (!find_symbol(yytext)) {
					insert_symbol(yytext,"Mc","",0,0);
				}

               
                nb_col = nb_col+ yyleng;
				return Else;
            }

"FOR"        {
				if (!find_symbol(yytext)) {
					insert_symbol(yytext,"Mc","",0,0);
				}

               
                nb_col = nb_col+ yyleng;
				return For ;
            }

"WHILE"      {
				if (!find_symbol(yytext)) {
					insert_symbol(yytext,"Mc","",0,0);
				}

               
                nb_col = nb_col+ yyleng;
				return While;
            }

"BEGIN"      {
				if (!find_symbol(yytext)) {
					insert_symbol(yytext,"Mc","",0,0);
				}

                
                nb_col = nb_col+ yyleng;
				return Begin;
            }

"END"        {
				if (!find_symbol(yytext)) {
					insert_symbol(yytext,"Mc","",0,0);
				}
                
                nb_col = nb_col+ yyleng;
				return End;
            }

"CONST"      {
				if (!find_symbol(yytext)) {
					insert_symbol(yytext,"Mc","",0,0);
				}
               
                nb_col = nb_col+ yyleng;
				return Const;
            }

"INTEGER"    {
				if (!find_symbol(yytext)) {
					insert_symbol(yytext,"Mc","",0,0);
				}
                
                nb_col = nb_col+ yyleng;
				yylval.str=strdup(yytext);
				return Int;
            }

"FLOAT"      {
				if (!find_symbol(yytext)) {
					insert_symbol(yytext,"Mc","",0,0);
				}
               
                nb_col = nb_col+ yyleng;
				yylval.str=strdup(yytext);
				return Float;
            }
"readln" {
    if (!find_symbol(yytext)) {
					insert_symbol(yytext,"Mc","",0,0);
    }
   
    nb_col = nb_col+ yyleng;
	return Read;
}
{write} {
    
    nb_col = nb_col+ yyleng;
	return Cst_msg;
}


"writeln" {
		if (!find_symbol("writeln")) {
		insert_symbol(yytext,"Mc","",0,0);
		}
   
    nb_col = nb_col+ yyleng;
	return Write;
}

"+" {
	if (!find_symbol(yytext)) {
		insert_symbol(yytext,"Sp","",0,0);
	}
   
    nb_col = nb_col+ yyleng;
	return Op_plus;
}

"-" {
	if (!find_symbol(yytext)) {
		insert_symbol(yytext,"Sp","",0,0);
	}
   
    nb_col = nb_col+ yyleng;
	return Op_minus;
}

"*" {
	if (!find_symbol(yytext)) {
		insert_symbol(yytext,"Sp","",0,0);
	}
   
    nb_col = nb_col+ yyleng;
	return Op_mult;
}

"/" {
	if (!find_symbol(yytext)) {
		insert_symbol(yytext,"Sp","",0,0);
	}
   
    nb_col = nb_col+ yyleng;
	return Op_div;
}

"&&" {
	if (!find_symbol(yytext)) {
		insert_symbol(yytext,"Sp","",0,0);
	}
    
    nb_col = nb_col+ yyleng;
	return Op_and;
}

"||" {
	if (!find_symbol(yytext)) {
		insert_symbol(yytext,"Sp","",0,0);
	}
   
    nb_col = nb_col+ yyleng;
	return Op_or;
}

"!" {
	if (!find_symbol(yytext)) {
		insert_symbol(yytext,"Sp","",0,0);
	}
    
    nb_col = nb_col+ yyleng;
	return Op_not;
}

">" {
	if (!find_symbol(yytext)) {
		insert_symbol(yytext,"Sp","",0,0);
	}
    
    nb_col = nb_col+ yyleng;
	return Op_grt;
}

"<" {
	if (!find_symbol(yytext)) {
		insert_symbol(yytext,"Sp","",0,0);
	}
    
   nb_col = nb_col+ yyleng;
	return Op_lwr;
}

">=" {
	if (!find_symbol(yytext)) {
		insert_symbol(yytext,"Sp","",0,0);
	}
    
    nb_col = nb_col+ yyleng;
	return Op_grtEqual;
}

"<=" {
	if (!find_symbol(yytext)) {
		insert_symbol(yytext,"Sp","",0,0);
	}
    
    nb_col = nb_col+ yyleng;
	return Op_lwrEqual;
}

"==" {
	if (!find_symbol(yytext)) {
		insert_symbol(yytext,"Sp","",0,0);
	}
   
    nb_col = nb_col+ yyleng;
	return Op_equal;
}

"!=" {
	if (!find_symbol(yytext)) {
		insert_symbol(yytext,"Sp","",0,0);
	}
  
    nb_col = nb_col+ yyleng;
	return Op_notEqual;
}

"(" {
	if (!find_symbol(yytext)) {
		insert_symbol(yytext,"Sp","",0,0);
	}
    
    nb_col = nb_col+ yyleng;
	return Par_open;
}

")" {
	if (!find_symbol(yytext)) {
		insert_symbol(yytext,"Sp","",0,0);
	}
   
    nb_col = nb_col+ yyleng;
	return Par_close;
}

"{" {
	if (!find_symbol(yytext)) {
		insert_symbol(yytext,"Sp","",0,0);
	}
    
    nb_col = nb_col+ yyleng;
	return Acol_open;
}

"}" {
	if (!find_symbol(yytext)) {
		insert_symbol(yytext,"Sp","",0,0);
	}
   
    nb_col = nb_col+ yyleng;
	return Acol_close;
}

"[" {
	if (!find_symbol(yytext)) {
		insert_symbol(yytext,"Sp","",0,0);
	}
    
    nb_col = nb_col+ yyleng;
	return Croch_open;
}

"]" {
	if (!find_symbol(yytext)) {
		insert_symbol(yytext,"Sp","",0,0);
	}
    
    nb_col = nb_col+ yyleng;
	return Croch_close;
}

":" {
	if (!find_symbol(yytext)) {
		insert_symbol(yytext,"Sp","",0,0);
	}
   
    nb_col = nb_col+ yyleng;
	return Colon;
}

"=" {
	if (!find_symbol(yytext)) {
		insert_symbol(yytext,"Sp","",0,0);
	}
    
    nb_col = nb_col+ yyleng;
	return Aff;
}

";" {
    if (!find_symbol(yytext)) {
		insert_symbol(yytext,"Sp","",0,0);
    }
    
    nb_col = nb_col+ yyleng;
	return Pvg;
}

"," {
    if (!find_symbol(yytext)) {
		insert_symbol(yytext,"Sp","",0,0);
    }
    
    nb_col = nb_col+ yyleng;
	return Vrg;
}
{cst_entier_non_signe} {
    int val = atoi(yytext); // Convert the string to an integer
    if (val < -32768 || val > 32767) {
        printf("Erreur lexicale : constante entiere %s hors de la plage valide (ligne %d, colonne %d)\n", yytext, nb_ligne, nb_col);
		return 0;
    } else {
		if (!find_symbol(yytext)) {
			insert_symbol(yytext, "cst","INTEGER",val,0);
        }
		nb_col = nb_col+ yyleng;
		yylval.entier=val;
		return cst_entier_non_signe;
    }
}
{cst_entier_signe} {
    
    int val;
    if (yytext[0] == '(' && yytext[yyleng - 1] == ')') {
        //on declare un autre taleau pour contenir la chiane sans parenthse
        char temp[yyleng - 1];
        strncpy(temp, yytext + 1, yyleng - 2);
        temp[yyleng - 2] = '\0'; 
        val = atoi(temp); // Convertir hdk la chaine
    }
    if (val <= -32768 || val >= 32767) {
        printf("Erreur lexicale : constante entiere %s hors de la plage valide (ligne %d, colonne %d)\n", yytext, nb_ligne, nb_col);
		return 0;
    } else {
        if (!find_symbol(yytext)) {
			insert_symbol(yytext, "cst","INTEGER",val,0);
        }
		nb_col = nb_col+ yyleng;
		yylval.entier=val;
		return cst_entier_signe;
    }
}
{cst_float_non_signe} {
    float val = atof(yytext);

    // Vérifier si la partie entière dépasse les limites
		char *dot_position = strchr(yytext, '.');
        int integer_part_length = dot_position - yytext;
        char integer_part[integer_part_length + 1];
        strncpy(integer_part, yytext, integer_part_length);
        integer_part[integer_part_length] = '\0';
		
        int integer_value = atoi(integer_part);
        if (integer_value >= 32767) {
            printf("Erreur lexicale : partie entière de la constante flottante %s hors de la plage valide (ligne %d, colonne %d)\n", yytext, nb_ligne, nb_col);
            return 0;
        }
		if (!find_symbol(yytext)) {
			insert_symbol(yytext, "cst", "FLOAT", val, 0);
		}
		nb_col = nb_col + yyleng;
		yylval.reel = val;
		return cst_float_non_signe;
}

{cst_float_signe} {
    float val;
    if (yytext[0] == '(' && yytext[yyleng - 1] == ')') {
        char temp[yyleng - 1];
        strncpy(temp, yytext + 1, yyleng - 2);
        temp[yyleng - 2] = '\0';
        val = atof(temp);

        // Vérifier si la partie entière dépasse les limites
        char *dot_position = strchr(temp, '.');
            int integer_part_length = dot_position - temp;
            char integer_part[integer_part_length + 1];
            strncpy(integer_part, temp, integer_part_length);
            integer_part[integer_part_length] = '\0';

            int integer_value = atoi(integer_part);
            if (integer_value <= -32768 || integer_value >= 32767) {
                printf("Erreur lexicale : partie entière de la constante flottante %s hors de la plage valide (ligne %d, colonne %d)\n", yytext, nb_ligne, nb_col);
                return 0;
            }
    }

    if (!find_symbol(yytext)) {
        insert_symbol(yytext, "cst", "FLOAT", val, 0);
    }
    nb_col = nb_col + yyleng;
    yylval.reel = val;
    return cst_float_signe;
}



{IDF} {
    if (yyleng > 7) {
        printf("Erreur lexicale : %s trop long a la ligne %d, colonne %d\n", yytext, nb_ligne, nb_col);
        return 0;
    } else {
        if (!find_symbol(yytext)) {  
            insert_symbol(yytext, "IDF","",0,0);  
        }
        nb_col = nb_col+ yyleng; 
		yylval.str=strdup(yytext);
		return IDF;
    }
}

			 
{Comm1}      { /* Commentaire ligne unique ignoré */ nb_col = nb_col + yyleng;}
{CommPlu}    { /* Commentaire multi-lignes ignoré */
                int i;
                for (i = 0; yytext[i] != '\0'; i++) {
                    if (yytext[i] == '\n') {
                        nb_ligne++;
                        nb_col = 1; 
                    } else {
                        nb_col++;
                    }
                }
			  }
"*/"           { printf("Erreur lexicale : fermetture sans ouverture de commentaire(ligne %d, colonne %d) \n", nb_ligne, nb_col);         
                   nb_col = nb_col + yyleng;
				   return 0;
			    }
[ \t]          { nb_col++; }
\n             { nb_ligne++; nb_col = 1; }
.              { printf("Erreur lexicale : %s a la ligne %d, colonne %d \n",yytext, nb_ligne, nb_col); 
                  nb_col = nb_col + yyleng; 
				  break;
				  }


