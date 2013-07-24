package com.reinatech.shpainter.tools
{
   import flash.display.*;
   import flash.filters.*;
   import flash.geom.Point;
   import flash.geom.ColorTransform;
   import com.reinatech.shpainter.DrawingSettings;


   public class BucketTool extends DrawingTool
   {
      public function BucketTool(param1:DrawingSettings) {
         super();
         toolClassName="BucketTool";
         shortToolClassName="f";
         this.drawingSettings=param1;
         return;
      }

      private var _redoBitmap:BitmapData = null;

      override public function draw(param1:IBitmapDrawable, param2:Boolean=false, param3:Boolean=true) : void {
         if(param1  is  BitmapData)
         {
            targetDrawableContainer=param1 as BitmapData;
            if((param3) && !undoBitmap)
            {
               undoBitmap=targetDrawableContainer.clone();
            }
            this._fill(drawPoints[0]);
            if(!this._redoBitmap)
            {
               this._redoBitmap=targetDrawableContainer.clone();
            }
            return;
         }
         throw new Error("Invalid target drawable container");
      }

      override public function drawFrame(param1:IBitmapDrawable, param2:int=0) : Point {
         targetDrawableContainer=param1 as BitmapData;
         this._fill(drawPoints[0]);
         return drawPoints[0];
      }

      override public function redo() : void {
         this._fill(drawPoints[0]);
         return;
      }

      private function _fill(param1:Point) : void {
         var _loc2_:BitmapData = null;
         var _loc3_:BitmapData = null;
         var _loc4_:Object = null;
         var _loc5_:ColorTransform = null;
         var _loc6_:BitmapData = null;
         var _loc7_:BitmapData = null;
         var _loc8_:uint = 0;
         var _loc9_:* = NaN;
         if(targetDrawableContainer.rect.containsPoint(param1))
         {
            _loc2_=BitmapData(targetDrawableContainer.clone());
            _loc3_=BitmapData(_loc2_.clone());
            _loc2_.floodFill(param1.x,param1.y,drawingSettings.getForegroundColor());
            _loc4_=_loc2_.compare(_loc3_);
            _loc5_=new ColorTransform();
            _loc5_.alphaMultiplier=drawingSettings.getOpacity();
            if(_loc4_ != 0)
            {
               _loc6_=BitmapData(_loc4_);
               _loc7_=_loc6_.clone();
               _loc8_=drawingSettings.getForegroundColor() >> 24 & 255;
               _loc9_=_loc8_ * 0.00392156862745098;
               _loc6_.applyFilter(_loc6_,_loc6_.rect,new Point(0,0),new GradientGlowFilter(0,90,[drawingSettings.getForegroundColor(),drawingSettings.getForegroundColor()],[0,_loc9_],[0,255],2,2,drawingSettings.getLineThickness(),BitmapFilterQuality.HIGH,BitmapFilterType.FULL,true));
               _loc7_.applyFilter(_loc6_,_loc6_.rect,new Point(0,0),new GradientGlowFilter(0,90,[drawingSettings.getForegroundColor(),drawingSettings.getForegroundColor()],[0,0],[0,255],2,2,drawingSettings.getLineThickness(),BitmapFilterQuality.HIGH,BitmapFilterType.FULL));
               _loc6_.colorTransform(_loc6_.rect,_loc5_);
               targetDrawableContainer.copyPixels(_loc6_,_loc6_.rect,new Point(0,0),_loc7_,new Point(0,0),true);
               _loc6_.dispose();
               _loc7_.dispose();
            }
            _loc2_.dispose();
            _loc3_.dispose();
         }
         return;
      }

      override public function clone() : DrawingTool {
         var _loc1_:BucketTool = null;
         _loc1_=new BucketTool(drawingSettings);
         _loc1_._redoBitmap=this._redoBitmap;
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