
void setup()
{
  println(sieveUntil(1000));
}

boolean checkPrimes(int[] primes)
{
  for (int i = 0; i < primes.length; i++)
  {
    if (primes[i] != firstThousandPrimes[i])
    {
      return false;
    }
  }
  return true;

}

// Sieves until the amount of primes reaches size
int[] sieveUntil(int size)
{
  ArrayList<Integer> primes = new ArrayList<Integer>();
  primes.add(2);
  int i = 3;
  while (primes.size() < size)
  {
    for(int j = 0; j < primes.size(); j++)
    {
      if (i % primes.get(j) == 0)
      {
        break;
      }
      else if (j == primes.size()-1)
      {
        primes.add(i);
      }
    }
    i++;
  }
  
  int PRIMES[] = new int[primes.size()];
  for (int index = 0; index < primes.size(); index++)
  {
    PRIMES[index] = primes.get(index);
  }
  
  return PRIMES;
  
}

// Sieves the numbers from 3 to size
int[] sieveTo(int size)
{
  ArrayList<Integer> primes = new ArrayList<Integer>();
  primes.add(2);
  for(int i = 3; i < size; i++)
  {
    for(int j = 0; j < primes.size(); j++)
    {
      if (i % primes.get(j) == 0)
      {
        break;
      }
      else if (j == primes.size()-1)
      {
        primes.add(i);
      }
    }
  }
  
  int PRIMES[] = new int[primes.size()];
  for (int i = 0; i < primes.size(); i++)
  {
    PRIMES[i] = primes.get(i);
  }
  
  return PRIMES;
  
}
