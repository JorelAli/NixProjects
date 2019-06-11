with builtins; rec {
  isComplex = x: hasAttr "re" x && hasAttr "im" x;

  conjugate = {re, im} @ x: assert isComplex x; { 
    inherit re;
    im = (-1) * im;
  };

  addComplex = x: assert isComplex x; y: assert isComplex y; {
    re = (x.re + y.re); 
    im = (x.im + y.im);
  };

  subComplex = x: assert isComplex x; y: assert isComplex y; {
    re = (x.re - y.re);
    im = (x.im + y.im);
  };

  mulComplex = x: assert isComplex x; y: assert isComplex y; {
    re = (x.re * y.re) - (x.im * y.im);
    im = (x.re * y.im) + (x.im + y.re);
  };

  divComplex = x: assert isComplex x; y: assert isComplex y; 
    let y' = conjugate y; in
      let 
        num = (mulComplex x y');
        den = (mulComplex y y').re;
      in 
      {
        re = (num.re / den);
        im = (num.im / den);
      };
}




