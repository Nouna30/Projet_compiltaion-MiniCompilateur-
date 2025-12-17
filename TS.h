#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

// Definition of a structure for a symbol in the symbol table
typedef struct Symbol {
    char name[20];
    char code[20];
    char type[20];
    float val;
    int taille;  // Added field for size (taille)
    struct Symbol* next;
} Symbol;

// Pointer to the head of the symbol table linked list
Symbol* symbolTable = NULL;

// Function to find a symbol in the table by its name
Symbol* find_symbol(const char* name) {
    Symbol* current = symbolTable;
    while (current != NULL) {
        if (strcmp(current->name, name) == 0) {
            return current; // Symbol found
        }
        current = current->next;
    }
    return NULL; // Symbol not found
}

// Function to insert a symbol into the table
void insert_symbol(const char* name, const char* code, const char* type, float val, int taille) {
    // Check if the symbol already exists in the table
    if (find_symbol(name) != NULL) {
            return; // Symbol already exists, do not add it
    }

    // Create a new node for the symbol
    Symbol* newSymbol = (Symbol*)malloc(sizeof(Symbol));
    if (newSymbol == NULL) {
        printf("Memory allocation error for the symbol\n");
        exit(1);
    }

    // Initialize the symbol fields
    strcpy(newSymbol->name, name);
    strcpy(newSymbol->code, code);
    strcpy(newSymbol->type, type);
    if (strcmp(code , "cst") == 0 ) newSymbol->val = val;
    newSymbol->next = symbolTable;  // Insert at the beginning of the list
    symbolTable = newSymbol;
}


// Function to display all symbols in the table
void print_symbol_table() {
    Symbol* current = symbolTable;
    if (current == NULL) {
        printf("No symbols in the table.\n");
        return;
    }

    // Print the header with proper alignment
    printf("%-20s %-20s %-20s %-20s %-20s\n", "Name", "Code", "Type", "Value", "Taille");
    printf("-------------------------------------------------------------------------------------------\n");
            
    // Print each symbol
    while (current != NULL) {
        printf("%-20s %-20s %-20s", current->name, current->code, current->type );
    
        // Print value only if it's a constant
        if ((strcmp(current->code, "cst") == 0) || (strcmp(current->code, "IDF-cst") == 0)) {
            if (strcmp(current->type, "INTEGER") == 0) {
                // Afficher la valeur entière sans décimales
                printf("%-20d", (int)current->val);  // On cast la valeur en entier pour supprimer les décimales
            } else {
                // Afficher la valeur flottante avec deux décimales
                printf("%-20.2f", current->val);
            }
       } else {
            printf("%-20s", "");  // Leave space if it's not a constant
        }
       // Print taille au cas du tab
        if (current->taille != 0) {
            printf("%-20d", current->taille);
        } else {
            printf("%-20s", ""); // Leave space 
        }
        printf("\n");

        current = current->next;
    }
}

// Function to free memory of the symbol table
void free_symbol_table() {
    Symbol* current = symbolTable;
    while (current != NULL) {
        Symbol* temp = current;
        current = current->next;
        free(temp);
    }
    symbolTable = NULL;
}


/**********************************Fonction des Routines Sementiques*********************************************/

void insererType(const char* name, const char* type )
{
    Symbol* elt = find_symbol(name);
    if(elt != NULL)  {strcpy(elt->type,type);}
}

void insererValeur(const char* name, const char* strVal) {
    Symbol* elt = find_symbol(name);

    if (elt != NULL) {
        elt->val = atof(strVal);
    } 
}

void insererTaille(const char* name, const char* strVal) {
    Symbol* elt = find_symbol(name);

    if (elt != NULL) {
        elt->taille = atoi(strVal);
    } 
}



int recherche_TS_type(const char* name) {
    Symbol* elt = find_symbol(name);
    if (strcmp(elt->type, "") == 0) return 0;
    else return -1;
}


void ChangerCode(const char* name,const char* nvCode)
{
    Symbol* elt = find_symbol(name);
    if(elt != NULL)  {strcpy(elt->code,nvCode);}
}




