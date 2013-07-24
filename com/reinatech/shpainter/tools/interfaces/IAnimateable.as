package com.reinatech.shpainter.tools.interfaces
{
   import flash.geom.Point;
   import flash.display.IBitmapDrawable;


   public interface IAnimateable
   {
      function getTotalFrames() : int;

      function drawFrame(param1:IBitmapDrawable, param2:int=0) : Point;
   }

}