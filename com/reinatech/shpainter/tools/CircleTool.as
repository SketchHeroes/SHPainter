package com.reinatech.shpainter.tools
{
   import flash.display.Shape;
   import flash.geom.Point;
   import com.reinatech.shpainter.DrawingSettings;


   public class CircleTool extends LineTool
   {
      public function CircleTool(param1:DrawingSettings) {
         super(param1);
         toolClassName="CircleTool";
         shortToolClassName="c";
         return;
      }

      override protected function _draw(param1:Point, param2:Point) : Shape {
         var _loc8_:uint = 0;
         var _loc3_:int = param2.x - param1.x;
         var _loc4_:int = param2.y - param1.y;
         var _loc5_:int = param1.x - _loc3_ / 2;
         var _loc6_:int = param1.y - _loc4_ / 2;
         var _loc7_:Shape = new Shape();
         if(drawingSettings.getBackgroundColor())
         {
            _loc8_=uint(parseInt(drawingSettings.getBackgroundColor()));
            _loc7_.graphics.beginFill(_loc8_,drawingSettings.getOpacity());
         }
         _loc7_.graphics.lineStyle(drawingSettings.getLineThickness(),drawingSettings.getForegroundColor(),drawingSettings.getOpacity(),drawingSettings.getLinePixelHinting(),drawingSettings.getLineScaleMode(),drawingSettings.getLineCaps(),drawingSettings.getLineJoints(),drawingSettings.getLineMiterLimit());
         _loc7_.graphics.drawEllipse(_loc5_,_loc6_,_loc3_,_loc4_);
         if(drawingSettings.getBackgroundColor())
         {
            _loc7_.graphics.endFill();
         }
         return _loc7_;
      }

      override public function clone() : DrawingTool {
         var _loc1_:CircleTool = null;
         _loc1_=new CircleTool(drawingSettings);
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