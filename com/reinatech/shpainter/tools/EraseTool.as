package com.reinatech.shpainter.tools
{
   import flash.display.Shape;
   import flash.geom.Matrix;
   import flash.display.BlendMode;
   import com.reinatech.shpainter.DrawingSettings;


   public class EraseTool extends BrushTool
   {
      public function EraseTool(param1:DrawingSettings) {
         this.shape=new Shape();
         super(param1);
         toolClassName="EraseTool";
         shortToolClassName="e";
         return;
      }

      private var shape:Shape;

      override protected function _drawPoint(param1:int, param2:int) : void {
         var _loc3_:Matrix = new Matrix();
         _loc3_.translate(param1 - drawingSettings.getLineThickness() / 2,param2 - drawingSettings.getLineThickness() / 2);
         this.shape.graphics.clear();
         this.shape.graphics.beginFill(0);
         this.shape.graphics.drawCircle(drawingSettings.getLineThickness() / 2,drawingSettings.getLineThickness() / 2,drawingSettings.getLineThickness());
         this.shape.graphics.endFill();
         targetDrawableContainer.draw(this.shape,_loc3_,null,BlendMode.ERASE,null,true);
         return;
      }

      override public function clone() : DrawingTool {
         var _loc1_:EraseTool = null;
         _loc1_=new EraseTool(drawingSettings);
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