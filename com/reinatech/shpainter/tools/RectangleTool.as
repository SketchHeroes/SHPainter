package com.reinatech.shpainter.tools
{
   import flash.display.Shape;
   import flash.geom.Point;
   import com.reinatech.shpainter.DrawingSettings;


   public class RectangleTool extends LineTool
   {
      public function RectangleTool(param1:DrawingSettings) {
         super(param1);
         toolClassName="RectangleTool";
         shortToolClassName="r";
         this.drawingSettings=param1;
         return;
      }

      override protected function _draw(param1:Point, param2:Point) : Shape {
         var _loc6_:uint = 0;
         var _loc3_:int = param2.x - param1.x;
         var _loc4_:int = param2.y - param1.y;
         var _loc5_:Shape = new Shape();
         if(drawingSettings.getBackgroundColor())
         {
            _loc6_=uint(parseInt(drawingSettings.getBackgroundColor()));
            _loc5_.graphics.beginFill(_loc6_,drawingSettings.getOpacity());
         }
         _loc5_.graphics.lineStyle(drawingSettings.getLineThickness(),drawingSettings.getForegroundColor(),drawingSettings.getOpacity(),drawingSettings.getLinePixelHinting(),drawingSettings.getLineScaleMode(),drawingSettings.getLineCaps(),drawingSettings.getLineJoints(),drawingSettings.getLineMiterLimit());
         _loc5_.graphics.drawRect(param1.x,param1.y,_loc3_,_loc4_);
         if(drawingSettings.getBackgroundColor())
         {
            _loc5_.graphics.endFill();
         }
         return _loc5_;
      }

      override public function clone() : DrawingTool {
         var _loc1_:RectangleTool = null;
         _loc1_=new RectangleTool(drawingSettings);
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