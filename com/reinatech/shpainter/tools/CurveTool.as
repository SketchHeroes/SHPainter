package com.reinatech.shpainter.tools
{
   import flash.geom.Point;
   import flash.display.*;
   import com.reinatech.shpainter.DrawingSettings;


   public class CurveTool extends DrawingTool
   {
      public function CurveTool(param1:DrawingSettings) {
         super();
         toolClassName="CurveTool";
         shortToolClassName="v";
         this.drawingSettings=param1;
         return;
      }

      override public function draw(param1:IBitmapDrawable, param2:Boolean=false, param3:Boolean=true) : void {
         if(param1  is  BitmapData)
         {
            targetDrawableContainer=param1 as BitmapData;
            if((param3) && (param2) && !undoBitmap)
            {
               undoBitmap=targetDrawableContainer.clone();
            }
            this._executeTool();
            return;
         }
         throw new Error("Invalid target drawable container");
      }

      override public function drawFrame(param1:IBitmapDrawable, param2:int=0) : Point {
         if(param2 == 0)
         {
            return drawPoints[0];
         }
         var _loc3_:BitmapData = param1 as BitmapData;
         _loc3_.draw(this._drawCurve(drawPoints[0],drawPoints[1],drawPoints[param2-1]));
         return drawPoints[param2-1];
      }

      override public function redo() : void {
         this._executeTool();
         return;
      }

      private function _executeTool() : void {
         if(drawPoints[2])
         {
            targetDrawableContainer.draw(this._drawCurve(drawPoints[0],drawPoints[1],drawPoints[drawPoints.length-1]));
         }
         else
         {
            targetDrawableContainer.draw(this._drawLine(drawPoints[0],drawPoints[1]));
         }
         return;
      }

      private function _drawLine(param1:Point, param2:Point) : Shape {
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.lineStyle(drawingSettings.getLineThickness(),drawingSettings.getForegroundColor(),drawingSettings.getOpacity(),drawingSettings.getLinePixelHinting(),drawingSettings.getLineScaleMode(),drawingSettings.getLineCaps(),drawingSettings.getLineJoints(),drawingSettings.getLineMiterLimit());
         _loc3_.graphics.moveTo(param1.x,param1.y);
         _loc3_.graphics.lineTo(param2.x,param2.y);
         return _loc3_;
      }

      private function _drawCurve(param1:Point, param2:Point, param3:Point) : Shape {
         var _loc4_:Shape = new Shape();
         _loc4_.graphics.lineStyle(drawingSettings.getLineThickness(),drawingSettings.getForegroundColor(),drawingSettings.getOpacity(),drawingSettings.getLinePixelHinting(),drawingSettings.getLineScaleMode(),drawingSettings.getLineCaps(),drawingSettings.getLineJoints(),drawingSettings.getLineMiterLimit());
         _loc4_.graphics.moveTo(param1.x,param1.y);
         _loc4_.graphics.curveTo(param3.x,param3.y,param2.x,param2.y);
         return _loc4_;
      }

      override public function clone() : DrawingTool {
         var _loc1_:CurveTool = null;
         _loc1_=new CurveTool(drawingSettings);
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