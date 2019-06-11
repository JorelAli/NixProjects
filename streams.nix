with builtins; rec {

  # stream :: (a -> a) -> Stream
  stream = f: { stream = f; };

  # take :: a -> Stream -> [a]
  take = n: stream: 
    if n == 0 then []
    else (take (n - 1) stream) ++ [(stream.stream n)];

  # sZipWith :: Stream -> Stream -> (a -> a -> a) -> Stream
  #
  # Example:
  #   sZipWith (stream (n: n*n)) (stream (n: n)) (s1: s2: s1+s2)
  #   => stream (n*n + n)
  sZipWith = {stream} @ stream1: {stream} @ stream2: f:
    { stream = n: f (stream1.stream n) (stream2.stream n); };
  
}
