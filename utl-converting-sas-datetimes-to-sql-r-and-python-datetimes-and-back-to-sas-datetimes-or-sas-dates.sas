%let pgm=utl-converting-sas-datetimes-to-sql-r-and-python-datetimes-and-back-to-sas-datetimes-or-sas-dates;

Converting sas datetimes to sql r and python datetimes and back to sas datetimes or sas dates

SAS date conversions are not covered because the conversion to and from any datetime to sas date is
merely a multiplication or division by the number of seconds in a day (24*60*60=86400);

  FORMULAE

  R SQLDF AND PYTHON PDSQL CONVESION EQUATIONS TO AND FROM SAS DATETIMES

   r_sqldf_datetime      = sas_datetime          - 3653 * 86400
   python_pdsql_datetime = sas_datetime          - 3653 * 86400

   sas_datetime          = r_sqldf_datetime      + 3653 * 86400
   sas_datetime          = python_pdsql_datetime + 3653 * 86400

SOAPBOX ON

Base python complicates data manipulation by introducing special date data types.
Most languages use a reference date? Python date data types are not the same as a number datatype so you
cannot do some arithmetic operations on python date types, you need to learn a new syntax.
Less is more?

This post lets you use 'standard' well known sas, r,sql date syntax to manipulate dates.
Since R and sqllite use the same reference date, the interface to and from sqllite is natural.

SOAPBOX OFF

Note
  sas birthdat                January  01, 1960:00:00 seconds (SAS have 10 years more dates thar sqllite so subtract 3653)
  r base birthday             January  01, 1970:00:00 seconds
  r sqldf birthday            January  01, 1970:00:00 seconds
  python panda sql birthday   January  01, 1970:00:00 seconds
  base python                 no reference date?

Note haven and stattransfer can do automatic conversions
to r datetimes. However I decided to turn automatic conversions off.

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

/**************************************************************************************************************************/
/*                                        |                                                 |                             */
/*             INPUT                      |   PROCESS                                       |       OUTPUT                */
/*             =====                      |   =======                                       |       ======                */
/*                                        |                                                 |                             */
/*  SD1.HAVE                              | Exactly the same code in Python                 | > R_SQLDF_DATETIME          */
/*                         SAS_           | pdsql and r sqldf                               |                             */
/*     SAS_DATETIMEC     DATETIME         |                                                 |      R_SQLDF_DATETIME       */
/*                                        |                                                 |                             */
/*  2020-12-02T18:02:00 1922551320        | to convert a sas datetime                       |            1606932120       */
/*                                        | to sqldf datetime in r or python sql            |                             */
/*                                        |                                                 |        R_SQLDF_DATETIMEC    */
/* options validvarname=upcase;           | r_sqldf_datetime     =sas_datetime-3653*86400   |                             */
/* libname sd1 "d:/sd1";                  | python_pdsql_datetime=sas_datetime-3653*86400   |      2020-12-02T18:02:00    */
/* data sd1.have;                         |                                                 |                             */
/*  sas_datetimec='2020-12-02T18:02:00';  | perform your datetime or date                   |                             */
/*  sas_datetime='2020-12-02T18:02:00'dt; | manipulations                                   | > BACK_TO_SAS_DATETIME      */
/* run;quit;                              |                                                 |                             */
/*                                        | to convert back to sas datetime or date         |      BACK_TO_SAS_DATETIME   */
/*                                        |                                                 |                             */
/*                                        | sas_datetime=r_sqldf_datetime+3653*86400        |          1922551320         */
/*                                        | sas_datetime=python_pdsql_datetime+3653*86400   |                             */
/*                                        |                                                 |      BACK_TO_SAS_DATETIMEC  */
/*                                        | sas datetime to r datetime                      |                             */
/*                                        |                                                 |        2020-12-02T18:02:00  */
/*                                        |                                                 |                             */
/*                                        | SAS DATETIME TO AND FROM PYTHON AND R           |                             */
/*                                        | =====================================           |                             */
/*                                        |                                                 |                             */
/*                                        |  SAS DATETIME TO R DATETIME                     |                             */
/*                                        |                                                 |                             */
/*                                        |  select                                         |                             */
/*                                        |     sas_datetime-3653*86400 as r_sqldf_datetime |                             */
/*                                        |    ,strftime("%Y-%m-%dT%H:%M:%S"                |                             */
/*                                        |       ,sas_datetime-3653*86400                  |                             */
/*                                        |       ,"unixepoch") as r_sqldf_datetimec        |                             */
/*                                        |  from                                           |                             */
/*                                        |     have                                        |                             */
/*                                        |                                                 |                             */
/*                                        |  R DATATIME BACK TO SAS DATETIME                |                             */
/*                                        |                                                 |                             */
/*                                        |  select                                         |                             */
/*                                        |     r_sqldf_datetime+3653*86400                 |                             */
/*                                        |      as  back_to_sas_datetime                   |                             */
/*                                        |    ,strftime("%Y-%m-%dT%H:%M:%S"                |                             */
/*                                        |       ,r_sqldf_datetime                         |                             */
/*                                        |       ,"unixepoch") as back_to_sas_datetimec    |                             */
/*                                        |  from                                           |                             */
/*                                        |     r_sqldf_datetime                            |                             */
/*                                        |                                                 |                             */
/**************************************************************************************************************************/

options validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;
 sas_datetimec='2020-12-02T18:02:00';
 sas_datetime='2020-12-02T18:02:00'dt;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  SD1.HAVE total obs=1                                                                                                  */
/*                                                                                                                        */
/*                                   SAS_                                                                                 */
/*  Obs       SAS_DATETIMEC        DATETIME                                                                               */
/*                                                                                                                        */
/*   1     2020-12-02T18:02:00    1922551320                                                                              */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*                    _     _  __
/ |  _ __   ___  __ _| | __| |/ _|
| | | `__| / __|/ _` | |/ _` | |_
| | | |    \__ \ (_| | | (_| |  _|
|_| |_|    |___/\__, |_|\__,_|_|
                   |_|
*/

%utl_rbeginx;
parmcards4;
library(haven)
library(sqldf)
source("c:/oto/fn_tosas9x.R")
have<-read_sas("d:/sd1/have.sas7bdat")
have
r_sqldf_datetime <- sqldf('
    select
       sas_datetime-3653*86400  as  r_sqldf_datetime
      ,strftime("%Y-%m-%dT%H:%M:%S"
         ,sas_datetime-3653*86400
         ,"unixepoch") as r_sqldf_datetimec
    from
       have
    ')
r_sqldf_datetime
back_to_sas_datetime<- sqldf('
    select
       r_sqldf_datetime+3653*86400
        as  back_to_sas_datetime
      ,strftime("%Y-%m-%dT%H:%M:%S"
         ,r_sqldf_datetime
         ,"unixepoch") as back_to_sas_datetimec
    from
       r_sqldf_datetime
    ')
back_to_sas_datetime
fn_tosas9x(
      inp    = back_to_sas_datetime
     ,outlib ="d:/sd1/"
     ,outdsn ="back_to_sas_datetime"
     )
;;;;
%utl_rendx;

data back_to_sas;
  set sd1.back_to_sas_datetime;
    back_to_sas_datetimec=put (back_to_sas_datetime, E8601DT.);
run;quit;

proc print;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  SAS DATETIME TO R DATETIME                                                                                            */
/*                                                                                                                        */
/*  R_SQLDF_DATETIME            R_SQLDF_DATETIMEC                                                                         */
/*                                                                                                                        */
/*        1606932120          2020-12-02T18:02:00                                                                         */
/*                                                                                                                        */
/*                                                                                                                        */
/*  R DATETIME TO SAS DATETIME                                                                                            */
/*                                                                                                                        */
/*  BACK_TO_SAS_DATETIME    BACK_TO_SAS_DATETIMEC                                                                         */
/*                                                                                                                        */
/*        1922551320          2020-12-02T18:02:00                                                                         */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*___                _   _                             _           _
|___ \   _ __  _   _| |_| |__   ___  _ __    _ __   __| |___  __ _| |
  __) | | `_ \| | | | __| `_ \ / _ \| `_ \  | `_ \ / _` / __|/ _` | |
 / __/  | |_) | |_| | |_| | | | (_) | | | | | |_) | (_| \__ \ (_| | |
|_____| | .__/ \__, |\__|_| |_|\___/|_| |_| | .__/ \__,_|___/\__, |_|
        |_|    |___/                        |_|                 |_|
*/

proc datasets lib=sd1 nolist nodetails;
 delete pywant;
run;quit;

%utl_pybeginx;
parmcards4;
exec(open('c:/oto/fn_python.py').read());
have,meta = ps.read_sas7bdat('d:/sd1/have.sas7bdat');
r_sqldf_datetime = pdsql('''                          \
    select                                            \
       sas_datetime-3653*86400  as  r_sqldf_datetime  \
      ,strftime("%Y-%m-%dT%H:%M:%S"                   \
         ,sas_datetime-3653*86400                     \
         ,"unixepoch") as r_sqldf_datetimec           \
    from                                              \
       have                                           \
    ''')
print(r_sqldf_datetime)
back_to_sas_datetime= pdsql('''                       \
    select                                            \
       r_sqldf_datetime+3653*86400                    \
        as  back_to_sas_datetime                      \
      ,strftime("%Y-%m-%dT%H:%M:%S"                   \
         ,r_sqldf_datetime                            \
         ,"unixepoch") as back_to_sas_datetimec       \
    from                                              \
       r_sqldf_datetime                               \
    ''')
print(back_to_sas_datetime)
;;;;
%utl_pyendx;

proc print data=sd1.pywant;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* SAS DATETIME TO PYTHON                                                                                                 */
/*                                                                                                                        */
/*     R_SQLDF_DATETIME    R_SQLDF_DATETIMEC                                                                              */
/*                                                                                                                        */
/*  0      1.606932e+09  2020-12-02T18:02:00                                                                              */
/*                                                                                                                        */
/*                                                                                                                        */
/*                                                                                                                        */
/* PYTHON TO SAS DATETIME                                                                                                 */
/*                                                                                                                        */
/*     BACK_TO_SAS_DATETIME BACK_TO_SAS_DATETIMEC                                                                         */
/*                                                                                                                        */
/*  0          1.922551e+09   2020-12-02T18:02:00                                                                         */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
