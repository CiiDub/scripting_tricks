# Scripting Tricks
A BBEdit package to help with scripting.

Just getting started (3/20/20). I hope to add a fair amount to this. As I use scripts, clippings, text filters and Stationery that I like and that help with scripting I’ll add them here.


## Align Operators
This is a text filter that will align you assignments to their operators. 


__What it will align:__

```
extern float var_name  = 4.2;  
static string var_name = “I don't move”;  
const int var_name     = 299792458; // meters a second
```

__These also:__

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
- __Ruby Clippings__ A set of simplified clippings for ruby.

- __Scripting__ Clippings to help with scripting in general.

## Stationery
- __Text Filter.rb__ is a good starting place to write a text filter in ruby. It sets up two loops. One to gather STDIN, line by line, process, and read into an array. One to process and read out to BBEdit. It also has a methed to help with line endings and reading out.

- __Menu Applescript__ is a starting point to write a Menu Script for BBedit. These are scripts that let you prepend, highjack, and/or append to a BBEdit native menu command.