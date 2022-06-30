void setup()
{
  fullScreen();
}

void draw()
{
  background(0);
  stroke(255);
  waves();
}

void waves()
{
  float amp = 100;
  float off = 100;
  float off2 = height-100;
  float inc = 0.01;
  float sample = 2*PI*10;
  float freq = 15;
  //for (float time = 0; time < sample; time += inc)
  //{
  //  float y = sin(time)*amp + off;
  //  point(map(time, 0, sample, 0, width), y);
  //  if (time != 0)
  //  {
  //    line(map(time-inc, 0, sample, 0, width), sin(time-inc)*amp + off, map(time, 0, sample, 0, width), y);
  //  }
  //}
  
  // Amplitude Modulation
  for (float time = 0; time < sample; time += inc)
  {
    float y = sin(time)*amp + off;                     //Tone / 'Voice' signal
    float a = map(y, amp + off, -amp + off, 10, 100);  // Modulated Amplitude
    float y2 = sin(time*freq)*a + height-100;        // Carrier Wave with Modulated Amplitude
    float y3 = sin(time*freq)*amp + height/2;    
    point(map(time, 0, sample, 0, width), y);          // Tone Signal Drawn
    point(map(time, 0, sample, 0, width), y2);         // Modulated Carrier Wave drawn
    point(map(time, 0, sample, 0, width), y3);      
    if (time != 0)                                     // Drawing both waves again but with lines to make it seamless
    {
      line(map(time-inc, 0, sample, 0, width), sin(time-inc)*amp + off, map(time, 0, sample, 0, width), y);
      line(map(time-inc, 0, sample, 0, width), sin((time-inc)*freq)*a + off2, map(time, 0, sample, 0, width), y2);
      line(map(time-inc, 0, sample, 0, width), sin((time-inc)*freq)*amp + height/2, map(time, 0, sample, 0, width), y3);
    }
  }

}
