int xt = 100;

void setup()
{
  //size(1000,1000);
  fullScreen();
  background(255);
  stroke(0);
  smithChart();
  loadPixels();
  color[] temp = horizontalFlip(pixels, displayWidth);
  for (int i = 0; i < pixels.length; i++)
  {
    pixels[i] = temp[i];
  }
  updatePixels();
}

void draw()
{
  //background(255);
  //stroke(0);
  //smithChart();
  //color[] temp = horizontalFlip(pixels, width);
  //pixels = temp;
  //updatePixels();
}

color[] horizontalFlip(color[] pixelArray, int imgWidth)
{
  color[] flipped = new color[pixelArray.length];
  for (int y = 0; y < pixelArray.length/imgWidth; y++)
  {
    for (int x = 0; x < imgWidth; x++)
    {
      flipped[x + y*imgWidth] = pixelArray[((imgWidth-x) + y*imgWidth) - 1];
    }
  }
  return flipped;
}

void smithChart()
{
  push();
  translate(xt, height/2);
  for (int y = -height/2; y < height/2; y++)
  {
    for (int x = -xt; x < width-xt; x++)
    {
      Polar p = new Polar(1,0);
      Complex Z0 = new Complex(50, 0);
      Complex ZL = new Complex(x, y);
      Complex gamma = gamma(ZL, Z0);
      p.r = gamma.real;
      p.theta = map(y, -height/2, height/2, 0, 2*PI);
      
      if ((p.r <= 0.875 && p.r >= 0.874) ||(p.r <= 0.85 && p.r >= 0.849) ||(p.r <= 0.75 && p.r >= 0.749) ||(p.r <= 0.8 && p.r >= 0.799) ||(p.r <= 0.7 && p.r >= 0.695) ||(p.r <= 0.99 && p.r >= 0.989) ||(p.r <= 0.09 && p.r >= 0.0855) || (p.r <= 0.1 && p.r >= 0.095) || (p.r <= 0.5 && p.r >= 0.495) || (p.r <= 0.4 && p.r >= 0.395) || (p.r <= 0.6 && p.r >= 0.595) || (p.r <= 0.9 && p.r >= 0.8995))
      {
        point(x,y);
      }
      
    }
  }
  for (int y = -height/2; y < height/2; y++)
  {
    for (int x = -xt; x < width-xt; x++)
    {
      Polar p = new Polar(1,0);
      Complex Z0 = new Complex(50, 0);
      Complex ZL = new Complex(x, y);
      Complex gamma = gamma(ZL, Z0);
      p.r = gamma.imaginary;
      p.theta = map(y, -height/2, height/2, 0, 2*PI);
      
      if (p.r == 0 || (p.r <= 0.14 && p.r >= 0.1398) ||(p.r <= 0.13 && p.r >= 0.1298) ||(p.r <= 0.12 && p.r >= 0.1198) ||(p.r <= 0.11 && p.r >= 0.1098) ||  (p.r <= 0.08 && p.r >= 0.0798) || (p.r <= 0.07 && p.r >= 0.0698) || (p.r <= 0.06 && p.r >= 0.0598) ||(p.r <= 0.05 && p.r >= 0.0498) ||(p.r <= 0.04 && p.r >= 0.0398) || (p.r <= 0.03 && p.r >= 0.0298)||(p.r <= 0.02 && p.r >= 0.0198)||(p.r <= 0.01 && p.r >= 0.0098)||(p.r <= 0.99 && p.r >= 0.98) ||(p.r <= 0.09 && p.r >= 0.0895) || (p.r <= 0.1 && p.r >= 0.0995) || (p.r <= 0.5 && p.r >= 0.495) || (p.r <= 0.4 && p.r >= 0.395) || (p.r <= 0.6 && p.r >= 0.595)|| (p.r <= 0.9 && p.r >= 0.8995))
      {
        point(x,y);
      }
      
    }
  }
  for (int y = -height/2; y < height/2; y++)
  {
    for (int x = -xt; x < width-xt; x++)
    {
      Polar p = new Polar(1,0);
      Complex Z0 = new Complex(50, 0);
      Complex ZL = new Complex(x, y);
      Complex gamma = gamma(ZL, Z0);
      p.r = -gamma.imaginary;
      p.theta = map(y, -height/2, height/2, 0, 2*PI);
      
      if (p.r == 0 || (p.r <= 0.14 && p.r >= 0.1398) ||(p.r <= 0.13 && p.r >= 0.1298) ||(p.r <= 0.12 && p.r >= 0.1198) ||(p.r <= 0.11 && p.r >= 0.1098) ||      (p.r <= 0.08 && p.r >= 0.0798) || (p.r <= 0.07 && p.r >= 0.0698) ||(p.r <= 0.06 && p.r >= 0.0598) ||(p.r <= 0.05 && p.r >= 0.0498) ||(p.r <= 0.04 && p.r >= 0.0398) ||(p.r <= 0.03 && p.r >= 0.0298)||(p.r <= 0.02 && p.r >= 0.0198)||(p.r <= 0.01 && p.r >= 0.0098)||(p.r <= 1 && p.r >= 0.99) ||(p.r <= 0.09 && p.r >= 0.0895) || (p.r <= 0.1 && p.r >= 0.0995) || (p.r <= 0.5 && p.r >= 0.495) || (p.r <= 0.4 && p.r >= 0.395) || (p.r <= 0.6 && p.r >= 0.599)|| (p.r <= 0.9 && p.r >= 0.8995))
      {
        point(x,y);
      }
      
    }
  }
  pop();
}

Complex gamma(Complex zL, Complex z0)
{
  Complex gamma = zL.subtractComplex(z0);
  gamma = gamma.divideComplex(zL.addComplex(z0));
  
  return gamma;
}

class Complex
{
  
  float real, imaginary;
  
  Complex(float _real, float _imaginary)
  {
    real = _real;
    imaginary = _imaginary;
  }
  
  Complex conjugate(Complex input)
  {
    Complex conjugate = input;
    conjugate.imaginary *= -1;
    
    return conjugate;
  }
  
  Complex addComplex(Complex a)
  {
    Complex sum = new Complex(a.real + real, a.imaginary + imaginary);
    
    return sum;
  }
  
  Complex subtractComplex(Complex a)
  {
    Complex difference = new Complex(real-a.real, imaginary-a.imaginary);
    
    return difference;
  }
  
  Complex multComplex(Complex a)
  {
    Complex product = new Complex((a.real * real) + (a.imaginary * imaginary * -1), (a.real*imaginary)+(real*a.imaginary));
    
    return product;
  }
  
  Complex divideComplex(Complex a)
  {
    float denominator = (a.real*a.real) + (a.imaginary*a.imaginary);
    Complex quotient = new Complex(((real*a.real)+(imaginary*a.imaginary))/denominator, ((imaginary*a.real)-(real*a.imaginary))/denominator);
    
    return quotient;
  }
  
  
}
