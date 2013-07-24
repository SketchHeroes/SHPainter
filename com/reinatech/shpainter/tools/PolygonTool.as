package com.reinatech.shpainter.tools
{
   import flash.geom.Point;
   import flash.display.*;
   import com.reinatech.shpainter.DrawingSettings;


   public class PolygonTool extends DrawingTool
   {
      public function PolygonTool(param1:DrawingSettings) {
         super();
         toolClassName="PolygonTool";
         shortToolClassName="y";
         this.drawingSettings=param1;
         return;
      }

      override public function draw(param1:IBitmapDrawable, param2:Boolean=false, param3:Boolean=true) : void {
         if(param1  is  BitmapData)
         {
            targetDrawableContainer=param1 as BitmapData;
            if((param3) && !undoBitmap)
            {
               undoBitmap=targetDrawableContainer.clone();
            }
            this._executeTool(drawPoints.length);
            return;
         }
         throw new Error("Invalid target drawable container");
      }

      override public function drawFrame(param1:IBitmapDrawable, param2:int=0) : Point {
         targetDrawableContainer=param1 as BitmapData;
         this._executeTool(param2);
         return drawPoints[param2];
      }

      override public function redo() : void {
         this._executeTool(drawPoints.length);
         return;
      }

      private function _executeTool(param1:int) : void {
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.lineStyle(drawingSettings.getLineThickness(),drawingSettings.getForegroundColor(),drawingSettings.getOpacity(),drawingSettings.getLinePixelHinting(),drawingSettings.getLineScaleMode(),drawingSettings.getLineCaps(),drawingSettings.getLineJoints(),drawingSettings.getLineMiterLimit());
         _loc2_.graphics.moveTo(drawPoints[0].x,drawPoints[0].y);
         var _loc3_:* = 1;
         while(_loc3_ < param1)
         {
            _loc2_.graphics.lineTo(drawPoints[_loc3_].x,drawPoints[_loc3_].y);
            _loc3_++;
         }
         targetDrawableContainer.draw(_loc2_);
         return;
      }

      override public function clone() : DrawingTool {
         var _loc1_:PolygonTool = null;
         _loc1_=new PolygonTool(drawingSettings);
         _loc1_.brushSprite=brushSprite;
         _loc1_.brushName=brushName;
         _loc1_.drawPoints=drawPoints;
         _loc1_.undoBitmap=undoBitmap;
         _loc1_.targetDrawableContainer=targetDrawableContainer;
         _loc1_.step=step;
         _loc1_.layerIndex=layerIndex;
         return _loc1_;
      }
   }

}