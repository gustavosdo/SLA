
# Defining alias for as.character
ac = function(x){as.character(x)}

# Defining alias for as.numeric
an = function(x){as.numeric(x)}

# Defining function to determine if the year is bissextile
isBissextile = function(x){
  char_x = ac(x)
  if ( xor ( (substr(char_x, 3, 4) == '00') & ((x %% 400) == 0) , (substr(char_x, 3, 4) != '00') & ((x %% 4) == 0)) )
  {
    return(T)
  } else {
    return(F)
  }
}
