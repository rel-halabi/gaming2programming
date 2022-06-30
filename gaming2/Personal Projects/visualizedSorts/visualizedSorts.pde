int pillars = 1280;
int[] numbers;
color[] colors;
boolean sorted = false;
boolean delayOnSwap = false;
int sortingAlgorithm = 0; // 0: Bubble Sort, 1: Insertion Sort
int delay = 100;

boolean started = false;
void keyPressed() {if(key == ' ') started = true;}
void setup()
{
  size(1280, 720);
  numbers = generateRandomArray(pillars, 25, height);
  colors = new color[numbers.length];
  resetColors();
  println("Before:");
  printarray(numbers);
  //bubblesort(numbers, numbers.length);
  println("After:");
  printarray(numbers);
}

int findHighest(int[] array)
{
  int highest = 0;
  for(int i = 1; i < array.length; i++)
  {
    if(array[highest] < array[i]) highest = i;
  }
  
  return array[highest];
}

int findLowest(int[] array)
{
  int lowest = 0;
  for(int i = 1; i < array.length; i++)
  {
    if(array[lowest] > array[i]) lowest = i;
  }
  
  return array[lowest];
}

void drawPillars()
{
  float w = (float)width/pillars;
  push();
  noStroke();
  for(int i = 0; i < numbers.length; i++)
  {
    float c = map(numbers[i], findLowest(numbers), findHighest(numbers), 0, 255);
    fill(color(c, 0, 255 - c));
    rect(i*w, height - numbers[i], w, numbers[i]);
  }
  pop();
  //println(w);
}

void draw()
{
  background(#1c1c1c);
  noStroke();
  fill(255);
  drawPillars();
  
  if(started)
  {
  if(frameCount % 10 == 0)
  {
    thread("tSort");
  }
  if(checkSort(numbers)) 
  {
    textSize(50);
    text("Sorted.", 100, 100);
    noLoop();
  }
  }
}

void insertionSort(int[] array)
{
  for(int i = 1; i < array.length; i++)
  {
    int j = i;
    while(j > 0 && array[j-1] > array[j])
    {
      swap(array, j, j-1);
      if(delayOnSwap) delay(delay);
    }
    //if(!delayOnSwap) delay(1);
  }
}

void tSort()
{
  switch(sortingAlgorithm)
  {
    case 0: bubblesort(numbers, numbers.length); break;
    case 1: insertionSort(numbers);  break;
  }
}

void printarray(int[] array)
{
  for(int i : array)
  {
    println(i);
  }
}

int[] generateRandomArray(int size, int min, int max)
{
  int[] array = new int[size];
  for(int i = 0; i < size; i++)
  {
    array[i] = (int)random(min, max);
  }
  
  return array;
}

void bubblesort(int[] array, int highIndex)
{
 if(highIndex < 2) return;
  
  for(int i = 1; i < highIndex; i++)
  {
    if(array[i-1] > array[i]) swap(array, i-1, i);
    if(delayOnSwap) delay(delay);
  }
  if(!delayOnSwap) delay(delay);
  bubblesort(array, highIndex - 1);
}

boolean checkSort(int[] array)
{
  for(int i = 1; i < array.length; i++)
  {
    if(array[i-1] > array[i]) return false;
  }
  
  return true;
}

void resetColors()
{
  for(int i = 0; i < colors.length; i++)
  {
    colors[i] = color(255);
  }
}

void bubbleSort(int arr[])
{
  int n = arr.length;
  for (int i = 0; i < n - 1; i++)
  {
    for (int j = 0; j < n - i - 1; j++)
    {
      for(int c = 0; c < colors.length; c++)
      {
        colors[c] = color(255);
      }
      colors[j] = color(255,0,0);
      if (arr[j] > arr[j + 1])
      {
        swap(arr, j, j+1);
      }
    }
    delay(100);
  }
  sorted = true;
}

void swap(int[] array, int index1, int index2)
{
  int temp = array[index1];
  array[index1] = array[index2];
  array[index2] = temp;
}
