__What it will align:__

```
extern float var_name  = 4.2;  
static string var_name = “I don't move”;  
const int var_name     = 299792458; // meters a second
```

__This also:__

```
@this     =   "that"  
$way      =   "way back"  
Const     =   "antly"  
name      =   "value"  
_valuable =   "name"  
foo       :=  "bar"
this      |=  "that"
cat       ||= "what ever I first observed"
```
__This as well:__

```
var jack         = "jumped"  
let jill         = "go to college out of state"  
var jason:Killer = "#overrated eighties villain"  
let old:Int      = 42  
this::That       = "dig deep!"  

fun withIndented ( stuff, as, well ) {

	red    = "#FF0000"  
	orange = "#FF3300"  
	blue   = "#175987"  

}
```

__What it won't:__

```
var b, c int = 1, 2  
var c, d string = "s", "x"  
let (firstNumber, secondNumber) = (10, 42)  
```