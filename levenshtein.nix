#// len_s and len_t are the number of characters in string s and t respectively
#int LevenshteinDistance(const char *s, int len_s, const char *t, int len_t)
#{ 
#  int cost;
#
#  /* base case: empty strings */
#  if (len_s == 0) return len_t;
#  if (len_t == 0) return len_s;
#
#  /* test if last characters of the strings match */
#  if (s[len_s-1] == t[len_t-1])
#      cost = 0;
#  else
#      cost = 1;
#
#  /* return minimum of delete char from s, delete char from t, and delete char from both */
#  return minimum(LevenshteinDistance(s, len_s - 1, t, len_t    ) + 1,
#                 LevenshteinDistance(s, len_s    , t, len_t - 1) + 1,
#                 LevenshteinDistance(s, len_s - 1, t, len_t - 1) + cost);
#}

with builtins; rec {
  levenshtein = str1: str2: 
    if stringLength str1 == 0 then stringLength str2
    else if stringLength str2 == 0 then stringLength str1
    else let cost = if lastChar str1 == lastChar str2 then 0 else 1; in
    minList [ 
      ((levenshtein (chop str1) str2) + 1)
      ((levenshtein str1 (chop str2)) + 1)
      ((levenshtein (chop str1) (chop str2)) + cost)
    ];

  lastChar = str: let strLen = stringLength str; in
    substring (strLen -1) strLen str;

  chop = str:  substring 0 (stringLength str - 1) str;

  min = x: y: if x < y then x else y;

  minList = xs: foldl' (acc: x: min acc x) 9223372036854775807 xs;
}
