
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton implementation for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.4.1"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1

/* Using locations.  */
#define YYLSP_NEEDED 1



/* Copy the first part of user declarations.  */

/* Line 189 of yacc.c  */
#line 3 ".\\Sintactico.y"

#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
#include <string.h>

FILE  *yyin;
FILE *graph;
int yyerror();
int yylex();


/* --- MOVER --- */
enum tipoError
{
    ErrorSintactico,
    ErrorLexico
};
/* Tipos de datos para la tabla de simbolos */
#define Integer 1
#define Float 2
#define String 3
#define CteInt 4
#define CteFloat 5
#define CteString 6
#define SinTipo 7
#define SIN_MEM -4
#define NODO_OK -3
#define TRUE 1
#define FALSE 0

#define TAMANIO_TABLA 300
#define TAM_NOMBRE 32
#define ES_CTE_CON_NOMBRE 1

/* Defino estructura de informacion para el arbol*/
typedef struct {
	char* dato;
	char* tipoDato;		
}tInfo;

/* Defino estructura de nodo de arbol*/
typedef struct sNodo{
	tInfo info;
	struct sNodo *izq, *der;
}tNodo;

/* Defino estructura de arbol*/
typedef tNodo* tArbol;

tNodo* crearNodo(const char* dato, tNodo *pIzq, tNodo *pDer);
tNodo* crearHoja(char* dato,char* tipo);
tArbol * hijoMasIzq(tArbol *p);
void enOrden(tArbol *p);
void verNodo(const char *p);
void postOrden(tArbol *p);
void _tree_print_dot_subtree(int nro_padre, tNodo *padre, int nro, tArbol *nodo, FILE* stream);
void tree_print_dot(tArbol *p,FILE* stream);
void llenarGragh(tNodo* padre, FILE *arch, int numNodo);
void escribirGragh(tNodo* padre);

typedef struct sNodoPila {
  tNodo *dato;
  struct sNodoPila *next;
}tNodoPila;

typedef struct 
{
  tNodoPila *tope;
  size_t tam; 
}tPila;

tPila *crearPila(void);
tNodo *copiarDato(tNodo *);
void ponerenPila( tPila *, tNodo *value);
tNodo *topedePila( tPila *);
void sacardePila(tPila *);
void vaciarPila( tPila *);
void borrarPila( tPila **);
	
/* --- Tabla de simbolos --- */
typedef struct
{
        char *nombre;
        char *tipo;
        union Valor{
                int valor_int;
                double valor_double;
                char *valor_str;
        }valor;
        int longitud;
}t_data;

typedef struct s_simbolo
{
        t_data data;
        struct s_simbolo *next;
}t_simbolo;


typedef struct
{
        t_simbolo *primero;
}t_tabla;

void crearTablaTS();
int insertarTS(const char*, const char*, const char*, int, double);
t_data* crearDatos(const char*, const char*, const char*, int, double);
void guardarTS();
t_tabla tablaTS;

char* getTipoId(const char* id); 

char idvec[32][50];
int cantid = 0, i=0;
char vecAux[20];
char* punt;

/* --- Validaciones --- */
int existeID(const char*);
char mensajes[100];
int esNumero(const char*,char*);

/* ---  Funciones auxiliares   --- */
void crearNodoCMP(char * comp);

/* ---  Pilas   --- */
tPila* pilaExpresion;
tPila* pilaBloque;
tPila* pilaCondicion;
tPila* pilaCondiciones;
tPila* pilaEtiq;
tPila* pilaEtiqExpMax;

//Declaración de punteros árbol sintáctico

tArbol 	asigPtr,			//Puntero de asignaciones
		exprPtr,			//Puntero de expresiones
		exprCadPtr,			//Puntero de expresiones de cadenas
		exprAritPtr,		//Puntero de expresiones aritmeticas
		terminoPtr,			//Puntero de terminos
		factorPtr,			//Puntero de factores
		bloquePtr,			//Puntero de bloque
		sentenciaPtr,		//Puntero de sentencia	
		iteracionPtr,		//Puntero de bloque de While	
		listaExpComaPtr,	//Puntero de lista expresion coma
		elseBloquePtr,		//Puntero para el bloque del else
		thenBloquePtr,		//Puntero para el bloque del then
		expreLogAuxPtr,
		auxBloquePtr,
		auxAritPtr,
		auxPtr,
		auxIfPtr,
		salidaPtr,
		entradaPtr,
		declConstantePtr,	//Puntero decl_constante
		auxMaximoHojaPtr,	//Puntero del Maximo
		auxMaxSelNodo,		//Puntero del Maximo
		auxMaxAsigNodo,		//Puntero del Maximo
		auxMaxIFNodo,		//Puntero del Maximo
		auxMaxNodoAnterior,	//Puntero del Maximo
		exprCMPPtr,
		seleccionPtr,
		seleccionIFPtr,
		seleccionIFElsePtr,
		terminoLogicoPtr,
		comparacionPtr,
		comparacionAuxPtr,
		condicionPtr,
		auxCondicionPtr,
		auxMaxNodo,
		exprMaximoPtr,
		auxEtiqPtr,
		auxWhilePtr,
		auxMaxCond,
		listaExpPtr,
		inlistPtr,
		betweenPtr,
		condicionIfPtr,
		accionPtr;



/* Line 189 of yacc.c  */
#line 257 "y.tab.c"

/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
#endif


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     DECVAR = 258,
     ENDDEC = 259,
     INTEGER = 260,
     FLOAT = 261,
     STRING = 262,
     IF = 263,
     ELSE = 264,
     ENDIF = 265,
     WHILE = 266,
     ENDWHILE = 267,
     PUNTOCOMA = 268,
     COMA = 269,
     DOSPUNTOS = 270,
     OPASIG = 271,
     OPSUMA = 272,
     OPRESTA = 273,
     OPMUL = 274,
     OPDIV = 275,
     PARENTESISA = 276,
     PARENTESISC = 277,
     CORCHETEA = 278,
     CORCHETEC = 279,
     LLAVEA = 280,
     LLAVEC = 281,
     OPIDENTICO = 282,
     OPDISTINTO = 283,
     OPMENOR = 284,
     OPMENORIGUAL = 285,
     OPMAYOR = 286,
     OPMAYORIGUAL = 287,
     AND = 288,
     OR = 289,
     NOT = 290,
     WRITE = 291,
     READ = 292,
     ID = 293,
     CONS_INT = 294,
     CONS_FLOAT = 295,
     CONS_STR = 296,
     BETWEEN = 297,
     INLIST = 298
   };
#endif
/* Tokens.  */
#define DECVAR 258
#define ENDDEC 259
#define INTEGER 260
#define FLOAT 261
#define STRING 262
#define IF 263
#define ELSE 264
#define ENDIF 265
#define WHILE 266
#define ENDWHILE 267
#define PUNTOCOMA 268
#define COMA 269
#define DOSPUNTOS 270
#define OPASIG 271
#define OPSUMA 272
#define OPRESTA 273
#define OPMUL 274
#define OPDIV 275
#define PARENTESISA 276
#define PARENTESISC 277
#define CORCHETEA 278
#define CORCHETEC 279
#define LLAVEA 280
#define LLAVEC 281
#define OPIDENTICO 282
#define OPDISTINTO 283
#define OPMENOR 284
#define OPMENORIGUAL 285
#define OPMAYOR 286
#define OPMAYORIGUAL 287
#define AND 288
#define OR 289
#define NOT 290
#define WRITE 291
#define READ 292
#define ID 293
#define CONS_INT 294
#define CONS_FLOAT 295
#define CONS_STR 296
#define BETWEEN 297
#define INLIST 298




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 214 of yacc.c  */
#line 186 ".\\Sintactico.y"

int tipo_int;
double tipo_double;
char *tipo_str;



/* Line 214 of yacc.c  */
#line 387 "y.tab.c"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
} YYLTYPE;
# define yyltype YYLTYPE /* obsolescent; will be withdrawn */
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif


/* Copy the second part of user declarations.  */


/* Line 264 of yacc.c  */
#line 412 "y.tab.c"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int yyi)
#else
static int
YYID (yyi)
    int yyi;
#endif
{
  return yyi;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef _STDLIB_H
#      define _STDLIB_H 1
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined _STDLIB_H \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef _STDLIB_H
#    define _STDLIB_H 1
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL \
	     && defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
  YYLTYPE yyls_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE) + sizeof (YYLTYPE)) \
      + 2 * YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)				\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack_alloc, Stack, yysize);			\
	Stack = &yyptr->Stack_alloc;					\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  8
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   140

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  44
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  45
/* YYNRULES -- Number of rules.  */
#define YYNRULES  78
/* YYNRULES -- Number of states.  */
#define YYNSTATES  140

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   298

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint8 yyprhs[] =
{
       0,     0,     3,     6,    10,    12,    15,    16,    21,    22,
      27,    28,    33,    34,    37,    38,    43,    45,    48,    50,
      52,    54,    56,    58,    61,    64,    67,    70,    73,    77,
      81,    82,    83,    92,    93,    94,    95,   107,   108,   109,
     118,   122,   125,   127,   129,   133,   134,   139,   140,   145,
     146,   151,   152,   157,   158,   163,   164,   169,   171,   173,
     174,   179,   183,   187,   189,   193,   197,   199,   201,   203,
     205,   206,   211,   212,   213,   214,   228,   237,   241
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      45,     0,    -1,    46,    55,    -1,     3,    47,     4,    -1,
      48,    -1,    47,    48,    -1,    -1,    52,    15,     5,    49,
      -1,    -1,    52,    15,     7,    50,    -1,    -1,    52,    15,
       6,    51,    -1,    -1,    38,    53,    -1,    -1,    38,    54,
      14,    52,    -1,    56,    -1,    55,    56,    -1,    59,    -1,
      60,    -1,    66,    -1,    57,    -1,    58,    -1,    36,    38,
      -1,    36,    41,    -1,    36,    40,    -1,    36,    39,    -1,
      37,    38,    -1,    38,    16,    79,    -1,    38,    16,    41,
      -1,    -1,    -1,     8,    21,    61,    69,    22,    62,    55,
      10,    -1,    -1,    -1,    -1,     8,    21,    63,    69,    22,
      64,    55,    65,     9,    55,    10,    -1,    -1,    -1,    11,
      21,    67,    69,    22,    68,    55,    12,    -1,    69,    34,
      70,    -1,    35,    70,    -1,    70,    -1,    71,    -1,    70,
      33,    71,    -1,    -1,    79,    72,    27,    79,    -1,    -1,
      79,    73,    30,    79,    -1,    -1,    79,    74,    32,    79,
      -1,    -1,    79,    75,    31,    79,    -1,    -1,    79,    76,
      29,    79,    -1,    -1,    79,    77,    28,    79,    -1,    83,
      -1,    87,    -1,    -1,    21,    78,    69,    22,    -1,    79,
      17,    80,    -1,    79,    18,    80,    -1,    80,    -1,    80,
      19,    81,    -1,    80,    20,    81,    -1,    81,    -1,    38,
      -1,    39,    -1,    40,    -1,    -1,    21,    82,    79,    22,
      -1,    -1,    -1,    -1,    42,    21,    38,    84,    14,    23,
      79,    85,    13,    79,    86,    24,    22,    -1,    43,    21,
      38,    14,    23,    88,    24,    22,    -1,    88,    13,    79,
      -1,    79,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   243,   243,   253,   257,   258,   262,   262,   274,   274,
     288,   288,   303,   303,   310,   310,   321,   331,   343,   348,
     353,   358,   363,   372,   386,   390,   396,   405,   420,   434,
     451,   457,   451,   481,   487,   497,   481,   514,   521,   514,
     550,   554,   558,   565,   569,   576,   576,   580,   580,   584,
     584,   588,   588,   592,   592,   596,   596,   600,   604,   608,
     608,   627,   634,   640,   648,   653,   657,   665,   684,   691,
     699,   699,   718,   730,   733,   718,   743,   751,   758
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "\"DECVAR\"", "\"ENDDEC\"",
  "\"INTEGER\"", "\"FLOAT\"", "\"STRING\"", "\"IF\"", "\"ELSE\"",
  "\"ENDIF\"", "\"WHILE\"", "\"ENDWHILE\"", "\";\"", "\",\"", "\".\"",
  "\":=\"", "\"+\"", "\"-\"", "\"*\"", "\"/\"", "\"(\"", "\")\"", "\"[\"",
  "\"]\"", "\"{\"", "\"}\"", "\"==\"", "\"!=\"", "\"<\"", "\"<=\"",
  "\">\"", "\">=\"", "\"AND\"", "\"OR\"", "\"NOT\"", "\"WRITE\"",
  "\"READ\"", "\"identificador\"", "\"constante entera\"",
  "\"constante real\"", "\"constante string\"", "\"BETWEEN\"",
  "\"INLIST\"", "$accept", "PROGRAMA", "bloque_declaraciones",
  "declaraciones", "declaracion", "$@1", "$@2", "$@3", "lista_variables",
  "$@4", "$@5", "bloque", "sentencia", "salida", "entrada", "asignacion",
  "seleccion", "$@6", "$@7", "$@8", "$@9", "$@10", "iteracion", "$@11",
  "$@12", "condicion", "termino_logico", "comparacion", "$@13", "$@14",
  "$@15", "$@16", "$@17", "$@18", "$@19", "expresion", "termino", "factor",
  "$@20", "between", "$@21", "$@22", "$@23", "inlist", "lista_expresiones", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    44,    45,    46,    47,    47,    49,    48,    50,    48,
      51,    48,    53,    52,    54,    52,    55,    55,    56,    56,
      56,    56,    56,    57,    57,    57,    57,    58,    59,    59,
      61,    62,    60,    63,    64,    65,    60,    67,    68,    66,
      69,    69,    69,    70,    70,    72,    71,    73,    71,    74,
      71,    75,    71,    76,    71,    77,    71,    71,    71,    78,
      71,    79,    79,    79,    80,    80,    80,    81,    81,    81,
      82,    81,    84,    85,    86,    83,    87,    88,    88
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     2,     3,     1,     2,     0,     4,     0,     4,
       0,     4,     0,     2,     0,     4,     1,     2,     1,     1,
       1,     1,     1,     2,     2,     2,     2,     2,     3,     3,
       0,     0,     8,     0,     0,     0,    11,     0,     0,     8,
       3,     2,     1,     1,     3,     0,     4,     0,     4,     0,
       4,     0,     4,     0,     4,     0,     4,     1,     1,     0,
       4,     3,     3,     1,     3,     3,     1,     1,     1,     1,
       0,     4,     0,     0,     0,    13,     8,     3,     1
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,     0,     0,    12,     0,     4,     0,     1,     0,
       0,     0,     0,     0,     2,    16,    21,    22,    18,    19,
      20,    13,     0,     3,     5,     0,    30,    37,    23,    26,
      25,    24,    27,     0,    17,     0,     6,    10,     8,     0,
       0,     0,    70,    67,    68,    69,    29,    28,    63,    66,
      15,     7,    11,     9,    59,     0,     0,     0,     0,    42,
      43,    45,    57,    58,     0,     0,     0,     0,     0,     0,
       0,     0,    41,     0,     0,    31,     0,     0,     0,     0,
       0,     0,     0,     0,    34,    38,     0,    61,    62,    64,
      65,     0,    72,     0,     0,    40,    44,     0,     0,     0,
       0,     0,     0,     0,     0,    71,    60,     0,     0,     0,
      46,    48,    50,    52,    54,    56,    35,     0,     0,     0,
      32,     0,    39,     0,    78,     0,     0,    73,     0,     0,
       0,     0,    77,    76,    36,     0,    74,     0,     0,    75
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     2,     3,     5,     6,    51,    53,    52,     7,    21,
      22,    14,    15,    16,    17,    18,    19,    39,    94,    40,
     103,   121,    20,    41,   104,    58,    59,    60,    78,    79,
      80,    81,    82,    83,    71,    61,    48,    49,    66,    62,
     107,   131,   137,    63,   125
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -94
static const yytype_int8 yypact[] =
{
       1,   -29,    26,    17,     3,    -1,   -94,    23,   -94,    27,
      31,    67,    20,    60,    17,   -94,   -94,   -94,   -94,   -94,
     -94,   -94,    65,   -94,   -94,   112,   -94,   -94,   -94,   -94,
     -94,   -94,   -94,    42,   -94,   -29,   -94,   -94,   -94,    22,
      22,    22,   -94,   -94,   -94,   -94,   -94,    76,    95,   -94,
     -94,   -94,   -94,   -94,   -94,    35,    66,    70,     0,    56,
     -94,    81,   -94,   -94,     5,    25,    -8,    -8,    -8,    -8,
      -8,    22,    56,    58,    84,   -94,    35,    35,    96,    94,
      93,    97,    98,   101,   -94,   -94,    68,    95,    95,   -94,
     -94,    50,   -94,   116,    17,    56,   -94,    -8,    -8,    -8,
      -8,    -8,    -8,    17,    17,   -94,   -94,   117,   103,     4,
      76,    76,    76,    76,    76,    76,    17,     8,   109,    -8,
     -94,   124,   -94,    -8,    76,    -6,    17,    76,    -8,   113,
      13,   121,    76,   -94,   -94,    -8,    76,   114,   115,   -94
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
     -94,   -94,   -94,   -94,   131,   -94,   -94,   -94,   104,   -94,
     -94,   -93,   -14,   -94,   -94,   -94,   -94,   -94,   -94,   -94,
     -94,   -94,   -94,   -94,   -94,   -35,   -47,    63,   -94,   -94,
     -94,   -94,   -94,   -94,   -94,   -31,    33,    51,   -94,   -94,
     -94,   -94,   -94,   -94,   -94
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -56
static const yytype_int16 yytable[] =
{
      34,   109,    47,    23,     1,    64,    65,   128,    72,     4,
     116,   117,     9,    42,   120,    10,     9,   -14,   129,    10,
     122,     9,    75,   134,    10,     9,     8,    84,    10,    95,
      43,    44,    45,   130,    76,    86,    91,     4,    25,    76,
      11,    12,    13,    54,    11,    12,    13,    85,    26,    11,
      12,    13,    27,    11,    12,    13,    54,    55,    32,    76,
      43,    44,    45,    42,    56,    57,   110,   111,   112,   113,
     114,   115,   106,    43,    44,    45,    33,    56,    57,    35,
      43,    44,    45,    46,    76,    67,    68,    73,   124,    77,
     105,    74,   127,    67,    68,    34,    92,   132,    67,    68,
      87,    88,    34,    34,   136,    28,    29,    30,    31,   -55,
     -53,   -47,   -51,   -49,    69,    70,    34,    36,    37,    38,
      89,    90,    93,    97,    98,    99,   119,   101,   100,   102,
     108,   118,   123,   126,   135,   133,    24,   139,   138,    50,
      96
};

static const yytype_uint8 yycheck[] =
{
      14,    94,    33,     4,     3,    40,    41,    13,    55,    38,
     103,   104,     8,    21,    10,    11,     8,    14,    24,    11,
      12,     8,    22,    10,    11,     8,     0,    22,    11,    76,
      38,    39,    40,   126,    34,    66,    71,    38,    15,    34,
      36,    37,    38,    21,    36,    37,    38,    22,    21,    36,
      37,    38,    21,    36,    37,    38,    21,    35,    38,    34,
      38,    39,    40,    21,    42,    43,    97,    98,    99,   100,
     101,   102,    22,    38,    39,    40,    16,    42,    43,    14,
      38,    39,    40,    41,    34,    17,    18,    21,   119,    33,
      22,    21,   123,    17,    18,   109,    38,   128,    17,    18,
      67,    68,   116,   117,   135,    38,    39,    40,    41,    28,
      29,    30,    31,    32,    19,    20,   130,     5,     6,     7,
      69,    70,    38,    27,    30,    32,    23,    29,    31,    28,
      14,    14,    23,     9,    13,    22,     5,    22,    24,    35,
      77
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     3,    45,    46,    38,    47,    48,    52,     0,     8,
      11,    36,    37,    38,    55,    56,    57,    58,    59,    60,
      66,    53,    54,     4,    48,    15,    21,    21,    38,    39,
      40,    41,    38,    16,    56,    14,     5,     6,     7,    61,
      63,    67,    21,    38,    39,    40,    41,    79,    80,    81,
      52,    49,    51,    50,    21,    35,    42,    43,    69,    70,
      71,    79,    83,    87,    69,    69,    82,    17,    18,    19,
      20,    78,    70,    21,    21,    22,    34,    33,    72,    73,
      74,    75,    76,    77,    22,    22,    79,    80,    80,    81,
      81,    69,    38,    38,    62,    70,    71,    27,    30,    32,
      31,    29,    28,    64,    68,    22,    22,    84,    14,    55,
      79,    79,    79,    79,    79,    79,    55,    55,    14,    23,
      10,    65,    12,    23,    79,    88,     9,    79,    13,    24,
      55,    85,    79,    22,    10,    13,    79,    86,    24,    22
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
	      (Loc).first_line, (Loc).first_column,	\
	      (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value, Location); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep, yylocationp)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
    YYLTYPE const * const yylocationp;
#endif
{
  if (!yyvaluep)
    return;
  YYUSE (yylocationp);
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep, yylocationp)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
    YYLTYPE const * const yylocationp;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  YY_LOCATION_PRINT (yyoutput, *yylocationp);
  YYFPRINTF (yyoutput, ": ");
  yy_symbol_value_print (yyoutput, yytype, yyvaluep, yylocationp);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
#else
static void
yy_stack_print (yybottom, yytop)
    yytype_int16 *yybottom;
    yytype_int16 *yytop;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, YYLTYPE *yylsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yylsp, yyrule)
    YYSTYPE *yyvsp;
    YYLTYPE *yylsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       , &(yylsp[(yyi + 1) - (yynrhs)])		       );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, yylsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into YYRESULT an error message about the unexpected token
   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
   including the terminating null byte.  If YYRESULT is null, do not
   copy anything; just return the number of bytes that would be
   copied.  As a special case, return 0 if an ordinary "syntax error"
   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
   size calculation.  */
static YYSIZE_T
yysyntax_error (char *yyresult, int yystate, int yychar)
{
  int yyn = yypact[yystate];

  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
    return 0;
  else
    {
      int yytype = YYTRANSLATE (yychar);
      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
      YYSIZE_T yysize = yysize0;
      YYSIZE_T yysize1;
      int yysize_overflow = 0;
      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
      int yyx;

# if 0
      /* This is so xgettext sees the translatable formats that are
	 constructed on the fly.  */
      YY_("syntax error, unexpected %s");
      YY_("syntax error, unexpected %s, expecting %s");
      YY_("syntax error, unexpected %s, expecting %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
# endif
      char *yyfmt;
      char const *yyf;
      static char const yyunexpected[] = "syntax error, unexpected %s";
      static char const yyexpecting[] = ", expecting %s";
      static char const yyor[] = " or %s";
      char yyformat[sizeof yyunexpected
		    + sizeof yyexpecting - 1
		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
		       * (sizeof yyor - 1))];
      char const *yyprefix = yyexpecting;

      /* Start YYX at -YYN if negative to avoid negative indexes in
	 YYCHECK.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;

      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yycount = 1;

      yyarg[0] = yytname[yytype];
      yyfmt = yystpcpy (yyformat, yyunexpected);

      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	  {
	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
	      {
		yycount = 1;
		yysize = yysize0;
		yyformat[sizeof yyunexpected - 1] = '\0';
		break;
	      }
	    yyarg[yycount++] = yytname[yyx];
	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
	    yysize_overflow |= (yysize1 < yysize);
	    yysize = yysize1;
	    yyfmt = yystpcpy (yyfmt, yyprefix);
	    yyprefix = yyor;
	  }

      yyf = YY_(yyformat);
      yysize1 = yysize + yystrlen (yyf);
      yysize_overflow |= (yysize1 < yysize);
      yysize = yysize1;

      if (yysize_overflow)
	return YYSIZE_MAXIMUM;

      if (yyresult)
	{
	  /* Avoid sprintf, as that infringes on the user's name space.
	     Don't have undefined behavior even if the translation
	     produced a string with the wrong number of "%s"s.  */
	  char *yyp = yyresult;
	  int yyi = 0;
	  while ((*yyp = *yyf) != '\0')
	    {
	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
		{
		  yyp += yytnamerr (yyp, yyarg[yyi++]);
		  yyf += 2;
		}
	      else
		{
		  yyp++;
		  yyf++;
		}
	    }
	}
      return yysize;
    }
}
#endif /* YYERROR_VERBOSE */


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep, YYLTYPE *yylocationp)
#else
static void
yydestruct (yymsg, yytype, yyvaluep, yylocationp)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
    YYLTYPE *yylocationp;
#endif
{
  YYUSE (yyvaluep);
  YYUSE (yylocationp);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
	break;
    }
}

/* Prevent warnings from -Wmissing-prototypes.  */
#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */


/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;

/* Location data for the lookahead symbol.  */
YYLTYPE yylloc;

/* Number of syntax errors so far.  */
int yynerrs;



/*-------------------------.
| yyparse or yypush_parse.  |
`-------------------------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{


    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       `yyss': related to states.
       `yyvs': related to semantic values.
       `yyls': related to locations.

       Refer to the stacks thru separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    /* The location stack.  */
    YYLTYPE yylsa[YYINITDEPTH];
    YYLTYPE *yyls;
    YYLTYPE *yylsp;

    /* The locations where the error started and ended.  */
    YYLTYPE yyerror_range[2];

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;
  YYLTYPE yyloc;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N), yylsp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yytoken = 0;
  yyss = yyssa;
  yyvs = yyvsa;
  yyls = yylsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */
  yyssp = yyss;
  yyvsp = yyvs;
  yylsp = yyls;

#if YYLTYPE_IS_TRIVIAL
  /* Initialize the default location before parsing starts.  */
  yylloc.first_line   = yylloc.last_line   = 1;
  yylloc.first_column = yylloc.last_column = 1;
#endif

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;
	YYLTYPE *yyls1 = yyls;

	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),
		    &yyls1, yysize * sizeof (*yylsp),
		    &yystacksize);

	yyls = yyls1;
	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss_alloc, yyss);
	YYSTACK_RELOCATE (yyvs_alloc, yyvs);
	YYSTACK_RELOCATE (yyls_alloc, yyls);
#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;
      yylsp = yyls + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  *++yyvsp = yylval;
  *++yylsp = yylloc;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];

  /* Default location.  */
  YYLLOC_DEFAULT (yyloc, (yylsp - yylen), yylen);
  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:

/* Line 1455 of yacc.c  */
#line 244 ".\\Sintactico.y"
    { 
			guardarTS();
			postOrden(&bloquePtr); //Agregamos funciones
			escribirGragh(bloquePtr);
			printf("\nCompilacion exitosa.\n");
		}
    break;

  case 3:

/* Line 1455 of yacc.c  */
#line 253 ".\\Sintactico.y"
    { printf("Bloque declaraciones.\n"); }
    break;

  case 4:

/* Line 1455 of yacc.c  */
#line 257 ".\\Sintactico.y"
    { printf("Declaraciones.\n"); }
    break;

  case 5:

/* Line 1455 of yacc.c  */
#line 258 ".\\Sintactico.y"
    { printf("Declaraciones.\n"); }
    break;

  case 6:

/* Line 1455 of yacc.c  */
#line 262 ".\\Sintactico.y"
    {
													for(i=0;i<cantid;i++) //vamos agregando todos los ids que leyo
													{
														if(insertarTS(idvec[i], "INTEGER", "", 0, 0) != 0) //devuelve error porque ya existe, entonces no lo guarda
														{
															sprintf(mensajes, "%s%s%s", "Error: la variable '", idvec[i], "' ya fue declarada");
															yyerror(mensajes, (yylsp[(3) - (3)]).first_line, (yylsp[(3) - (3)]).first_column, (yylsp[(3) - (3)]).last_column);
														}
													}
													cantid=0;												
												}
    break;

  case 7:

/* Line 1455 of yacc.c  */
#line 273 ".\\Sintactico.y"
    { printf("Declaracion.\n"); }
    break;

  case 8:

/* Line 1455 of yacc.c  */
#line 274 ".\\Sintactico.y"
    {                                                    
                                                    for(i=0;i<cantid;i++)
                                                    {
                                                        
                                                        if(insertarTS(idvec[i], "STRING", "", 0, 0) != 0)
                                                        {
                                                            sprintf(mensajes, "%s%s%s", "Error: la variable '", idvec[i], "' ya fue declarada");
                                                            yyerror(mensajes, (yylsp[(3) - (3)]).first_line, (yylsp[(3) - (3)]).first_column, (yylsp[(3) - (3)]).last_column);
                                                        }
                                                        
                                                    } 
													cantid=0;
                                                }
    break;

  case 9:

/* Line 1455 of yacc.c  */
#line 287 ".\\Sintactico.y"
    { printf("Declaracion.\n"); }
    break;

  case 10:

/* Line 1455 of yacc.c  */
#line 288 ".\\Sintactico.y"
    {                                                    
                                                    for(i=0;i<cantid;i++)
                                                    {
                                                        if(insertarTS(idvec[i], "FLOAT", "", 0, 0) != 0)
                                                        {
                                                            sprintf(mensajes, "%s%s%s", "Error: la variable '", idvec[i], "' ya fue declarada");
                                                            yyerror(mensajes, (yylsp[(3) - (3)]).first_line, (yylsp[(3) - (3)]).first_column, (yylsp[(3) - (3)]).last_column);
                                                        }   
                                                    }
													cantid=0;                                                    
                                                }
    break;

  case 11:

/* Line 1455 of yacc.c  */
#line 299 ".\\Sintactico.y"
    { printf("Declaracion.\n"); }
    break;

  case 12:

/* Line 1455 of yacc.c  */
#line 303 ".\\Sintactico.y"
    {                        
                        strcpy(vecAux, yylval.tipo_str); //leemos el nombre de la variable
                        punt = strtok(vecAux, " ,\n"); //eliminamos el caracter separador de la lista de variables
                        strcpy(idvec[cantid], punt); //copiamos al array de ids
                        cantid++;
                    }
    break;

  case 13:

/* Line 1455 of yacc.c  */
#line 309 ".\\Sintactico.y"
    { printf("Lista de variables.\n"); }
    break;

  case 14:

/* Line 1455 of yacc.c  */
#line 310 ".\\Sintactico.y"
    {                        
                        strcpy(vecAux, yylval.tipo_str); //se repite aca tambien, no lo toma de arriba
                        punt = strtok(vecAux, " ,\n");
                        strcpy(idvec[cantid], punt);
                        cantid++;
                    }
    break;

  case 15:

/* Line 1455 of yacc.c  */
#line 317 ".\\Sintactico.y"
    { printf("Lista de variables.\n"); }
    break;

  case 16:

/* Line 1455 of yacc.c  */
#line 322 ".\\Sintactico.y"
    { 
			printf("Bloque.\n"); 
			 
			if(bloquePtr != NULL){
				bloquePtr = (tNodo *)crearNodo("BLOQUE", sentenciaPtr, NULL);
			} else {
				bloquePtr = sentenciaPtr;
			}
		}
    break;

  case 17:

/* Line 1455 of yacc.c  */
#line 332 ".\\Sintactico.y"
    { 
			printf("Bloque.\n"); 
			if(bloquePtr != NULL){
				bloquePtr = (tNodo *)crearNodo("BLOQUE", bloquePtr, sentenciaPtr);
			} else {
				bloquePtr = (tNodo *)crearNodo("BLOQUE", sentenciaPtr,NULL);
			}
		}
    break;

  case 18:

/* Line 1455 of yacc.c  */
#line 344 ".\\Sintactico.y"
    { 
				printf("Sentencia.\n"); 
				sentenciaPtr=asigPtr;
			}
    break;

  case 19:

/* Line 1455 of yacc.c  */
#line 349 ".\\Sintactico.y"
    { 
				printf("Sentencia.\n"); 
				sentenciaPtr=seleccionPtr;
			}
    break;

  case 20:

/* Line 1455 of yacc.c  */
#line 354 ".\\Sintactico.y"
    { 
				printf("Sentencia.\n"); 
				sentenciaPtr=iteracionPtr;
			}
    break;

  case 21:

/* Line 1455 of yacc.c  */
#line 359 ".\\Sintactico.y"
    { 
				printf("Sentencia.\n"); 
				sentenciaPtr=salidaPtr;
			}
    break;

  case 22:

/* Line 1455 of yacc.c  */
#line 364 ".\\Sintactico.y"
    { 
				printf("Sentencia.\n"); 
				sentenciaPtr=entradaPtr;
			}
    break;

  case 23:

/* Line 1455 of yacc.c  */
#line 373 ".\\Sintactico.y"
    {
			strcpy(vecAux, (yyvsp[(2) - (2)].tipo_str)); // Comprueba que la variable esté declarada.
			punt = strtok(vecAux," ;\n");
			if(!existeID(punt)) {
				sprintf(mensajes, "%s%s%s", "Error: no se declaro la variable '", punt, "'");
				yyerror(mensajes, (yylsp[(1) - (2)]).first_line, (yylsp[(2) - (2)]).first_column, (yylsp[(2) - (2)]).last_column);
			}
			else {
				salidaPtr=(tNodo *)crearNodo("WRITE", crearHoja(punt, getTipoId(punt)), NULL);
			}
			printf("Salida >>>\n"); //Acá se insertarían en el arbol las salidas ¿Cómo se haría?
				//Posiblemente un nodo con una sola hoja para el write, o solo la hoja
		}
    break;

  case 24:

/* Line 1455 of yacc.c  */
#line 386 ".\\Sintactico.y"
    {
			salidaPtr=(tNodo *)crearNodo("WRITE", crearHoja((yyvsp[(2) - (2)].tipo_str), "CONS_STR"), NULL);
			printf("Salida >>>\n");
		}
    break;

  case 25:

/* Line 1455 of yacc.c  */
#line 390 ".\\Sintactico.y"
    {
			char* name;
			sprintf(name, "%s", (yyvsp[(2) - (2)].tipo_double));
			salidaPtr=(tNodo *)crearNodo("WRITE", crearHoja(name,"CONS_FLOAT"), NULL);
			printf("Salida >>>\n");
		}
    break;

  case 26:

/* Line 1455 of yacc.c  */
#line 396 ".\\Sintactico.y"
    {
			char* name;
			sprintf(name, "%s", (yyvsp[(2) - (2)].tipo_int));
			salidaPtr=(tNodo *)crearNodo("WRITE", crearHoja(name,"CONS_INT"), NULL);
			printf("Salida >>>\n");
		}
    break;

  case 27:

/* Line 1455 of yacc.c  */
#line 405 ".\\Sintactico.y"
    {
					printf("Entrada >>>\n");
					strcpy(vecAux, (yyvsp[(2) - (2)].tipo_str)); // Comprueba que la variable esté declarada.
                    punt = strtok(vecAux," ;\n");
                    if(!existeID(punt)) {
                        sprintf(mensajes, "%s%s%s", "Error: no se declaro la variable '", punt, "'");
                        yyerror(mensajes, (yylsp[(1) - (2)]).first_line, (yylsp[(2) - (2)]).first_column, (yylsp[(2) - (2)]).last_column);
                    }
					else {
						entradaPtr=(tNodo *)crearNodo("READ", crearHoja(punt, getTipoId(punt)), NULL);
					}
				}
    break;

  case 28:

/* Line 1455 of yacc.c  */
#line 420 ".\\Sintactico.y"
    {
									strcpy(vecAux, (yyvsp[(1) - (3)].tipo_str)); //en $1 esta el valor de ID
									punt = strtok(vecAux," +-*/[](){}:=,\n");
									if(!existeID(punt)) //No existe: entonces no esta declarada
									{
										sprintf(mensajes, "%s%s%s", "Error: no se declaro la variable '", punt, "'");
										yyerror(mensajes, (yylsp[(1) - (3)]).first_line, (yylsp[(1) - (3)]).first_column, (yylsp[(1) - (3)]).last_column);
									}
									else{
										asigPtr=(tNodo *)crearHoja(punt,getTipoId(punt));
										asigPtr=(tNodo *)crearNodo("OPASIG", asigPtr, exprAritPtr);
									}
									printf("Asignacion.\n");
								}
    break;

  case 29:

/* Line 1455 of yacc.c  */
#line 434 ".\\Sintactico.y"
    {
									strcpy(vecAux, (yyvsp[(1) - (3)].tipo_str)); //en $1 esta el valor de ID
									punt = strtok(vecAux," +-*/[](){}:=,\n");
									if(!existeID(punt)) //No existe: entonces no esta declarada
									{
										sprintf(mensajes, "%s%s%s", "Error: no se declaro la variable '", punt, "'");
										yyerror(mensajes, (yylsp[(1) - (3)]).first_line, (yylsp[(1) - (3)]).first_column, (yylsp[(1) - (3)]).last_column);
									}
									else{
										
										asigPtr=(tNodo *)crearNodo("OPASIG", crearHoja(punt,getTipoId(punt)), crearHoja((yyvsp[(3) - (3)].tipo_str),"CONS_STR"));
									}
									printf("Asignacion.\n");
								}
    break;

  case 30:

/* Line 1455 of yacc.c  */
#line 451 ".\\Sintactico.y"
    {
				if(condicionPtr){
						ponerenPila(pilaCondiciones,condicionPtr);
						condicionPtr=NULL;
					}
			}
    break;

  case 31:

/* Line 1455 of yacc.c  */
#line 457 ".\\Sintactico.y"
    {
				if(bloquePtr){
					ponerenPila(pilaBloque,bloquePtr);
					bloquePtr=NULL;
				}
				else{
					if(sentenciaPtr) {
						  ponerenPila(pilaBloque,sentenciaPtr);
					}
				}
			}
    break;

  case 32:

/* Line 1455 of yacc.c  */
#line 468 ".\\Sintactico.y"
    { 
				seleccionPtr=(tNodo *)crearNodo("IF", condicionPtr, bloquePtr);
				
				if (topedePila(pilaCondiciones)){
					condicionPtr = topedePila(pilaCondiciones);
					sacardePila(pilaCondiciones);
				}
				if (topedePila(pilaBloque)){
					  bloquePtr = topedePila(pilaBloque);
					  sacardePila(pilaBloque);
				}
				printf("Seleccion\n");
			}
    break;

  case 33:

/* Line 1455 of yacc.c  */
#line 481 ".\\Sintactico.y"
    {
				if(condicionPtr){
						ponerenPila(pilaCondiciones,condicionPtr);
						condicionPtr=NULL;
					}
				}
    break;

  case 34:

/* Line 1455 of yacc.c  */
#line 487 ".\\Sintactico.y"
    {
				if(bloquePtr){
					ponerenPila(pilaBloque,bloquePtr);
					bloquePtr=NULL;
				}
				else{
					if(sentenciaPtr) {
						  ponerenPila(pilaBloque,sentenciaPtr);
					}
				}
			}
    break;

  case 35:

/* Line 1455 of yacc.c  */
#line 497 ".\\Sintactico.y"
    {auxBloquePtr=bloquePtr;}
    break;

  case 36:

/* Line 1455 of yacc.c  */
#line 499 ".\\Sintactico.y"
    { 
				seleccionPtr =(tNodo *) crearNodo("IF-ELSE", condicionPtr, crearNodo("cuerpo",auxBloquePtr,bloquePtr));
				if (topedePila(pilaCondiciones)){
					condicionPtr = topedePila(pilaCondiciones);
					sacardePila(pilaCondiciones);
				}
				if (topedePila(pilaBloque)){
					  bloquePtr = topedePila(pilaBloque);
					  sacardePila(pilaBloque);
				}
				printf("Seleccion con ELSE\n"); 
			}
    break;

  case 37:

/* Line 1455 of yacc.c  */
#line 514 ".\\Sintactico.y"
    {
					if(condicionPtr){
						ponerenPila(pilaCondiciones,condicionPtr);
						condicionPtr=NULL;
					}
						
			}
    break;

  case 38:

/* Line 1455 of yacc.c  */
#line 521 ".\\Sintactico.y"
    {
				if(bloquePtr){
					ponerenPila(pilaBloque,bloquePtr);
					bloquePtr=NULL;
				}
				else{
					if(sentenciaPtr) {
						ponerenPila(pilaBloque,sentenciaPtr);
					}
				}		
			}
    break;

  case 39:

/* Line 1455 of yacc.c  */
#line 533 ".\\Sintactico.y"
    { 
				
				iteracionPtr=(tNodo *)crearNodo("WHILE", condicionPtr, bloquePtr);
				if (topedePila(pilaBloque)){
					bloquePtr = topedePila(pilaBloque);
					sacardePila(pilaBloque);
				}
				if (topedePila(pilaCondiciones)){
					condicionPtr = topedePila(pilaCondiciones);
					sacardePila(pilaCondiciones);
				}
				printf("Iteracion\n"); 
			}
    break;

  case 40:

/* Line 1455 of yacc.c  */
#line 550 ".\\Sintactico.y"
    {
				printf("Condicion OR\n"); 
				condicionPtr=(tNodo *)crearNodo("OR", condicionPtr, terminoLogicoPtr);
				}
    break;

  case 41:

/* Line 1455 of yacc.c  */
#line 554 ".\\Sintactico.y"
    { 
				printf("Condicion NOT\n"); 
				condicionPtr = (tNodo *)crearNodo("NOT",terminoLogicoPtr,NULL);
			}
    break;

  case 42:

/* Line 1455 of yacc.c  */
#line 558 ".\\Sintactico.y"
    { 
				printf("Condicion\n");
				condicionPtr=terminoLogicoPtr;
				}
    break;

  case 43:

/* Line 1455 of yacc.c  */
#line 565 ".\\Sintactico.y"
    { 
				terminoLogicoPtr=comparacionPtr;
				printf("Termino logico\n"); 
			}
    break;

  case 44:

/* Line 1455 of yacc.c  */
#line 569 ".\\Sintactico.y"
    { 
				terminoLogicoPtr=(tNodo *)crearNodo("AND", terminoLogicoPtr, comparacionPtr);
				printf("Termino logico\n"); 
				
			}
    break;

  case 45:

/* Line 1455 of yacc.c  */
#line 576 ".\\Sintactico.y"
    {exprCMPPtr = exprPtr; }
    break;

  case 46:

/* Line 1455 of yacc.c  */
#line 576 ".\\Sintactico.y"
    { 
				comparacionPtr = (tNodo *)crearNodo("OPIDENTICO",exprCMPPtr,exprPtr);
				printf("Comparacion ==\n"); 
			}
    break;

  case 47:

/* Line 1455 of yacc.c  */
#line 580 ".\\Sintactico.y"
    {exprCMPPtr = exprPtr; }
    break;

  case 48:

/* Line 1455 of yacc.c  */
#line 580 ".\\Sintactico.y"
    { 
				comparacionPtr = (tNodo *)crearNodo("OPMENORIGUAL",exprCMPPtr,exprPtr);
				printf("Comparacion <=\n"); 
			}
    break;

  case 49:

/* Line 1455 of yacc.c  */
#line 584 ".\\Sintactico.y"
    {exprCMPPtr = exprPtr; }
    break;

  case 50:

/* Line 1455 of yacc.c  */
#line 584 ".\\Sintactico.y"
    { 
				comparacionPtr = (tNodo *)crearNodo("OPMAYORIGUAL",exprCMPPtr,exprPtr);
				printf("Comparacion >=\n"); 
			}
    break;

  case 51:

/* Line 1455 of yacc.c  */
#line 588 ".\\Sintactico.y"
    {exprCMPPtr = exprPtr; }
    break;

  case 52:

/* Line 1455 of yacc.c  */
#line 588 ".\\Sintactico.y"
    { 
				comparacionPtr = (tNodo *)crearNodo("OPMAYOR",exprCMPPtr,exprPtr);
				printf("Comparacion >\n"); 
			}
    break;

  case 53:

/* Line 1455 of yacc.c  */
#line 592 ".\\Sintactico.y"
    {exprCMPPtr = exprPtr; }
    break;

  case 54:

/* Line 1455 of yacc.c  */
#line 592 ".\\Sintactico.y"
    { 
				comparacionPtr = (tNodo *)crearNodo("OPMENOR",exprCMPPtr,exprPtr);
				printf("Comparacion <\n"); 
			}
    break;

  case 55:

/* Line 1455 of yacc.c  */
#line 596 ".\\Sintactico.y"
    {exprCMPPtr = exprPtr; }
    break;

  case 56:

/* Line 1455 of yacc.c  */
#line 596 ".\\Sintactico.y"
    { 
				comparacionPtr = (tNodo *)crearNodo("OPDISTINTO",exprCMPPtr,exprPtr);
				printf("Comparacion !=\n"); 
			}
    break;

  case 57:

/* Line 1455 of yacc.c  */
#line 600 ".\\Sintactico.y"
    { 
			//VER POR LAS DUDAS
				printf("Comparacion Between\n"); 
			}
    break;

  case 58:

/* Line 1455 of yacc.c  */
#line 604 ".\\Sintactico.y"
    { 
			//VER POR LAS DUDAS
			printf("Comparacion Inlist\n"); 
			}
    break;

  case 59:

/* Line 1455 of yacc.c  */
#line 608 ".\\Sintactico.y"
    {
				if(condicionPtr){
					ponerenPila(pilaCondicion, condicionPtr);
				}
					
			}
    break;

  case 60:

/* Line 1455 of yacc.c  */
#line 613 ".\\Sintactico.y"
    { 
				printf("Comparacion ()\n"); 
				comparacionPtr=condicionPtr;
				if(topedePila(pilaCondicion)){
					condicionPtr = topedePila(pilaCondicion);
					sacardePila(pilaCondicion);
				}
			}
    break;

  case 61:

/* Line 1455 of yacc.c  */
#line 628 ".\\Sintactico.y"
    { 
				printf("Expresion suma\n"); 
				exprAritPtr=(tNodo *)crearNodo("OPSUMA", exprPtr, terminoPtr);
				//exprAritPtr->info.tipoDato= terminoPtr->info.tipoDato;
				//Puntero de Expresion (EXPT) = Crear nodo(+, EXPT, TEPT)
			}
    break;

  case 62:

/* Line 1455 of yacc.c  */
#line 634 ".\\Sintactico.y"
    { 
				printf("Expresion resta\n"); 
				exprAritPtr=(tNodo *)crearNodo("OPRESTA", exprPtr, terminoPtr);
				//exprAritPtr->info.tipoDato= terminoPtr->info.tipoDato;
				//Puntero de Expresion (EXPT) = Crear nodo(-, EXPT, TEPT)
				}
    break;

  case 63:

/* Line 1455 of yacc.c  */
#line 640 ".\\Sintactico.y"
    { 
				printf("Expresion\n"); //copiado de punteros 
				exprAritPtr = terminoPtr; 
				//exprAritPtr->info.tipoDato= terminoPtr->info.tipoDato;
			}
    break;

  case 64:

/* Line 1455 of yacc.c  */
#line 648 ".\\Sintactico.y"
    { 
			printf("Termino multiplicacion\n");
			terminoPtr=(tNodo *)crearNodo("OPMUL", terminoPtr, factorPtr);
			//terminoPtr->info.tipoDato= factorPtr->info.tipoDato;
		}
    break;

  case 65:

/* Line 1455 of yacc.c  */
#line 653 ".\\Sintactico.y"
    { printf("Termino division\n");
			terminoPtr=(tNodo *)crearNodo("OPDIV", terminoPtr, factorPtr);
			//terminoPtr->info.tipoDato= factorPtr->info.tipoDato;
		}
    break;

  case 66:

/* Line 1455 of yacc.c  */
#line 657 ".\\Sintactico.y"
    { 
			terminoPtr = factorPtr;
			//terminoPtr->info.tipoDato= factorPtr->info.tipoDato; Parece innecesario
			printf("Termino\n"); //copiado de punteros TEPT=FAPT
			}
    break;

  case 67:

/* Line 1455 of yacc.c  */
#line 665 ".\\Sintactico.y"
    {
			char error[50];
			strcpy(vecAux, (yyvsp[(1) - (1)].tipo_str));
			punt = strtok(vecAux," +-*/[](){}:=,\n");
			if(!existeID(punt)) //No existe: entonces no esta declarada --> error
			{
				sprintf(mensajes, "%s%s%s", "Error: no se declaro la variable '", punt, "'");
				yyerror(mensajes, (yylsp[(1) - (1)]).first_line, (yylsp[(1) - (1)]).first_column, (yylsp[(1) - (1)]).last_column);
			}
            else{
                factorPtr = (tNodo *)crearHoja(punt,getTipoId(punt));
            }
			if(!esNumero(punt,error)) /*No es una variable numérica --> error*/
			{
				sprintf(mensajes, "%s", error);
				yyerror(mensajes, (yylsp[(1) - (1)]).first_line, (yylsp[(1) - (1)]).first_column, (yylsp[(1) - (1)]).last_column);
			}
            printf("Factor ID\n");
		}
    break;

  case 68:

/* Line 1455 of yacc.c  */
#line 684 ".\\Sintactico.y"
    { 
            (yyval.tipo_int) = (yyvsp[(1) - (1)].tipo_int); 
			char* name;
			sprintf(name, "%s", (yyvsp[(1) - (1)].tipo_int));
		    printf("Factor cte entera\n"); 
            factorPtr = (tNodo *)crearHoja(name,"CONS_INT");
		}
    break;

  case 69:

/* Line 1455 of yacc.c  */
#line 691 ".\\Sintactico.y"
    { 
        (yyval.tipo_double) = (yyvsp[(1) - (1)].tipo_double); 
		char* name;
		sprintf(name, "%g", (yyval.tipo_double));
		printf("Factor cte real\n"); 
		printf("%g \n",name); 
        //factorPtr = (tNodo *)crearHoja(name,"CONS_FLOAT");
		}
    break;

  case 70:

/* Line 1455 of yacc.c  */
#line 699 ".\\Sintactico.y"
    {
			if(exprAritPtr){
				ponerenPila(pilaExpresion,exprAritPtr);
			}
		}
    break;

  case 71:

/* Line 1455 of yacc.c  */
#line 706 ".\\Sintactico.y"
    { 
			factorPtr = exprAritPtr;
			if(topedePila(pilaExpresion)){
            exprAritPtr = topedePila(pilaExpresion);
            sacardePila(pilaExpresion);
            }
			printf("Factor ()\n"); 
		}
    break;

  case 72:

/* Line 1455 of yacc.c  */
#line 718 ".\\Sintactico.y"
    {
                            //ver que sea una variable numérica
                            char error[50];
                            strcpy(vecAux, (yyvsp[(3) - (3)].tipo_str));
                            punt = strtok(vecAux," ;\n");
                            if(!esNumero(punt, error))
                            {
                                sprintf(mensajes, "%s", error);
                                yyerror(mensajes, (yylsp[(1) - (3)]).first_line, (yylsp[(1) - (3)]).first_column, (yylsp[(1) - (3)]).last_column);
                            }
                            //insertar en árbol
                        }
    break;

  case 73:

/* Line 1455 of yacc.c  */
#line 730 ".\\Sintactico.y"
    {//Acá iría una comparacion por mayor
						//condicionIfPtr=crearNodo(">", crearHoja (printf("%s",$3), getTipoId(printf("%s",$3))), exprPtr);
						}
    break;

  case 74:

/* Line 1455 of yacc.c  */
#line 733 ".\\Sintactico.y"
    {
						//Aca iría una comparación por menor	
						//condicionIfPtr=crearNodo("AND", condicionIfPtr , crearNodo("<", crearHoja (printf("%s",$3), getTipoId(printf("%s",$3))), exprPtr));
						//accionPtr=crearNodo("Cuerpo",crearNodo(":=","@between","1"),crearNodo(":=","@between","0"));
						//listaExpPtr=crearNodo("IF",condicionIfPtr,accionPtr);
						}
    break;

  case 75:

/* Line 1455 of yacc.c  */
#line 738 ".\\Sintactico.y"
    {printf("Between\n");}
    break;

  case 76:

/* Line 1455 of yacc.c  */
#line 743 ".\\Sintactico.y"
    {
			printf("Inlist\n");
			//comparar ID con cada una de las expresiones.
			//Podría haber una variable @found que indique si se encontró
			inlistPtr = listaExpPtr;
		}
    break;

  case 77:

/* Line 1455 of yacc.c  */
#line 752 ".\\Sintactico.y"
    { 
					
						printf("Lista de expresiones\n"); 
						//listaExpPtr=(tNodo *)crearNodo("OR", listaExpPtr , crearNodo("==", crearHoja (ID, getTipoId(ID)), exprPtr));
						
					}
    break;

  case 78:

/* Line 1455 of yacc.c  */
#line 759 ".\\Sintactico.y"
    { 
						printf("Lista de expresiones\n"); 
						//listaExpPtr=(tNodo *)crearNodo("==", crearHoja (ID, getTipoId(ID)), exprPtr);
						//IF ( ID = expresion OR ID = expresion 2, etc)
						//		@found=true	
						//
					}
    break;



/* Line 1455 of yacc.c  */
#line 2686 "y.tab.c"
      default: break;
    }
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;
  *++yylsp = yyloc;

  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
      {
	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
	  {
	    YYSIZE_T yyalloc = 2 * yysize;
	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
	    if (yymsg != yymsgbuf)
	      YYSTACK_FREE (yymsg);
	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
	    if (yymsg)
	      yymsg_alloc = yyalloc;
	    else
	      {
		yymsg = yymsgbuf;
		yymsg_alloc = sizeof yymsgbuf;
	      }
	  }

	if (0 < yysize && yysize <= yymsg_alloc)
	  {
	    (void) yysyntax_error (yymsg, yystate, yychar);
	    yyerror (yymsg);
	  }
	else
	  {
	    yyerror (YY_("syntax error"));
	    if (yysize != 0)
	      goto yyexhaustedlab;
	  }
      }
#endif
    }

  yyerror_range[0] = yylloc;

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval, &yylloc);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  yyerror_range[0] = yylsp[1-yylen];
  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;

      yyerror_range[0] = *yylsp;
      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp, yylsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  *++yyvsp = yylval;

  yyerror_range[1] = yylloc;
  /* Using YYLLOC is tempting, but would change the location of
     the lookahead.  YYLOC is available though.  */
  YYLLOC_DEFAULT (yyloc, (yyerror_range - 1), 2);
  *++yylsp = yyloc;

  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined(yyoverflow) || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
     yydestruct ("Cleanup: discarding lookahead",
		 yytoken, &yylval, &yylloc);
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp, yylsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}



/* Line 1675 of yacc.c  */
#line 768 ".\\Sintactico.y"



/*---- 4. Código ----*/

int main(int argc, char *argv[])
{

    if((yyin = fopen(argv[1], "rt"))==NULL)
    {
        printf("\nNo se puede abrir el archivo de prueba: %s\r\n", argv[1]);
        return -1;
    }
    else
    { 

	/*graph = fopen("gragh.dot", "wt");
	if (graph == NULL) 
	{
		printf("\nNo se pudo crear el archivo del grafico de generacion de codigo intermedia: %s\r\n", argv[1]);
		return -1;
	}*/
	pilaExpresion = crearPila();      
	pilaBloque = crearPila();
	pilaCondicion = crearPila();
	pilaEtiq = crearPila();
	pilaEtiqExpMax = crearPila();
        crearTablaTS(); //tablaTS.primero = NULL;
        yyparse();
        fclose(yyin);
        system("Pause");
        return 0;
    }
}

int insertarTS(const char *nombre,const char *tipo, const char* valString, int valInt, double valDouble)
{
    t_simbolo *tabla = tablaTS.primero;
    char nombreCTE[32] = "_";
    strcat(nombreCTE, nombre);
    
    while(tabla)
    {
	if(strcmp(tabla->data.nombre, nombre) == 0 || strcmp(tabla->data.nombre, nombreCTE) == 0)
    {
            return 1;
    }
        else if(strcmp(tabla->data.tipo, "CONS_STR") == 0)
        {
            if(strcmp(tabla->data.valor.valor_str, valString) == 0)
            {
                return 1;
            }
        }
        
        if(tabla->next == NULL)
        {
            break;
        }
        tabla = tabla->next;
    }

    t_data *data = (t_data*)malloc(sizeof(t_data));
    data = crearDatos(nombre, tipo, valString, valInt, valDouble);
    
    if(data == NULL)
    {
        return 1;
    }
   
    t_simbolo* nuevo = (t_simbolo*)malloc(sizeof(t_simbolo));

    if(nuevo == NULL)
    {
        return 2;
    }

    nuevo->data = *data;
    nuevo->next = NULL;

    if(tablaTS.primero == NULL)
    {
        tablaTS.primero = nuevo;
    }
    else
    {
        tabla->next = nuevo;
    }

    return 0;
}


t_data* crearDatos(const char *nombre, const char *tipo, const char* valString, int valInt, double valDouble)
{
    char full[50] = "_";
    char aux[20];

    t_data *data = (t_data*)calloc(1, sizeof(t_data));
    if(data == NULL)
    {
        return NULL;
    }

    data->tipo = (char*)malloc(sizeof(char) * (strlen(tipo) + 1));
    strcpy(data->tipo, tipo);

    //Es una variable
    if(strcmp(tipo, "STRING")==0 || strcmp(tipo, "INTEGER")==0 || strcmp(tipo, "FLOAT")==0)
    {
        //al nombre lo dejo aca porque no lleva _
        data->nombre = (char*)malloc(sizeof(char) * (strlen(nombre) + 1));
        strcpy(data->nombre, nombre);
        return data;
    }
    else
    {      //Son constantes: tenemos que agregarlos a la tabla con "_" al comienzo del nombre, hay que agregarle el valor
        if(strcmp(tipo, "CONS_STR") == 0)
        {
            data->valor.valor_str = (char*)malloc(sizeof(char) * strlen(valString) +1);
            data->nombre = (char*)malloc(sizeof(char) * (strlen(valString) + 1));
            strcat(full, valString);
            strcpy(data->nombre, full);    
            strcpy(data->valor.valor_str, valString);
        }
        if(strcmp(tipo, "CONS_FLOAT") == 0)
        {
            sprintf(aux, "%g", valDouble);
            strcat(full, aux);
            data->nombre = (char*)malloc(sizeof(char) * strlen(full));

            strcpy(data->nombre, full);
            data->valor.valor_double = valDouble;
        }
        if(strcmp(tipo, "CONS_INT") == 0)
        {
            sprintf(aux, "%d", valInt);
            strcat(full, aux);
            data->nombre = (char*)malloc(sizeof(char) * strlen(full));
            strcpy(data->nombre, full);
            data->valor.valor_int = valInt;
        }
        return data;
    }
    return NULL;
}

void guardarTS()
{
    FILE* arch;
    if((arch = fopen("ts.txt", "wt")) == NULL)
    {
            printf("\nNo se pudo crear la tabla de simbolos.\n\n");
            return;
    }
    else if(tablaTS.primero == NULL)
            return;
    
    fprintf(arch, "%-30s%-30s%-30s%-30s\n", "NOMBRE", "TIPODATO", "VALOR", "LONGITUD");

    t_simbolo *aux;
    t_simbolo *tabla = tablaTS.primero;
    char linea[100];

    while(tabla)
    {
        aux = tabla;
        tabla = tabla->next;
        
        if(strcmp(aux->data.tipo, "INTEGER") == 0) //variable integer
        {
            sprintf(linea, "%-30s%-30s%-30s%-d\n", aux->data.nombre, aux->data.tipo, "--", strlen(aux->data.nombre));
        }
        else if(strcmp(aux->data.tipo, "CONS_INT") == 0)
        {
            sprintf(linea, "%-30s%-30s%-30d%-d\n", aux->data.nombre, aux->data.tipo, aux->data.valor.valor_int, strlen(aux->data.nombre) -1);
        }
        else if(strcmp(aux->data.tipo, "FLOAT") ==0)
        {
            sprintf(linea, "%-30s%-30s%-30s%-d\n", aux->data.nombre, aux->data.tipo, "--", strlen(aux->data.nombre));
        }
        else if(strcmp(aux->data.tipo, "CONS_FLOAT") == 0)
        {
            sprintf(linea, "%-30s%-30s%-30g%-d\n", aux->data.nombre, aux->data.tipo, aux->data.valor.valor_double, strlen(aux->data.nombre) -1);
        }
        else if(strcmp(aux->data.tipo, "STRING") == 0)
        {
            sprintf(linea, "%-30s%-30s%-30s%-d\n", aux->data.nombre, aux->data.tipo, "--", strlen(aux->data.nombre));
        }
        else if(strcmp(aux->data.tipo, "CONS_STR") == 0)
        {
            sprintf(linea, "%-30s%-30s%-30s%-d\n", aux->data.nombre, aux->data.tipo, aux->data.valor.valor_str, strlen(aux->data.nombre) -1);
        }
        fprintf(arch, "%s", linea);
        free(aux);
    }
    fclose(arch); 
}

void crearTablaTS()
{
    tablaTS.primero = NULL;
}

int existeID(const char* id) 
{
    t_simbolo *tabla = tablaTS.primero;
    char nombreCTE[32] = "_";
    strcat(nombreCTE, id);
    int b1 = 0;
    int b2 = 0;

     while(tabla)
    {
        b1 = strcmp(tabla->data.nombre, id);
        b2 = strcmp(tabla->data.nombre, nombreCTE);
        if(b1 == 0 || b2 == 0)
        {
               return 1;
        }
        tabla = tabla->next;
    }
    return 0;
}

//Comprueba si un id es de tipo numérico
int esNumero(const char* id,char* error)
{
    t_simbolo *tabla = tablaTS.primero;
    char nombreCTE[32] = "_";
    strcat(nombreCTE, id);

    while(tabla)
    {
        if(strcmp(tabla->data.nombre, id) == 0 || strcmp(tabla->data.nombre, nombreCTE) == 0)
        {
            if(strcmp(tabla->data.tipo, "INTEGER")==0 || strcmp(tabla->data.tipo, "FLOAT")==0)
            {
				//Me parece que no toma en cuenta los tipos de las constantes, quizá podríamos quitar esta parte
                return 1;
            }
            else
            {
                sprintf(error,"%s%s%s","Error: tipo de dato de la variable '",id,"' incorrecto. Los tipos permitidos son 'int' y 'float'");
                return 0;
            }
        }
        tabla = tabla->next;
    }
    sprintf(error, "%s%s%s", "Error: no se declaro la variable '", id, "'");
    return 0;
}

char* getTipoId(const char* id) 
{
    t_simbolo *tabla = tablaTS.primero;
    char nombreCTE[32] = "_";
    strcat(nombreCTE, id);
    int b1 = 0;
    int b2 = 0;

     while(tabla)
    {
        b1 = strcmp(tabla->data.nombre, id);
        b2 = strcmp(tabla->data.nombre, nombreCTE);
        if(b1 == 0 || b2 == 0)
        {
               return tabla->data.tipo;
        }
        tabla = tabla->next;
    }
    return NULL;
}

void crearNodoCMP(char * comp){
	comparacionPtr = (tNodo *)crearNodo("CMP",exprCMPPtr,exprPtr);
	comparacionPtr = (tNodo *)crearNodo(comp,comparacionPtr,NULL);
}

/* --- MOVER --- */
tNodo* crearNodo(const char* dato, tNodo *pIzq, tNodo *pDer){
    tNodo* nodo = malloc(sizeof(tNodo));   
    tInfo info;

    info.dato = (char*)malloc(sizeof(char) * (strlen(dato) + 1));
	strcpy(info.dato, dato);
    
    nodo->info = info;
    nodo->izq = pIzq;
    nodo->der = pDer;

    return nodo;
}

tNodo* crearHoja(char* dato,char* tipo){	
    tNodo* nodoNuevo = (tNodo*)malloc(sizeof(tNodo));

    nodoNuevo->info.dato = (char*)malloc(sizeof(char) * (strlen(dato) + 1));
	strcpy(nodoNuevo->info.dato, dato);
	
    nodoNuevo->info.tipoDato = (char*)malloc(sizeof(char) * (strlen(tipo) + 1));
    strcpy(nodoNuevo->info.tipoDato, dato);
    
    nodoNuevo->izq = NULL;
    nodoNuevo->der = NULL;
    
    return nodoNuevo;
}

tArbol * hijoMasIzq(tArbol *p){
    if(*p){
        if((*p)->izq)
            return hijoMasIzq(&(*p)->izq);
        else
            return p;
    }
    return NULL;
}

void enOrden(tArbol *p){
    if (*p)
    {
        enOrden(&(*p)->izq);
        verNodo((*p)->info.dato);
        enOrden(&(*p)->der);
    }
}

void postOrden(tArbol *p){
    if (*p){
        postOrden(&(*p)->izq);
        postOrden(&(*p)->der);
		verNodo((*p)->info.dato);
    }
}

void verNodo(const char *p){
    printf("%s ", p);
}


tPila *crearPila(void)
{
  tPila *stack = malloc(sizeof *stack);
  if (stack)
  {
    stack->tope = NULL;
    stack->tam = 0;
  }
  return stack;
};

tNodo *copiarDato(tNodo *str)
{
  tNodo *tmp =(tNodo*) malloc(sizeof(tNodo));
  if (tmp)
    memcpy(tmp, str,sizeof(tNodo));
  return tmp;
}

void ponerenPila(tPila *theStack, tNodo *value)
{
  tNodoPila *entry = malloc(sizeof *entry); 
  if (entry)
  {
    entry->dato = copiarDato(value);
    entry->next = theStack->tope;
    theStack->tope = entry;
    theStack->tam++;
  }
}

tNodo *topedePila( tPila *theStack)
{
  if (theStack && theStack->tope)
    return theStack->tope->dato;
  else
    return NULL;
}

void sacardePila(tPila *theStack)
{
  if (theStack->tope != NULL)
  {
    theStack->tope = theStack->tope->next;
    theStack->tam--;
  }
}

void vaciarPila( tPila *theStack)
{
  while (theStack->tope != NULL)
    sacardePila(theStack);
}

void borrarPila( tPila **theStack)
{
  vaciarPila(*theStack);
  free(*theStack);
  *theStack = NULL;
}
void _tree_print_dot_subtree(int nro_padre, tNodo *padre, int nro, tArbol *nodo, FILE* stream)
{
    if (*nodo != NULL)
    {    
        fprintf(stream, "x%d [label=<%s>];\n",nro,(*nodo)->info.dato);
        if (padre != NULL){
            fprintf(stream, "x%d -> x%d;\n",nro_padre,nro);
        }   
        _tree_print_dot_subtree(nro, *nodo, 2 * nro + 1, &(*nodo)->izq, stream);
        _tree_print_dot_subtree(nro, *nodo, 2 * nro + 2, &(*nodo)->der, stream);
        
    }
}
void tree_print_dot(tArbol *p,FILE* stream)
{
	fprintf(stream, "digraph BST {\n");
	if (*p)
		_tree_print_dot_subtree(-1, NULL, 0, &(*p), stream);
	fprintf(stream, "}");
}
void llenarGragh(tNodo* padre, FILE *arch, int numNodo) {
    char* string1 = (char*) malloc(sizeof(char) *50);
    char* string2 = (char*) malloc(sizeof(char) *50);
    if(padre == NULL) {
        return;
    }
    int numHI = numNodo*2+1;
    int numHD = numNodo*2+2;
    
    if(padre->izq) {
        sprintf(string1, "%s|%s", padre->info.dato, padre->info.tipoDato);
        sprintf(string2, "%s|%s", padre->izq->info.dato, padre->izq->info.tipoDato);
        fprintf(arch, "\t\"nodo_%d \\n%s\" -> \"nodo_%d \\n%s\"\n", numNodo, string1, numHI, string2);
    }
    if(padre->der) {
        sprintf(string1, "%s|%s", padre->info.dato, padre->info.tipoDato);
        sprintf(string2, "%s|%s", padre->der->info.dato, padre->der->info.tipoDato);
        fprintf(arch, "\t\"nodo_%d \\n%s\" -> \"nodo_%d \\n%s\"\n", numNodo, string1 ,numHD ,string2);
    }
    llenarGragh(padre->izq, arch, numHI);
    llenarGragh(padre->der, arch, numHD);
    return;
}

void escribirGragh(tNodo* padre) {
    FILE *archivo;

	archivo = fopen("gragh.dot", "w");
	if (archivo == NULL) {
		printf("ERROR");
		return;
	}
    //Escribir plantilla para poder dibujar el grafo
    fprintf(archivo, "%s\n", "digraph G {");
    llenarGragh(padre, archivo, 0);
    fprintf(archivo, "%s", "}");
    
    fclose(archivo);
    return;
}
