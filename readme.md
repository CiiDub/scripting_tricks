# Scripting Tricks
A BBEdit package to help with scripting.

I hope to add a fair amount to this. As I use scripts, clippings, text filters and find them worthy I’ll move them into this project.

## Rake Tasks
- __rake package:install__ Installs Scripts, Text Filters, Clippings, and Resources for Scripting Tricks.
- __rake package:remove__ Deletes Installed Package.
- __rake stationery:install__ Installs stationery files into BBEdits Stationery folder.
- __rake stationery:remove__ Deletes installed stationery files.

The best way to install this package is to download/clone it where you might keep projects and install it with the commands above.

You can however download and install it by copying or moving the files manually.

## Text Filters
- __Align Assignments__
This is a text filter that will align a list of assignments to their operators.  

__So it takes this__ ___mad woman's breakfast:___

```
var magic-johnson = "Number one choice"
var oscar-robertson = "Number two choice"
var i-thomas = "Number three choice"
```
__Then makes:__ 

```
var magic-johnson   = "Number one choice"
var oscar-robertson = "Number two choice"
var i-thomas        = "Number three choice"
```

__What it will align:__

```
extern float var_name  = 4.2;  
static string var_name = "I don't move";  
const int var_name     = 299792458; // meters a second
```

__These also (works with a bunch of operators):__

```
name      =   "Livingston"
@this     =   "that"
$way      =   "way back"
Const     =   "antly"  
_valuable =   "name"
foo       :=  "bar"
this      |=  "that"
cat       ||= "what ever I first observed"
```
__This as well:__

```
var jack         = "jumped"  
let jill         = "go to college out of state"  
var jason:Killer = "overrated eighties villain"  
let old:Int      = 42  
this::That       = "dig deep!"  

```

__Processes assignments in groups and respects indention__

```
fun withIndented ( stuff, as, well ) {

	red    = "#FF0000"  
	orange = "#FF3300"  
	blue   = "#175987"  

}

outside = "cold"
inside  = "warm"
florida = "crazy town"

$one = "lonely"
two  = "not so much"

self-quarantined = "I love books"

```


__What it won't:__

```
var b, c int = 1, 2
var c, d string = "s", "x"
let (firstNumber, secondNumber) = (10, 42)
```

## Clippings
Note: You can use the Setup palette to enable or disable clipping groups per language. You can find it under the menu __BBEdit > Setup__.

- __Ruby Clippings__ A set of simplified clippings for ruby.  

- __Scripting Clippings__ to help with scripting in general.
	- __shebang__  
	`#!/usr/bin/env < interpreter >`  
	This works with a script in the Resources folder to try and guess the right interpreter. It’s default (or fallback) is the documents language.  
    
	- __BB_*__
	All of the BBEdit environmental variables wrapped in a single quote string.
    
- __Applescript Clippings__ A little help with AppleScript App. AppleScript, well, it’s better than JXA.
	
	- __path_to__ & __path_to_bbedit__ This will help in dealing with paths. You can convert then to Classic Mac/Finder paths with ` <path> as alias` or convert them to Unix style paths with `POSIX path <var for path>`.
	
		- __path_to__
		`set #INSERTION#_path to ((path to <#?home folder | application support folder | application app#> from user domain) as text) <#? as alias #>`
	
		- __path_to_bbedit__
		`set #SELSTART#bbedit_folder#SELEND# to ((path to application support folder from user domain) as text) & "BBEdit" <#? as alias #>`
	
- __WorkSheet Clippings__ are to be used with Shell/Unix Worksheets. They expand out to useful shell commands.

	- __man_bb__  
	`man < cmd > | col -b | bbedit --view-top -m "UNIX man page"`  
	Executing this will open a Unix man page in a separate BBEdit window with the language set to UNIX man page.  
	My normal color scheme is a dark blue, I have the the Unix Man page language (doc type) set to the standard black and white. If I were really hip it would be yellow with black text.
	I think a lot of folks would like this as addition to their .bashrc, I added it as a function to Fishshell.

	- __cd_pwd__  
	`cd < '/Users/chris/' >; PWD`  
	`cd '/projects/root/dir/'; PWD`    
	`cd < You might want to save. >; PWD`  
	This one finds your working directory and uses it as the input for the `cd` command, followed by `PWD` to display the directory.  
		- If your using BBEdits persistent Unix Worksheet `PWD` will be the current working directory. The default is your home directory. The path to `PDW` will be selected so it can be changed easily.
		- If your working in a BBEdit project the `PWD` is the projects root directory. 
		- If you are using a good ol' Shell Worksheet it's parent directory is the PWD. If the Worksheet isn’t saved it will remind you to save and let you type something in. 
## Scripts
- __List BBEdit Env Variables__ Opens a document with the BBEdit environmental variables listed with their current values.
	
## Stationery
- __Text Filter.rb__ is a starting point to write a text filter in ruby. Text filters the selection ( if present ) or the entire file as input.

- __Menu AppleScript__ is a starting point to write a Menu Script for BBedit. These are scripts that let you prepend, highjack, and/or append to a BBEdit native menu command.

- __Launchd Definition__ ... to make a definition for the launchd demon/agent launcher in macOS ( and sometimes Linux ).
