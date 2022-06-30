int items = 100;
int[] numbers;
boolean shuffling = false;
boolean shuffled = false;
boolean sort = false;
boolean nestedDelay = false;
int algorithm = 1;
int delayTime = 10;

void setup()
{
  size(1300, 730);
  numbers = new int[items];
  initNumbers();
}

void initNumbers()
{
  for(int i = 0; i < numbers.length; i++)
  {
    numbers[i] = (i*height)/items + height/items;
  }
}

void displayGraph()
{
  float w = (float)width/items;
  push();
  for(int i = 0; i < numbers.length; i++)
  {
    float fillColor = map(numbers[i], height/items, (numbers.length-1)*height/items + height/items, 0, 255);
    fill(color(0, 255 - fillColor, fillColor));
    rect(i*w, height - numbers[i], w, numbers[i]);
  }
  pop();
}

void shuffle(int[] array)
{
  for(int i = array.length - 1; i > 0; i--)
  {
    int j = (int)random(array.length-1);
    
    swap(array, i, j);
    delay(delayTime);
  }
  
  shuffling = false;
  shuffled = false;
}

void swap(int[] array, int index1, int index2)
{
  int temp = array[index1];
  array[index1] = array[index2];
  array[index2] = temp;
}

void draw()
{
  background(#1c1c1c);
  fill(255);
  noStroke();
  displayGraph();
  
  if(shuffling && frameCount % 30 == 0)
  {
    if(!shuffled) thread("tShuffle");
  }
  else if(sort && frameCount % 30 == 0)
  {
    thread("tSort");
  }
  
  displayInfo();
}

void displayInfo()
{
  push();
  noStroke();
  fill(255);
  textSize(width/25);
  switch(algorithm)
  {
    case 0: text("Bubble Sort", width/20, height/10); break;
    case 1: text("Insertion Sort", width/20, height/10); break;
  }
  if(sort)
  {
    textSize(width/50);
    text("Sorting...", width/20, height/10 + width/50);
  }
  if(shuffling)
  {
    textSize(width/50);
    text("Shuffling...", width/20, height/10 + width/50);
  }
  if(nestedDelay)
  {
    textSize(width/50);
    text("Nested Delay", width/20, height/10 + 2*width/50);
  }
  textSize(width/50);
  text("Items: " + items, width/3, height/10);
  pop();
}

void tShuffle()
{
  shuffled = true;
  shuffle(numbers);
}

void tSort()
{
  sortingAlgorithm(numbers);
}

void sortingAlgorithm(int[] array)
{
  switch(algorithm)
  {
    case 0: bubblesort(numbers); break;
    case 1: insertionsort(numbers); break;
  }
}

void insertionsort(int[] array)
{
  for(int i = 1; i <= array.length; i++)
  {
    int j = i - 1;
    
    while(j > 0 && array[j - 1] > array[j])
    {
      swap(array, j, j-1);
      j -= 1;
      if(nestedDelay) delay(delayTime);
    }
    if(!nestedDelay) delay(delayTime);
  }
  
  sort = false;
}

void bubblesort(int[] array)
{
  for(int i = 0; i < array.length; i++)
  {
    for(int j = 1; j < array.length-i; j++)
    {
      if(array[j-1] > array[j]) swap(array, j, j-1);
      if(nestedDelay) delay(delayTime);
    }
    if(!nestedDelay) delay(delayTime);
  }
  
  sort = false;
}

void keyPressed()
{
  switch(key)
  {
    case 'r': if(!sort) shuffling = true; break;
    case 's': if(!shuffling) sort = true; break;
    case ' ': if(!sort) algorithm = algorithm == 1 ? 0 : 1; break;
    case 'n': nestedDelay = !nestedDelay; break;
    case 'a': if(!sort && !shuffling) {items = items < width ? items + 10 : items; setup();} break;
    case 'd': if(!sort && !shuffling) {items = items > 10 ? items - 10 : items; setup();} break;
  }
}
