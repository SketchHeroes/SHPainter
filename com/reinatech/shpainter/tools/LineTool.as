package com.reinatech.shpainter.tools
{
   import flash.geom.Point;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   import com.reinatech.shpainter.DrawingSettings;


   public class LineTool extends DrawingTool
   {
      public function LineTool(param1:DrawingSettings) {
         this.shape=new Shape();
         super();
         toolClassName="LineTool";
         shortToolClassName="l";
         this.drawingSettings=param1;
         return;
      }

      private var shape:Shape;

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
         _loc3_.draw(this._draw(drawPoints[0],drawPoints[param2-1]));
         return drawPoints[param2-1];
      }

      override public function redo() : void {
         this._executeTool();
         return;
      }

      private function _executeTool() : void {
         targetDrawableContainer.draw(this._draw(drawPoints[0],drawPoints[drawPoints.length-1]));
         return;
      }

      protected function _draw(param1:Point, param2:Point) : Shape {
         this.shape.graphics.clear();
         this.shape.graphics.lineStyle(drawingSettings.getLineThickness(),drawingSettings.getForegroundColor(),drawingSettings.getOpacity(),drawingSettings.getLinePixelHinting(),drawingSettings.getLineScaleMode(),drawingSettings.getLineCaps(),drawingSettings.getLineJoints(),drawingSettings.getLineMiterLimit());
         this.shape.graphics.moveTo(param1.x,param1.y);
         this.shape.graphics.lineTo(param2.x,param2.y);
         return this.shape;
      }

      override public function clone() : DrawingTool {
         var _loc1_:LineTool = null;
         _loc1_=new LineTool(drawingSettings);
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