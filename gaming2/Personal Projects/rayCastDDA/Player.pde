class Player
{
  PVector vPos, vDir, vPlane;
  float fMoveSpeed, fRotSpeed;
  
  Player(float x, float y)
  {
    vPos = new PVector(x, y);
    vDir = new PVector(-1, 0);
    vPlane = new PVector(0, 0.66);
    fMoveSpeed = 0.5;
    fRotSpeed = PI/10;
  }
  
  void keyPressed()
  {
    if (key == 'w')
    {
      if (map[int(vPos.x + vDir.x * fMoveSpeed)][int(vPos.y)] == 0) vPos.x += vDir.x * fMoveSpeed;
      if (map[int(vPos.x)][int(vPos.y + vDir.y * fMoveSpeed)] == 0) vPos.y += vDir.y * fMoveSpeed;
    }
    if (key == 's')
    {
      if (map[int(vPos.x - vDir.x * fMoveSpeed)][int(vPos.y)] == 0) vPos.x -= vDir.x * fMoveSpeed;
      if (map[int(vPos.x)][int(vPos.y - vDir.y * fMoveSpeed)] == 0) vPos.y -= vDir.y * fMoveSpeed;
    }
    
    if (key == 'a')
    {
      double dOldDirX = vDir.x;
      vDir.x = vDir.x * cos(fRotSpeed) - vDir.y * sin(fRotSpeed);
      vDir.y = (float)(dOldDirX * sin(fRotSpeed) + vDir.y * cos(fRotSpeed));
      double dOldPlaneX = vPlane.x;
      vPlane.x = vPlane.x * cos(fRotSpeed) - vPlane.y * sin(fRotSpeed);
      vPlane.y = (float)(dOldPlaneX * sin(fRotSpeed) + vPlane.y * cos(fRotSpeed));
    }
    if (key == 'd')
    {
      double dOldDirX = vDir.x;
      vDir.x = vDir.x * cos(-fRotSpeed) - vDir.y * sin(-fRotSpeed);
      vDir.y = (float)(dOldDirX * sin(-fRotSpeed) + vDir.y * cos(-fRotSpeed));
      double dOldPlaneX = vPlane.x;
      vPlane.x = vPlane.x * cos(-fRotSpeed) - vPlane.y * sin(-fRotSpeed);
      vPlane.y = (float)(dOldPlaneX * sin(-fRotSpeed) + vPlane.y * cos(-fRotSpeed));
    }
  }
  
  void raycast(int w)
  {
    for(int x = 0; x < w; x++)
    {
      double dCameraX = 2 * x / ((double)w) - 1;
      PVector vRayDir = new PVector((float)(vDir.x + vPlane.x * dCameraX), (float)(vDir.y + vPlane.y * dCameraX));
      
      PVector vMap = new PVector(int(vPos.x), int(vPos.y));
      
      PVector vSideDist = new PVector();
      
      PVector vDeltaDist = new PVector((vRayDir.x == 0) ? 1e30 : abs(1/vRayDir.x), (vRayDir.y == 0) ? 1e30 : abs(1/vRayDir.y));
      double dPerpWallDist;
      
      PVector vStep = new PVector();
      int hit = 0;
      int side = 0;
      
      if(vRayDir.x < 0)
      {
        vStep.x = -1;
        vSideDist.x = (vPos.x - vMap.x) * vDeltaDist.x;
      }
      else
      {
        vStep.x = 1;
        vSideDist.x = (vMap.x + 1 - vPos.x) * vDeltaDist.x;
      }
      
      if(vRayDir.y < 0)
      {
        vStep.y = -1;
        vSideDist.y = (vPos.y - vMap.y) * vDeltaDist.y;
      }
      else
      {
        vStep.y = 1;
        vSideDist.y = (vMap.y + 1 - vPos.y) * vDeltaDist.y;
      }
      
      while(hit == 0)
      {
        if (vSideDist.x < vSideDist.y)
        {
          vSideDist.x += vDeltaDist.x;
          vMap.x += vStep.x;
          side = 0;
        }
        else
        {
          vSideDist.y += vDeltaDist.y;
          vMap.y += vStep.y;
          side = 1;
        }
        
        if(vMap.x >= 0 && vMap.y >= 0)
        {
          if(map[int(vMap.x)][int(vMap.y)] > 0) hit = 1;
        }
      }
      
      if(side == 0) dPerpWallDist = (vSideDist.x - vDeltaDist.x);
      else          dPerpWallDist = (vSideDist.y - vDeltaDist.y);
      
      int lineHeight = (int)(height / dPerpWallDist);
      
      int drawStart = -lineHeight / 2 + height / 2;
      if (drawStart < 0) drawStart = 0;
      int drawEnd = lineHeight /2 + height / 2;
      if (drawEnd >= height) drawEnd = height - 1;
      
      color cLineColor;
      switch(map[int(vMap.x)][int(vMap.y)])
      {
        case 1: cLineColor = color(0, 0, 255); break;
        case 2: cLineColor = color(255, 0, 0); break;
        case 3: cLineColor = color(0, 255, 0); break;
        case 4: cLineColor = color(255, 0, 255); break;
        default: cLineColor = color(255, 255, 0); break;
      }
      if (side == 1) cLineColor = color(red(cLineColor)/2, green(cLineColor)/2, blue(cLineColor)/2);
      
      stroke(cLineColor);
      line(x, drawStart, x, drawEnd);
      
    }
  }
}
