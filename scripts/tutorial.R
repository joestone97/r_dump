#NOTE 1:
#In Rstudio make sure to turn on "soft wrap" on, it's in the code drop down.
#it will make the comments easier to read.

#NOTE 2:
#Use the "Document Outline" in the top right corner of this screen to navigate 

#IMPORTANT: ALL INFORMATION IS PROBABLY FROM STACKOVERFLOW, BLOGS, OR THE BOOKS BELOW!
#Almost none of it is my original content, I've just added to this some of what I've learnt
#to keep a record for myself, for Keyvan's reference, and now for sharing at a Tech Talk:
#- R for Data Science : https://r4ds.had.co.nz
#- Advanced R : https://adv-r.hadley.nz 
#- Advanced R Solutions :  https://advanced-r-solutions.rbind.io/index.html
#- Introduction to Spatial Data Programming with R: https://geobgu.xyz/r/index.html#spdep-example
#- Dr Rodger Bivand's works (lead author of Maptools) : https://orcid.org/0000-0003-2392-6140
#- Spatial Data Science - https://r-spatial.org/book/

#This is the last multiline comment as I'm lazy.
# Joseph Stone - Spatial Software Engineer / Masters of Data Science Student

#1: DATA  ######################################################################
## Types =======================================================================
### Character ------------------------------------------------------------------
variable_name <- "character"
variable_name <- 'character'

### Numeric --------------------------------------------------------------------
variable_name <- 1
variable_name <- 1.0

### Integer --------------------------------------------------------------------
variable_name <- 1L

### Logical --------------------------------------------------------------------
variable_name <- TRUE
variable_name <- FALSE

### Raw/Complex (haven't used once) --------------------------------------------
#dont see much value outside of math

### Note on NA/NULL ------------------------------------------------------------
variable_name <- NA #A logical variable that holds it's value. returns NA if evaluated in an expression.
variable_name <- NULL #Not allowed in a vector. Is returned from a list if the name you're using doesn't exist. Example below

## Structures ==================================================================
### List -----------------------------------------------------------------------
variable_name <- list(1,"character",TRUE)
print(variable_name)

#they can be named
variable_name <- list("first element"=1,"second element"="character")
print(variable_name)

### Vector ---------------------------------------------------------------------
#How to create sequences of numbers
variable_name <- c(1,2,3,4,5)
variable_name <- 1:5 #defaults to int data type
variable_name <- rep(1,5)
variable_name <- seq(from=2,to=10,by=2)

#data types
variable_name <- c(1L,2L,3L,4L,5L)
variable_name <- c(1,2,3,4,5)
variable_name <- c(TRUE,FALSE,TRUE,FALSE,TRUE)
variable_name <- c("character1","character2")

#dynamically changing data types
variable_name <- c(TRUE,FALSE)
print(variable_name)
print(class(variable_name))

variable_name <- c(variable_name,1L)
print(variable_name)
print(class(variable_name))

variable_name <- c(variable_name,1.1)
print(variable_name)
print(typeof(variable_name))

variable_name <- c(variable_name,"character")
print(variable_name)
print(typeof(variable_name))

#usefulness of vectors
variable_name <- c(1,2,3,4)

variable_name * 2
paste(variable_name,"character") 
variable_name + c(10,1,10,1)
#recycling rules exist
variable_name + c(10,1,2) #error 4 to 3
variable_name + c(10,1) #fine as 4 to 2 becomes 4 to 4 dynamically

### Factor ---------------------------------------------------------------------
# I've only really had to to use them for statistics.  They're good for categorical data and for visualisation/stats. I only mention them as when you're importing base dataframes character (ie string) columns can default to a factor. Read this blog to see what someone passionate about them says: https://blog.exploratory.io/why-factor-is-one-of-the-most-amazing-things-in-r-e967fe27d292

variable_name <- factor(c("one","two","two","two","one"))

### Matrix ---------------------------------------------------------------------
#look I'm gonna skip over this and array's as I use dataframes. One thing to note is the whole matrix has the same data type, which follows the same rules described in the vector section. Although this might be used by raster processing packages.
variable_name <- matrix(1:12,nrow=3)
variable_name
variable_name <- rbind(variable_name, c(1,2,3,"4")) 
variable_name

### Data frames/tables/tibbles -------------------------------------------------
#base = data.frame()
variable_name = data.frame("numbers" = c(1,2,3,4),"letters" = c("a","b","c","d"))

#tidyverse = tibble()
variable_name = tibble("numbers" = c(1,2,3,4),"letters" = c("a","b","c","d"))
  #never converts datatypes (e.g. character to factor)
  #never changes variable names
  #recycling rules are different
  #printing is different
  #syntax is more verbose but easier to read
  #stricter subsetting rules create consistency

#data.tables
#won't go into them here. But they're faster, so might be worth considering with big data. Note for me - Look into integration with distributed computing providers as there's no "dask", read https://therinspark.com

#2. PACKAGE MANAGEMENT AND USAGE ###############################################
## Installation ================================================================
#be careful using install.packages() if you're working on an old machine that's had R installed for a while... I've spent a day troubleshooting an obscure bug caused by accidentally updating a package.
install.packages("tibbles")

devtools::install_version() #to install specific versions or from somewhere other than CRAN

## Importing (attaching/loading) ===============================================
### Basics (attaching) ---------------------------------------------------------
library(dplyr)
require(dplyr) #returns warning if package not installed, rather than error. 

### Verbose method (loading) ---------------------------------------------------
# you can use a single function by declaring the package before. Useful if there's a clash of function names between packages. You can just declare which package you want to use. There are ways to load only some functions from a package (like python's  'from ... import x,y,z' function), but I've never used it in R as I've never had a problem with load speed. I think it's because R has an 'autoload environment' which delays the loading of large objects until they're called, but might be wrong.
dplyr::add_count()

###Similar to "Beyond the python file" -----------------------------------------
#noted if you're doing this then it's nice to prefix the functions with an alias so you dont have to do the pythonic iport approach of using an alais
source("/Users/joestone/Documents/kevins/r_function1.R")


### importing as alias -----------------------------------------------------------
#only do it if you're running into lots of conflicts, but if you are you should probably be thinking why and using the verbose method.
install.packages("import")
sf <- import::from(sf, .all=TRUE, .into={new.env()})

### Importing from github --------------------------------------------------------
library(devtools)
source_url("https://raw.githubusercontent.com/joestone97/r_dump/main/scripts/r_function2.R")


#3. OPERATORS ##################################################################
#skipped over a lot as they're intuitive

## Assignment ==================================================================
#READ AGAIN AFTER THE FUNCTIONS SECTION IF YOU'RE CONFUSED
### The funny (but useful) list ------------------------------------------------
x<-1
x=1
1->x
assign("x",1)
x<<-1
1->>x

#yes that means this is valid...
x <- 1 -> y

### Why do people use "<-" rather than "=" ? -----------------------------------
#Short story: the arrow was introduced first, and it will ALWAYS assign a variable
#Long story: People online will complain about different scoping rules or something, when realistically it's an edgecase that no one will ever notice. but this will illustrate their argument
x<-""
variable_name <- 1:10
mean(x=variable_name) 
#check the global environment now and you should see x=="", not x==1:10. That's because during the calling of the mean() function the "=" call is telling mean() what the value of the "x" argument should be, not assigning a value to the x variable. 
mean(x<-variable_name) #this both calls the function with x, and assigns a new value to x... Cool, but no one ever wants to do that.

### Assignment v super assignment (<- v <<-) -----------------------------------
#The <- operator always assigns a variable in the environment it was called.
x <- 1
function_name <- function(){
  #a function has it's own environment
  x <- 2
}
function_name
x
#When the function was called x == 2 in the function's environment, but in the global environment it was and still is: x == 1

#An over simplification is that the super assignment operator ("<<-") lets you assign a variable outside of the current scope. I use it in functions if im performing a complex analysis/transformation and the intermediary data may be interesting. Think of the times you've done a complex workflow in QGIS/Arcmap and then shown someone the output of a middle step even though they only need the final output. This helps with that. The R community says it's bad practice but that narrow view means you're not using a useful tool, it can be used wrong, but it's great as long as you have a naming convention in your global environment so you dont accidentally overwrite something useful (like prefixing with funint_). 
#More detailed: <<- changes a value in the parent environment, but if the variable doesn't exist in the parent environment, it checks the next parent environment and so on. Finally if will reach the global environment and it assigns there. The variable can still can be used in the current scope though due to lexical scoping. See below if you're interested

#The following shows the output can still be used despite assigning to the global environment, as the output to the console is 10, meaning the anonymous function returned 10, which was in turn assigned to x and returned from the encapsulating function.
function_name <- function(){
  #a function has it's own environment
  x <- (function() y <<-10)()
  return(paste("output =",x))
}
function_name()

#The following shows a function with two nested anonymous functions, and an assignment of z<-0 in the global environment. The first function assigns z <- 1 in the function's enviroment. Then calls an "empty" anonymous function that has nothing in it besides calling/encapsulating another anonymous function. The most nested function then calls z <<- 100 (the mess begins). Z is not assigned in the immediate parent environment as it's just a blank environment with no z to replace, then it checks the next parent and finds z<-1 and replaces it with 100. The z is then returned from the outermost function. Notice that in the global environment z == 0 still. The super assignment didn't get that far... 
z <- 0
z
function_name2 <- function(){
  z<-1
  print(z)
  (function() (function() z <<-100 )())()
  return(paste("output: =",z))
}
function_name2()

## "Not"  ======================================================================
variable_name != 10

variable_name <- c(1,2,3,4,5)
variable_name[!variable_name ==2]

## or/and ======================================================================
variable_name = 11:1


variable_name == 10 & variable_name == 11 #returns a vector
variable_name == 10 | variable_name == 11
variable_name == 10 || variable_name == 11 #evaluates first element of a vector

## %in% 
1 %in% 1:5

#4. FUNCTIONS ##################################################################
## General syntax ==============================================================

function_name <- function(variable_name=10) {
  variable_name <- variable_name+1
  return(variable_name)
}
#... usage
function_name <- function(variable_name=10,...) {
  variable_name <- list(variable_name,...)
}

## Anonymous functions =========================================================
#they wont appear in the document outline automatically
(function(x) x ^ 3)(10) #think python's lambda function

## Infix functions =============================================================
#when you want the function to sit between two variables. Use backticks and percentage around whatever you want to use to call the function)
`%+%`<- function(a,b)paste(a,b,collapse='\n',sep=" Stone ")
cat("Joe" %+% c("has impressive and useless R knowledge",
                "is talking WAAAY to fast (it's a habit)",
                "is boring"))

`%notin%` <- function(a,b) !a %in% b

#Note I've ignored at least one other function creation method (might be more, i dunno) as it's confusing.

#5. NAME FOR SYNTAX THAT CONTROLS FLOW?  #######################################
## if/else statements  =========================================================
### Basic syntax ---------------------------------------------------------------
if ( test_expression1) {
  statement1
} else if ( test_expression2) {
  statement2
} else {
  statement4
}
#Note: In my opinion the syntax (lack of tabs) makes it hard to read nested if statements (ie when you put an if statement inside a statement section above). So just create complex test expressions and comment what they mean in the first line of the statement. 

### Similar to pythons single line syntax --------------------------------------
variable_name <- 1
if (variable_name == 1) "yep that's right" else "nope"

### ifelse() -------------------------------------------------------------------
variable_name <- 1:10
ifelse(variable_name %in% 1:5,variable_name*10, 0) #equivalent is list comprehension in python

## switch ========================================================================
#note really a fan, but seem to be used in symbolising plots. you could use it for replacing values in a vector to make an ETL pipeline more traceable when cleaning data. Just chucked the bottom section together to remind myself. I like it now.
expression <- "val1"
answer<- switch(expression,"val1"="x","val2"="y")

variable_name <- rep(c('var1',"var2","var1","var3"),100000/4)
vectorised_switch <- Vectorize(vectorize.args = "x",
          FUN = function(x) {
            switch(as.character(x),
                   "var1" = "x",
                   "var2" = "y",
                   "other")})
test <- vectorised_switch(variable_name)
test <- ifelse(test== "other",names(test), test) #revert the "other" values

## iteration  ====================================================================
###for -------------------------------------------------------------------------
variable_name <- c("a","b","c")
for(el in variable_name){
  print(el)
}

###while -----------------------------------------------------------------------
variable_name <- 2
while(variable_name != 1){
  variable_name <- 1
}

###repeat/break/next -----------------------------------------------------------
repeat{
  break
  next
}

### functions ------------------------------------------------------------------
#basically if you're looping then the for loop is slow as it's iterating at the R level. The apply and map functions are written in a lower level language (probably C or C++), so they're faster. However, they're a bit of a pain to remember.
#apply functions < map functions
lapply(x, function) #takes vector,list, or df and returns a list
sapply(x,function) #like lapply but returns vector
vapply/tapply/apply

#Note 1: If you're going to the effort of learning these, then instead learn the purrr::map functions. They have a more similar syntax and format to other languages (like python), apparently cater for edgecases that cause bugs more, but more importantly you can use purr::safely(). When you run a "for loop" you see the results up to an error, which is great for troubleshooting a bug. The apply/map functions just shit themselves and you'll only have a traceback rather than the results leading up to the error. 
#Note 2: It's worth learning these (I'm a hypocrite), as it lets you easily add some form of parallelisation into your workflow (not much though). Pretty friendly by using the parrallel:mclapply or parallel:mcMap()

#6. SUBSETTING RULES ###########################################################
#Base
## [] (preserves data type) =====================================================
variable_name <- 1:10

#using an expression (actually just a logical vector)
variable_name[variable_name==2]

#using an index
variable_name[2]

#using row/column
variable_name = data.frame("numbers" = c(1,2,3,4),"letters" = c("a","b","c","d"))
variable_name
variable_name[1,2] #[row,column]

#always returns the data type of the variable you are subsetting
variable_name <- list(1:3,"string")
variable_name[1] #even though the first element is a vector, it returns a list of length 1, which contains the vector.
## [[]] simplifies data type====================================================
variable_name[[1]] #returns the vector
## $ ===========================================================================
# used to return subset by name (e.g. column).  Dont use it in base R for subsetting as partial matching can cause bugs. Use [["character"]] or ["character"] depending on whether you want data structures preserved. However! if you're using environments and objects then you'll use it, but it wont feel like subsetting. 

## list subsetting note ========================================================
#this is why I dont tend to use named lists. Look at the output. then look at how many typos there are in the comments
variable_name <- list("first element"=1,"second element"="character")
print(variable_name)

variable_name[[3]]
variable_name[["third element"]]


## Tidyverse ===================================================================
#as mentioned in the tibbles section there are constraints placed on tibbles (a core data structure) in the Tidyverse. The constraints make the subsetting rules a little more consistent with what subsetting returns.



#7.  REPLICATING MINOR PYTHON CONVENIENCES    ##################################
## Dictionaries  ===============================================================
#dictionary functionality can be used through the dict package as it would in python. However, lists can be named in R, providing the same functionality (iterating with keys and values is a little different as there's no shorthand).

#You could even create your own environments instead. I won't go into them as I've read into them, but haven't used them in practice. I was mainly interested when looking into how to break scope (out of interest). Unlike most objects in R, which are copy-on-modify (new memory is assigned when a variable is modified), environments are not copied when they are modified. 

## f-strings ===================================================================
variable_name <- "audience"
variable_name2 <- "bored or confused"

#base
sprintf("The %s is probably %s by this point",variable_name,variable_name2)

#external
install.packages("glue")
library("glue")
glue("The {variable_name} is probably {variable_name2} by this point")

#8. OOP ########################################################################

## S3 ==========================================================================
#Only some notes, the reference material is in the Advanced R book. Honestly I prefer the JS/TS approach (might just be because that's what I learnt first and this version of OOP is very different. I found these topics vaguely explained and confusing (research when I have more time): concept of a generic, method dispatch, method creation, inheritance
variable_name <- structure(list(),class="joeclass")
#or
variable_name <- list()
class(variable_name) <- "joeclass"

#checking a class
class(variable_name)

#check if an object is an instance of a specific class
inherits(variable_name,"joeclass")

### Constructor ----------------------------------------------------------------
#creates new objects with the correct structure
new_joeclass <- function(x=character()){
  stopifnot(is.character(x))
  structure(x, class = "joeclass")
}

### Validator ------------------------------------------------------------------
#performs checks to ensure that the object has correct values
validate_joeclass <- function(x){
  if (!all(!is.na(x) & is.character(x) & !length(x)<1)){
    stop(
      "All values must be a character with a length greater than 1",
      call. = FALSE
    )
  }
  x
}

### Helper ---------------------------------------------------------------------
#convenient way for others to create objects of your class
joeclass <- function(x){
  x <- as.character(x)
  validate_joeclass(new_joeclass(x))
}

### Methods  -------------------------------------------------------------------
#Not really sure how this works yet, but
my_new_generic <- function(x) {
  UseMethod("my_new_generic")
}
?UseMethod

g <- function(x) {
  x <- 10
  y <- 10
  UseMethod("g")
}
g.default <- function(x) c(x = x, y = y)
x <- 1
y <- 1
g(x)

## R6  =========================================================================
install.packages("R6")
library(R6)
?R6Class()

### class declaration-----------------------------------------------------------
#arg1 = name (not necessary), arg2 = list of methods and properties --
testR6 <- R6Class("testr6", list(
  pros = c(),
  cons = c(),
  initialize = function(pros, cons = NA) {
    stopifnot(is.character(pros), length(pros) >= 1)
    self$pros <- pros
    
    self$cons <- c("",cons)
  },
  print = function(...) {
    cat("First R6 test: \n")
    cat("  Pros: ", self$pros, "\n", sep = "")
    cat("  Cons: ", self$cons, "\n", sep = "")
    invisible(self)}
))

#instantiation? ----------------------------------------------------------------
testinstantiation <- testR6$new("seems more familiar","not idiomatic")
testinstantiation

#add methods/properties to classes after declaration----------------------------
testR6$set("public","do_like_this","no") #at least you cant edit the properties/methods pre-existing, but it means you cant edit the default print either

testinstantiation2 <- testR6$new("seems more familiar","not idiomatic")
testinstantiation2$do_like_this

#$copy() to copy
#$finalise() is ran to delete using a method and unlink(self$property/method)

## S4 (practice with S3 first) =================================================

## RC ==========================================================================
#9. SPATIAL ####################################################################
## Integration =================================================================
### Bloody ESRI ----------------------------------------------------------------

#packages:
#rpygeo - which uses reticulate to use arcpy
#some gimmicky bridge thing which does half a job
#https://www.esri.com/en-us/arcgis/products/r-arcgis-bridge/overview
#https://highered-esricanada.github.io/r-arcgis-tutorials/1-Getting-Started.pdf

#can't test at CF or bayside. But from what I see I dont like the ESRI integration, it seems a little gimmicky to be able to pass the data from esri to R and back, using their promoted package, but to not have access to any of the tools through the same package. Yes it's a good way to be able to access data. But I really dont like the reticulate method of accessing arcpy etc as most users will have to learn python as well, so it's not accessible. It's probably just because they cant figure out how to integrate licensing into the bridge,  


### FME ------------------------------------------------------------------------
#I do not recommend integrating R with FME. I've done it for climate friendly and the set up was fiddly (but not difficult) in FME Server, in workbench I had no issues once I knew what I was doing. In my experience, when it came to standalone code it was fine, it was even fine if you were saving local files from your workbench then triggering an R script which was reading the files. However, I was asked to not write to local files and clean up later, and it was way too fiddly to get the Rcaller transformer to input spatial data to the script. I realised midway through I could just recreate the R script section of the process in FME and it would be more maintainable for others, take around the same time as all the set up I'd done, and be less of a headache. 


### QGIS -----------------------------------------------------------------------
#Compared to ESRI there's amazing integration available. Only limitation is that you probably cant make plugins. That'll probably require QT, which is python based.

#1. Example of embedding scripts into QGIS directly and having variables entered via the normal UI:
#https://www.aspexit.com/link-r-and-qgis-integrate-your-own-r-algorithms-in-qgis/

#2. qgisprocess : lets you use the QGIS tools in R

### Google Earth Engine --------------------------------------------------------
#rgee (API to download data)
#https://www.css.cornell.edu/faculty/dgr2/_static/files/R_html/ex_rgee.html

### DEA ------------------------------------------------------------------------
#I can probably load the webmaps, but there isn't an R equivalent to the python scripts accessing the data cube. 
#https://docs.dea.ga.gov.au/notebooks/Tools/index.html
#https://gis.stackexchange.com/search?q=open-data-cube

## Vector ======================================================================
#The main vector processing package now, most of the functions follow a familiar format as PostGIS. The cheatsheet is here: https://github.com/rstudio/cheatsheets/blob/main/sf.pdf.
#History: SP (another package) used to be the main package for vector processing, it's based on objects and a little less readable. It also doesn't have the benefits of being Tidyverse compatible. 
#Vector package usage: Basically for new code use SF, legacy code will likely be in SP but you can convert to SF using the code below. HOWEVER, when I was doing vector processing on insanely large datasets for CF (a polygonised NCAS Forest Cover and all lot boundaries over a specific area in each state) performing the equivalent of QGIS's dissolve by field was incredibly slow. In those situations it helps to know other packages like SP, maptools, and rgdal. However, I've removed all the code for rgdal and maptools as theose packages are being retired (https://r-spatial.org/r/2022/04/12/evolution.html). I may be jumping the gun though as there's currently active devleopment on an rgdal2 package. 

st_read(shp, quiet = TRUE, type = 3) #use the type number to specify the geometry type read in (e.g. geometrycollection,multipolygon,polygon). cant remember when I used this 

#Convert SP to SF
as.sf(variable_name)

#convert SF to SP
as(variable_name, "SpatialPolygonsDataFrame")

#sftime: for spatiotemporal analytics of vector data
#https://r-spatial.org/r/2022/04/12/sftime-1.html

#sfdbi: for spatial database

## Raster ======================================================================
  #terra (essentially replacement for the raster package, but can convert to raster in the case of compatibility issues)

  #stars - uses: time series analysis, cubed data, and lost link showing how to use it for visualisations of changes between years (but it looked cool)

## Look Into Usage of Following Analytics ======================================
  #rgeoda - clustering analyticsde
  #spdep/sfdep - spatial autocorrelation 

## Visualising  ================================================================
  ## tmap/mapview/mapsf/ggplot2 ================================================


## WFS =========================================================================
#Old scripts are stored on desktop computer in CF backup


#9. USEFUL APPLICATIONS  #######################################################
## R notebook ==================================================================

## R markdown ==================================================================
## R Documentation =============================================================

## R HTML ======================================================================
## R Sweave ====================================================================
## knitr =======================================================================
## Shiny web app ===============================================================
## R Plumber API  ==============================================================
## R swirl =====================================================================

