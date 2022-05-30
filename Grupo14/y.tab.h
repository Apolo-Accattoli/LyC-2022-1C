
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
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

/* Line 1676 of yacc.c  */
#line 186 ".\\Sintactico.y"

int tipo_int;
double tipo_double;
char *tipo_str;



/* Line 1676 of yacc.c  */
#line 146 "y.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;

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

extern YYLTYPE yylloc;

