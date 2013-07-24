package com.reinatech.shpainter.tools
{
   import flash.geom.*;
   import flash.display.*;
   import com.reinatech.shpainter.DrawingSettings;
   import com.reinatech.shpainter.Settings;


   public class BrushTool extends DrawingTool
   {
      public function BrushTool(param1:DrawingSettings) {
         super();
         toolClassName="BrushTool";
         shortToolClassName="b";
         this.drawingSettings=param1;
         brushSprite=Settings.CURRENT_BRUSH;
         brushName=Settings.CURRENT_BRUSH_NAME;
         return;
      }

      private var _isDrawn:Boolean = false;

      override public function draw(param1:IBitmapDrawable, param2:Boolean=false, param3:Boolean=true) : void {
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         if(param1  is  BitmapData)
         {
            targetDrawableContainer=param1 as BitmapData;
            if((param3) && !undoBitmap)
            {
               undoBitmap=targetDrawableContainer.clone();
            }
            if((param2) && !this._isDrawn)
            {
               if(drawPoints.length > 1)
               {
                  this._drawPath(drawPoints);
               }
               else
               {
                  this._drawPoint(drawPoints[0].x,drawPoints[0].y);
               }
            }
            else
            {
               this._isDrawn=true;
               _loc4_=drawPoints[drawPoints.length - 2];
               _loc5_=drawPoints[drawPoints.length-1];
               if(!(_loc4_ == null) && !(_loc5_ == null))
               {
                  this._drawLine(_loc4_.x,_loc4_.y,_loc5_.x,_loc5_.y);
               }
               else
               {
                  if(_loc5_ != null)
                  {
                     this._drawPoint(_loc5_.x,_loc5_.y);
                  }
               }
            }
            return;
         }
         throw new Error("Invalid target drawable container");
      }

      override public function drawFrame(param1:IBitmapDrawable, param2:int=0) : Point {
         this._isDrawn=false;
         targetDrawableContainer=param1 as BitmapData;
         if(drawPoints.length > 1)
         {
            this._drawTo(param2);
         }
         else
         {
            this._drawPoint(drawPoints[0].x,drawPoints[0].y);
         }
         return drawPoints[param2];
      }

      override public function redo() : void {
         if(drawPoints.length == 1)
         {
            this._drawPoint(drawPoints[0].x,drawPoints[0].y);
         }
         else
         {
            this._drawPath(drawPoints);
         }
         return;
      }

      private function _drawTo(param1:int) : void {
         var _loc2_:Point = drawPoints[param1];
         var _loc3_:Point = drawPoints[param1 + 1];
         this._drawLine(_loc2_.x,_loc2_.y,_loc3_.x,_loc3_.y);
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
            this._drawLine(_loc4_.x,_loc4_.y,_loc5_.x,_loc5_.y);
            _loc3_++;
         }
         return;
      }

      protected function _drawPoint(param1:int, param2:int) : void {
         var _loc3_:Matrix = new Matrix();
         _loc3_.translate(param1 - drawingSettings.getLineThickness() / 2,param2 - drawingSettings.getLineThickness() / 2);
         var _loc4_:ColorTransform = new ColorTransform();
         _loc4_.color=drawingSettings.getForegroundColor();
         _loc4_.alphaMultiplier=drawingSettings.getOpacity();
         brushSprite.width=drawingSettings.getLineThickness();
         brushSprite.height=drawingSettings.getLineThickness();
         targetDrawableContainer.draw(brushSprite,_loc3_,_loc4_,null,null,true);
         return;
      }

      private function _drawLine(param1:int, param2:int, param3:int, param4:int) : void {
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc5_:int = param3 - param1;
         var _loc6_:int = param4 - param2;
         this._drawPoint(param1,param2);
         if(Math.abs(_loc5_) > Math.abs(_loc6_))
         {
            _loc7_=_loc6_ / _loc5_;
            _loc8_=param2 - _loc7_ * param1;
            _loc5_=_loc5_ < 0?-1:1;
            while(param1 != param3)
            {
               param1=param1 + _loc5_;
               this._drawPoint(param1,Math.round(_loc7_ * param1 + _loc8_));
            }
         }
         else
         {
            if(_loc6_ != 0)
            {
               _loc7_=_loc5_ / _loc6_;
               _loc8_=param1 - _loc7_ * param2;
               _loc6_=_loc6_ < 0?-1:1;
               while(param2 != param4)
               {
                  param2=param2 + _loc6_;
                  this._drawPoint(Math.round(_loc7_ * param2 + _loc8_),param2);
               }
            }
         }
         return;
      }

      override public function clone() : DrawingTool {
         var _loc1_:BrushTool = null;
         _loc1_=new BrushTool(drawingSettings);
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