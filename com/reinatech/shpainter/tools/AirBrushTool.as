package com.reinatech.shpainter.tools
{
   import flash.display.*;
   import flash.geom.Point;
   import flash.filters.BlurFilter;
   import com.reinatech.shpainter.DrawingSettings;


   public class AirBrushTool extends DrawingTool
   {
      public function AirBrushTool(param1:DrawingSettings) {
         super();
         toolClassName="AirBrushTool";
         shortToolClassName="a";
         this.drawingSettings=param1;
         return;
      }

      private var _isDrawn:Boolean = false;

      override public function draw(param1:IBitmapDrawable, param2:Boolean=false, param3:Boolean=true) : void {
         if(param1  is  BitmapData)
         {
            targetDrawableContainer=param1 as BitmapData;
            if((param3) && !undoBitmap)
            {
               undoBitmap=targetDrawableContainer.clone();
            }
            if((param2) && !this._isDrawn)
            {
               this._drawTo(drawPoints.length-1);
            }
            else
            {
               if(drawPoints[drawPoints.length - 2])
               {
                  this._drawTo(drawPoints.length-1);
               }
            }
            return;
         }
         throw new Error("Invalid target drawable container");
      }

      override public function drawFrame(param1:IBitmapDrawable, param2:int=0) : Point {
         if(param2 == 0)
         {
            return drawPoints[0];
         }
         if(!drawPoints[param2-1])
         {
            return null;
         }
         targetDrawableContainer=param1 as BitmapData;
         this._drawTo(param2-1);
         return drawPoints[param2-1];
      }

      override public function redo() : void {
         this._drawTo(drawPoints.length-1);
         return;
      }

      private function _drawTo(param1:int) : void {
         var _loc5_:Point = null;
         var _loc6_:Point = null;
         this._isDrawn=false;
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.lineStyle(drawingSettings.getLineThickness(),drawingSettings.getForegroundColor(),drawingSettings.getOpacity(),drawingSettings.getLinePixelHinting(),drawingSettings.getLineScaleMode(),drawingSettings.getLineCaps(),drawingSettings.getLineJoints(),drawingSettings.getLineMiterLimit());
         _loc2_.graphics.moveTo(drawPoints[0].x,drawPoints[0].y);
         var _loc3_:* = 1;
         while(_loc3_ < param1)
         {
            _loc5_=drawPoints[_loc3_];
            _loc6_=drawPoints[_loc3_ + 1];
            _loc2_.graphics.lineTo(_loc6_.x,_loc6_.y);
            _loc3_++;
         }
         var _loc4_:BlurFilter = new BlurFilter(drawingSettings.getLineThickness() * 2,drawingSettings.getLineThickness() * 2,1);
         _loc2_.filters=[_loc4_];
         targetDrawableContainer.draw(_loc2_);
         return;
      }

      private function _drawPath(param1:Array) : void {
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         var _loc2_:int = param1.length;
         var _loc3_:* = 1;
         while(_loc3_ < _loc2_)
         {
            _loc4_=param1[_loc3_-1];
            _loc5_=param1[_loc3_];
            targetDrawableContainer.draw(this._drawLine(_loc4_,_loc5_));
            _loc3_++;
         }
         return;
      }

      private function _drawLine(param1:Point, param2:Point) : Shape {
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.lineStyle(drawingSettings.getLineThickness(),drawingSettings.getForegroundColor(),drawingSettings.getOpacity(),drawingSettings.getLinePixelHinting(),drawingSettings.getLineScaleMode(),drawingSettings.getLineCaps(),drawingSettings.getLineJoints(),drawingSettings.getLineMiterLimit());
         _loc3_.graphics.moveTo(param1.x,param1.y);
         _loc3_.graphics.lineTo(param2.x,param2.y);
         var _loc4_:BlurFilter = new BlurFilter(drawingSettings.getLineThickness() * 2,drawingSettings.getLineThickness() * 2,1);
         _loc3_.filters=[_loc4_];
         return _loc3_;
      }

      override public function clone() : DrawingTool {
         var _loc1_:AirBrushTool = null;
         _loc1_=new AirBrushTool(drawingSettings);
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