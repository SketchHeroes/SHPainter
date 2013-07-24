package com.reinatech.shpainter.tools
{
   import flash.geom.Point;
   import flash.display.*;
   import com.reinatech.shpainter.DrawingSettings;


   public class PenTool extends DrawingTool
   {
      public function PenTool(param1:DrawingSettings) {
         this.shape=new Shape();
         super();
         toolClassName="PenTool";
         shortToolClassName="p";
         this.drawingSettings=param1;
         return;
      }

      private var shape:Shape;

      override public function draw(param1:IBitmapDrawable, param2:Boolean=false, param3:Boolean=true) : void {
         if(param1  is  BitmapData)
         {
            targetDrawableContainer=param1 as BitmapData;
            if(param2)
            {
               if((param3) && !undoBitmap)
               {
                  undoBitmap=targetDrawableContainer.clone();
               }
               targetDrawableContainer.draw(this._drawPath(drawPoints));
            }
            else
            {
               targetDrawableContainer.draw(this._drawLines());
            }
            return;
         }
         throw new Error("Invalid target drawable container");
      }

      override public function drawFrame(param1:IBitmapDrawable, param2:int=0) : Point {
         targetDrawableContainer=param1 as BitmapData;
         if(param2 == drawPoints.length)
         {
            targetDrawableContainer.draw(this._drawPath(drawPoints));
         }
         else
         {
            targetDrawableContainer.draw(this._drawTo(param2));
         }
         return drawPoints[param2];
      }

      override public function redo() : void {
         targetDrawableContainer.draw(this._drawPath(drawPoints));
         return;
      }

      private function _drawPath(param1:Array) : Shape {
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         if(drawPoints[0])
         {
         }
         this.shape.graphics.clear();
         this.shape.graphics.lineStyle(drawingSettings.getLineThickness(),drawingSettings.getForegroundColor(),drawingSettings.getOpacity(),drawingSettings.getLinePixelHinting(),drawingSettings.getLineScaleMode(),drawingSettings.getLineCaps(),drawingSettings.getLineJoints(),drawingSettings.getLineMiterLimit());
         this.shape.graphics.moveTo(drawPoints[0].x,drawPoints[0].y);
         var _loc2_:Point = null;
         var _loc3_:Point = new Point();
         var _loc4_:int = param1.length;
         var _loc7_:* = 1;
         while(_loc7_ < _loc4_)
         {
            _loc5_=param1[_loc7_-1];
            _loc6_=param1[_loc7_];
            _loc3_.x=_loc5_.x + (_loc6_.x - _loc5_.x) / 2;
            _loc3_.y=_loc5_.y + (_loc6_.y - _loc5_.y) / 2;
            this.shape.graphics.lineTo(_loc3_.x,_loc3_.y);
            _loc2_=_loc3_;
            _loc7_++;
         }
         if(_loc6_)
         {
            this.shape.graphics.lineTo(_loc6_.x,_loc6_.y);
         }
         return this.shape;
      }

      private function _drawTo(param1:int) : Shape {
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.lineStyle(drawingSettings.getLineThickness(),drawingSettings.getForegroundColor(),drawingSettings.getOpacity(),drawingSettings.getLinePixelHinting(),drawingSettings.getLineScaleMode(),drawingSettings.getLineCaps(),drawingSettings.getLineJoints(),drawingSettings.getLineMiterLimit());
         _loc2_.graphics.moveTo(drawPoints[0].x,drawPoints[0].y);
         var _loc3_:* = 1;
         while(_loc3_ < param1)
         {
            _loc2_.graphics.lineTo(drawPoints[_loc3_].x,drawPoints[_loc3_].y);
            _loc3_++;
         }
         return _loc2_;
      }

      private function _drawLines() : Shape {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.lineStyle(drawingSettings.getLineThickness(),drawingSettings.getForegroundColor(),drawingSettings.getOpacity(),drawingSettings.getLinePixelHinting(),drawingSettings.getLineScaleMode(),drawingSettings.getLineCaps(),drawingSettings.getLineJoints(),drawingSettings.getLineMiterLimit());
         _loc1_.graphics.moveTo(drawPoints[0].x,drawPoints[0].y);
         var _loc2_:* = 1;
         while(_loc2_ < drawPoints.length)
         {
            _loc1_.graphics.lineTo(drawPoints[_loc2_].x,drawPoints[_loc2_].y);
            _loc2_++;
         }
         return _loc1_;
      }

      override public function clone() : DrawingTool {
         var _loc1_:PenTool = null;
         _loc1_=new PenTool(drawingSettings);
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