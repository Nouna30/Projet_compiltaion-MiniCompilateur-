%{
	int nb_ligne = 1;
    int nb_col = 1;
	char SaveType[20]; 
    float val;
	int taille;
    char strVal[8];
%}

%union {
    int entier;
    char* str;
    float reel;

}


%token Program Var If Else For While Begin End Const <str>Int <str>Float Read Write
    Op_plus Op_minus Op_mult Op_div Op_and Op_or Op_not Op_grt Op_lwr 
    Op_grtEqual Op_lwrEqual Op_equal Op_notEqual Par_open Par_close 
    Acol_open Acol_close Colon Aff Pvg Vrg Croch_open Croch_close
    <entier> cst_entier_non_signe 
	<entier> cst_entier_signe
    <reel> cst_float_non_signe 
    <reel> cst_float_signe 
    <str> IDF
	<str> Cst_msg

%left Op_or
%left Op_and
%left Op_plus Op_minus
%left Op_mult Op_div 
%nonassoc Op_grt Op_lwr Op_equal Op_notEqual Op_lwrEqual Op_grtEqual 

%start S

%type <str>valeur_possible

%%

S: Program IDF Var Acol_open declarations Acol_close Begin Instructions End{ 
        printf("PROGRAMME ECRIT CORRECT SYNTAXIQUEMENT !\n");
		printf("le no du prog est %s\n",$2);
        YYACCEPT;
    }
;

declarations: declaration declarations
            | /* epsilon production pour une liste vide */
;

declaration : declaration_variable
            | declaration_tableau
            | declaration_constante
;

declaration_variable: type liste_variables Pvg
;

liste_variables: IDF {
					if(recherche_TS_type($1)==0)   { insererType($1,SaveType);}		
					} 
               | IDF Vrg liste_variables
			      {
					if(recherche_TS_type($1)==0)   { insererType($1,SaveType);}		
				  } 
;
declaration_tableau: type tableau Pvg
;

tableau: IDF Croch_open cst_entier_non_signe Croch_close
          {
			if(recherche_TS_type($1)==0)   
			     { insererType($1,SaveType);
			       ChangerCode($1,"IDF-tab");
					taille = $3 ;
					snprintf(strVal, sizeof(strVal), "%d", taille);
					insererTaille($1,strVal);
			      }		
		} 
;


declaration_constante: Const liste_constantes Pvg
;

liste_constantes: IDF Aff valeur_possible 
					{
						if(recherche_TS_type($1)==0)   
						 { 
							insererType($1,$3);
							ChangerCode($1,"IDF-cst"); 
							snprintf(strVal, sizeof(strVal), "%.2f", val);
							insererValeur($1,strVal);
							
						 }		
					} 
 
;

valeur_possible: cst_entier_non_signe 
				  {    
					   $$ = "INTEGER"; 
					   val = $1;
					}
				  | cst_float_non_signe {  $$ = "FLOAT"; val = $1;  }
				  | cst_entier_signe   {    $$ = "INTEGER"; val = $1;}
				  | cst_float_signe   {   $$ = "FLOAT"; val = $1;}
;			   

type: Int { strcpy(SaveType,$1);}
    | Float { strcpy(SaveType,$1);}
;


Instructions: Instruction Instructions
            | /* epsilon production */
;

Instruction: simple_instruction
		   | while_statement
		   | if_statement
		   | for_statement
;

simple_instruction: assignment
					| read_statement
					| write_statement
;

assignment: IDF Aff expression Pvg    
			|IDF Croch_open cst_entier_non_signe Croch_close Aff expression Pvg 
			|IDF Croch_open IDF Croch_close Aff expression Pvg 
;

expression:
    term {/* Pour assurer la priorite */}
    | expression Op_plus term 
    | expression Op_minus term 
;

term:
    factor
	| valeur_possible
    | term Op_mult factor 
    | term Op_div factor 
	| term Op_mult valeur_possible
	| term Op_div valeur_possible 
;

factor:
    Par_open expression Par_close 
	| IDF  
	| IDF Croch_open cst_entier_non_signe Croch_close 
	| IDF Croch_open IDF Croch_close 
;


read_statement:
    Read Par_open IDF Par_close Pvg 
;

write_statement:
    Write Par_open Cst_msg Par_close Pvg 
;

while_statement:
    While Par_open condition Par_close Acol_open Instructions Acol_close
;

condition: 
	Comparaison         
	| condition op_logique Comparaison
    | Op_not Par_open condition Par_close                         
    | Par_open condition Par_close        
;
op_logique :  Op_or
              |Op_and
;
op_comparaison : Op_grt
                 |Op_lwr
				 |Op_grtEqual
				 |Op_lwrEqual
				 |Op_equal 
				 |Op_notEqual
;
			
Comparaison:
      expression op_comparaison expression                      
;

if_statement:
    If Par_open condition Par_close Acol_open Instructions Acol_close optional_else
	| If Par_open condition Par_close simple_instruction optional_else
;
optional_else:
    Else Acol_open Instructions Acol_close
    | Else simple_instruction
    | /* epsilon pour permettre de ne pas genere le else*/
;
for_statement:
    For Par_open IDF Colon cst_entier_non_signe Colon expression Colon expression Par_close Acol_open Instructions Acol_close 
	{
	
	}
;

%%


int main() {
    printf("Démarrage du processus d'analyse...\n");
    yyparse();
	print_symbol_table();
    return 0;
}

yywrap() {
    return 1; 
}

int yyerror(char *msg) {
    printf("Erreur syntaxique à la ligne : %d, à la colonne : %d\n", nb_ligne, nb_col);
    return 1;
}
